test_that("create diagrams", {
  expect_is(
    nomnoml(""),
    "htmlwidget"
  )
  
  diagram <- "[Hallo] -> [World]"
  expect_equal(
    nomnoml(diagram)$x$code,
    paste(nomnoml_defaults(), diagram)
  )
  
  png <- tempfile(fileext = ".png")
  expect_equal(file.size(png), NA_real_)
  
  
  nomnoml(diagram, png = png)
  expect_true(file.size(png) > 0)
  
})
