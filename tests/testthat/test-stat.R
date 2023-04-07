test_that("geom_mean", {
  expect_equal(geom_mean(c(1, 9)), 3)
  expect_equal(geom_mean(c(1, 10, 100)), 10)
})

test_that("stat_test, by", {
  expect_snapshot(
    stat_test(mini_diamond, y = price, x = cut, .by = clarity) %>%
      print(width = Inf, n = Inf)
  )
})

test_that("stat_test", {
  expect_snapshot(
    stat_test(mini_diamond, y = price, x = cut) %>%
      print(width = Inf, n = Inf)
  )
})

test_that("stat_fc", {
  expect_snapshot(
    stat_fc(mini_diamond, y = price, x = cut, .by = clarity) %>%
      print(n = Inf)
  )
})

test_that("stat_fc, rev_div=TRUE", {
  expect_snapshot(
    stat_fc(mini_diamond,
      y = price, x = cut,
      rev_div = TRUE, .by = clarity
    ) %>%
      print(n = Inf)
  )
})

test_that("stat_fc, method='median'", {
  expect_snapshot(
    suppressWarnings(
      stat_fc(mini_diamond,
        y = price, x = cut,
        .by = clarity, method = "median"
      ) %>%
        print(n = Inf)
    )
  )
})

test_that("stat_fc, method='geom_mean'", {
  expect_snapshot(
    stat_fc(mini_diamond,
      y = price, x = cut,
      .by = clarity, method = "geom_mean"
    ) %>% print(n = Inf)
  )
})
