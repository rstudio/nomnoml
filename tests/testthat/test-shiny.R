library(shinytest)

# Launch the target app (replace with the correct path)
# recordTest("inst/examples/shiny")

test_that("shiny", {
  skip_on_cran()
  
  # Use compareImages=FALSE because the expected image screenshots were created
  # on a Mac, and they will differ from screenshots taken on the CI platform,
  # which runs on Linux.
  appdir <- system.file(package = "nomnoml", "examples/shiny")
  expect_pass(testApp(appdir, compareImages = FALSE))
})
