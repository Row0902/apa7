#!/usr/bin/env bash
# Runs the template gate, which lives in `tests/template-gate.sh`, then proves it
# still fails for the shapes it exists to catch.
#
# The gate is a versioned script rather than an inline workflow block on purpose:
# extracting and executing the workflow's `run:` content would execute
# PR-controlled CI configuration, and this suite must not cross that boundary.
set -uo pipefail

cd "$(dirname "$0")/.." || exit 1

gate="$PWD/tests/template-gate.sh"

workdir="$(mktemp -d)"
trap 'rm -rf "$workdir"' EXIT

status=0
passed=0
failed=0

if [ ! -f "$gate" ]; then
  printf 'FAIL template gate script is missing: %s\n' "$gate"
  exit 1
fi

pass() {
  passed=$((passed + 1))
  printf 'ok   %s\n' "$1"
}

fail() {
  failed=$((failed + 1))
  status=1
  printf 'FAIL %s\n' "$1"
  shift
  for line in "$@"; do
    printf '     %s\n' "$line"
  done
}

# A throwaway copy of the tree the gate needs, so each case starts clean.
seed="$workdir/seed"
mkdir -p "$seed"
tar -cf - --exclude=./.git --exclude=./build . 2>/dev/null | tar -xf - -C "$seed"

reset_tree() {
  rm -rf "$workdir/tree"
  cp -r "$seed" "$workdir/tree"
}

run_gate() {
  # Run the copy inside the tree under test: the gate resolves its own project
  # root from its location, so an absolute path would always test the real repo.
  ( cd "$workdir/tree" && bash tests/template-gate.sh ) 2>&1
}

# 1. The shipped template passes, and produces the PDF.
reset_tree
if output="$(run_gate)"; then
  if [ -f "$workdir/tree/output-template.pdf" ]; then
    pass "gate: shipped template compiles"
  else
    fail "gate: shipped template compiles (no output-template.pdf)" "$output"
  fi
else
  fail "gate: shipped template compiles" "$output"
fi

# 2. A broken template body fails.
reset_tree
printf '\n#undefined-helper-xyz[boom]\n' >> "$workdir/tree/template/main.typ"
if output="$(run_gate)"; then
  fail "gate: broken template body is rejected (it passed)"
else
  pass "gate: broken template body is rejected"
fi

# 3. A pin ahead of typst.toml fails.
reset_tree
sed -i 's|@preview/pandect-apa7:[0-9][0-9.]*|@preview/pandect-apa7:9.9.9|' "$workdir/tree/template/main.typ"
if output="$(run_gate)"; then
  fail "gate: pin ahead of typst.toml is rejected (it passed)"
else
  pass "gate: pin ahead of typst.toml is rejected"
fi

# 4. A template that imports no pinned version fails.
reset_tree
sed -i 's|@preview/pandect-apa7:[0-9][0-9.]*|../src/lib.typ|' "$workdir/tree/template/main.typ"
if output="$(run_gate)"; then
  fail "gate: missing @preview pin is rejected (it passed)"
else
  pass "gate: missing @preview pin is rejected"
fi

# 5. A malformed declared version fails instead of comparing wrongly.
reset_tree
sed -i 's/^version *= *".*"/version = "0.2"/' "$workdir/tree/typst.toml"
if output="$(run_gate)"; then
  fail "gate: malformed package version is rejected (it passed)"
else
  pass "gate: malformed package version is rejected"
fi

# 6. A lagging pin is allowed: Typst Universe serves the released version only.
reset_tree
sed -i 's|@preview/pandect-apa7:[0-9][0-9.]*|@preview/pandect-apa7:0.1.0|' "$workdir/tree/template/main.typ"
sed -i 's/^version *= *".*"/version = "0.2.0"/' "$workdir/tree/typst.toml"
if output="$(run_gate)"; then
  pass "gate: lagging pin is allowed"
else
  fail "gate: lagging pin is allowed" "$output"
fi

# 7. The gate copies the whole template directory, so a template that grows a
#    sibling file still compiles instead of failing on a missing import.
reset_tree
printf 'This is a sibling file the template may import.\n' > "$workdir/tree/template/extra.txt"
if output="$(run_gate)"; then
  pass "gate: template with an extra packaged file still compiles"
else
  fail "gate: template with an extra packaged file still compiles" "$output"
fi

printf '\n%d passed, %d failed\n' "$passed" "$failed"
exit "$status"
