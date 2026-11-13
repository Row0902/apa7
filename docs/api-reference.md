# API Reference

Complete reference of all functions, helpers, and operators exported by `pandect-apa7`.

---

## 1. Document Orchestration: `#apa7(...)`

Configures the root document lifecycle, metadata, layout, typography, headings, tables, figures, and references.

```typst
#show: apa7.with(
  title: [Untitled Document],
  authors: (),
  paper-type: "student",
  running-head: none,
  course: none,
  instructor: none,
  due-date: none,
  author-note: none,
  abstract: none,
  keywords: (),
  repeat-title: true,
  cover: true,
  font: "Times New Roman",
  font-size: auto,
  paper-size: "us-letter",
  lang: "en",
  region: none,
  date: auto,
)
```

### Parameters

| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `title` | `str` / `content` | `[Untitled]` | Document title. Injected into PDF XMP metadata and printed centered on title page. |
| `authors` | `array` | `()` | Array of author dicts `(name: "...", affiliation: "...")` or strings. Formatted automatically. |
| `paper-type` | `str` | `"student"` | `"student"` (no running head, includes course/instructor) or `"professional"` (running head + author note). |
| `running-head` | `str` | `none` | Shortened uppercase title (max 50 chars). Displayed on professional papers. |
| `course` | `str` / `content` | `none` | Course number and title (student papers). |
| `instructor` | `str` / `content` | `none` | Instructor name with degrees/honorifics (student papers). |
| `due-date` | `datetime` / `str` | `none` | Assignment due date. Formatted according to `lang` (e.g. "November 9, 2026" or "9 de noviembre de 2026"). |
| `author-note` | `content` | `none` | Disclosures, acknowledgments, and correspondence contact (professional papers). |
| `abstract` | `content` | `none` | Unindented summary paragraph on Page 2. |
| `keywords` | `array` | `()` | Indexing keywords. Indented 0.5 in with italicized label. |
| `repeat-title` | `bool` | `true` | When true, centers and bolds the title at the top of the first body text page (APA 7 Section 2.11). |
| `cover` | `bool` | `true` | When true, generates the cover title page automatically. |
| `font` | `str` | `"Times New Roman"` | Approved APA font (`"Times New Roman"`, `"Georgia"`, `"Calibri"`, `"Arial"`, `"Lucida Sans Unicode"`). |
| `font-size` | `length` / `auto` | `auto` | Font size. If `auto`, selects standard APA size for the font (12pt for Times New Roman, 11pt for Calibri/Arial/Georgia). |
| `paper-size` | `str` | `"us-letter"` | `"us-letter"` (8.5 × 11 in) or `"a4"`. |
| `lang` | `str` | `"en"` | ISO 639-1 language code (`"en"`, `"es"`). Configures hyphenation, CSL citations, and localized labels. |
| `region` | `str` | `none` | Optional ISO 3166-1 alpha-2 region code. |

---

## 2. Tables and Figures

### `#apa-table(...)`

Constructs an APA 7 table with semantic header tags for PDF/UA-1 accessibility, 3 horizontal rules, and flush-left notes.

```typst
#apa-table(
  title: [Table Title],
  columns: (2fr, 1fr, 1fr),
  header: ([*Variable*], [*Sample 1*], [*Sample 2*]),
  note: [Explanatory text for the entire table.],
  lang: "en",
  [Mean Age], [21.4], [22.1],
  [Score], [88.5], [89.2],
)
```

### `#apa-figure(...)`

Constructs an APA 7 figure with caption positioned above, accessible alt-text description, and flush-left notes.

```typst
#apa-figure(
  image("chart.png", width: 80%),
  title: [Figure Title in Italic],
  alt: "Comprehensive natural language description of visual content",
  note: [Source notes, abbreviations, and significance levels.],
  lang: "en",
)
```

---

## 3. Appendices: `#apa-appendix(...)`

Starts a separate, isolated appendix page with subordinate figure and table numbering (e.g. Table A1, Figure A1).

```typst
#apa-appendix(title: [Stimulus Materials], letter: auto, multi: true, lang: "en")[
  Appendix content here...
]
```

---

## 4. Academic Citations

| Helper | Example | Output |
| :--- | :--- | :--- |
| Direct markup | `@baddeley1974` | `(Baddeley & Hitch, 1974)` |
| With page | `@baddeley1974[p. 48]` | `(Baddeley & Hitch, 1974, p. 48)` |
| `#cite-narrative(...)` | `#cite-narrative(<baddeley1974>, page: 48)` | `Baddeley and Hitch (1974, p. 48)` |
| `#cite-parenthetical(...)` | `#cite-parenthetical(<baddeley1974>, pages: "48-52")` | `(Baddeley & Hitch, 1974, pp. 48-52)` |

---

## 5. Statistical Reporting: `#apa-stat(...)`

Automates APA 7 formatting rules (leading zero elimination for bounded stats, consecutive degrees of freedom, and exact p-values).

```typst
// Student's t-test: t(48) = 2.45, p = .018, d = 0.71
#apa-stat(t: 2.45, df: 48, p: .018, d: .71)

// ANOVA: F(2, 45) = 4.23, p = .020, η² = .16
#apa-stat(f: 4.23, df1: 2, df2: 45, p: .020, eta2: .16)

// Correlation: r(98) = .42, p = .003
#apa-stat(r: .42, df: 98, p: .003)

// Chi-Square: χ²(2, N = 100) = 8.42, p = .015
#apa-stat(chi2: 8.42, df: 2, n: 100, p: .015)

// Mean & Standard Deviation: M = 24.50, SD = 3.20
#apa-mean(24.5, sd: 3.2)

// Confidence Interval: 95% CI [1.20, 10.20]
#apa-ci(1.20, 10.20)
```

---

## 6. STEM Theorems and Accessible Math

### Environments

- `#apa-theorem(title: "...")[...]` — Formats **Theorem 1 (Title).** with italicized text.
- `#apa-definition(title: "...")[...]` — Formats **Definition 1 (Title).** with upright text.
- `#apa-lemma(title: "...")[...]` — Formats **Lemma 1.**
- `#apa-corollary(title: "...")[...]` — Formats **Corollary 1.**
- `#apa-proposition(title: "...")[...]` — Formats **Proposition 1.**
- `#apa-example(title: "...")[...]` — Formats **Example 1.**
- `#apa-proof[...]` — Formats *Proof.* with a right-aligned QED symbol ($\square$).

### Accessible Math Helpers

- `#eq("alt text", $f(x)$)` — Inline equation with screen reader speech description.
- `#deq("alt text", $E = m c^2$)` — Display/block equation with speech description and numbering.

### Spanish Mathematical Operators

Recognized as upright Roman mathematical operators:
- **Trigonometric:** `sen`, `tg`, `ctg`, `cotg`, `cosec`, `arcsen`, `arctg`, `arcctg`, `arccotg`
- **Hyperbolic:** `senh`, `tgh`, `ctgh`, `cotgh`, `cosech`
- **Arithmetic:** `mcd`, `mcm`, `MCD`, `MCM`
- **Linear Algebra & Vector Calculus:** `rot`, `traza`, `rango`
