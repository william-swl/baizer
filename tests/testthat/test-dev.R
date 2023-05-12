test_that("alias_arg", {
  func <- function(x = 1, y = NULL, z = NULL) {
    x <- alias_arg(x, y, z, default = x)
    return(x)
  }
  expect_identical(func(), 1)
  expect_identical(func(x = 8), 8)
  expect_identical(func(z = 10), 10)
})


test_that("check_arg", {
  func <- function(x = 1, y = NULL, z = NULL) {
    if (!check_arg(x, y, z, n = 2)) {
      stop("")
    }
    return(TRUE)
  }
  expect_error(func())
  expect_error(func(x = 1, y = 1, z = 1))
  expect_identical(func(x = 1, y = 1), TRUE)

  func <- function(x = 1, y = NULL, z = NULL) {
    if (!check_arg(x, y, z, n = 2, fun = ~ .x > 3)) {
      stop("")
    }
    return(TRUE)
  }
  expect_error(func())
  expect_error(func(x = 1, y = 2, z = 3))
  expect_error(func(x = 2, y = 3, z = 4))
  expect_identical(func(x = 2, y = 4, z = 6), TRUE)
})
