# Bangor University computer science thesis and dissertation template
[![Open in Overleaf](https://img.shields.io/badge/Open_in_Overleaf-44A141?style=for-the-badge&logo=overleaf&logoColor=white)](https://www.overleaf.com/docs?snip_uri=https://github.com/Mearman/bangor-cs-thesis-template/archive/refs/heads/main.zip)
[![Use this template](https://img.shields.io/badge/Use_this_template-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/Mearman/bangor-cs-thesis-template/generate)
[![Download ZIP](https://img.shields.io/badge/Download_ZIP-ED0000?style=for-the-badge&labelColor=231F20&logo=data:image/svg%2Bxml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAxNiAxNiIgd2lkdGg9IjE2IiBoZWlnaHQ9IjE2Ij48cmVjdCB4PSI3LjMiIHk9IjEiIHdpZHRoPSIxLjQiIGhlaWdodD0iNS41IiBmaWxsPSJ3aGl0ZSIvPjxwYXRoIGQ9Ik04IDEwLjUgNC43IDYuOGg2LjZaIiBmaWxsPSJ3aGl0ZSIvPjxwYXRoIGQ9Ik0yIDExLjV2MS44YTEuMiAxLjIgMCAwIDAgMS4yIDEuMmg5LjZhMS4yIDEuMiAwIDAgMCAxLjItMS4ydi0xLjhoLTEuNXYxLjVIMy41di0xLjVaIiBmaWxsPSJ3aGl0ZSIvPjwvc3ZnPg==)](https://github.com/Mearman/bangor-cs-thesis-template/archive/refs/heads/main.zip)

A LaTeX template for computer science projects at Bangor University, and the natural successor to the department's `bangorcsthesis` class. It compiles on Overleaf with no install step: the class it needs sits in `vendor/`. This README uses controlled English. It is written in British English.

## Start on Overleaf

1. Press the *Open in Overleaf* badge above. Overleaf creates a project from this template and compiles it with pdfLaTeX at once. This path needs no GitHub account.
2. If you want your own git repository, press the *Use this template* badge or the green button instead, then import your copy into Overleaf from *New Project* and *Import from GitHub*.

If you use git on your own machine, clone your copy instead and run `latexmk -pdf main.tex`.

## Use it on your own TeX system

No git and no install step needed. Press the *Download ZIP* badge above, extract the archive, and run `latexmk -pdf main.tex` from the extracted folder. The `.latexmkrc` file beside `main.tex` points the compiler at `vendor/`, which is where the class and the crest live, so the project compiles as extracted.

The class is one file, `vendor/bangor.cls`, and it needs only the crest, `vendor/bangor-crest-colour.pdf`, beside it. The files that must stay together when you copy the project into your own setup are `main.tex`, `references.bib`, `preamble-cs.tex`, `continuation-markers.tex`, `.latexmkrc`, the whole `content/` folder, and the whole `vendor/` folder. If your editor runs `pdflatex` directly rather than through `latexmk`, set the `TEXINPUTS` environment variable to include `vendor//:` first, or point the editor at `latexmk`.


## Write your project

Set your facts in `main.tex`: title, author, degree scheme, school, supervisor, date, and word count. The degree option is `bsc` in the worked example; switch it for `meng`, `msc`, or `phd` as you need. Research options set the title page to say *thesis*; taught options set it to say *dissertation*.

Write your chapters under `content/chapters/`, one numbered folder per chapter. The `index.tex` in each folder holds the `\chapter` line and the text before the first section, and then inputs one file per section, numbered in order, each starting with its `\section`. `main.tex` inputs each chapter's `index`, so adding a chapter is a new folder and one line there, and adding a section is a new file and one line in that chapter's `index.tex`. Appendices follow the same layout under `content/appendices/`. Keep your sources in `references.bib`.

The citation style is IEEE, the department convention. Change it with the `citations` option if your supervisor asks for another style.

Code listings, algorithm floats, and the verbatim setup live in `preamble-cs.tex`. That file is yours to adjust: these are school conventions, not university rules.

The class checks the university format rules and fails the build when one is broken: the font family and size, the margins, the 1.5 line spacing, and the 600-word cap on the abstract. Set `strict=false` to turn each failure into a warning. Check your module handbook for rules this template does not cover, such as the project word count.

State how you used generative AI tools. Replace the bracketed guidance through the `\aistatement` command in `main.tex`, and check your school's current policy.

### Other class options

A few class options have no demonstration in this template because they change the document's whole shape. `print` adds a blank page before the title page and starts each chapter on a recto page, for duplex printing and binding. `welsh` prints the statutory declaration in Welsh and loads Welsh hyphenation through babel, for Welsh-medium submission. `frontmattertoc` enters the abstract, acknowledgements, lists of figures and tables, and list of abbreviations in the contents; by default they carry PDF bookmarks but no contents entries. The body font can be switched from the default Times-like face with `font=bonum` or `font=heros`. Set any of these on the `\documentclass` line.

## Keep the vendored class current

The file `vendor/VERSION` shows which package release your copy carries. A scheduled workflow keeps it current: it pulls the latest package release into `vendor/`, compiles the project against it, and lands the update directly when the result is green and the change stays inside `vendor/`. GitHub disables scheduled workflows after 60 days of repository inactivity. If you work only inside Overleaf, download the newest release of this template and copy the files in `vendor/` over your copies.

Never edit the files in `vendor/`. They are snapshots of the package repository, [Mearman/bangor](https://github.com/Mearman/bangor). A fix belongs there.

## From bangorcsthesis

If you have an existing document on the old `bangorcsthesis` class: start from this template, copy your chapters across, and move the metadata commands. Most of the old class options map directly onto this class. The old class timed out on Overleaf for every student; this one does not.

## Contribute

Make changes in the package repository, not in `vendor/` here. Commit messages follow the conventional commit format. Set up the hooks once per clone:

```sh
git config core.hooksPath .githooks
```

## Licence

The class in `vendor/` is released under the LaTeX Project Public License, version 1.3c or later. They are derived in part from the `bangorcsthesis` class by Cameron Gray, Bangor University, as is this template's purpose.

## Roadmap

Done:

- Worked example project with listings, algorithm floats, tables, and IEEE citations.
- A vendored copy of the class with automatic vendor updates.
- CI that compiles the template and checks the compile time against the Overleaf free-tier budget.

Next:

- A migration table from `bangorcsthesis` options, written from real conversions.

At the CTAN switchover:

- This template stops vendoring and resolves against the installed package. The update workflow migrates your copy for you.
- A `-vendored` duplicate of this template keeps carrying the vendored copies, for people who want to tweak the class source directly. Both variants stay available.
