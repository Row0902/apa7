# Getting Started with apa7

`apa7` is a standards-compliant, universally accessible template and framework for academic papers in Typst (APA 7th Edition).

## Quick Setup

To use `apa7` in your document:

```typst
#import "@preview/apa7:0.1.0": *

#show: apa7.with(
  title: "Your Document Title",
  authors: (
    (name: "Jane Doe", affiliation: "Department of Psychology, University Name"),
  ),
  paper-type: "student", // or "professional"
  lang: "en",            // or "es"
)

= Introduction

Your paper body starts here...
```

---

## 1. Choose Your Paper Mode

APA 7 distinguishes between two types of papers:

| Setting | Intended Audience | Key Visual Characteristics |
| :--- | :--- | :--- |
| `paper-type: "student"` | University assignments, course essays, theses | • No running head in the header (only page number)<br>• Includes Course, Instructor, and Due Date |
| `paper-type: "professional"` | Journal submissions, conference papers, peer-reviewed manuscripts | • Uppercase Running Head flush left (max 50 chars)<br>• Includes Author Note at bottom of title page |

---

## 2. Student Paper Template (Ready to Copy)

```typst
#import "@preview/apa7:0.1.0": *

#show: apa7.with(
  paper-type: "student",
  title: "Impact of Sleep Deprivation on Working Memory",
  authors: (
    (name: "Alex Johnson", affiliation: "School of Psychology, University Example"),
  ),
  course: "PSYC 201: Research Methods",
  instructor: "Dr. Maria Rodriguez",
  due-date: datetime(year: 2026, month: 11, day: 15),
  abstract: [
    A concise summary of your research purpose, methodology, and primary conclusions...
  ],
  keywords: ("Sleep deprivation", "Cognitive psychology", "Working memory"),
  lang: "en",
)

= Introduction

Sleep disturbances are pervasive in academic settings...
```

---

## 3. Professional Paper Template (Ready to Copy)

```typst
#import "@preview/apa7:0.1.0": *

#show: apa7.with(
  paper-type: "professional",
  title: "Neural Correlates of Working Memory Retention",
  running-head: "WORKING MEMORY RETENTION",
  authors: (
    (name: "Dr. Jane Smith", affiliation: "Department of Neuroscience, Example Institute"),
  ),
  author-note: [
    Jane Smith, Department of Neuroscience, Example Institute.

    This research was supported by Grant 12345 from the National Science Foundation.
    Correspondence concerning this article should be addressed to Jane Smith, Email: jsmith\@example.edu.
  ],
  abstract: [
    This study investigates functional connectivity patterns underlying short-term retention...
  ],
  keywords: ("Neuroscience", "fMRI", "Working memory"),
  lang: "en",
)

= Introduction

Recent neuroimaging findings indicate...
```

---

## 4. Compiling Your Document

To compile your document into a standard or universally accessible PDF:

```bash
# Standard compilation
typst compile paper.typ paper.pdf

# Compiling with Universal Accessibility (PDF/UA-1 validation)
typst compile --pdf-standard ua-1 paper.typ paper.pdf
```

---

## Next Steps

- Explore [API Reference](api-reference.md) for parameter details.
- Read [Accessibility Guide](accessibility.md) for screen reader navigation and PDF/UA-1 rules.
- Review [STEM & Math Guide](stem-and-math.md) for calculus theorems, proofs, and statistical reporting.
