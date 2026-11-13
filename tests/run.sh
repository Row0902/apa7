#!/usr/bin/env bash
# Runs the statistics test suite:
#   1. tests/stat.typ renders every `apa-stat` branch and asserts the string.
#   2. tests/fail/*.typ must abort compilation with a message that names the
#      missing parameter and the helper that fits the caller's data.
set -uo pipefail

cd "$(dirname "$0")/.." || exit 1

workdir="$(mktemp -d)"
trap 'rm -rf "$workdir"' EXIT

status=0
passed=0
failed=0

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

# 1. Rendered strings.
if output="$(typst compile --root . tests/stat.typ "$workdir/stat.pdf" 2>&1)"; then
  pass "render: tests/stat.typ"
else
  fail "render: tests/stat.typ" "$output"
fi

# 2. Compile-time failures. Each fixture must fail and mention every needle.
expect_compile_error() {
  local fixture="$1"
  shift
  local output

  if output="$(typst compile --root . "tests/fail/$fixture" "$workdir/$fixture.pdf" 2>&1)"; then
    fail "guard: $fixture (compiled but should have failed)"
    return
  fi

  local needle
  for needle in "$@"; do
    if [[ "$output" != *"$needle"* ]]; then
      fail "guard: $fixture (message does not mention $needle)" "$output"
      return
    fi
  done

  pass "guard: $fixture"
}

expect_compile_error t-without-df.typ '`df`' 'apa-t'
expect_compile_error t-df-explicit-none.typ '`df`' 'apa-t'
expect_compile_error chi2-without-df.typ '`df`' 'apa-chi2'
expect_compile_error f-without-df1.typ '`df1`' 'apa-f'
expect_compile_error f-without-df2.typ '`df2`' 'apa-f'
expect_compile_error f-without-df-pair.typ '`df1`' 'apa-f'
expect_compile_error f-df-triple.typ '`df: (df1, df2)`' 'apa-f'
expect_compile_error ci-not-a-pair.typ '`ci`' 'lower, upper' 'apa-ci'
expect_compile_error ci-three-bounds.typ 'lower, upper' 'apa-ci'
expect_compile_error level-without-ci.typ '`level`' '`ci`'
expect_compile_error no-statistic.typ '`ci`' 'apa-mean'

printf '\n%d passed, %d failed\n' "$passed" "$failed"
exit "$status"
