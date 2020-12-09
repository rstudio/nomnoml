

test_that("knitting works", {
  skip_on_cran()
  
  unlink("example_knitr_files", recursive = TRUE)
  unlink("example_knitr.knit.md")
  z <- rmarkdown::render("example_knitr.Rmd", run_pandoc = FALSE, quiet = TRUE)
  
  expect_equivalent(z, "example_knitr.knit.md")
  expect_true(file.exists("example_knitr_files/figure-html/one-1.png"))
  expect_true(file.exists("example_knitr_files/figure-html/two-2.png"))
  expect_true(file.size("example_knitr_files/figure-html/two-2.png") > 1000)
  expect_true(file.size("example_knitr_files/figure-html/two-2.png") > 1000)
  
  unlink("example_knitr_files", recursive = TRUE)
  unlink("example_knitr.knit.md")
})
