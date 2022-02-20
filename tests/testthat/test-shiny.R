

library(shinytest)
test_that("shiny", {
  # Launch the target app (replace with the correct path)
  # recordTest("inst/examples/shiny")

  skip_on_cran()
  skip_on_ci() # These test are unreliable from version to version
  skip_on_os("windows")
  testthat::skip_if_not(webshot::is_phantomjs_installed())
  
  # Only run the tests for code coverage on Github Actions
  
  
  # Use compareImages=FALSE because the expected image screenshots were created
  # on a Mac, and they will differ from screenshots taken on the CI platform,
  # which runs on Linux.
  appdir <- system.file(package = "nomnoml", "examples/shiny")
  expect_pass(
    testApp(appdir, compareImages = FALSE)
  )
})

