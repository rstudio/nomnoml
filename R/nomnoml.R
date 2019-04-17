#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
nomnoml <- function(
  code = "[Hello]-[World!]",
  width = NULL,
  height = NULL,
  id = NULL,
  class = NULL,
  png = NULL,
  ...) {

  # forward options using x
  x <- list(
    code = paste(
      nomnoml_defaults(),
      code
    ),
    className = class,
    svg = FALSE
  )

  # create widget
  widget <- htmlwidgets::createWidget(
    name = 'nomnoml',
    x,
    width = width,
    height = height,
    package = 'nomnoml',
    elementId = id
  )
  
  if (!is.null(png)) {
    file <- tempfile(fileext = ".html")
    htmlwidgets::saveWidget(widget, file)
    
    webshot::webshot(file, png, selector = "canvas")
  }
  
  widget
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
  #lineWidth: 2
  #zoom: 4
  #direction: right
  "
}
