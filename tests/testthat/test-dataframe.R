test_that("c2r", {
  expect_snapshot(head(mini_diamond) %>% c2r("id"))
})


test_that("c2r, column index", {
  expect_identical(
    all(head(mini_diamond) %>% c2r("id") == head(mini_diamond) %>% c2r(1)),
    TRUE
  )
})



test_that("r2c", {
  expect_identical(
    all(head(mini_diamond) == head(mini_diamond) %>%
      c2r("id") %>%
      r2c("id")),
    TRUE
  )
})

test_that("fancy_count, one column", {
  expect_snapshot(
    fancy_count(mini_diamond, cut)
  )
})


test_that("fancy_count, ext_fmt='count'", {
  expect_snapshot(
    fancy_count(mini_diamond, cut, ext = clarity, ext_fmt = "count")
  )
})

test_that("fancy_count, ext_fmt='ratio'", {
  expect_snapshot(
    fancy_count(mini_diamond, cut, ext = clarity, ext_fmt = "ratio")
  )
})

test_that("fancy_count, ext_fmt='clean'", {
  expect_snapshot(
    fancy_count(mini_diamond, cut, ext = clarity, ext_fmt = "clean")
  )
})

test_that("fancy_count, sort=FALSE", {
  expect_snapshot(
    fancy_count(mini_diamond, cut, ext = clarity, sort = FALSE)
  )
})

test_that("fancy_count, three column", {
  expect_snapshot(
    fancy_count(mini_diamond, cut, clarity, ext = id) %>% print(n = Inf)
  )
})



test_that("expand_df", {
  expect_snapshot(
    fancy_count(mini_diamond, cut, ext = clarity) %>%
      split_column(name_col = cut, value_col = clarity) %>%
      print(n = Inf)
  )
})



test_that("move_row, .after=TRUE", {
  expect_snapshot(move_row(mini_diamond, 3:5, .after = TRUE) %>% print(n = Inf))
})

test_that("move_row, after last row", {
  expect_snapshot(
    move_row(mini_diamond, 3:5, .after = nrow(mini_diamond)) %>% print(n = Inf)
  )
})

test_that("move_row, after first row", {
  expect_snapshot(move_row(mini_diamond, 3:5, .after = 1) %>% print(n = Inf))
})

test_that("move_row, .before=TRUE", {
  expect_snapshot(
    move_row(mini_diamond, 3:5, .before = TRUE) %>% print(n = Inf)
  )
})

test_that("move_row, beofre first row", {
  expect_snapshot(
    move_row(mini_diamond, 3:5, .before = 1) %>% print(n = Inf)
  )
})

test_that("move_row, beofre last row", {
  expect_snapshot(
    move_row(mini_diamond, 3:5, .before = nrow(mini_diamond)) %>%
      print(n = Inf)
  )
})

test_that("move_row", {
  expect_snapshot(move_row(mini_diamond, 3:5, .after = 8) %>% print(n = Inf))
})


test_that("ordered_slice", {
  expect_snapshot(ordered_slice(mini_diamond, id, c("id-3", "id-2")))
})

test_that("ordered_slice, with NA and dup", {
  expect_snapshot(
    ordered_slice(mini_diamond, id, c("id-3", "id-2", "id-3", NA, NA))
  )
})

test_that("ordered_slice, with unknown id", {
  expect_snapshot(
    ordered_slice(mini_diamond, id, c("id-3", "unknown-id"))
  )
})

test_that("ordered_slice, remove dup", {
  expect_snapshot(
    ordered_slice(mini_diamond, id,
      c("id-3", "id-2", NA, "id-3", "unknown-id", NA),
      dup.rm = TRUE
    )
  )
})

test_that("ordered_slice, remove NA", {
  expect_snapshot(
    ordered_slice(mini_diamond, id,
      c("id-3", "id-2", NA, "id-3", "unknown-id", NA),
      na.rm = TRUE
    )
  )
})

test_that("ordered_slice, remove dup and NA", {
  expect_snapshot(
    ordered_slice(mini_diamond, id,
      c("id-3", "id-2", NA, "id-3", "unknown-id", NA),
      na.rm = TRUE, dup = TRUE
    )
  )
})

test_that("ordered_slice, pass column with duplication", {
  expect_error(ordered_slice(mini_diamond, cut, c("Ideal")))
})

test_that("hist_bins", {
  vector <- dplyr::pull(mini_diamond, price, id)
  expect_error(hist_bins(c("a", "b")))
  expect_snapshot(hist_bins(vector) %>% print(n = Inf))
})

test_that("hist_bins, lim", {
  vector <- dplyr::pull(mini_diamond, price, id)
  expect_error(hist_bins(vector, lim = c(2000, 18000)))
  expect_snapshot(hist_bins(vector, lim = c(0, 20000)) %>% print(n = Inf))
})

test_that("hist_bins, breaks", {
  vector <- dplyr::pull(mini_diamond, price, id)
  expect_error(hist_bins(vector, breaks = seq(2000, 18000, length.out = 11)))
  expect_snapshot(hist_bins(vector, breaks = seq(0, 20000, length.out = 11)) %>%
    print(n = Inf))
})
