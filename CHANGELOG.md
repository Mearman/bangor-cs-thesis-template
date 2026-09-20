## [1.2.3](https://github.com/Mearman/bangor-cs-thesis-template/compare/v1.2.2...v1.2.3) (2026-09-20)


### Bug Fixes

* no-tags on the vendor fetch ([bb576a1](https://github.com/Mearman/bangor-cs-thesis-template/commit/bb576a18efbd2d6d5a839f763d7293529094ea69))

## [1.2.2](https://github.com/Mearman/bangor-cs-thesis-template/compare/v1.2.1...v1.2.2) (2026-09-20)


### Bug Fixes

* drop capitalise so cref and Cref differ, convention documented ([3757b8c](https://github.com/Mearman/bangor-cs-thesis-template/commit/3757b8c5d234fbf027ce538da5582f36b5c34686))

## [1.2.1](https://github.com/Mearman/bangor-cs-thesis-template/compare/v1.2.0...v1.2.1) (2026-09-20)


### Bug Fixes

* escape the cref-colon in prose, all types compile green ([d4cedf4](https://github.com/Mearman/bangor-cs-thesis-template/commit/d4cedf47313403feac7854f7f32f4e1f7e786d95))

# [1.2.0](https://github.com/Mearman/bangor-cs-thesis-template/compare/v1.1.4...v1.2.0) (2026-09-20)


### Features

* cleveref references and every content type demonstrated ([beecb16](https://github.com/Mearman/bangor-cs-thesis-template/commit/beecb16180da0aa7f39adbf26c5c22670238a95c))
* every content type with cleveref, vendor updated ([48939a1](https://github.com/Mearman/bangor-cs-thesis-template/commit/48939a105d74ea78d2c5fa149a1a04cd0b8b73ce))

## [1.1.4](https://github.com/Mearman/bangor-cs-thesis-template/compare/v1.1.3...v1.1.4) (2026-09-20)


### Bug Fixes

* grep -cv exits nonzero on empty input, killing the step under errexit ([828e685](https://github.com/Mearman/bangor-cs-thesis-template/commit/828e685ff411514f2256fbd47e1e2d0a7fbd9be6))

## [1.1.3](https://github.com/Mearman/bangor-cs-thesis-template/compare/v1.1.2...v1.1.3) (2026-09-20)


### Bug Fixes

* vendor sync via git archive, needing no subtree merge ancestry ([36ed6d7](https://github.com/Mearman/bangor-cs-thesis-template/commit/36ed6d76c78a8264147ddbbe2e14ee54fbb0527c))

## [1.1.2](https://github.com/Mearman/bangor-cs-thesis-template/compare/v1.1.1...v1.1.2) (2026-09-19)


### Bug Fixes

* squash the vendor subtree bump so it needs no merge ancestry ([37db6b6](https://github.com/Mearman/bangor-cs-thesis-template/commit/37db6b677dd7436585592a86b3b1cafdac0d7a99))

## [1.1.1](https://github.com/Mearman/bangor-cs-thesis-template/compare/v1.1.0...v1.1.1) (2026-09-19)


### Bug Fixes

* subtree bump pulls from main, avoiding unrelated histories on the release tag ([7877563](https://github.com/Mearman/bangor-cs-thesis-template/commit/78775635bb164b515063c95767bc3687b1526bfd))

# [1.1.0](https://github.com/Mearman/bangor-cs-thesis-template/compare/v1.0.0...v1.1.0) (2026-09-19)


### Bug Fixes

* attach the built documentation PDF from its actual path ([1729ab0](https://github.com/Mearman/bangor-cs-thesis-template/commit/1729ab0676fbb6bc244fc1536824c80b268bd293))
* biber search path for smoke tests, texlua-invoked l3build, version-safe latexindent config ([a610d64](https://github.com/Mearman/bangor-cs-thesis-template/commit/a610d649c25706df4550d3da1d7901df8c5070b8))
* clean latexindent backups after formatting ([8884a23](https://github.com/Mearman/bangor-cs-thesis-template/commit/8884a237a4e74374c3968eb6584cc1c97da111bd))
* correct l3build fetch path and strip trailing whitespace ([48c86c9](https://github.com/Mearman/bangor-cs-thesis-template/commit/48c86c940f920d5fa9f8952b5237e8a91bbfc0f3))
* narrow the lint disabled set and the CI undefined grep ([02417ab](https://github.com/Mearman/bangor-cs-thesis-template/commit/02417abce36d72c6f56928b626cd32f60721ffcc))
* rewrite the version stamp in python to avoid sed delimiter conflicts ([73b2465](https://github.com/Mearman/bangor-cs-thesis-template/commit/73b2465362faeda1e2f9aab771fb44524ac6650b))
* TEXMFHOME bootstrap for l3build and disable the expl3 double-space lint ([1b678bb](https://github.com/Mearman/bangor-cs-thesis-template/commit/1b678bbe5eb8ba351decef25afeb6d851a78a2f4))
* whitespace-clean sources and error-only chktex gate ([8d80232](https://github.com/Mearman/bangor-cs-thesis-template/commit/8d80232db5577929dfa2db0d96f555b4ff3066a3))
* wordmark renders black by default per the brand colour restraint guidance ([082dc00](https://github.com/Mearman/bangor-cs-thesis-template/commit/082dc001413e0c165ffae568169863d2337dc3f4))


### Features

* branded action badges and one-click format workflow ([127f5b5](https://github.com/Mearman/bangor-cs-thesis-template/commit/127f5b50d1f0b2b0c6021e34bfbcc877cf20d81f))

# 1.0.0 (2026-09-19)


### Bug Fixes

* add texlive-science for algorithm packages and version-safe latexindent config ([e8117a7](https://github.com/Mearman/bangor-cs-thesis-template/commit/e8117a716ec93529670d051a5384a33ad050caef))
* colour-only listing keywords and reference-specific CI grep ([8321457](https://github.com/Mearman/bangor-cs-thesis-template/commit/8321457186041fff58337d401c58839abba6e64c))


### Features

* add worked computer science project example with listings and algorithms ([ee21a05](https://github.com/Mearman/bangor-cs-thesis-template/commit/ee21a05975702154a7cf0f29bf7edccf103c2c94))
* **brand:** add bangor brand layer with palette, crest, wordmark, and version stamp ([c7f9f77](https://github.com/Mearman/bangor-cs-thesis-template/commit/c7f9f7732d310067cd94f51c708244f923751f64))
* **declarations:** add statutory declarations in English and Welsh ([1c3281e](https://github.com/Mearman/bangor-cs-thesis-template/commit/1c3281e9fc5cdb2ae34ab3b656130388eff3f992))
* **identity:** add document metadata and identity block module ([e47405b](https://github.com/Mearman/bangor-cs-thesis-template/commit/e47405b7258074f54c1d62959606bd8cca790c15))
* **layout:** add regulation layout module with strict validation ([0eac4c2](https://github.com/Mearman/bangor-cs-thesis-template/commit/0eac4c2da2323b9a5b5189fc2690c70d5c79a077))
* **letter:** add headed letter style ([e020d83](https://github.com/Mearman/bangor-cs-thesis-template/commit/e020d83531699e4a463856e29d538e1527eb6d2f))
* **thesis:** add thesis and dissertation class ([b73d668](https://github.com/Mearman/bangor-cs-thesis-template/commit/b73d6686e8e321465807a36934c7b5565d8db371))
