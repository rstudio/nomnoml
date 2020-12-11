test_that("diagram validation via V8 works", {
  
  skip_on_cran()
  skip_if(numeric_version(V8::engine_info()$version) < 6, 
          message = "V8 version less than 6")
  
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
