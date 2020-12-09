

library(shinytest)
test_that("shiny", {
  # Launch the target app (replace with the correct path)
  # recordTest("inst/examples/shiny")

  skip_on_cran()
  
  # Only run the tests for code coverage on Github Actions
  skip_if_not(identical(Sys.getenv("R_COVR"), "true"), message = "Only test for coverage on github actions")
  
  # Use compareImages=FALSE because the expected image screenshots were created
  # on a Mac, and they will differ from screenshots taken on the CI platform,
  # which runs on Linux.
  appdir <- system.file(package = "nomnoml", "examples/shiny")
  expect_pass(
    testApp(appdir, compareImages = FALSE)
  )
})

