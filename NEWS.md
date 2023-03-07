# nomnoml (development version)

- Update `nomnoml.js` to v1.5.3
- Fix spurious package startup message

# nomnoml 0.2.5

- Correctly use `packageStartupMessage()`


# nomnoml 0.2.4

- Update `nomnoml.js` to version 1.4.0


# nomnoml 0.2.3

- Fix CRAN check failures, specifically relaxing the requirement for phantomjs.

- PhantomJS is only necessary for creating PNG files, including PNG output in R Markdown, but not for SVG output or any interactive widgets, e.g. in a shiny app.


# nomnoml 0.2.2

- Update `nomnoml` to v1.3.1 (taking dependency on `graphre`)

- Add additional tests and improved code coverage

- Add `pkgdown` documentation site

- Add `nomnoml_validate()`, an experimental function to validate if a diagram can be parsed.  Uses the `V8` package to do this.

- Added "experimental badge" to package


# nomnoml 0.2.1

- Change maintainer to @andrie

- Add additional tests


# nomnoml 0.2.0 

- Update `nomnoml` to version 0.7.2

- Add support for 'svg' output in 'nomnoml()'.

- Fix issue introducing too much blank space in Rmd docs.

- Fix duplicate diagrams in Shiny apps (@andrie, #15).


# nomnoml 0.1.0 

- Use `nomnoml` version 0.2.0

- Support to render PNGs.

- Support to render 'htmlwidgets'.

- Support for 'nomnoml' chunks in R Markdown.
