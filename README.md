
# nomnoml <img src='man/figures/logo.svg' align="right" height="139" />

[![Travis](https://travis-ci.org/rstudio/travis.svg?branch=master)](https://travis-ci.org/rstudio/nomnoml)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/56dd82589vji7saw?svg=true)](https://ci.appveyor.com/project/rstudio/nomnoml)
[![CRAN\_Status\_Badge](https://www.r-pkg.org/badges/version/nomnoml)](https://cran.r-project.org/package=nomnoml)
<a href="https://www.r-pkg.org/pkg/nomnoml"><img src="https://cranlogs.r-pkg.org/badges/nomnoml?color=brightgreen" style=""></a>

**nomnoml** provides an R interface to
[nomnoml](http://www.nomnoml.com/), a tool for drawing sassy UML
diagrams based on syntax with customizable styling.

## Installation

Install from CRAN:

``` r
install.packages("nomnoml")
```

Or from GitHub using:

``` r
install.packages("remotes")
remotes::install_github("rstudio/nomnoml")
```

## Getting Started

You can create your first diagram by running:

``` r
nomnoml::nomnoml("[Hello]-[World!]")
```

![](tools/readme/nomnoml-simple-1.png)<!-- -->

To make the diagram flow vertically, the default at
[nomnoml.com](http://www.nomnoml.com/), add the
[direction](https://github.com/rstudio/nomnoml/issues/5) directive:

![](tools/readme/nomnoml-vertical-2.png)<!-- -->

You can also use `nomnoml` in R Markdown:

```` markdown
---
title: "A Diagram"
output: html_document
---

```{r, setup, include=FALSE}
library(nomnoml)
```

```{nomnoml}
#stroke: orange
#.box: fill=#8f8 dashed visual=ellipse

[A]-[B]
[B]-[<box>C]
```
````

![](tools/readme/nomnoml-multiline-3.png)<!-- -->

### SVG

To render using SVG, add `svg = TRUE`

``` r
diagram <- "
[A]-[B]
[B]-[<box>C]
"

nomnoml(diagram, svg = TRUE)
```

To render a `nomnoml` chunk in R Markdown, add `svg=TRUE` to the chunk
options

```` markdown
```{nomnoml, svg=TRUE}
#stroke: orange
#.box: fill=#8f8 dashed visual=ellipse

[A]-[B]
[B]-[<box>C]
```
````

![](tools/readme/nomnoml-svg-1.png)<!-- -->

### Advanced

Notice that much more complex diagrams can be designed using ‘nomnoml’
by combining association types, classifier types, directives and custom
classifier styles.

``` nomnoml
#stroke: #a86128
[<frame>Decorator pattern|
  [<abstract>Component||+ operation()]
  [Client] depends --> [Component]
  [Decorator|- next: Component]
  [Decorator] decorates -- [ConcreteComponent]
  [Component] <:- [Decorator]
  [Component] <:- [ConcreteComponent]
]
```

![](tools/readme/nomnoml-decorator-2.png)<!-- -->

### Association types

    -    association
    ->   association
    <->  association
    -->  dependency
    <--> dependency
    -:>  generalization
    <:-  generalization
    --:> implementation
    <:-- implementation
    +-   composition
    +->  composition
    o-   aggregation
    o->  aggregation
    --   note
    -/-  hidden

### Classifier types

    [name]
    [<abstract> name]
    [<instance> name]
    [<reference> name]
    [<note> name]
    [<package> name]
    [<frame> name]
    [<database> name]
    [<start> name]
    [<end> name]
    [<state> name]
    [<choice> name]
    [<input> name]
    [<sender> name]
    [<receiver> name]
    [<transceiver> name]
    [<actor> name]
    [<usecase> name]
    [<label> name]
    [<hidden> name]

### Directives

    #arrowSize: 1
    #bendSize: 0.3
    #direction: down | right
    #gutter: 5
    #edgeMargin: 0
    #edges: hard | rounded
    #fill: #eee8d5; #fdf6e3
    #fillArrows: false
    #font: Calibri
    #fontSize: 12
    #leading: 1.25
    #lineWidth: 3
    #padding: 8
    #spacing: 40
    #stroke: #33322E
    #title: filename
    #zoom: 1

Directives only available when using the command line interface

    #import: my-common-styles.nomnoml

### Custom classifier styles

A directive that starts with “.” define a classifier style.

    #.box: fill=#88ff88
    #.blob: fill=pink visual=ellipse italic bold dashed
    [<box> GreenBox]
    [<blob> HideousBlob]

Available visuals are

    visual=actor
    visual=class
    visual=database
    visual=ellipse
    visual=end
    visual=frame
    visual=hidden
    visual=input
    visual=none
    visual=note
    visual=package
    visual=receiver
    visual=rhomb
    visual=roundrect
    visual=sender
    visual=start
    visual=transceiver

Available modifiers are

    center
    bold
    underline
    italic
    dashed
    empty

## Contributing

Please refer to
[github.com/skanaar/nomnoml](https://github.com/skanaar/nomnoml).
