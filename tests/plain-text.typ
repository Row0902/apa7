/// Flattens content into the characters a reader sees, so tests can assert on
/// rendered strings instead of on Typst's internal content tree.
///
/// Typst has no built-in "content to text" conversion. This helper walks the
/// content tree and concatenates every text run, spacing element, and math
/// symbol it finds. Math is flattened to its base/subscript/superscript
/// characters, so `$eta_p^2$` reads `ηp2`.
///
/// The `space` element has no accessible constructor in the standard library
/// (`h()` builds a different element), so it is recognized by its function
/// name.
#let space-func-name = "space"
#let linebreak-func = linebreak().func()
#let parbreak-func = parbreak().func()

#let math-attach-fields = ("base", "b", "t")

#let plain-text(value) = {
  if value == none { return "" }
  let kind = type(value)
  if kind == str { return value }
  if kind != content { return "" }

  if value.has("text") { return value.at("text") }
  if value.has("body") { return plain-text(value.body) }

  let children = value.at("children", default: none)
  if children != none { return children.map(plain-text).join("") }

  let func = value.func()
  if repr(func) == space-func-name { return " " }
  if func == linebreak-func or func == parbreak-func { return "\n" }

  // Math attachments (`chi^2`, `eta_p^2`) keep their parts as named fields.
  let fields = value.fields()
  if fields.len() == 0 { return "" }
  let ordered = math-attach-fields.filter(name => name in fields)
  let names = if ordered.len() == fields.len() { ordered } else { fields.keys() }
  return names.map(name => plain-text(fields.at(name))).join("")
}
