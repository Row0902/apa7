# 14 — Compile the template in CI and cover the untested documented features

Feature branch: `ci/14-template-and-feature-coverage`. Tracker for issue #14.

## Specs

- S1 — From the issue: "A broken `template/main.typ` fails CI."
- S2 — From the issue: "The new example compiles under `--pdf-standard ua-1`."
- S3 — From the issue: "The workflow documents which features it covers, so a future addition has an obvious home."
- S4 — From the issue: "Align the compiler versions, or document why they differ." (CI `0.15.1` at `.github/workflows/ci.yml:22`, `compiler = "0.15.0"` at `typst.toml:24`.)
- S5 — From the issue: "Compile the template in CI with the `@preview` import substituted for the local `src/lib.typ`."
- S6 — From the issue: "Add one example that exercises the list above." The list: `apa-lemma`, `apa-corollary`, `apa-proposition`, `apa-example`, the `f:`/`r:`/`chi2:`/`z:`/`m:` branches of `apa-stat`, `format-num`, `format-p`, `paper-size: "a4"`, `font`/`font-size` overrides, `region`, `cover: false`, `repeat-title: false`, `apa-appendix(letter:, multi: false)`, `cite-*(supplement:)`, `apa-ci(level:)` and `apa-proof(title:)`.
- S7 — From the issue's framing: "a wrong version pin survives a release" must no longer go undetected.

## Tasks

| ID | Task | Spec | Route | Commit |
| :--- | :--- | :--- | :--- | :--- |
| T1 | `examples/features.typ`: one example compiling under `--pdf-standard ua-1`, exercising every item in S6 | S2, S6 | inline | T1+T2 |
| T2 | CI: compile the new example with `ua-1`, and add the coverage comment naming what each step covers | S2, S3 | inline | T1+T2 |
| T3 | CI: compile `template/main.typ` with the `@preview` import substituted for the local `src/lib.typ`; fail if the substitution matches nothing, and if the pinned version is ahead of `typst.toml` | S1, S5, S7 | inline | T3+T4 |
| T4 | Document the compiler drift: `compiler = "0.15.0"` is the minimum a user needs, CI runs `0.15.1` | S4 | inline | T3+T4 |
| T5 | README / docs point at the new example | S3 | inline | T5 |

## Log

L1 (user, verbatim): `Dale con el 14`

L2 (evidence): `curl` proves Universe serves `pandect-apa7-0.1.0.tar.gz` (200) and `pandect-apa7-0.2.0.tar.gz` (404); `typst/packages` PR #6400 "pandect-apa7:0.2.0" is still OPEN. So the template pin at `0.1.0` is not a bug: the template must pin the **published** version, which lags the repository while a submission is pending. The check therefore asserts the pin is never **ahead** of `typst.toml`, instead of requiring equality — equality would fail today, and bumping the pin to 0.2.0 would break every `typst init` against Universe.

L3 (decision): the substitution step must fail when the `sed` rewrite changes nothing, otherwise a future import change silently turns S1's gate into a no-op compile of the published package.

L4 (independent verification, 4/4 requirements PASS) findings and dispositions:
- A3 accepted: the gate copied two named files, so a template packaged with anything else failed for the wrong reason. It now copies `template/` wholesale (`cp -r template/. build/`) and `tests/ci-gates.sh` pins case 7 for it.
- A5 accepted: `0.2` compared equal to `0.2.0` and a pre-release suffix inverted `sort -V`. Both versions are now asserted to be `MAJOR.MINOR.PATCH`.
- A7 accepted: the issue does not mention it, but adding a fourth bundled example while `cutver.toml`'s preflight compiled only three would have made the release gate's own promise false. `examples/features.typ` is in the preflight now. The template gate is deliberately not in the preflight: it needs a scratch copy and a rewritten import, and a release must not depend on rewriting checked-in files.
- A8 accepted: the coverage comment said "exactly one of these four places" while listing five and while several features appear in more than one example; and only `sen` is rendered in the Spanish example. Corrected.
- A9 accepted: `/odd` added to `typst.toml` `exclude`, and the workflow-documentation bullet moved out of the Tests section in `CHANGELOG.md`.
- A4 recorded, not changed: the "substitution changed nothing" guard is unreachable today because the extraction regex is a strict subset of the `sed` pattern. It stays as defence in depth and is no longer advertised as a testable failure mode.
- A1/A2 recorded as a known limit, now stated in the workflow: the gate proves the template body against **this checkout**, not against the pinned release. A template using a helper that exists only on `main` would pass here and fail after `typst init`; the mitigation is procedural (bump the pin only once Universe serves the release), and the comment says so.
- A6 recorded: `font: "Georgia"` cannot be verified on `ubuntu-latest` (unknown font is a warning, not an error). The override is verified locally through the PDF's font resources.
- A10 resolved by execution: the workflow's validity is no longer argued from structure — run 43527089333 executed the template step (step 10) and the coverage example (step 5) successfully on GitHub.
