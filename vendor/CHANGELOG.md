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
