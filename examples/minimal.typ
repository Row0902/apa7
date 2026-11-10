#import "../src/lib.typ": apa7, apa-table, apa-figure, apa-appendix

#show: apa7.with(
  title: "A Minimal APA 7 Document",
  authors: (
    (name: "Rowell Urbaez Reyes", affiliation: "Independent Researcher"),
  ),
  paper-type: "professional",
  running-head: "MINIMAL APA7",
  author-note: [
    Rowell Urbaez Reyes, Independent Researcher.

    Correspondence concerning this article should be addressed to Rowell Urbaez Reyes, Email: contact\@example.com.
  ],
  abstract: [
    This paper presents a standardized, accessible implementation of the American
    Psychological Association (APA) 7th edition formatting guidelines within the
    Typst typesetting ecosystem. The template enforces strict layout geometry,
    dual-mode title pages, hierarchical headings, and universal accessibility
    compliant with the PDF/UA-1 standard.
  ],
  keywords: ("APA style", "Typst", "Academic writing", "Accessibility", "PDF/UA-1"),
  lang: "en",
)

= Introduction

This is the first paragraph of the body under Level 1 (Centered, Bold). According to
the APA 7th edition manual, every standard paragraph in the body must be indented by
exactly 0.5 inches (1.27 cm). The text is flush left with a ragged right margin,
without full justification.

== Background and Theoretical Context

This is a paragraph under Level 2 (Flush Left, Bold). Notice that there is no extra blank
space between paragraphs, and the line spacing is exactly double throughout the entire paper.

=== Empirical Evidence

This is a paragraph under Level 3 (Flush Left, Bold Italic). It continues with standard
0.5-inch paragraph indentation and double line spacing.

==== Qualitative Findings
This is a run-in paragraph immediately following a Level 4 heading (Indented, Bold, ending with a period).
The text continues right on the same line as the heading.

===== Case Study A
This is a run-in paragraph following a Level 5 heading (Indented, Bold Italic, ending with a period).
The text continues right on the same line as well.

== Results

Below is an accessible APA 7 table and figure illustrating the required layout and semantic metadata.

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
