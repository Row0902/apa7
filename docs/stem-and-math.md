# STEM, Mathematics, and Statistics Guide

A practical guide for drafting calculus, linear algebra, and statistical analyses using `pandect-apa7`.

---

## 1. Calculus & Differential Equations

Typst features a concise, plain-text mathematical syntax without verbose LaTeX macros.

### Limits and Continuity

```typst
$ lim_(x -> c) f(x) = L $
$ lim_(x -> 0) (sen(x)) / x = 1 $
```

### Derivatives & Partial Derivatives

Use `dif` for ordinary derivatives (rendered upright per ISO 80000-2) and `diff` for partial derivatives:

```typst
$ (dif y) / (dif x) = 3x^2 + 2x $

$ (diff f) / (diff x) + (diff f) / (diff y) = 0 $
```

### Integrals & Multivariable Calculus

```typst
// Single definite integral
$ integral_0^1 x^2 dif x = 1/3 $

// Double integral over region D
$ integral.double_D (x^2 + y^2) dif A $

// Closed line integral
$ integral.cont_C bold(F) dot dif bold(r) $
```

---

## 2. Linear Algebra & Vector Calculus

### Matrices and Vectors

```typst
// Standard matrix with parentheses
$ bold(A) = mat(1, 2; 3, 4) $

// Determinant with vertical bars
$ det(bold(A)) = mat(delim: "|", a, b; c, d) = a d - b c $

// Column vector
$ bold(v) = vec(x_1, x_2, x_3) $
```

### Systems & Piecewise Functions

```typst
// Piecewise function
$ f(x) = cases(
  x^2 &"if" x >= 0,
  -x  &"if" x < 0
) $

// Multiline derivations aligned with &
$
  (x + 1)^2 &= (x + 1)(x + 1) \
            &= x^2 + 2x + 1
$
```

---

## 3. Formal Academic Blocks (Theorems & Proofs)

Structure formal proofs and lemmas with automatic counters and multilingual labels:

```typst
#apa-definition(title: "Uniform Continuity")[
  A function $f$ is uniformly continuous on an interval $I$ if for every $epsilon > 0$
  there exists $delta > 0$ such that $|x - y| < delta$ implies $|f(x) - f(y)| < epsilon$.
]

#apa-theorem(title: "Heine-Cantor Theorem")[
  Every continuous function on a closed and bounded interval is uniformly continuous.
]

#apa-proof[
  Let $f$ be continuous on $[a, b]$. Since $[a, b]$ is compact, continuity implies uniform continuity.
]
```
*(The proof block automatically appends the QED symbol $\square$ flush right and labels it for screen readers).*

---

## 4. Reporting Statistics in APA 7 (`apa-stat`)

APA 7 specifies strict rules for reporting statistical findings (Sections 6.40–6.44):

| Test / Statistic | Code | Rendered APA 7 Output |
| :--- | :--- | :--- |
| **Independent $t$-test** | `#apa-stat(t: 2.45, df: 48, p: .018, d: .71)` | $t(48) = 2.45, p = .018, d = 0.71$ |
| **ANOVA ($F$-test)** | `#apa-stat(f: 4.23, df1: 2, df2: 45, p: .020, eta2: .16)` | $F(2, 45) = 4.23, p = .020, \eta_p^2 = .16$ |
| **Correlation** | `#apa-stat(r: .42, df: 98, p: .003)` | $r(98) = .42, p = .003$ |
| **Chi-Square** | `#apa-stat(chi2: 8.42, df: 2, n: 100, p: .015)` | $\chi^2(2, N = 100) = 8.42, p = .015$ |
| **Descriptive Stats** | `#apa-mean(24.5, sd: 3.2, n: 100)` | $M = 24.50, SD = 3.20, N = 100$ |
| **Confidence Interval** | `#apa-ci(1.20, 10.20)` | $95\% \text{ CI } [1.20, 10.20]$ |

*Note: The engine automatically suppresses the leading zero for statistics bounded by 1 (such as $p$, $r$, and $\eta_p^2$).*

---

## 5. Spanish Mathematical Operators

`pandect-apa7` natively exports canonical Spanish mathematical operators so they render in upright Roman type with proper spacing instead of italic multiplied variables:

```typst
$ sen^2(x) + cos^2(x) = 1 $
$ lim_(x -> 0) (sen(x)) / x = 1 $
$ tg(x) = (sen(x)) / (cos(x)) $
$ mcd(24, 36) = 12 $
$ rot(bold(F)) = bold(nabla) times bold(F) $
$ traza(bold(A)) = sum_(i=1)^n a_(i i) $
```
