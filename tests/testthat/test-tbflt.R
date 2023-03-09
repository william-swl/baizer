test_that("tbflt1", {
  c1 <- tbflt(cut == "Fair")
  expect_snapshot(mini_diamond %>% filterC(c1))
})

test_that("tbflt2", {
  c1 <- tbflt(cut == "Fair")
  expect_snapshot(mini_diamond %>% filterC(!c1))
})

test_that("tbflt3", {
  c1 <- tbflt(cut == "Fair")
  c2 <- tbflt(x > 8)
  expect_snapshot(mini_diamond %>% filterC(c1 & c2))
})

test_that("tbflt4", {
  c1 <- tbflt(cut == "Fair")
  c2 <- tbflt(x > 8)
  expect_snapshot(mini_diamond %>% filterC(c1 | c2))
})
