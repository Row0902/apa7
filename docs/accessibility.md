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

## 5. Validating Your Document

To assert that your paper complies with universal accessibility standards, compile with the `--pdf-standard ua-1` flag:

```bash
typst compile --pdf-standard ua-1 paper.typ paper.pdf
```

If any element lacks required alt text or violates heading sequence, the Typst compiler will immediately catch it and report an explicit diagnostic.
