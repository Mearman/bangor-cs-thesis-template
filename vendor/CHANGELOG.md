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
