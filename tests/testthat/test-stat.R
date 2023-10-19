test_that("geom_mean", {
  expect_equal(
    gen_combn(1:4, n = 2),
    list(c(1, 2), c(1, 3), c(1, 4), c(2, 3), c(2, 4), c(3, 4))
  )
})



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

test_that("stat_test, exclude_func", {
  df <- pivot_longer(mini_diamond, c(x, y),
    names_to = "coord", values_to = "value"
  )

  expect_snapshot(
    stat_test(df,
      x = coord, y = value, paired = TRUE,
      paired_by = id, exclude_func = ~ abs(.x - .y) < 0.1
    )
  )
})

test_that("stat_test, one side NA", {
  df <- mini_diamond %>%
    dplyr::mutate(y = ifelse(cut == "Fair", NA, y)) %>%
    dplyr::select(id, cut, x, y) %>%
    pivot_longer(-c(id, cut), names_to = "type", values_to = "value")

  expect_snapshot(
    stat_test(df, x = type, y = value, .by = cut, paired = TRUE, paired_by = id)
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

test_that("stat_fc, one side NA", {
  df <- mini_diamond %>%
    dplyr::mutate(y = ifelse(cut == "Fair", NA, y)) %>%
    dplyr::select(id, cut, x, y) %>%
    pivot_longer(-c(id, cut), names_to = "type", values_to = "value")

  expect_snapshot(
    stat_fc(df, x = type, y = value, .by = cut)
  )
})




test_that("stat_phi", {
  data <- matrix(c(10, 8, 14, 18), nrow = 2)
  expect_equal(stat_phi(data), 0.11342410894527)
})
