/// Unit tests for the `apa-stat` dispatcher: every branch must render the
/// exact APA 7 string, and valid calls must keep rendering what they rendered
/// before the dispatcher started validating its input.
///
/// Run with `bash tests/run.sh`.
#import "plain-text.typ": plain-text
#import "../src/apa7/stat.typ": apa-stat, apa-ci

#let cases = (
  // t-test branch
  (
    name: "t",
    got: apa-stat(t: 2.45, df: 48, p: .018, d: .71),
    want: "t(48) = 2.45, p = .018, d = 0.71",
  ),
  (
    name: "t-bare",
    got: apa-stat(t: 2.45, df: 48),
    want: "t(48) = 2.45",
  ),
  // ANOVA branch
  (
    name: "f",
    got: apa-stat(f: 4.23, df1: 2, df2: 45, p: .020, eta2: .16),
    want: "F(2, 45) = 4.23, p = .020, ηp2 = .16",
  ),
  (
    name: "f-df-array",
    got: apa-stat(f: 4.23, df: (2, 45)),
    want: "F(2, 45) = 4.23",
  ),
  (
    name: "f-df-mixed",
    got: apa-stat(f: 4.23, df1: 2, df: (2, 45)),
    want: "F(2, 45) = 4.23",
  ),
  // correlation branch
  (
    name: "r",
    got: apa-stat(r: .42, df: 98, p: .003),
    want: "r(98) = .42, p = .003",
  ),
  (
    name: "r-without-df",
    got: apa-stat(r: .42),
    want: "r = .42",
  ),
  // chi-square branch
  (
    name: "chi2",
    got: apa-stat(chi2: 8.42, df: 2, n: 100, p: .015),
    want: "χ2 (2, N = 100) = 8.42, p = .015",
  ),
  (
    name: "chi2-without-n",
    got: apa-stat(chi2: 8.42, df: 2),
    want: "χ2 (2) = 8.42",
  ),
  // z branch
  (
    name: "z",
    got: apa-stat(z: 2.15, p: .032),
    want: "z = 2.15, p = .032",
  ),
  // descriptive-statistics branch
  (
    name: "m",
    got: apa-stat(m: 24.5, sd: 3.2, n: 100),
    want: "M = 24.50, SD = 3.20, N = 100",
  ),
  (
    name: "m-bare",
    got: apa-stat(m: 24.5),
    want: "M = 24.50",
  ),
  // confidence-interval branch
  (
    name: "ci",
    got: apa-stat(ci: (1.20, 10.20)),
    want: "95% CI [1.20, 10.20]",
  ),
  (
    name: "ci-level-99",
    got: apa-stat(ci: (1.20, 10.20), level: 99),
    want: "99% CI [1.20, 10.20]",
  ),
  (
    name: "ci-level-90",
    got: apa-stat(ci: (1.20, 10.20), level: 90),
    want: "90% CI [1.20, 10.20]",
  ),
  (
    name: "ci-negative",
    got: apa-stat(ci: (-10.20, -1.20)),
    want: "95% CI [-10.20, -1.20]",
  ),
  // the helper alone keeps its own contract
  (
    name: "apa-ci-level-99",
    got: apa-ci(1.20, 10.20, level: 99),
    want: "99% CI [1.20, 10.20]",
  ),
)

#let failures = cases.filter(c => plain-text(c.got) != c.want)

#assert(
  failures.len() == 0,
  message: "apa-stat render tests failed:\n" + failures
    .map(c => "  " + c.name + "\n    want: " + c.want + "\n    got:  " + plain-text(c.got))
    .join("\n"),
)

All #cases.len() `apa-stat` render cases passed.
