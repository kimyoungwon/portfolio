# kimyoungwon.github.io/portfolio

Personal academic site for **Youngwon Kim** — machine learning researcher, clinical AI.
Built with [Quarto](https://quarto.org). No Ruby, no Node, no package manager: one
signed binary renders the whole thing.

---

## Quick start

Quarto ships inside RStudio and is **not on your `PATH`**. Add this to `~/.zshrc` once:

```sh
alias quarto='/Applications/RStudio.app/Contents/Resources/app/quarto/bin/quarto'
```

Then:

```sh
quarto preview     # live-reloading local server, usually http://localhost:4321
quarto render      # one-off build into docs/
```

> **Do not run `quarto render` while `quarto preview` is running.** Render deletes and
> recreates the output directory underneath the preview's file watcher, which kills it —
> the server then serves `BadResource: Bad resource ID` on every request while still
> returning HTTP 200. If that happens: `pkill -f "quarto preview"`, then restart it.
> While previewing, just save a file; it rebuilds on its own.

---

## Updating content

Each collection is **one YAML file**. Adding an item means copying a block and editing
fields — no HTML, no templates, no touching the layout.

| To add a… | Edit | Notes |
|---|---|---|
| Publication | `publications.yml` | `kind` groups the page. `year` shows in the left rail; `date` is only a sort key. |
| Presentation | `presentations.yml` | `when` is the display string (`"2026 · May"`); `date` only sorts. Optional `writeup` / `abstract` / `paper` / `slides` / `video` links. |
| Course | `teaching.yml` | `role` groups the page: Lecturer → Computing Assistant → Teaching Assistant. |
| Write-up / project | `writing.yml` | `group` is `Research write-ups` or `Earlier coursework`. **Give every card an `image`** — the CSS grid leaves holes otherwise. |

Prose pages are ordinary files: `index.qmd` (home), `research.qmd`, `cv.qmd`.

### Author names

Your own name is bolded automatically — never write `<b>` in the YAML, because Quarto
escapes HTML inside data values and it would render as literal `&lt;b&gt;`.

The bolded form **depends on the publication type**, matching how you cite yourself:

| Group | Form used |
|---|---|
| Journal articles, Working papers, Preprints | `Kim, Y. W.` |
| Conference proceedings | `Kim, Y.` |

This distinction matters: the 2017 *Review of Educational Research* paper has a
**different** author also listed as `Kim, Y.`, and only your `Kim, Y. W.` is bolded there.
The mapping lives in `_templates/pubs.ejs` (`selfFor`).

### Publication groups

Rendered in this order: **Preprints & under review** → **Journal articles** →
**Conference proceedings** → **Working papers**. Change the order in
`_templates/pubs.ejs`.

---

## Design system

Two SCSS files hold the entire visual identity; `styles.css` styles every component
through their tokens, so both themes work from one rule set.

| File | Holds |
|---|---|
| `theme-light.scss` | Bootstrap overrides in `scss:defaults`, then `--yk-*` tokens in `scss:rules` |
| `theme-dark.scss` | The same, with dark values |
| `styles.css` | All components, using only `--yk-*` tokens |

**Palette** — warm paper + ink blue. `#FCFCFA` ground, `#14161A` text, `#2B4ACB` accent
(light); `#0E0F11` / `#EDEDE8` / `#8FADFF` (dark). Text contrast is 17.6:1 light and
16.3:1 dark.

**Type** — **Instrument Serif** for the claim and section headings, **Geist** for body,
**Geist Mono** for the header, metadata labels, and all figures.

**Rules that keep it coherent:** one accent, used only for links, focus rings, and the
active nav item. Hairline dividers, never cards. `tabular-nums` on every date. The
publication *title* is the heaviest thing in an entry — not the year.

### Three traps

1. **Instrument Serif has only weight 400.** Never give it a heavier weight; the browser
   synthesizes a fake bold that looks cheap. `.yk-card__title` explicitly forces the sans
   stack for exactly this reason. Emphasis comes from size and italic.
2. **EJS templates must emit flush-left HTML.** Any output line indented 4+ spaces becomes
   a Pandoc code block and the whole listing renders as escaped source.
3. **Quarto hoists the first `<h1>`** out of your markup to use as the page title. The
   homepage claim is therefore a `div` with `role="heading" aria-level="1"`, not an `h1`.

---

## Figures

`assets/images/*.svg` are hand-written stat tiles sharing one visual language
(`#F3F2ED` surface, mono type, `#2B4ACB` accent).

**Every number in them traces to a published source** — the AMIA proceedings paper, the
ASCO and ISPOR abstracts, or the Truveta write-ups. Nothing is estimated or invented.
`markov-schematic.svg` shows no data at all and says so on its face
(*"METHOD ILLUSTRATION · NOT DATA"*), because that study reported no headline metric.

If a reported figure changes, edit the SVG.

---

## Publishing

`quarto render` writes to **`docs/`**, which is committed. GitHub Pages serves it directly
from the branch — no CI, nothing to keep alive. `docs/.nojekyll` stops Pages from trying to
Jekyll-build the output.

```sh
quarto render
git add -A && git commit -m "Update site"
git push
```

**One-time setup:** in the repo's Settings → Pages, set Source to *Deploy from a branch*,
branch `master`, folder **`/docs`**. It was previously serving the repo root as a Jekyll
site, so this must be changed or the site will not update.

---

## History

This repo was an [academicpages](https://github.com/academicpages/academicpages.github.io)
Jekyll fork until September 2026. The full previous site, including its git history, is
archived at:

```
../portfolio-jekyll-backup-20260910.zip   (73 MB, 947 entries)
```

The rebuild also fixed content bugs carried over from that site: eight broken PDF links
pointing at an old `personal_page` repo, a conference entry that had ASCO's talk filed
under JSM's name and city, `McComb` → `McCombs School of Business`, `Baltimore, MA` → `MD`,
a dead project link, and a 648 KB portrait served for a 160 px slot.

## Known gaps

- `cv.qmd` covers Positions and Education only; everything else points at the PDF.
- The homepage says *Seattle, WA*; the CV says Truveta is in *Bellevue, WA*. Both are true.
