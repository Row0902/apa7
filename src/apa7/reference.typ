/// References module for APA 7th Edition.
///
/// Implements APA 7 reference list and citation formatting (Chapter 9 & 10):
/// - Automatic page break before the reference list.
/// - Centered bold Level 1 heading ("References" or "Referencias").
/// - Hanging indent of 0.5 inches (1.27 cm) on all reference entries.
/// - Double line spacing throughout.
/// - Native APA CSL citation style.

/// Applies APA 7 bibliography and reference list formatting.
///
/// Parameters:
/// - lang: ISO 639-1 language code ("en" or "es").
/// - body: Document content.
#let apply-references(lang: "en", body) = {
  // Use Typst's built-in APA 7th edition CSL citation and reference style
  set bibliography(
    style: "apa",
    title: if lang == "es" [Referencias] else [References],
  )

  // APA 7 Section 9.43:
  // - Starts on a new page.
  // - Hanging indent of 0.5 inches (first line flush left, subsequent lines indented 0.5in).
  // - Double line spacing (leading: 1em) without extra space between entries (spacing: 1em).
  show bibliography: it => {
    pagebreak()
    set par(
      hanging-indent: 0.5in,
      first-line-indent: 0pt,
      leading: 1em,
      spacing: 1em,
      justify: false,
    )
    it
  }

  body
}
