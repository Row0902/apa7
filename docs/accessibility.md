# Accessibility Guide (PDF/UA-1 & Screen Readers)

`pandect-apa7` is designed from the ground up for **Universal Access** and conforms to the international standard **PDF/UA-1** (ISO 14289-1), Section 508, the ADA, and the European Accessibility Act (EAA).

---

## 1. What Makes `pandect-apa7` Accessible by Design?

| Feature | Standard Document (LaTeX/Word) | `pandect-apa7` in Typst |
| :--- | :--- | :--- |
| **Document Metadata** | Often missing or blank | Injects title, author list, and date directly into XMP metadata catalog |
| **Language Tagging** | Default unlocalized | Declares ISO 639-1 language (`lang`) to ensure screen readers use correct pronunciation |
| **Headings** | Often bolded visual text without tags | Generates real `<H1>` through `<H5>` tags for bookmark navigation |
| **Running Heads & Page Numbers** | Repeatedly read aloud on every page | Isolated as **PDF Artifacts** so screen readers ignore them during continuous reading |
| **Data Tables** | Flat text or unassociated cells | Enforces `table.header()` so screen readers associate data cells with column names |
| **Figures** | Alt text optional, and usually forgotten | `#apa-figure` requires `alt` and stops the build without it; `decorative: true` covers graphics that carry no information |
| **Mathematical Formulas** | Mute visual glyphs or unpronounceable characters | Supports `#eq` and `#deq` with natural language phonetic descriptions |
| **Contrast & Typography** | Inconsistent line height, justified rivers | 100% black on white (WCAG AAA), ragged-right unhyphenated text for cognitive ease |

---

## 2. Navigating with a Screen Reader (NVDA / JAWS)

When reading a PDF compiled with `pandect-apa7`:

### Quick Keys in Browse Mode

- **`H` / `Shift + H`:** Jump forward or backward between section headings.
- **`1` through `5`:** Jump directly to headings of a specific level.
- **`T` / `Shift + T`:** Jump directly to data tables.
- **`Ctrl + Alt + Arrow Keys`:** Navigate cell by cell within a table. The screen reader automatically speaks the column header before the cell contents.
- **`G` / `Shift + G`:** Jump between graphics and figures (reads the `alt` text).

---

## 3. Recommended PDF Viewers for Screen Reader Users

PDF accessibility depends on the viewer's ability to expose Tagged PDF structure to assistive APIs (UI Automation and IAccessible2):

1. **Adobe Acrobat Reader (Desktop):** The industry standard for Tagged PDF and PDF/UA-1. Best-in-class support for NVDA and JAWS.
2. **Microsoft Edge:** Edge embeds the official Adobe Acrobat rendering engine natively, providing first-class table navigation with `T` and cell-by-cell reading.
3. **Google Chrome:** Chrome's default viewer (PDFium) flattens tables to plain text. **Solution:** Install the free official *Adobe Acrobat Extension for Google Chrome* and enable *"Allow access to file URLs"* in `chrome://extensions`.

---

## 4. Writing Accessible Math with `#eq` and `#deq`

In PDF/UA-1, mathematical equations must provide a speech description so assistive technologies do not pronounce characters as disjointed symbols.

### Inline Math: `#eq(alt, body)`

```typst
Let #eq("f of x", $f(x)$) be a continuous function on the real numbers.
```

### Display / Block Math: `#deq(alt, body)`

```typst
#deq("Limit of sine of x over x as x approaches zero equals one", $ lim_(x -> 0) (sen(x)) / x = 1 $)
```

---

## 5. Describing Figures with `#apa-figure`

A screen reader announces a figure through its `alt` text. `#apa-figure(...)` therefore requires `alt`, and the requirement is enforced at compile time: a figure with no `alt`, or with an empty one, stops the build with a message that names the parameter and explains what to write.

```typst
#apa-figure(
  image("path-model.png", width: 80%),
  title: [Path Analysis Model],
  alt: "Path diagram: sleep duration predicts retention directly and through attention span.",
  note: [Single-headed arrows represent direct paths.],
)
```

A graphic that carries no information — a divider rule, a repeated logo — passes `decorative: true` instead. The helper then supplies a neutral description, because PDF/UA-1 rejects a figure with an empty description even when the graphic is decorative.

```typst
#apa-figure(rect(width: 100%, height: 4pt, fill: black), decorative: true, title: [Divider])
```

Passing `decorative: true` together with a real `alt` is a contradiction — a graphic either carries information or it does not — and stops the build.

---

## 6. Validating Your Document

To assert that your paper complies with universal accessibility standards, compile with the `--pdf-standard ua-1` flag:

```bash
typst compile --pdf-standard ua-1 paper.typ paper.pdf
```

Typst enforces PDF/UA-1 at compile time: a figure with no description, an equation with no description, or a document with no title each stop the build with an explicit diagnostic. `pandect-apa7` adds its own checks on top of Typst's, so `#apa-figure` and `#apa-stat` report the offending parameter and how to supply it, instead of leaving you with a raw PDF/UA-1 error.
