
test_that("knitting works", {
  skip_on_cran()

  # make sure files don't exist  
  unlink("example_knitr_files", recursive = TRUE)
  unlink("example_knitr.knit.md")
  
  # render to .md
  z <- rmarkdown::render("example_knitr.Rmd", quiet = TRUE, clean = FALSE)
  
  # check files exist
  expect_equal(basename(z), "example_knitr.html", ignore_attr = TRUE)
  expect_true(file.exists("example_knitr_files/figure-html/one-1.png"))
  expect_true(file.exists("example_knitr_files/figure-html/two-2.png"))
  expect_gt(file.size("example_knitr_files/figure-html/two-2.png"), 1000)
  expect_gt(file.size("example_knitr_files/figure-html/two-2.png"), 1000)
  
  # clean up
  unlink("example_knitr_files", recursive = TRUE)
  unlink("_snaps", recursive = TRUE, force= TRUE)
  unlink("example_knitr.knit.md")
  unlink("example_knitr.html")
})
