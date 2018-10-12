knit_nomnoml <- function (options) {
  knit_print <- get("knit_print", envir = asNamespace("knitr"))
  engine_output <- get("engine_output", envir = asNamespace("knitr"))
  code <- paste(options$code, collapse = "\n")
  
  if ("reactive" %in% class(options$data)) {
    widget <- renderNomnoml({
      nomnoml(
        code
      )
    })
  } else {
    widget <- nomnoml(
      code = code,
      width = options$width,
      height = options$height
    )
  }
  
  if (identical(.Platform$GUI, "RStudio")) {
    widget
  }
  else {
    code_output <- structure(list(src = code), class = 'source')
    widget_output <- knit_print(widget, options = options)
    
    if (identical(options$echo, FALSE)) {
      render_output <- list(
        widget_output
      )
    }
    else {
      render_output <- list(
        code_output,
        widget_output
      )
    }
    
    engine_output(
      options, out = render_output
    )
  }
}