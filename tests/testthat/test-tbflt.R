test_that("tbflt1", {
  c1 <- tbflt(cut == "Fair")
  expect_snapshot(mini_diamond %>% filterC(c1) %>% print(n = Inf))
})

test_that("tbflt2", {
  c1 <- tbflt(cut == "Fair")
  expect_snapshot(mini_diamond %>% filterC(!c1) %>% print(n = Inf))
})

test_that("tbflt3", {
  c1 <- tbflt(cut == "Fair")
  c2 <- tbflt(x > 8)
  expect_snapshot(mini_diamond %>% filterC(c1 & c2))
})

test_that("tbflt4", {
  c1 <- tbflt(cut == "Fair")
  c2 <- tbflt(x > 8)
  expect_snapshot(mini_diamond %>% filterC(c1 | c2) %>% print(n = Inf))
})

test_that("tbflt in function", {
  foo <- function(tb, d) {
    cond <- tbflt(cut == d)
    tb %>% filterC(cond)
  }
  expect_snapshot(foo(mini_diamond, "Ideal") %>% print(n = Inf))
})

test_that("tbflt logical operation in function", {
  foo <- function(tb, xx, yy) {
    cond1 <- tbflt(cut == xx)
    cond2 <- tbflt(clarity == yy)
    tb %>% filterC(cond1 & cond2)
  }
  expect_snapshot(foo(mini_diamond, "Ideal", "VVS1"))
})

test_that("tbflt logical operation in and out of function", {
  foo <- function(tb, xx, cond2) {
    cond1 <- tbflt(cut == xx)
    tb %>% filterC(cond1 & cond2)
  }
  cond2 <- tbflt(clarity == "VVS1")
  expect_snapshot(foo(mini_diamond, "Ideal", cond2))
})


test_that("tbflt logical operation out of function", {
  foo <- function(tb, cond1, cond2) {
    tb %>% filterC(cond1 & cond2)
  }

  cond1 <- tbflt(cut == "Ideal")
  cond2 <- tbflt(clarity == "VVS1")
  expect_snapshot(foo(mini_diamond, cond1, cond2))
})


test_that("tbflt, usecol=FALSE", {
  x <- 8
  cond <- tbflt(y > x)
  expect_error(filterC(mini_diamond, cond, usecol = FALSE))
  cond <- tbflt(y > !!x)
  expect_snapshot(filterC(mini_diamond, cond, usecol = FALSE))
})

test_that("tbflt, usecol=FALSE, use .env", {
  x <- 8
  cond <- tbflt(y > x)
  expect_error(filterC(mini_diamond, cond, usecol = FALSE))
  cond <- tbflt(y > .env$x)
  expect_snapshot(filterC(mini_diamond, cond))
})
