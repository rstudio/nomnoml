

test_that("knitting works", {
  skip_on_cran()
  testthat::skip_if_not(webshot::is_phantomjs_installed())

  # make sure files don't exist  
  unlink("example_knitr_files", recursive = TRUE)
  unlink("example_knitr.knit.md")
  
  # render to .md
  z <- rmarkdown::render("example_knitr.Rmd", run_pandoc = FALSE, quiet = TRUE)
  
  # check files exist
  expect_equivalent(z, "example_knitr.knit.md", ignore_attr = TRUE)
  # expect_true(file.exists("example_knitr.html"))
  expect_true(file.exists("example_knitr_files/figure-html/one-1.png"))
  expect_true(file.exists("example_knitr_files/figure-html/two-2.png"))
  expect_true(file.size("example_knitr_files/figure-html/two-2.png") > 1000)
  expect_true(file.size("example_knitr_files/figure-html/two-2.png") > 1000)
  
  # clean up
  unlink("example_knitr_files", recursive = TRUE)
  unlink("_snaps", recursive = TRUE, force= TRUE)
  unlink("example_knitr.knit.md")
  unlink("example_knitr.html")
})
