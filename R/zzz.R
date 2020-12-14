.onAttach <- function(...) {
  
  if (requireNamespace("knitr", quietly = TRUE)) {
    knit_engines <- get("knit_engines", envir = asNamespace("knitr"))
    knit_engines$set(nomnoml = knit_nomnoml)
  }
  if (!webshot::is_phantomjs_installed()) {
    rlang::inform(
      "To use `nomnoml` in R markdown you must install PhantomJS using webshot::install_phantomjs()",
      .frequency = "once",
      .frequency_id = "nomnoml_package"
    )
  }
}