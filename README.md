<div align="center">

# apa7

**A modular, standards-compliant APA 7th Edition template and toolkit for Typst.**

[![Typst Compiler](https://img.shields.io/badge/typst-0.15.1-blue?style=flat-square&logo=typst)](https://typst.app/)
[![Package Version](https://img.shields.io/badge/version-0.1.0-orange?style=flat-square)](typst.toml)
[![License](https://img.shields.io/badge/license-MIT-green?style=flat-square)](LICENSE)

</div>

---

## Overview

`apa7` provides a complete, modern implementation of the **American Psychological Association (APA) Style (7th Edition)** for [Typst](https://typst.app/). Designed with modularity and extensibility in mind, it handles structural layouts, typography, title pages, headings, tables, figures, abstracts, and appendices with strict adherence to APA guidelines.

## Features

- **Strict Page Geometry:** Standard Letter (or A4) dimensions, 1-inch (2.54 cm) margins on all sides, and top-right page numbers.
- **Student & Professional Paper Modes:** Configurable title pages following official APA 7 guidelines for both academic student submissions and peer-reviewed professional manuscripts.
- **APA 7 Headings (Levels 1–5):** Automated formatting for all five heading levels (centering, alignment, bold, italics, indentations, and inline run-in headings).
- **Approved Typography:** Native presets for standard APA fonts (Times New Roman 12pt, Georgia 11pt, Calibri 11pt, Arial 11pt) with double line spacing (200%) and 0.5-inch paragraph indentation.
- **Structured Tables & Figures:** Clean layouts supporting APA numbering, italicized titles, and three-tiered notes (*General*, *Specific*, *Probability*).
- **Abstract & Keywords:** Dedicated unindented abstract page with formatted keywords.
- **Appendices:** Automatic labeling and formatting for supplementary materials.

---

## Quickstart

### Student Paper Example

```typst
#import "@preview/apa7:0.1.0": apa7

#show: apa7.with(
  paper-type: "student",
  title: "The Effects of Sleep Deprivation on Cognitive Performance",
  authors: (
    (
      name: "Rowell Urbaez Reyes",
      affiliation: "Department of Psychology, University Example",
    ),
  ),
  course: "PSYC 201: Research Methods in Psychology",
  instructor: "Dr. Jane Smith",
  due-date: datetime(year: 2026, month: 11, day: 9),
  abstract: [
    This study investigates the correlation between chronic sleep restriction and
    short-term working memory retention among undergraduate students...
  ],
  keywords: ("Sleep deprivation", "Cognitive psychology", "Memory retention"),
)

= Introduction

Sleep deprivation is a prevalent issue in modern academic environments...
```

---

## Configuration Reference

The `#apa7(...)` template accepts the following configuration arguments:

| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `paper-type` | `str` | `"student"` | `"student"` or `"professional"`. Controls title page format and running head. |
| `title` | `str` / `content` | *required* | Full title of the paper (centered, bold, title case). |
| `running-head` | `str` | `auto` | Shortened uppercase title (max 50 chars). Displayed on professional papers. |
| `authors` | `array` | `()` | Array of author dictionaries `(name: "...", affiliation: "...", email: "...")`. |
| `course` | `str` | `none` | Course number and name (student papers only). |
| `instructor` | `str` | `none` | Name of the instructor (student papers only). |
| `due-date` | `datetime` / `str` | `none` | Assignment due date (student papers only). |
| `author-note` | `content` | `none` | Departmental affiliations, disclosures, and correspondence (professional papers). |
| `abstract` | `content` | `none` | Abstract text (placed on page 2, unindented paragraph). |
| `keywords` | `array` | `()` | List of indexing keywords formatted according to APA style. |
| `font` | `str` | `"Times New Roman"` | APA approved font (`"Times New Roman"`, `"Georgia"`, `"Calibri"`, `"Arial"`). |
| `font-size` | `length` | `12pt` | Base font size matching the selected typeface. |
| `paper-size` | `str` | `"us-letter"` | `"us-letter"` or `"a4"`. |

---

## Architecture & Modules

The package is partitioned into focused, single-responsibility modules inside `src/apa7/`:

```text
src/
├── lib.typ             # Main entry point and #apa7(...) orchestration function
└── apa7/
    ├── layout.typ      # Page dimensions, margins, running heads, and page numbers
    ├── typography.typ  # Typeface settings, paragraph indents, and line spacing
    ├── heading.typ     # Rules and show functions for Heading Levels 1 to 5
    ├── cover.typ       # Student and Professional cover page renderers
    ├── abstract.typ    # Abstract layout and keywords block
    ├── table.typ       # APA compliant table styling and notes
    ├── figure.typ      # APA compliant figure layouts and captions
    └── appendix.typ    # Appendix title and letter-sequencing utilities
```

---

## Heading Levels Reference

APA 7 specifies exact formatting rules for 5 levels of section titles:

| Level | Format |
| :---: | :--- |
| **1** | **Centered, Bold, Title Case** (Text starts on a new line) |
| **2** | **Flush Left, Bold, Title Case** (Text starts on a new line) |
| **3** | ***Flush Left, Bold Italic, Title Case*** (Text starts on a new line) |
| **4** | &nbsp;&nbsp;&nbsp;&nbsp;**Indented, Bold, Title Case, Ending With a Period.** Text begins on the same line. |
| **5** | &nbsp;&nbsp;&nbsp;&nbsp;***Indented, Bold Italic, Title Case, Ending With a Period.*** Text begins on the same line. |

`apa7` automatically transforms standard Typst headings (`= Level 1`, `== Level 2`, etc.) to match these rules.

---

## Development & Testing

To compile or inspect the package locally:

```bash
# Clone the repository
git clone git@github.com:Row0902/apa7.git
cd apa7

# Compile an example document
typst compile examples/sample.typ output.pdf
```

---

## Author

**Rowell Urbaez Reyes**  
- GitHub: [@Row0902](https://github.com/Row0902)

## License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.
