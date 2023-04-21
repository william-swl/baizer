test_that("alias_arg", {
  func <- function(x = 1, y = NULL, z = NULL) {
    x <- alias_arg(x, y, with_default = x)
    return(x)
  }
  expect_identical(func(), 1)
  x <- 8
  expect_identical(func(x), 8)
  z <- 10
  expect_identical(func(z), 10)
})
