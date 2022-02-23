stop_if_no_phantomjs <- function() {
  if (!webshot::is_phantomjs_installed()) {
    stop("You must install phantomjs using webshot::install_phantomjs()")
  }
}

#' Create and render a nomnoml diagram.
#'
#' @description 
#' 
#' `r lifecycle::badge("experimental")`
#' 
#' Renders a 'nomnoml' diagram as an 'htmlwidget' or saves it
#' as a '.png' or '.svg' image.
#' 
#' @param code The nomnoml diagram code.
#' 
#' @param png Optional file name to export diagram as 'png'.
#' 
#' @param width Optional width in pixels for the exported 'png'.
#' 
#' @param height Optional height in pixels for the exported 'png'.
#' 
#' @param svg Use 'svg' output instead of 'png'? Notice that rendering in
#'   'svg' is not at a par with 'png' and renders incorrectly at times.
#'   
#' @param ... Additional parameters.
#' 
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
#' @section Syntax:
#' 
#' For a summary of available `nomnoml` syntax, including association types, 
#' directives and customer classifier styles, see [nomnoml_syntax]
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
#' 
#' @seealso [nomnomlOutput()], [renderNomnoml()], [nomnoml_validate()], [nomnoml_syntax()]
#' 
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
    svg = svg,
    png = png
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
    stop_if_no_phantomjs()
    widget
  }
  else {
    widget
  }
}

#' Shiny bindings for nomnoml.
#' 
#' @description 
#' 
#' `r lifecycle::badge("experimental")`
#'
#' Output and render functions for using nomnoml within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' 
#' @param width,height Must be a valid CSS unit (like `'100%'`,
#'   `'400px'`, `'auto'`) or a number, which will be coerced to a
#'   string and have `'px'` appended.
#'   
#' @param expr An expression that generates a nomnoml
#' 
#' @param env The environment in which to evaluate `expr`.
#' 
#' @param quoted Is `expr` a quoted expression (with `quote()`)? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name nomnoml-shiny
#' 
#' @seealso [nomnoml()]
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
