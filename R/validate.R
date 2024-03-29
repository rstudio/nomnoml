#' Use the `V8` JavaScript engine to validate a `nomnoml` diagram.
#' 
#' @description 
#' 
#' `r lifecycle::badge("experimental")`
#' 
#' Although the `nomnoml` widgets render very quickly in the IDE, it can take a
#' few seconds to grab a static screenshot and create a `png` file.  In these
#' situations it can be helpful to validate if the `nomnoml` JS library can
#' parse a diagram.
#'
#' This function returns `TRUE` if a diagram can be parsed, and `FALSE`
#' otherwise.  If `FALSE` the function also throws a warning.
#'
#' @param diagram A `nomnoml` diagram to validate
#'
#' @return Either TRUE or FALSE
#' @export
#' @seealso [nomnoml()]
#' @importFrom utils compareVersion
#'
#' @examples
#' \dontrun{
#' if (requireNamespace("V8", quietly = TRUE)) nomnoml_validate("[hello] -> [world]")
#' }
#' 
nomnoml_validate <- function(diagram = "[test]") {
  
  if (!requireNamespace("V8", quietly = TRUE)) {stop("Install the V8 package to validate nomnoml code")}
  
  ct <- V8::v8()
  
  v8_version <- V8::engine_info()$version
  
  # it's not clear where exactly the break happens, but my local install of
  # windows has V8 version 6, and the linux server has V8 version 8
  
  if (compareVersion(v8_version, "7.0") < 0) {
    ct$source(system.file("htmlwidgets/lib-raw/graphre.js", package = "nomnoml", mustWork = TRUE))
    ct$source(system.file("htmlwidgets/lib-raw/nomnoml.js", package = "nomnoml", mustWork = TRUE))
  } else {
    ct$source(system.file("htmlwidgets/lib/graphre/graphre.js", package = "nomnoml", mustWork = TRUE))
    ct$source(system.file("htmlwidgets/lib/nomnoml/nomnoml.js", package = "nomnoml", mustWork = TRUE))
  }
  
  ct$assign("diagram", diagram)
  
  
  z <- tryCatch(
    ct$eval("nomnoml.parse(diagram)"),
    error = function(e) e
  )
  if (inherits(z, "error")) warning(z$message)
  !inherits(z, "error")
}



