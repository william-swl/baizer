test_that("stat_test", {
  expect_snapshot(stat_test(mini_diamond, y = price, x = cut, .by = clarity))
})
