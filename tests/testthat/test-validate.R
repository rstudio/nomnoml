test_that("diagram validation via V8 works", {
  
  skip_on_cran()
  
  expect_true(
    nomnoml_validate("[hello]")
  )
  
  expect_warning(
    nomnoml_validate("[hello")
  )
  
  expect_warning(
    nomnoml_validate("[hello
                [world]")
  )
  
  expect_true(
    nomnoml_validate("[hello]
                [world]")
  )
  
})
