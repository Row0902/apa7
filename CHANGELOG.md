# Changelog

All notable changes to this project will be documented in this file.
Format based on [Keep a Changelog](https://keepachangelog.com).

## [Unreleased]

## [v0.2.0] - 2026-11-13

### ✨ Features
- **release**: cut releases with the github-publish plugin in [#3](https://github.com/Row0902/pandect-apa7/pull/3) ([e630254](https://github.com/Row0902/pandect-apa7/commit/e63025457eb137b483e6ba92b0fd6159f3127fcd)) by @Row0902

### 🐛 Fixes
- **docs**: use absolute GitHub URLs for assets/docs and set compiler to 0.15.0 ([ee3b329](https://github.com/Row0902/pandect-apa7/commit/ee3b329aeddef46470937391ceb8189ee6971189)) by @Row0902
- **ci**: robust dry_run boolean evaluation for publish release step ([f0363aa](https://github.com/Row0902/pandect-apa7/commit/f0363aae3f171780b0c2df6daba2ff1c45dd33b7)) by @Row0902

### 🔄 Refactoring
- rename package to pandect-apa7 ([d5d0253](https://github.com/Row0902/pandect-apa7/commit/d5d02532cfc15fa236452e2f4bede351ee0f7400)) by @Row0902

### 📚 Documentation
- pin assets and documentation links to v0.1.0 release tag ([dc3479d](https://github.com/Row0902/pandect-apa7/commit/dc3479df2be7c1e7686ff3c3207fc5158a8faa2f)) by @Row0902
- add release orchestration section highlighting cutver ([3f35259](https://github.com/Row0902/pandect-apa7/commit/3f35259b217d132df9466d3fa809ad64e6759913)) by @Row0902
- add official released with cutver badge to readme ([8ab217c](https://github.com/Row0902/pandect-apa7/commit/8ab217c3879d07ab376e994a3d19d0b9b2bb88fe)) by @Row0902
- **changelog**: position unreleased section at top of changelog ([32b843c](https://github.com/Row0902/pandect-apa7/commit/32b843c47638780355de23b3ff438c47a49290bb)) by @Row0902

### 🛠️ Maintenance
- **release**: let the cutver preflight run on pull requests in [#2](https://github.com/Row0902/pandect-apa7/pull/2) ([206e379](https://github.com/Row0902/pandect-apa7/commit/206e379f32de5f37a1f8a550e136c67334073b12)) by @Row0902

### 👥 Contributors
@Row0902

[Compare v0.1.0...v0.2.0](https://github.com/Row0902/pandect-apa7/compare/v0.1.0...v0.2.0)
## [v0.1.0] - 2026-11-10
### 🐛 Bug Fixes
- **ci**: calibrate cutver/release inputs using command bump for dry-run simulation ([ee4f503](https://github.com/Row0902/pandect-apa7/commit/ee4f503aec4552fb9be8972dec797f9f295fde3e)) by @Row0902
- **appendix**: use weak pagebreak to prevent redundant blank pages ([ffc3bd5](https://github.com/Row0902/pandect-apa7/commit/ffc3bd5fae5d8cec370d16c5f5add965a8144d2d)) by @Row0902

### 🛠️ Maintenance & Dependencies
- **skills**: add cutver agent skills and lockfile for collaborative releases ([6db2943](https://github.com/Row0902/pandect-apa7/commit/6db2943f4e933d74757e1e5dca03cd4815656ae4)) by @Row0902
- initial scaffold for apa7 typst package ([60232e6](https://github.com/Row0902/pandect-apa7/commit/60232e63629de7e2f9a65e8b5905c34fe2416528)) by @Row0902

### 🛠️ Maintenance & Dependencies
- add GitHub Actions workflow to validate compilation and PDF/UA-1 accessibility ([2becc76](https://github.com/Row0902/pandect-apa7/commit/2becc7662a940346e7b2ed4170fb47d545ecf390)) by @Row0902

### 🚀 Features & Enhancements
- **package**: configure manifest and template for Typst Universe submission ([9c29aaf](https://github.com/Row0902/pandect-apa7/commit/9c29aaf3900396ca0e06c8781e893a10167ca0a6)) by @Row0902
- **math**: add spanish mathematical operators (sen, tg, ctg, mcd, rot, etc.) ([c832462](https://github.com/Row0902/pandect-apa7/commit/c8324620f83213939bbdefece3077ecff78e837c)) by @Row0902
- **theorem**: implement accessible STEM theorem and math blocks with QED and alt-text ([cf284f7](https://github.com/Row0902/pandect-apa7/commit/cf284f7a1e7c43dbd49b5d86331055c8ead7cebd)) by @Row0902
- **stat**: implement APA 7 statistical reporting engine with PDF/UA-1 accessibility ([54c9131](https://github.com/Row0902/pandect-apa7/commit/54c9131d8729143354087354d2fc1fbd34fde1b3)) by @Row0902
- **reference**: add cite-narrative and cite-parenthetical helpers with page support ([e4cd197](https://github.com/Row0902/pandect-apa7/commit/e4cd1976aca811e0d5c683a227c4982877035c5d)) by @Row0902
- **cover**: support spanish author coordination without oxford comma per normas-apa.org ([ecb0155](https://github.com/Row0902/pandect-apa7/commit/ecb0155bc9091fbd04ab7464fcfd8d325811ee5e)) by @Row0902
- implement APA 7 references, block quotes, math numbering and footnotes ([93992a4](https://github.com/Row0902/pandect-apa7/commit/93992a400f34c486c026eebd8ca8fea680302310)) by @Row0902
- implement accessible APA 7 appendix module with subordinate numbering ([e43a7fb](https://github.com/Row0902/pandect-apa7/commit/e43a7fb7a197243e35adf7939a7d6a3cfc728624)) by @Row0902
- implement accessible APA 7 tables and figures modules ([78047dc](https://github.com/Row0902/pandect-apa7/commit/78047dc0f75b865e37e423cccd704f4a3ec54127)) by @Row0902
- implement accessible abstract and keywords module (APA 7) ([bc52eee](https://github.com/Row0902/pandect-apa7/commit/bc52eee7429c572db7695434d0c487461e1b55a5)) by @Row0902
- implement accessible student and professional title pages (APA 7) ([6c0b9d4](https://github.com/Row0902/pandect-apa7/commit/6c0b9d49b2c737bd37f958e2645dee6b56249244)) by @Row0902
- implement APA 7 heading levels 1-5 with PDF/UA-1 accessibility ([8838674](https://github.com/Row0902/pandect-apa7/commit/8838674f3cb91b2d8ec909d72472c3fca33d99bc)) by @Row0902
- implement accessible layout and typography modules for APA 7 ([d221008](https://github.com/Row0902/pandect-apa7/commit/d2210083b2f41f774c8c32f724817ac40a885de5)) by @Row0902

### 📚 Documentation
- **readme**: upgrade with rich accessible alt-text, details/summary templates and kbd shortcuts ([2d8ff36](https://github.com/Row0902/pandect-apa7/commit/2d8ff364d9a53276b179c3b30dde43530e33e78e)) by @Row0902
- add comprehensive low-cognitive-load documentation and visual asset gallery ([e76aa0f](https://github.com/Row0902/pandect-apa7/commit/e76aa0fe3bbdac1f29d82f818080ed8e44a77296)) by @Row0902
- write comprehensive README with architecture, API reference and APA 7 specs ([cdfd86f](https://github.com/Row0902/pandect-apa7/commit/cdfd86f430824746c1e89373c968a96d129e352e)) by @Row0902

### 👥 Contributors
- @Row0902


--- • *CI Build #6*
