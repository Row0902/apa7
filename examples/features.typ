// Features example: exercises the documented surface that no other example
// covers, so CI compiles it on every push.
//
// Covered here (nothing else in examples/ uses these):
// - theorem family beyond theorem/definition: lemma, corollary, proposition, example
// - `apa-proof(title: ...)`
// - `apa-stat` branches f, r, chi2 (with and without n), z, m (with and without sd/n), ci with level
// - `format-num` and `format-p`, including the p < .001 path
// - `apa-ci(level: ...)`
// - paper-level options: paper-size "a4", font, font-size, region, cover: false, repeat-title: false
// - `apa-appendix(letter: ..., multi: false)` and the default letter derivation
// - `cite-narrative(supplement:)` and `cite-parenthetical(supplement:)`
#import "../src/lib.typ": *

#show: apa7.with(
  title: "Documented Surface Coverage",
  authors: (
    (name: "Rowell Urbáez Reyes", affiliation: "Department of Psychology, Example University"),
  ),
  paper-type: "student",
  course: "PSY 501",
  instructor: "Dr. Example",
  due-date: "November 13, 2026",
  abstract: [This document exists so the compiler, not the reader, checks the
    documented surface of the package. Every helper used here has one call and
    one expected output.],
  keywords: ("coverage", "regression", "accessibility"),
  // Paper-level overrides that no other example exercises.
  paper-size: "a4",
  font: "Georgia",
  font-size: 11pt,
  region: "GB",
  cover: false,
  repeat-title: false,
)

= Statistical Branches

Every dispatcher branch is stated once, in the order the manual lists them.

- ANOVA with explicit degrees of freedom: #apa-stat(f: 4.23, df1: 2, df2: 45, p: .020, eta2: .16).
- The same test through the array shorthand: #apa-stat(f: 4.23, df: (2, 45)).
- Correlation: #apa-stat(r: .42, df: 98, p: .003).
- Chi-square with a sample size: #apa-stat(chi2: 8.42, df: 2, n: 100, p: .015).
- Chi-square without one: #apa-stat(chi2: 8.42, df: 2).
- Standardized normal: #apa-stat(z: 2.15, p: .032).
- Descriptives: #apa-stat(m: 24.5, sd: 3.2, n: 100), and bare: #apa-stat(m: 24.5).
- A 99% interval through the dispatcher: #apa-stat(ci: (1.20, 10.20), level: 99).

The primitives behind them are public too: #format-num(2.4567, decimals: 3) and
#format-num(0.423, decimals: 2, leading-zero: false) round and drop the leading
zero, #format-p(0.018) keeps three decimals, and #format-p(0.0004) collapses to
the inequality the manual requires. A helper called directly keeps its own
interval level: #apa-ci(1.20, 10.20, level: 99).

= Theorem Family

#apa-theorem(title: "Monotone Convergence")[
  Every bounded monotone sequence converges.
]

#apa-lemma(title: "Boundedness")[
  A convergent sequence is bounded.
]

#apa-corollary[
  Every convergent subsequence of a bounded sequence is itself bounded.
]

#apa-proposition(title: "Monotonicity")[
  The response increases with dose across the tested range.
]

#apa-example[
  Take #eq("n equals three", $n = 3$) and iterate twice to see the fixed point.
]

#apa-proof(title: "Proof of Lemma 1.")[
  Apply the monotone limit theorem to the partial sums.
]

= Citations and Appendices

A narrative citation with an explicit supplement: #cite-narrative(<baddeley1974>, supplement: "p. 48").
A parenthetical one with a page range: #cite-parenthetical(<baddeley1974>, supplement: [pp. 48–52]).
The manual itself is cited the same way #cite-parenthetical(<apa2020manual>).

#apa-appendix(title: [A Supplement That Derives Its Letter])[
  The default `letter: auto` continues the appendix counter.
]

#apa-appendix(title: [A Supplement Without a Letter], multi: false)[
  `multi: false` drops the letter from the heading while table and figure
  numbering keeps using it.
]

#apa-appendix(title: [A Supplement With an Explicit Letter], letter: "C")[
  An explicit `letter` overrides the derived one. The derived letter follows the
  appendix position, not the previous label, so an explicit letter that lands on
  a later position would repeat it — keep explicit labels ascending.
]

#bibliography("sample.bib")
