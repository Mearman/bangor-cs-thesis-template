## [5.3.1](https://github.com/Mearman/bangor/compare/v5.3.0...v5.3.1) (2026-09-21)

### Bug Fixes

* keep a wrapped table's caption and panes on one page ([cbb5d8f](https://github.com/Mearman/bangor/commit/cbb5d8fd422c044b796f6dc9f04b11bbac605f4f))

## [5.3.0](https://github.com/Mearman/bangor/compare/v5.2.0...v5.3.0) (2026-09-21)

### Features

* wrap narrow tables into side-by-side panes with columns=N ([438a420](https://github.com/Mearman/bangor/commit/438a4200d4b48f3592aff917fd5861ce78c1510c))

### Styles

* run latexindent over the sources ([c5fb4a6](https://github.com/Mearman/bangor/commit/c5fb4a6b07eed3e0bacba230ea2bca5a188bd104))

## [5.2.0](https://github.com/Mearman/bangor/compare/v5.1.0...v5.2.0) (2026-09-21)

### Features

* add longtabular, one environment for tall and wide tables ([736bb46](https://github.com/Mearman/bangor/commit/736bb46ab7d35e5fddb68c1ab01f2af93cd18458))

### Styles

* run latexindent over the sources ([8e790c4](https://github.com/Mearman/bangor/commit/8e790c4b0a2311253cdd3ba7ade5a286bea6abd6))

## [5.1.0](https://github.com/Mearman/bangor/compare/v5.0.4...v5.1.0) (2026-09-21)

### Features

* add captiondesc, the caption form that carries a description ([795287c](https://github.com/Mearman/bangor/commit/795287c94d4498965acb38ce127bbc58d5f23768))
* fail on list-of-floats entries past eighty characters ([44dda88](https://github.com/Mearman/bangor/commit/44dda887751249fdac06fa99e7ab576ad87f1e74))

### Styles

* run latexindent over the sources ([29191db](https://github.com/Mearman/bangor/commit/29191db29c521e7cbb76847bd85e9b3fbbd3b442))

## [5.0.4](https://github.com/Mearman/bangor/compare/v5.0.3...v5.0.4) (2026-09-21)

### Bug Fixes

* give paragraphs with an unbreakable word emergency stretch ([6ac51be](https://github.com/Mearman/bangor/commit/6ac51be48ae33d48f42e20c251a7e20f3b71b82b))
* reference the total page count without a link ([9c5e393](https://github.com/Mearman/bangor/commit/9c5e393c4374e48e6ec0ce7f0a31e00f22216701))
* set fonts in T1 so a typewriter backslash has a font shape ([69285c5](https://github.com/Mearman/bangor/commit/69285c54ef9fd612e202460542bcd32fefce7ab9))

## [5.0.3](https://github.com/Mearman/bangor/compare/v5.0.2...v5.0.3) (2026-09-21)

### Continuous Integration

* apply the header length limit in the commit-msg hook ([48f1d61](https://github.com/Mearman/bangor/commit/48f1d61f81462ed7b473821859978cbabd6c0935))
* release every conventional commit type and list each in the notes ([9cc93da](https://github.com/Mearman/bangor/commit/9cc93daf7289c0dd576e5e2eafda84c0634ba914))

## [5.0.2](https://github.com/Mearman/bangor/compare/v5.0.1...v5.0.2) (2026-09-21)


### Bug Fixes

* give tables and listings that share the figure counter the figure's anchor name ([9272839](https://github.com/Mearman/bangor/commit/9272839e9c64a348859bcdee694e7018ea660c03))
* load float before hyperref so table and figure destinations stay unique ([b0f3192](https://github.com/Mearman/bangor/commit/b0f3192c4bafba9042530406bf6d6315ea29bcc7))

## [5.0.1](https://github.com/Mearman/bangor/compare/v5.0.0...v5.0.1) (2026-09-21)


### Bug Fixes

* title the list of abbreviations like the other front matter lists ([15e50a4](https://github.com/Mearman/bangor/commit/15e50a4df00c2b4fb7fbee47344de3b3e8f63b59))

# [5.0.0](https://github.com/Mearman/bangor/compare/v4.1.1...v5.0.0) (2026-09-21)


* feat!: enter the unnumbered front matter in the contents only with frontmattertoc ([1098d0e](https://github.com/Mearman/bangor/commit/1098d0ed095253c3668d3ba59bc3497ea6c8a809))


### BREAKING CHANGES

* the abstract and the acknowledgements no longer appear
in the contents, and a document without figures or tables no longer
prints an empty list page. Set frontmattertoc in the class options to
enter the front matter in the contents as before.

## [4.1.1](https://github.com/Mearman/bangor/compare/v4.1.0...v4.1.1) (2026-09-20)


### Bug Fixes

* print the total pages of each appendix in the appendix footer ([8060988](https://github.com/Mearman/bangor/commit/80609886edfc55e44330b2a752d7a3b435d550f3))

# [4.1.0](https://github.com/Mearman/bangor/compare/v4.0.0...v4.1.0) (2026-09-20)


### Bug Fixes

* write the last page number after the final page has shipped ([6099b24](https://github.com/Mearman/bangor/commit/6099b242dc702ff57307f2aa8d9a7197c2af93fa))


### Features

* give the list of abbreviations a heading and the pages that use each entry ([c7bfc5e](https://github.com/Mearman/bangor/commit/c7bfc5efed302fa78c8d4774047758fb322d677e))

# [4.0.0](https://github.com/Mearman/bangor/compare/v3.0.0...v4.0.0) (2026-09-20)


* feat!: print Page N of M and number each appendix on its own by default ([ee39c9d](https://github.com/Mearman/bangor/commit/ee39c9d064790e4c0cd159f3f23041df7c59b482))


### BREAKING CHANGES

* page numbers in existing documents change. The footer
now reads "Page N of M" and appendix pages are numbered per appendix.
Set pageofm=false and appendixpages=false in the class options to keep
the previous numbering.

# [3.0.0](https://github.com/Mearman/bangor/compare/v2.3.0...v3.0.0) (2026-09-20)


* feat!: number floats within sections on one shared counter by default ([86b91a4](https://github.com/Mearman/bangor/commit/86b91a492ad3600c8e9df0e0fc6662533f4a5481))


### BREAKING CHANGES

* float numbers in existing documents change. Figures,
tables, listings and algorithms now share one counter that restarts at
each section. Set sharedfloats=false and sectionfloats=none in the class
options to keep the previous numbering.

# [2.3.0](https://github.com/Mearman/bangor/compare/v2.2.0...v2.3.0) (2026-09-20)


### Features

* add sharedfloats and sectionfloats options for float numbering ([75361a0](https://github.com/Mearman/bangor/commit/75361a02fc0e5d930b61a7fa6ad434f57af60fa5))

# [2.2.0](https://github.com/Mearman/bangor/compare/v2.1.1...v2.2.0) (2026-09-20)


### Bug Fixes

* push the formatting commit to the branch the workflow was run on ([1eeabad](https://github.com/Mearman/bangor/commit/1eeabad7dfe1a89cbdd3da505a1b348ed90d3a3d))


### Features

* number the title page, front matter, main text and appendices separately ([b338444](https://github.com/Mearman/bangor/commit/b33844496a4edb9647c29a4584d569667cd7a5fb))

## [2.1.1](https://github.com/Mearman/bangor/compare/v2.1.0...v2.1.1) (2026-09-20)


### Bug Fixes

* align the section name to the right edge of the running header ([63640eb](https://github.com/Mearman/bangor/commit/63640eb369b04ffe7c1ddf7a6612a05c1687dc7c))

# [2.1.0](https://github.com/Mearman/bangor/compare/v2.0.0...v2.1.0) (2026-09-20)


### Features

* configurable headers and footers with strict overflow checks ([6e4cf50](https://github.com/Mearman/bangor/commit/6e4cf50442ceeb453ea786f5deaca254c3e8defa))
* **identity:** add shorttitle for the running footer ([2d59713](https://github.com/Mearman/bangor/commit/2d5971349f8296cf1ba130e22422df007852aee9))

# [2.0.0](https://github.com/Mearman/bangor/compare/v1.3.0...v2.0.0) (2026-09-20)


* refactor!: use lowercase command names and rename commands that clash with packages ([e65bb57](https://github.com/Mearman/bangor/commit/e65bb579ab1a8c4dd751407e0df99416580a63ce))


### BREAKING CHANGES

* several commands are renamed.
\degreeScheme is now \degreescheme.
\bibliographySetup is now \bibliographysetup.
\wordcount is now \submissionwordcount, because stringstrings also defines \wordcount.
\gls and \Gls are now \useabbrev and \Useabbrev, because glossaries defines \gls and \Gls.

# [1.3.0](https://github.com/Mearman/bangor/compare/v1.2.2...v1.3.0) (2026-09-20)


### Bug Fixes

* use kernel str_compare instead of redefining it ([1f284d4](https://github.com/Mearman/bangor/commit/1f284d48242ee697a2e1c9db732f319376d7b625))


### Features

* zero-dependency abbreviations module, headheight fix, lstlisting cref ([9f31375](https://github.com/Mearman/bangor/commit/9f31375d3987667f4b832d8da2ea462349827356))

## [1.2.2](https://github.com/Mearman/bangor/compare/v1.2.1...v1.2.2) (2026-09-20)


### Bug Fixes

* amsmath loads before cleveref so the glossary module doesn't break load order ([f507133](https://github.com/Mearman/bangor/commit/f5071334c2840a36e067d699973d11d23896fed2))
* bangortables and bangorglossary are opt-in, not loaded by default ([2152482](https://github.com/Mearman/bangor/commit/2152482a9938001b7c58ab9b19f77a424b385de1))

## [1.2.1](https://github.com/Mearman/bangor/compare/v1.2.0...v1.2.1) (2026-09-20)


### Bug Fixes

* bangortables loads longtable, tabularx, pdflscape independently ([9d21ad2](https://github.com/Mearman/bangor/commit/9d21ad2308c8d6c92aff5c9dec15226a70cfda42))

# [1.2.0](https://github.com/Mearman/bangor/compare/v1.1.1...v1.2.0) (2026-09-20)


### Features

* table support via xltabular, glossary abbreviations, running headers replacing markdraft ([304f085](https://github.com/Mearman/bangor/commit/304f085df62d83e931ec94b4d48331d52f05ab70))

## [1.1.1](https://github.com/Mearman/bangor/compare/v1.1.0...v1.1.1) (2026-09-20)


### Bug Fixes

* drop the capitalise option so cref and Cref differ as documented ([f59ca6b](https://github.com/Mearman/bangor/commit/f59ca6b587113918b71d63260e9a87ced1b9eba8))

# [1.1.0](https://github.com/Mearman/bangor/compare/v1.0.4...v1.1.0) (2026-09-20)


### Features

* load cleveref after hyperref so templates reference content by label alone ([27081cc](https://github.com/Mearman/bangor/commit/27081cc3fc3ad102991738c3bc929c770f201d4f))

## [1.0.4](https://github.com/Mearman/bangor/compare/v1.0.3...v1.0.4) (2026-09-20)


### Bug Fixes

* pdfinfo for metadata, correct output paths ([f7799ad](https://github.com/Mearman/bangor/commit/f7799ad2254bc74f6ea7f6db337b0e6b910d7339))
* pdfinfo Subject for the metadata assertion, correct log paths ([b2f946b](https://github.com/Mearman/bangor/commit/b2f946b6c51d03c6832f54c045398dc434473fc2))

## [1.0.3](https://github.com/Mearman/bangor/compare/v1.0.2...v1.0.3) (2026-09-19)


### Bug Fixes

* packaging job needs the full TeX engine for the ctan check gate ([b68919e](https://github.com/Mearman/bangor/commit/b68919edca1e8c6f5057f724f833b25a5a55d4fe))

## [1.0.2](https://github.com/Mearman/bangor/compare/v1.0.1...v1.0.2) (2026-09-19)


### Bug Fixes

* install the babel welsh language pack for the option coverage fixture ([60ea0d4](https://github.com/Mearman/bangor/commit/60ea0d4271d198112cc87c23e6c0bbf6952a4932))

## [1.0.1](https://github.com/Mearman/bangor/compare/v1.0.0...v1.0.1) (2026-09-19)


### Bug Fixes

* attach the built documentation PDF from its actual path ([1729ab0](https://github.com/Mearman/bangor/commit/1729ab0676fbb6bc244fc1536824c80b268bd293))
* wordmark renders black by default per the brand colour restraint guidance ([082dc00](https://github.com/Mearman/bangor/commit/082dc001413e0c165ffae568169863d2337dc3f4))

# 1.0.0 (2026-09-19)


### Bug Fixes

* biber search path for smoke tests, texlua-invoked l3build, version-safe latexindent config ([a610d64](https://github.com/Mearman/bangor/commit/a610d649c25706df4550d3da1d7901df8c5070b8))
* clean latexindent backups after formatting ([8884a23](https://github.com/Mearman/bangor/commit/8884a237a4e74374c3968eb6584cc1c97da111bd))
* correct l3build fetch path and strip trailing whitespace ([48c86c9](https://github.com/Mearman/bangor/commit/48c86c940f920d5fa9f8952b5237e8a91bbfc0f3))
* narrow the lint disabled set and the CI undefined grep ([02417ab](https://github.com/Mearman/bangor/commit/02417abce36d72c6f56928b626cd32f60721ffcc))
* rewrite the version stamp in python to avoid sed delimiter conflicts ([73b2465](https://github.com/Mearman/bangor/commit/73b2465362faeda1e2f9aab771fb44524ac6650b))
* TEXMFHOME bootstrap for l3build and disable the expl3 double-space lint ([1b678bb](https://github.com/Mearman/bangor/commit/1b678bbe5eb8ba351decef25afeb6d851a78a2f4))
* whitespace-clean sources and error-only chktex gate ([8d80232](https://github.com/Mearman/bangor/commit/8d80232db5577929dfa2db0d96f555b4ff3066a3))


### Features

* **brand:** add bangor brand layer with palette, crest, wordmark, and version stamp ([c7f9f77](https://github.com/Mearman/bangor/commit/c7f9f7732d310067cd94f51c708244f923751f64))
* branded action badges and one-click format workflow ([127f5b5](https://github.com/Mearman/bangor/commit/127f5b50d1f0b2b0c6021e34bfbcc877cf20d81f))
* **declarations:** add statutory declarations in English and Welsh ([1c3281e](https://github.com/Mearman/bangor/commit/1c3281e9fc5cdb2ae34ab3b656130388eff3f992))
* **identity:** add document metadata and identity block module ([e47405b](https://github.com/Mearman/bangor/commit/e47405b7258074f54c1d62959606bd8cca790c15))
* **layout:** add regulation layout module with strict validation ([0eac4c2](https://github.com/Mearman/bangor/commit/0eac4c2da2323b9a5b5189fc2690c70d5c79a077))
* **letter:** add headed letter style ([e020d83](https://github.com/Mearman/bangor/commit/e020d83531699e4a463856e29d538e1527eb6d2f))
* **thesis:** add thesis and dissertation class ([b73d668](https://github.com/Mearman/bangor/commit/b73d6686e8e321465807a36934c7b5565d8db371))
