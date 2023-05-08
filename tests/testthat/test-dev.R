test_that("alias_arg", {
  func <- function(x = 1, y = NULL, z = NULL) {
    x <- alias_arg(x, y, z, default = x)
    return(x)
  }
  expect_identical(func(), 1)
  expect_identical(func(x = 8), 8)
  expect_identical(func(z = 10), 10)
})
