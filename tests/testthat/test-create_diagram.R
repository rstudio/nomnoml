test_that("create diagrams", {
  expect_s3_class(
    nomnoml(""),
    "htmlwidget"
  )
  
  diagram <- "[Hallo] -> [World]"
  expect_equal(
    nomnoml(diagram)$x$code,
    paste(nomnoml:::nomnoml_defaults(), diagram, sep = "\n")
  )
})
