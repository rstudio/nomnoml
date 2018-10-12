.onAttach <- function(...) {
  
  if (requireNamespace("knitr", quietly = TRUE)) {
    knit_engines <- get("knit_engines", envir = asNamespace("knitr"))
    knit_engines$set(nomnoml = knit_nomnoml)
  }

}