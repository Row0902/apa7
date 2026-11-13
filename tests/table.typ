/// Unit tests for `apa-table`'s shape handling: the row form and the flat form
/// must produce the same cells, and one track must always mean one column.
///
/// ///
/// Run with `bash tests/run.sh`.
#import "plain-text.typ": plain-text
#import "../src/apa7/table.typ": apa-table

// Text of every cell in document order, so a shift is visible as a reordering.
#let find-table(value) = {
  if type(value) != content { return none }
  if value.func() == table { return value }
  // `figure` keeps its body in a named field; `sequence` uses positional children.
  if value.has("body") { return find-table(value.body) }
  let children = value.at("children", default: none)
  if children == none { return none }
  for child in children {
    let hit = find-table(child)
    if hit != none { return hit }
  }
  none
}

#let cell-texts(value) = {
  let found = find-table(value)
  if found == none { return () }
  // `table.header` wraps the header cells in one element, so the table's rows
  // are flattened one level before their text is read.
  found
    .children
    .map(child => {
      if type(child) == content and child.func() == table.header {
        child.at("children", default: ())
      } else {
        (child,)
      }
    })
    .flatten()
    // Rules and empty elements flatten to nothing, and a structural element
    // with no text at all flattens to `none`, so keep only real strings.
    .map(plain-text)
    .filter(text => type(text) == str)
    .map(text => text.trim())
    .filter(text => text != "")
}

#let flat = apa-table(
    columns: 2,
    header: ([Name], [Score]),
    [Alpha], [1],
    [Beta], [2],
  )

#let rows = apa-table(
    columns: 2,
    header: ([Name], [Score]),
    data: (([Alpha], [1]), ([Beta], [2])),
  )

#let cases = (
    (
      name: "rows-match-flat",
      got: cell-texts(rows),
      want: cell-texts(flat),
    ),
    (
      name: "flat-order",
      got: cell-texts(flat),
      want: ("Name", "Score", "Alpha", "1", "Beta", "2"),
    ),
    (
      name: "header-only",
      got: cell-texts(apa-table(columns: 2, header: ([Name], [Score]))),
      want: ("Name", "Score"),
    ),
    (
      name: "no-header-is-allowed",
      got: cell-texts(apa-table(columns: 2, [Alpha], [1], [Beta], [2])),
      want: ("Alpha", "1", "Beta", "2"),
    ),
    (
      name: "auto-columns-is-one-column",
      got: cell-texts(apa-table([Alpha], [Beta])),
      want: ("Alpha", "Beta"),
    ),
    (
      name: "fraction-columns-is-one-column",
      got: cell-texts(apa-table(columns: 1fr, [Alpha], [Beta])),
      want: ("Alpha", "Beta"),
    ),
    // One track means one column, so three cells make three rows, not one.
    (
      name: "single-track-holds-three-cells",
      got: cell-texts(apa-table(columns: 1fr, [A], [B], [C])),
      want: ("A", "B", "C"),
    ),
    (
      name: "auto-holds-three-cells",
      got: cell-texts(apa-table([A], [B], [C])),
      want: ("A", "B", "C"),
    ),
  )

#let failures = cases.filter(c => repr(c.got) != repr(c.want))

  assert(
    failures.len() == 0,
    message: "apa-table shape tests failed:\n" + failures
      .map(c => "  " + c.name + "\n    want: " + repr(c.want) + "\n    got:  " + repr(c.got))
      .join("\n"),
  )

  [All #cases.len() `apa-table` shape cases passed.]
}
