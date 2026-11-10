#import "apa7/layout.typ": apply-layout, format-running-head
#import "apa7/typography.typ": apply-typography, default-font-size
#import "apa7/heading.typ": apply-headings

/// Main template function for APA 7th Edition documents in Typst.
///
/// Configures document metadata (PDF/UA-1), page geometry, running heads,
/// approved typography, line spacing, and paragraph indentation.
///
/// Parameters:
/// - title: The title of the paper (string or content). Required for PDF metadata.
/// - authors: List of author dictionaries: (name: "...", affiliation: "...").
/// - paper-type: "student" | "professional" (default: "student").
/// - running-head: Shortened uppercase title (max 50 chars) for professional headers.
/// - font: Standard font family (default: "Times New Roman").
/// - font-size: Font size length or auto (auto selects standard size per font).
/// - paper-size: "us-letter" | "a4" (default: "us-letter").
/// - lang: ISO 639-1 language code (default: "en").
/// - region: Optional ISO 3166-1 alpha-2 region code.
/// - date: Publication or assignment date (datetime or auto).
/// - body: Document content.
#let apa7(
  title: [Untitled Document],
  authors: (),
  paper-type: "student",
  running-head: none,
  font: "Times New Roman",
  font-size: auto,
  paper-size: "us-letter",
  lang: "en",
  region: none,
  date: auto,
  body,
) = {
  // Extract author names for PDF metadata
  let author-names = if type(authors) == array {
    authors.map(a => {
      if type(a) == dictionary {
        a.at("name", default: "")
      } else {
        str(a)
      }
    })
  } else {
    ()
  }

  // Set document metadata for PDF/UA-1 and screen reader catalog access
  set document(
    title: title,
    author: author-names,
    date: date,
  )

  show: apply-layout.with(
    paper-type: paper-type,
    running-head: if running-head != none { running-head } else { title },
    paper-size: paper-size,
  )

  show: apply-typography.with(
    font: font,
    font-size: font-size,
    lang: lang,
    region: region,
  )

  show: apply-headings

  body
}
