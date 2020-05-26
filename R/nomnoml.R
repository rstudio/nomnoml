#' Render Diagram
#'
#' Renders a 'nomnoml' diagram as an 'htmlwidget' or saves it
#' as a 'png' image.
#' 
#' @param code The nomnoml diagram code.
#' @param png Optional file name to export diagram as 'png'.
#' @param width Optional width in pixels for the exported 'png'.
#' @param height Optional height in pixels for the exported 'png'.
#' @param svg Use 'svg' output instead of 'png'? Notice that rendering in
#'   'svg' is not at a par with 'png' and renders incorrectly at times.
#' @param ... Additional parameters.
#' 
#' @details
#' 
#' The 'nomnoml' syntax is simple and intuitive, a "Hello World"
#' example can be rendered as an 'htmlwidget' as follows:
#' 
#' \code{nomnoml::nomnoml("[Hello]-[World!]", "orange")}
#' 
#' You can also render as a 'png' file with specific dimensions:
#' 
#' \code{nomnoml::nomnoml("[Hello]-[World!]", "hello.png", 600, 100)}
#' 
#' Still, complex diagrams can be defined by combining multiple
#' association types, classifier types, directives and
#' custom classifier styles.
#' 
#' You can also use of the \code{nomnoml} 'knitr' chunk
#' to render inline diagrams in R Markdown documents.
#' 
#' @section Association Types:
#' 
#' \code{association -}
#' 
#' \code{association ->}
#' 
#' \code{association <->}
#' 
#' \code{dependency -->}
#' 
#' \code{dependency <-->}
#' 
#' \code{generalization -:>}
#' 
#' \code{generalization <:-}
#' 
#' \code{implementation --:>}
#' 
#' \code{implementation <:--}
#' 
#' \code{composition +-}
#' 
#' \code{composition +->}
#' 
#' \code{aggregation o-}
#' 
#' \code{aggregation o->}
#' 
#' \code{note --}
#' 
#' \code{hidden -/-}
#' 
#' @section Classifier Types:
#' 
#' \code{[name]}
#' 
#' \code{[<abstract> name]}
#' 
#' \code{[<instance> name]}
#' 
#' \code{[<note> name]}
#' 
#' \code{[<reference> name]}
#' 
#' \code{[<package> name]}
#' 
#' \code{[<frame> name]}
#' 
#' \code{[<database> name]}
#' 
#' \code{[<start> name]}
#' 
#' \code{[<end> name]}
#' 
#' \code{[<state> name]}
#' 
#' \code{[<choice> name]}
#' 
#' \code{[<input> name]}
#' 
#' \code{[<sender> name]}
#' 
#' \code{[<receiver> name]}
#' 
#' \code{[<transceiver> name]}
#' 
#' \code{[<actor> name]}
#' 
#' \code{[<usecase> name]}
#' 
#' \code{[<label> name]}
#' 
#' \code{[<hidden> name]}
#' 
#' @section Directives:
#' 
#' \code{#arrowSize: 1}
#' 
#' \code{#bendSize: 0.3}
#' 
#' \code{#direction: down | right}
#' 
#' \code{#gutter: 5}
#' 
#' \code{#edgeMargin: 0}
#' 
#' \code{#edges: hard | rounded}
#' 
#' \code{#fill: #eee8d5; #fdf6e3}
#' 
#' \code{#fillArrows: false}
#' 
#' \code{#font: Calibri}
#' 
#' \code{#fontSize: 12}
#' 
#' \code{#leading: 1.25}
#' 
#' \code{#lineWidth: 3}
#' 
#' \code{#padding: 8}
#' 
#' \code{#spacing: 40}
#' 
#' \code{#stroke: #33322E}
#' 
#' \code{#title: filename}
#' 
#' \code{#zoom: 1}
#' 
#' @section Custom Classifier Styles:
#' 
#' A directive that starts with \code{.} define a classifier style.
#' The style is written as a space separated list of modifiers and
#' key/value pairs.
#' 
#' \code{#.box: fill=#8f8 dashed}
#' 
#' \code{#.blob: visual=ellipse}
#' 
#' \code{[<box> GreenBox]}
#' 
#' \code{[<blob> HideousBlob]}
#' 
#' Available key/value pairs are:
#' 
#' \code{fill=(any css color)}
#' 
#' \code{stroke=(any css color)}
#' 
#' \code{align=center}
#' 
#' \code{align=left}
#' 
#' \code{direction=right}
#' 
#' \code{direction=down}
#' 
#' \code{visual=actor}
#' 
#' \code{visual=class}
#' 
#' \code{visual=database}
#' 
#' \code{visual=ellipse}
#' 
#' \code{visual=end}
#' 
#' \code{visual=frame}
#' 
#' \code{visual=hidden}
#' 
#' \code{visual=input}
#' 
#' \code{visual=none}
#' 
#' \code{visual=note}
#' 
#' \code{visual=package}
#' 
#' \code{visual=receiver}
#' 
#' \code{visual=rhomb}
#' 
#' \code{visual=roundrect}
#' 
#' \code{visual=sender}
#' 
#' \code{visual=start}
#' 
#' \code{visual=transceiver}
#' 
#' Available modifiers are:
#' 
#' \code{bold}
#' 
#' \code{underline}
#' 
#' \code{italic}
#' 
#' \code{dashed}
#' 
#' \code{empty}
#' 
#' @examples 
#' # Render simple diagram:
#' nomnoml::nomnoml("[Hello]-[World!]")
#' 
#' # Render complex diagram:
#' nomnoml::nomnoml("
#'   #stroke: #a86128
#'   [<frame>Decorator pattern|
#'     [<abstract>Component||+ operation()]
#'     [Client] depends --> [Component]
#'     [Decorator|- next: Component]
#'     [Decorator] decorates -- [ConcreteComponent]
#'     [Component] <:- [Decorator]
#'     [Component] <:- [ConcreteComponent]
#'   ]")
#'
#' @import htmlwidgets
#' @export
nomnoml <- function(
  code = "[Hello]-[World!]",
  png = NULL,
  width = NULL,
  height = NULL,
  svg = FALSE,
  ...) {
  
  # forward options using x
  x <- list(
    code = paste(
      nomnoml_defaults(),
      code,
      sep = "\n"
    ),
    svg = svg
  )
  
  # create widget
  widget <- htmlwidgets::createWidget(
    name = 'nomnoml',
    x,
    width = width,
    height = height,
    package = 'nomnoml'
  )
  
  if (!is.null(png)) {
    file <- tempfile(fileext = ".html")
    htmlwidgets::saveWidget(widget, file)
    
    webshot::webshot(file, png, selector = "canvas")
  }
  else {
    widget
  }
}

#' Shiny bindings for nomnoml
#'
#' Output and render functions for using nomnoml within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a nomnoml
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name nomnoml-shiny
#'
#' @export
nomnomlOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'nomnoml', width, height, package = 'nomnoml')
}

#' @rdname nomnoml-shiny
#' @export
renderNomnoml <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, nomnomlOutput, env, quoted = TRUE)
}

nomnoml_defaults <- function() {
"
#fill: #FEFEFF
#lineWidth: 1
#zoom: 4
#direction: right
"
}
