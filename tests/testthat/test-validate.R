test_that("diagram validation via V8 works", {
  
  # skip tests on Linux because it's so hard to install V8 on Xenial 
  # (xenial 16.04 is still the os on github actions)
  
  skip_on_os("linux")
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
