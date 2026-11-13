/// Unit tests for `apa-figure`: alt text is resolved before the figure is
/// built, and the decorative escape hatch supplies a description instead of
/// silently dropping accessibility.
///
/// Run with `bash tests/run.sh`.
#import "../src/apa7/figure.typ": apa-figure

#let body = rect(width: 100pt, height: 40pt)

#let cases = (
  (
    name: "alt-passthrough",
    got: apa-figure(body, alt: "A path diagram with two arrows.").alt,
    want: "A path diagram with two arrows.",
  ),
  (
    name: "decorative-en",
    got: apa-figure(body, decorative: true).alt,
    want: "Decorative image, no informative content.",
  ),
  (
    name: "decorative-es",
    got: apa-figure(body, decorative: true, lang: "es").alt,
    want: "Imagen decorativa, sin contenido informativo.",
  ),
  (
    name: "decorative-empty-alt-is-not-a-conflict",
    got: apa-figure(body, decorative: true, alt: "").alt,
    want: "Decorative image, no informative content.",
  ),
)

#let failures = cases.filter(c => c.got != c.want)

#assert(
  failures.len() == 0,
  message: "apa-figure alt tests failed:\n" + failures
    .map(c => "  " + c.name + "\n    want: " + repr(c.want) + "\n    got:  " + repr(c.got))
    .join("\n"),
)

All #cases.len() `apa-figure` alt cases passed.
