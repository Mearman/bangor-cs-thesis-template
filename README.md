# Bangor University computer science thesis and dissertation template

A LaTeX template for computer science projects at Bangor University, and the natural successor to the department's `bangorcsthesis` class. It compiles on Overleaf with no install step: the package modules it needs sit in `vendor/`. This README uses controlled English. It is written in British English.

## Start on Overleaf

1. Press the green *Use this template* button on this repository. You get your own copy.
2. Open Overleaf and select *New Project*, then *Import from GitHub*.
3. Select your copy. Overleaf compiles it with pdfLaTeX at once.

If you use git on your own machine, clone your copy instead and run `latexmk -pdf main.tex`.

## Write your project

Set your facts in `main.tex`: title, author, degree scheme, school, supervisor, date, and word count. The degree option is `bsc` in the worked example; switch it for `meng`, `msc`, or `phd` as you need. Research options set the title page to say *thesis*; taught options set it to say *dissertation*.

The citation style is IEEE, the department convention. Change it with the `citations` option if your supervisor asks for another style.

Code listings, algorithm floats, and the verbatim setup live in `preamble-cs.tex`. That file is yours to adjust: these are school conventions, not university rules.

The class checks the university format rules and fails the build when one is broken: the font family and size, the margins, the 1.5 line spacing, and the 600-word cap on the abstract. Set `strict=false` to turn each failure into a warning. Check your module handbook for rules this template does not cover, such as the project word count.

State how you used generative AI tools. Replace the bracketed guidance through the `\aistatement` command in `main.tex`, and check your school's current policy.

## Keep the vendored modules current

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

The modules in `vendor/` are released under the LaTeX Project Public License, version 1.3c or later. They are derived in part from the `bangorcsthesis` class by Cameron Gray, Bangor University, as is this template's purpose.

## Roadmap

Done:

- Worked example project with listings, algorithm floats, tables, and IEEE citations.
- Vendored package modules with automatic vendor updates.
- CI that compiles the template and checks the compile time against the Overleaf free-tier budget.

Next:

- A migration table from `bangorcsthesis` options, written from real conversions.

At the CTAN switchover:

- This template stops vendoring and resolves against the installed package. The update workflow migrates your copy for you.
- A `-vendored` duplicate of this template keeps carrying the vendored copies, for people who want to tweak the module sources directly. Both variants stay available.
