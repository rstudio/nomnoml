test_that("diagram validation via V8 works", {
  
  # skip tests on Linux because it's so hard to install V8 on Xenial 
  # (xenial 16.04 is still the os on github actions)
  
  skip_on_os("linux")
  
  expect_equal(2 * 2, 4)
  
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
