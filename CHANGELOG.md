# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog], and this project adheres to
[Semantic Versioning].

## [Unreleased]

### Added

- Ability to generate a formatted bibliography that appears directly
  in the Table of Contents with the `\printbibliography` command (Issue #13)
- Asymmetric margins when using the `twoside` option (Issue #25)

### Changed

- Hard-coded `\addbibresource` filename to use a glob pattern (Issue #38)

## [2.3.0] - 2021-02-18

### Added

- Ability to pass optional value argument to `\nomunit` (Issue #31)

### Fixed

- Failing compilation on TeXLive 2020 (Issue #34)

### Changed

- `\documentclass` to use `tudelft-light/tud-report` instead of
  `tudelft-light/report` (Issue #34)
- Use of `\import` to `\include` for adding report structure support in VS Code
  LaTeX Workshop and support the `\includeonly` macro (Issue #29)
- Bumped version of `tudelft-light-template` to
  [87c1708](https://github.com/skilkis/tudelft-light-template/commit/87c1708)

## [2.2.0] - 2020-12-01

### Added

- `title fontsize` option to the `\makecover` macro to allow users to
  format the cover page title font size (Issue #23)
- Remove hyphenation from cover page title text using the `hyphenat` package
- `title fontsize` argument to the [README] `\makecover` example

### Changed

- Bumped version of `tudelft-light-template` to [c2c6bcb]

### Fixed

- Grammar mistake in the Inner Title Page section of the [README]

## [2.1.0] - 2020-10-05

### Added

- SVG logo to the README as well as improved it with highlights and pictures
- Ability to automatically compile the template and create releases on tagged
  commits
- Automated plural suffix addition to the "Author" and "Supervisor" words
  in the inner title page

### Changed

- `tudelft-light` directory into a submodule to make it easier to embed
  a minimal template into other Git repositories

### Fixed

- Hardcoded supervisor name (Issue #14)

## [2.0.0] - 2020-02-20

An overhauled version that greatly increases usability. You can now generate
awesome cover pages and title pages easily!

### Added

- `\makecover` and `\maketitle` macros to generate the cover page and title
  page (Issue #1)
- Option to toggle display of a fancy header to the document class
- Use of the `import` package to fix build errors
- Units and Numbers section to the LaTeX example elements chapter
- Font files from [TU Delft Thesis Template]
- Light and dark vector cover images and logos
- Definition of TU Delft House Style fonts and colors
- Check to make sure that document is being compiled with [XeLaTeX]
- String labels for PDF page numbers (Issue #9)

### Changed

- Location of LaTeX example elements chapter and `abstract.tex` into
  `examples/` folder
- `usepackage` statements in the template to `RequirePackage` (Issue #4)
- Adopt correct usage of a document class file `.cls` instead of a package with
  multiple sub-packages to increase readability
- Usage of `listings` package in favor of `minted` (Issue #7)

### Removed

- `samplerefs.txt` and placed its contents into the [README]
- Unnecessary call to `\addcontentsline` macro by using the `intoc` option of
  the `nomencl` package
- Introduction chapter and old listing examples
- Static `outercover.pdf` cover page generated with Adobe InDesign and
  `innercover.tex` title page

### Fixed

- Overlapping text in the header by using the `truncate` package (Issue #2)
- An issue where page numbers would not render correctly (Issue #5)
- Incorrect page number being displayed in the List of Tables (Issue #6)

## [1.0.0] - 2020-02-08

### Added

- `\nomunit` macro for improving usage of the `siunits` package with the
  nomenclature

### Changed

- Generalized PDF metadata
- Example reference to a fictional paper
- Location of template files into `tudelft-light/` directory
- From Apache 2.0 to Mozilla Public License 2.0

### Removed

- `.eps` image files with `.pdf` to reduce compile time
- Improper use of `.cls` file and adopted usage of LaTeX package `.sty` files

<!-- Un-wrapped Text Below for References, Links, Images, etc. -->
[Keep a Changelog]: https://keepachangelog.com/en/1.0.0/
[Semantic Versioning]: https://semver.org/spec/v2.0.0.html
[README]: /README.md
[TU Delft Thesis Template]: https://d1rkab7tlqy5f1.cloudfront.net/Websections/TU%20Delft%20Huisstijl/report_style.zip
[XeLaTeX]: https://www.tug.org/xetex/
[c2c6bcb]: https://github.com/skilkis/tudelft-light-template/commit/c2c6bcb07863894689a3acc286e18907837b485e