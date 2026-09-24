# bangor
[![Open in Overleaf](https://img.shields.io/badge/Open_in_Overleaf-44A141?style=for-the-badge&logo=overleaf&logoColor=white)](https://www.overleaf.com/docs?snip_uri=https://github.com/Mearman/bangor/archive/refs/heads/main.zip)
[![Download ZIP](https://img.shields.io/badge/Download_ZIP-ED0000?style=for-the-badge&labelColor=231F20&logo=data:image/svg%2Bxml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAxNiAxNiIgd2lkdGg9IjE2IiBoZWlnaHQ9IjE2Ij48cmVjdCB4PSI3LjMiIHk9IjEiIHdpZHRoPSIxLjQiIGhlaWdodD0iNS41IiBmaWxsPSJ3aGl0ZSIvPjxwYXRoIGQ9Ik04IDEwLjUgNC43IDYuOGg2LjZaIiBmaWxsPSJ3aGl0ZSIvPjxwYXRoIGQ9Ik0yIDExLjV2MS44YTEuMiAxLjIgMCAwIDAgMS4yIDEuMmg5LjZhMS4yIDEuMiAwIDAgMCAxLjItMS4ydi0xLjhoLTEuNXYxLjVIMy41di0xLjVaIiBmaWxsPSJ3aGl0ZSIvPjwvc3ZnPg==)](https://github.com/Mearman/bangor/archive/refs/heads/main.zip)

A single LaTeX class for Bangor University documents: `bangor.cls`. It typesets theses and dissertations to the regulation layout, and headed letters, from one self-contained file. This README uses controlled English. It is written in British English.

This class replaces the department's `bangorcsthesis` class, which times out on Overleaf. The cause was a heavy design: a large inline drawing of the crest, a fixed citation style, and a large package stack. This class keeps the compile light. The crest ships as a pre-rendered PDF. The citation style is an option. The package stack is small.

## What is in the class

One file holds everything: the brand facts (the colours, the crest, the wordmark, the version stamp), the document identity, the regulation layout with strict validation, the statutory declarations, the thesis body, and the headed letter style. Two features are optional class options, so a document pays for them only when it asks: `tables` adds the `longtabular` environment, and `glossary` adds the abbreviation list. The only other file is the crest, `bangor-crest-colour.pdf`, which sits beside the class.

Full interface documentation is in `doc/bangor.pdf`.

## Install

Copy two files into your project folder: `bangor.cls` and `bangor-crest-colour.pdf`. Every release publishes both:

```sh
curl -LO https://github.com/Mearman/bangor/releases/latest/download/bangor.cls
curl -LO https://github.com/Mearman/bangor/releases/latest/download/bangor-crest-colour.pdf
```

TeX Live and MiKTeX users can install the class from CTAN once it is published.

If the crest file is missing, the build does not stop. The first use of the crest prints a frame that holds the wordmark, and the log shows one warning that names the download address.

## Use

Start a thesis or dissertation like this:

```latex
\documentclass[phd,12pt,a4paper]{bangor}
```

Set the document facts in the preamble, then build the front matter:

```latex
\school{School of Computer Science and Engineering}
\college{College of Science and Engineering}
\degreescheme{Doctor of Philosophy}
\supervisor{Dr A. Supervisor}
\bibliographysetup
\addbibresource{references.bib}

\begin{document}
\maketitle
\statementspage
\begin{acknowledgements}...\end{acknowledgements}
\begin{abstract}...\end{abstract}
\tables
```

Add `tables` and `glossary` to the option list when the document needs the `longtabular` environment or the abbreviation list:

```latex
\documentclass[phd,tables,glossary,12pt,a4paper]{bangor}
```

Start a headed letter with the `letter` option. The class loads the standard `letter` class for you:

```latex
\documentclass[letter,a4paper,11pt]{bangor}
\school{School of Computer Science and Engineering}
\begin{document}
\begin{letter}{The Recipient}
  \bangorletterhead
  \opening{Dear Recipient,}
  ...
\end{letter}
\end{document}
```

A letter takes no thesis option. Mixing them, for example `[letter,phd]`, is an error that names the option.

The GitHub template repositories give you a working document in one step:

- `bangor-thesis-template`: the general thesis and dissertation template.
- `bangor-cs-thesis-template`: the computer science variant, with code listings and algorithm floats.
- `bangor-letter-template`: the headed letter template.

Use the green *Use this template* button, then import your copy into Overleaf. The templates carry a copy of `bangor.cls` and the crest in `vendor/`, so they compile with no install step.

## Upgrading from version 5

Version 6 replaces the module family with one class. This is a breaking change.

| Version 5 | Version 6 |
| --- | --- |
| `\documentclass{bangorthesis}` | `\documentclass{bangor}` |
| `\usepackage{bangortables}` | class option `tables` |
| `\usepackage{bangorglossary}` | class option `glossary` |
| `\documentclass{letter}` and `\usepackage{bangorletter}` | `\documentclass[letter]{bangor}` |
| `\usepackage{bangor}`, `bangoridentity`, `bangorlayout`, `bangordeclarations` | not needed, the class provides them |

The public commands keep their names. Delete the old `.aux` file once after you upgrade, because the abbreviation page lists in it were written by the old modules. A document that must keep using a separate module can stay on version 5.

## Tables

The class option `tables` provides `longtabular`, one environment for tables that run past a page, need X columns to fit the text width, or both. It paginates with the header repeating when the header rows sit before `\endhead`, and its optional `[wide]` form rotates the table onto a landscape page. `[columns=N]` instead wraps a narrow table's rows into N side-by-side panes on one page, with the head repeated in each pane and the caption printed once above; the wrapped table must fit one page, and in this form the head sits between `\panehead` and `\endpanehead` in the body. The options combine (`[wide,columns=2]`); any other optional value is an error. The underlying `longtable`, `tabularx` and `landscape` remain available for special cases.

## Regulation checks

The class checks the rules from Regulation 03, 2025 Version 01, section 6.3: the font family and size floors, the binding and side margins, the 1.5 line spacing, and the 600-word cap on the abstract. Strict mode is on by default. A violation fails the build. Set `strict=false` to turn each failure into a warning.

The checks govern settings made through this class. They cannot see changes made around it.

## Front matter and the contents

The contents lists the numbered chapters, the bibliography and the appendices. The unnumbered front matter (the abstract, the acknowledgements, the list of abbreviations and the lists of figures and tables) is not entered in it by default, but each heading still gets a PDF bookmark. Set `frontmattertoc` to enter all of them, with their roman-numeral pages. `\tables` prints the contents, then a list of figures and a list of tables only when the document has figures or tables, so a document without figures has no empty list page. The list appears from the second run, once the first run has recorded that floats exist. Other lists, such as a list of listings from a package, are the document's own to add. `\bangorfrontheading{Title}` prints a heading of the same kind for a front matter page of your own.

## Page numbering

The title page carries no number. The front matter (acknowledgements, abstract, contents and lists) is numbered in roman numerals, centred in the footer, and has no running header. The numbering restarts in arabic at the first numbered chapter, and the running header and footer start there. The switch is automatic, so there is no command to call. Each appendix is numbered on its own: the count restarts at each appendix, the footer reads "Appendix A - Page n of m" where m is the number of pages in that appendix, and the contents list the pages as `A-1`. Set `appendixpages=false` to continue the arabic sequence of the main text through the appendices instead. The footer reads "Page N of M", where M is the last page of the main text while appendices are numbered on their own, and the last page of the document with `appendixpages=false`. Set `pageofm=false` to print the number alone.

## Captions

`\captiondesc[short]{title}{description}` is the caption form that also carries a description: the title prints as the caption, the description prints beneath it in smaller type, and the short form is the list-of-floats entry, defaulting to the title exactly as with `\caption`. Plain `\caption` is unchanged and the two can be mixed freely. A list entry longer than 80 characters fails the build in strict mode and warns with `strict=false`; give the caption a short form.

## Float numbering

Floats are numbered within their section, on one counter for every float type, so the first float in section 5.1 is 5.1.1 and the sequence reads Figure 5.1.1, Table 5.1.2, Listing 5.1.3. Two options control this, and both are on by default. `sharedfloats=false` gives each float type its own counter. `sectionfloats=none` numbers floats within their chapter instead of their section. A float that comes before the first section of a chapter is numbered by the chapter alone (5.1). Set `sectionfloats=zero` to number it by section zero (5.0.1) instead. Listings and algorithms take part when their packages are loaded.

## Headers and footers

The class sets running headers and footers. By default the header shows the chapter name on the left and the section name on the right, and the footer shows the title and the page number. Set `\shorttitle{Short title}` for a shorter footer title. Class options change the layout: `headers=chapter` puts the page number in the header, `pageofm=false` prints the page number alone instead of "Page N of M", and `headrule` and `footrule` each take `hairline` (the default), `visible`, or `none`.

A name too wide for the header, or a title too wide for the footer, fails the build in strict mode. Use `\chapter[Short title]{Long title}` for a shorter running title, or `\shorttitle` for the footer. With `strict=false` the text is cut short and the build shows a warning.

Citation style is a class option, not a school lookup: `citations=ieee` is the default, and any biblatex style name is valid. Ask your supervisor which style your school requires.

## Contribute

Make changes in this repository. Never edit the vendored copies inside the template repositories: they are snapshots of this repository, and a fix made there is lost at the next update. Each template repository pulls `bangor.cls` and the crest into its `vendor/` directory from a tagged release here.

Commit messages follow the conventional commit format. The git hooks and CI check it. Set up the hooks once per clone:

```sh
git config core.hooksPath .githooks
```

`l3build` is the build entry point: `l3build doc` compiles the documentation, `l3build ctan` builds the distribution archive. `latexmk -pdf tests/smoke/<name>.tex` runs one smoke test.

## Licence

Released under the LaTeX Project Public License, version 1.3c or later. See `LICENSE`. Derived in part from the `bangorcsthesis` class by Cameron Gray, Bangor University.

## Roadmap

Done:

- Brand layer: palette, crest, wordmark, version stamp.
- Identity, layout with strict regulation checks, and statutory declarations.
- Headed letter style and the thesis and dissertation class, in one class.
- Regulation-derived settings: font choice, print or digital, Welsh declaration, word count statement.
- Smoke tests, CI, git hooks, and automatic releases with changelogs.

Next:

- Official crest masters from the university brand library, plus the monochrome and horizontal variants.
- CTAN upload of `bangor.cls`, once the university confirms the terms for redistributing the crest.
- Brand typeface option for engines that support system fonts.
- CI word-count enforcement for the thesis word limits by degree.

Later:

- Further templates as demand appears.
- Full Welsh localisation of the interface strings.

At the CTAN switchover:

- The template repositories stop vendoring and resolve against the installed package.
- Each template is duplicated under a `-vendored` suffix, for people who want to tweak the module sources directly. Both variants stay available.
