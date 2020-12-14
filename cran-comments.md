## Test environments

* local R installation, R 4.0.3
* ubuntu 16.04 (on github actions): R-devel, R-release and R-oldver
* win-builder (devel)

## R CMD check results

1 note:

Transfer of repo ownership. The previous owner already responded to a CRAN email.

## Comments

The previous version failed the CRAN reverse dependency checks because I was too insistent on having the PhantomJS system requirement installed.

I have now relaxed this requirement, and only insist on this when rendering R Markdown with PNG files, when this dependency is required.

For any rendering as an HTML widget, or in a shiny app, or as a SVG, PhantomJS is not necessary.

In addition, I have now tested the reverse dependency (supreme) in an environment where PhantomJS is not available, and all tests pass.
