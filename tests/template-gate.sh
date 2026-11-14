#!/usr/bin/env bash
# Template gate: compile `template/main.typ` against this checkout.
#
# The published template imports the released package by version, so no other CI
# step exercises it. Rewriting that import to `src/lib.typ` proves the template
# body against THIS checkout — not against the pinned release: a template that
# used a helper existing only on main would still pass here, so bump the pin only
# once Typst Universe serves the release.
#
# This lives in a versioned script rather than inline in the workflow so that
# `tests/ci-gates.sh` runs exactly the bytes CI runs. Executing the extracted
# `run:` block of the workflow would mean executing PR-controlled CI
# configuration, which is a privilege boundary the test suite must not cross.
set -euo pipefail

cd "$(dirname "$0")/.." || exit 1

pinned="$(sed -n 's|^#import "@preview/pandect-apa7:\([0-9][0-9.]*\)".*|\1|p' template/main.typ)"
if [ -z "$pinned" ]; then
  echo "::error::template/main.typ does not import @preview/pandect-apa7:<version>; this gate would be a no-op."
  exit 1
fi

declared="$(sed -n 's/^version *= *"\(.*\)"/\1/p' typst.toml | head -1)"
echo "template pins $pinned, package declares $declared"

# Both must be a real package version. Without this, `0.2` compares equal to
# `0.2.0`, and a pre-release suffix inverts the ordering below.
for version in "$pinned" "$declared"; do
  if ! printf '%s' "$version" | grep -Eq '^[0-9]+\.[0-9]+\.[0-9]+$'; then
    echo "::error::'$version' is not a MAJOR.MINOR.PATCH package version."
    exit 1
  fi
done

# The pin must never be ahead of the package: that version cannot exist yet. It
# may lag while a Typst Universe submission is pending, because `typst init` can
# only resolve a version Universe already serves.
newest="$(printf '%s\n%s\n' "$pinned" "$declared" | sort -V | tail -1)"
if [ "$newest" != "$declared" ]; then
  echo "::error::template/main.typ pins $pinned, ahead of typst.toml ($declared)."
  exit 1
fi

# `mktemp` never reuses an existing path, so a repository cannot pre-create the
# scratch directory as a symlink and turn the copy below into a write outside the
# workspace. It stays inside the project root because the rewritten import is
# relative and Typst refuses a source outside `--root`.
scratch="$(mktemp -d .gate-XXXXXX)"
trap 'rm -rf "$scratch"' EXIT

# Copy the whole template, not two named files: the template may be packaged with
# anything it imports, and a missing file must not become a gate failure of its own.
cp -r template/. "$scratch/"
sed -i 's|@preview/pandect-apa7:[0-9][0-9.]*|../src/lib.typ|' "$scratch/main.typ"
if ! grep -q '"../src/lib.typ"' "$scratch/main.typ"; then
  echo "::error::the local import substitution changed nothing; the template gate is broken."
  exit 1
fi

typst compile --root . --pdf-standard ua-1 "$scratch/main.typ" output-template.pdf
echo "template gate: compiled against this checkout"
