/// Table module for APA 7th Edition.
///
/// Implements APA 7 table formatting rules (Chapter 7, Sections 7.4-7.21):
/// - Numbering above the title (e.g. "Table 1" in bold).
/// - Title in italic title case on a new line below the number.
/// - Border rules: single horizontal lines at top (1pt), under header (0.5pt),
///   and bottom of table (1pt). Vertical lines are strictly forbidden.
/// - Notes below the table starting with italicized "Note." or "Nota.".
/// - Accessibility: mandates semantic table.header() for PDF/UA-1 screen readers.

/// Helper to render APA table notes (General, Specific, Probability).
#let render-table-note(
  note,
  lang: "en",
) = {
  if note == none or note == "" {
    return none
  }

  let note-label = if lang == "es" {
    emph[Nota.]
  } else {
    emph[Note.]
  }

  align(left)[
    #set text(size: 10pt)
    #set par(first-line-indent: 0pt, leading: 0.6em, spacing: 0.6em)
    #note-label #note
  ]
}

/// Helper function to create an APA 7 compliant table.
///
/// Automatically applies:
/// - Semantic table.header() wrapping for screen reader accessibility.
/// - APA 7 three-rule horizontal borders (top, header-bottom, table-bottom).
/// - Zero vertical lines.
/// - Flush-left italicized notes block below the table.
///
/// Parameters:
/// - title: Table title (content or string). Displayed in italics below table number.
/// - columns: Column specification (e.g., 3, (1fr, auto, auto)).
/// - header: Array of header cells. Wrapped into table.header() for PDF/UA-1.
/// - data: Body as one array per row, e.g. `(([A], [1]), ([B], [2]))`. Preferred shape.
/// - note: Optional explanatory note placed at the bottom.
/// - lang: ISO 639-1 language code (default: "en").
/// - ..cells: Body data cells, flat. Every column after a gap would shift, so
///   the count must be a multiple of the column count.
#let apa-table(
  title: [Untitled Table],
  columns: auto,
  header: (),
  data: none,
  note: none,
  lang: "en",
  ..cells,
) = {
  let table-supplement = if lang == "es" { [Tabla] } else { [Table] }
  let fail(message) = panic("apa-table: " + message)

  // `columns` is a count, an array of track sizes, or one track: in every
  // shape the number of columns is known, so a mismatch is always detectable.
  let column-count = if type(columns) == int {
    columns
  } else if type(columns) == array {
    columns.len()
  } else {
    1
  }

  let flat = cells.pos()

  let header-cells = if header == none {
    ()
  } else if type(header) == array {
    header
  } else {
    fail(
      "`header` must be an array of cells, e.g. `header: ([*A*], [*B*])`, but got " + type(header) + ".",
    )
  }

  let rows = if data == none {
    ()
  } else if type(data) == array {
    data
  } else {
    fail(
      "`data` must be an array of rows, e.g. `data: (([1], [2]), ([3], [4]))`, but got " + type(data) + ".",
    )
  }

  if rows.len() > 0 and flat.len() > 0 {
    fail(
      "pass either `data` (one array per row) or positional cells, not both: mixing the two body shapes leaves the row order undefined.",
    )
  }

  if column-count < 1 {
    fail("`columns` must describe at least one column.")
  }

  // A header shorter than the table pulls the first body row into the header
  // row, which is the silent shift this helper exists to prevent, so its width
  // must match exactly. A table with no header stays allowed.
  if header-cells.len() > 0 and header-cells.len() != column-count {
    fail(
      "`header` has " + str(header-cells.len()) + " cells but the table has " + str(column-count) + " column(s), so the header would not line up with the body. Give exactly " + str(column-count) + " header cells, or change `columns`.",
    )
  }

  let body = if rows.len() > 0 {
    for (index, row) in rows.enumerate() {
      if type(row) != array {
        fail(
          "row " + str(index + 1) + " of `data` is not an array of cells. Write `data: ((" + "…" + "), (" + "…" + "))`, one array per row.",
        )
      }
      if row.len() != column-count {
        fail(
          "row " + str(index + 1) + " of `data` has " + str(row.len()) + " cells but the table has " + str(column-count) + " column(s), so its cells would shift into the neighbouring columns.",
        )
      }
    }
    rows.flatten()
  } else {
    if calc.rem(flat.len(), column-count) != 0 {
      fail(
        "`cells` has " + str(flat.len()) + " cells but the table has " + str(column-count) + " column(s), so every row after the gap shifts. Give a multiple of " + str(column-count) + " cells, or pass `data: ((" + "…" + "), (" + "…" + "))` with one array per row.",
      )
    }
    flat
  }

  figure(
    caption: title,
    kind: table,
    supplement: table-supplement,
    [
      #table(
        columns: columns,
        stroke: none,
        table.hline(stroke: 1pt),
        table.header(..header-cells),
        table.hline(stroke: 0.5pt),
        ..body,
        table.hline(stroke: 1pt),
      )
      #render-table-note(note, lang: lang)
    ]
  )
}

/// Applies APA 7 table caption styling across all tables in the document.
#let apply-tables(lang: "en", body) = {
  // APA 7: Table captions are placed ABOVE the table.
  show figure.where(kind: table): set figure.caption(position: top)

  // APA 7: Line 1 has bold table number; Line 2 has italicized title.
  show figure.where(kind: table): set figure(
    supplement: if lang == "es" [Tabla] else [Table]
  )

  show figure.caption.where(kind: table): it => align(left)[
    #strong[#it.supplement #context it.counter.display(it.numbering)] \
    #emph[#it.body]
  ]

  body
}
