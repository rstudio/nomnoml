#' Render nomnoml diagram.
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
#' `nomnoml::nomnoml("[Hello]-[World!]")`
#' 
#' You can also render as a 'png' file with specific dimensions:
#' 
#' `nomnoml::nomnoml("[Hello]-[World!]", png = "hello.png", 600, 100)`
#' 
#' Still, complex diagrams can be defined by combining multiple
#' association types, classifier types, directives and
#' custom classifier styles.
#' 
#' You can also use of the `nomnoml` 'knitr' chunk
#' to render inline diagrams in R Markdown documents.
#' 
#' @section Association Types:
#' 
#' `association -`
#' 
#' `association ->`
#' 
#' `association <->`
#' 
#' `dependency -->`
#' 
#' `dependency <-->`
#' 
#' `generalization -:>`
#' 
#' `generalization <:-`
#' 
#' `implementation --:>`
#' 
#' `implementation <:--`
#' 
#' `composition +-`
#' 
#' `composition +->`
#' 
#' `aggregation o-`
#' 
#' `aggregation o->`
#' 
#' `note --`
#' 
#' `hidden -/-`
#' 
#' @section Classifier Types:
#' 
#' `[name]`
#' 
#' `[<abstract> name]`
#' 
#' `[<instance> name]`
#' 
#' `[<note> name]`
#' 
#' `[<reference> name]`
#' 
#' `[<package> name]`
#' 
#' `[<frame> name]`
#' 
#' `[<database> name]`
#' 
#' `[<start> name]`
#' 
#' `[<end> name]`
#' 
#' `[<state> name]`
#' 
#' `[<choice> name]`
#' 
#' `[<input> name]`
#' 
#' `[<sender> name]`
#' 
#' `[<receiver> name]`
#' 
#' `[<transceiver> name]`
#' 
#' `[<actor> name]`
#' 
#' `[<usecase> name]`
#' 
#' `[<label> name]`
#' 
#' `[<hidden> name]`
#' 
#' @section Directives:
#' 
#' `#arrowSize: 1`
#' 
#' `#bendSize: 0.3`
#' 
#' `#direction: down | right`
#' 
#' `#gutter: 5`
#' 
#' `#edgeMargin: 0`
#' 
#' `#edges: hard | rounded`
#' 
#' `#fill: #eee8d5; #fdf6e3`
#' 
#' `#fillArrows: false`
#' 
#' `#font: Calibri`
#' 
#' `#fontSize: 12`
#' 
#' `#leading: 1.25`
#' 
#' `#lineWidth: 3`
#' 
#' `#padding: 8`
#' 
#' `#spacing: 40`
#' 
#' `#stroke: #33322E`
#' 
#' `#title: filename`
#' 
#' `#zoom: 1`
#' 
#' @section Custom Classifier Styles:
#' 
#' A directive that starts with `.` define a classifier style.
#' The style is written as a space separated list of modifiers and
#' key/value pairs.
#' 
#' `#.box: fill=#8f8 dashed`
#' 
#' `#.blob: visual=ellipse`
#' 
#' `[<box> GreenBox]`
#' 
#' `[<blob> HideousBlob]`
#' 
#' Available key/value pairs are:
#' 
#' `fill=(any css color)`
#' 
#' `stroke=(any css color)`
#' 
#' `align=center`
#' 
#' `align=left`
#' 
#' `direction=right`
#' 
#' `direction=down`
#' 
#' `visual=actor`
#' 
#' `visual=class`
#' 
#' `visual=database`
#' 
#' `visual=ellipse`
#' 
#' `visual=end`
#' 
#' `visual=frame`
#' 
#' `visual=hidden`
#' 
#' `visual=input`
#' 
#' `visual=none`
#' 
#' `visual=note`
#' 
#' `visual=package`
#' 
#' `visual=receiver`
#' 
#' `visual=rhomb`
#' 
#' `visual=roundrect`
#' 
#' `visual=sender`
#' 
#' `visual=start`
#' 
#' `visual=transceiver`
#' 
#' Available modifiers are:
#' 
#' `bold`
#' 
#' `underline`
#' 
#' `italic`
#' 
#' `dashed`
#' 
#' `empty`
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
    if (svg) stop("Parameter 'svg' must be false when creating PNGs.")
    
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
#' @param width,height Must be a valid CSS unit (like `'100\%'`,
#'   `'400px'`, `'auto'`) or a number, which will be coerced to a
#'   string and have `'px'` appended.
#' @param expr An expression that generates a nomnoml
#' @param env The environment in which to evaluate `expr`.
#' @param quoted Is `expr` a quoted expression (with `quote()`)? This
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
