#import "../src/lib.typ": (
  apa7,
  apa-table,
  apa-figure,
  apa-appendix,
  cite-narrative,
  cite-parenthetical,
  apa-stat,
  apa-t,
  apa-mean,
  apa-ci,
  apa-theorem,
  apa-definition,
  apa-proof,
  eq,
  deq,
)

#show: apa7.with(
  title: "A Comprehensive Demonstration of APA 7th Edition in Typst",
  authors: (
    (name: "Rowell Urbaez Reyes", affiliation: "Independent Researcher"),
  ),
  paper-type: "professional",
  running-head: "APA 7 TYPST COMPREHENSIVE",
  author-note: [
    Rowell Urbaez Reyes, Independent Researcher.

    Correspondence concerning this article should be addressed to Rowell Urbaez Reyes, Email: contact\@example.com.
  ],
  abstract: [
    This paper presents a standardized, accessible implementation of the American
    Psychological Association (APA) 7th edition formatting guidelines within the
    Typst typesetting ecosystem. The template enforces strict layout geometry,
    dual-mode title pages, hierarchical headings, accessible tables and figures,
    hanging-indent references, and universal accessibility compliant with the
    PDF/UA-1 standard.
  ],
  keywords: ("APA style", "Typst", "Academic writing", "Accessibility", "PDF/UA-1"),
  lang: "en",
)

= Introduction

Sleep deprivation is a prevalent issue in modern academic and professional environments.
As demonstrated by #cite-narrative(<baddeley1974>, page: 48), working memory capacity
is essential for short-term information retention and complex reasoning.
According to the @apa2020manual, all academic submissions must maintain uniform
double spacing throughout the entire paper, including headings, quotations, and references.
Recent empirical investigations corroborate these findings #cite-parenthetical(<baddeley1974>, pages: "52-54").

== Background and Theoretical Context

This section introduces the theoretical framework. The following direct quotation illustrates
the formal block quote format required for quotations of 40 words or more:

#quote(block: true)[
  Direct quotations of 40 words or more are formatted as block quotations. Block quotations
  do not use quotation marks. The entire block is indented 0.5 inches from the left margin,
  maintaining the same double line spacing as the rest of the paper. If there are additional
  paragraphs within the quotation, each subsequent paragraph is indented an additional 0.5 inches.
]

The study evaluated several distinct cognitive dimensions:#footnote[All experimental procedures complied with institutional review board standards.]
- Verbal working memory processing speed
- Visuospatial pattern recognition accuracy
- Executive task-switching latency

=== Mathematical Model

The primary cognitive retention model is formalized in @eq-retention:

#deq("R of t equals R zero times e raised to the power of negative lambda times t", $ R(t) = R_0 e^(-lambda t) $) <eq-retention>

#apa-definition(title: "Cognitive Retention Capacity")[
  Let #eq("R of t", $R(t)$) denote the proportion of retained items at time #eq("t", $t$).
  The capacity function is bounded and non-negative across all observation windows.
]

#apa-theorem(title: "Asymptotic Stability")[
  For any strictly positive decay constant #eq("lambda", $lambda$), the system exhibits
  asymptotic convergence to the baseline state.
]

#apa-proof[
  The result follows directly by taking the limit as #eq("t approaches infinity", $t -> infinity$).
]

== Quantitative Results

Below is an accessible APA 7 table and figure illustrating the required layout and semantic metadata.
An independent-samples _t_-test revealed that working memory performance was significantly higher
in the experimental group (#apa-mean(74.1, sd: 7.9)) than in the control group (#apa-mean(68.4, sd: 8.2)),
#apa-stat(t: 2.45, df: 48, p: .018, d: .71), #apa-ci(1.20, 10.20).

#apa-table(
  title: [Descriptive Statistics for Baseline and Post-Intervention Measures],
  columns: (2fr, 1fr, 1fr),
  header: ([*Measure*], [*Pre-Test (_M_)*], [*Post-Test (_M_)*]),
  note: [All values are scored on a standardized 0–100 scale. Standard deviations in parentheses.],
  [Working Memory Capacity], [68.4 (8.2)], [74.1 (7.9)],
  [Attention Span Index], [52.3 (6.5)], [61.0 (5.8)],
)

#apa-figure(
  rect(width: 100%, height: 60pt, fill: luma(245), stroke: 0.5pt + luma(180))[
    #align(center + horizon)[#text(size: 11pt, style: "italic")[Hypothesized Path Diagram]]
  ],
  title: [Path Analysis Model of Cognitive Performance Under Sleep Deprivation],
  alt: "Path model showing direct and indirect effects of sleep duration on cognitive retention",
  note: [Single-headed arrows represent direct directional paths. Significance levels: _p_ < .05.],
)

#apa-appendix(title: [Standardized Battery Task Items])[
  This appendix lists the complete set of memory evaluation items administered
  during testing.

  #apa-table(
    title: [Subordinate Battery Scores and Item Reliability],
    columns: (2fr, 1fr),
    header: ([*Item Domain*], [*Cronbach's _α_*]),
    note: [Values reflect reliability estimates across all participants.],
    [Spatial Span Subtest], [0.89],
    [Digit Ordering Subtest], [0.84],
  )
]

#bibliography("sample.bib")
