test_that("create diagrams", {
  expect_is(
    nomnoml(""),
    "htmlwidget"
  )
  
  diagram <- "[Hallo] -> [World]"
  expect_equal(
    nomnoml(diagram)$x$code,
    paste(nomnoml:::nomnoml_defaults(), diagram, sep = "\n")
  )
})
