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

test_that("fancy_count, one group", {
  expect_snapshot(
    fancy_count(mini_diamond, "cut")
  )
})


test_that("fancy_count, fine_fmt='count'", {
  expect_snapshot(
    fancy_count(mini_diamond, "cut", "clarity", fine_fmt = "count")
  )
})

test_that("fancy_count, fine_fmt='ratio'", {
  expect_snapshot(
    fancy_count(mini_diamond, "cut", "clarity", fine_fmt = "ratio")
  )
})

test_that("fancy_count, fine_fmt='clean'", {
  expect_snapshot(
    fancy_count(mini_diamond, "cut", "clarity", fine_fmt = "clean")
  )
})

test_that("fancy_count, sort=TRUE", {
  expect_snapshot(fancy_count(mini_diamond, "cut", "clarity", sort = TRUE))
})


test_that("expand_df", {
  expect_snapshot(fancy_count(mini_diamond, "cut", "clarity") %>%
    split_column(name_col = "cut", value_col = "clarity"))
})



test_that("move_row, .after=TRUE", {
  expect_snapshot(move_row(mini_diamond, 3:5, .after = TRUE))
})

test_that("move_row, after last row", {
  expect_snapshot(move_row(mini_diamond, 3:5, .after = nrow(mini_diamond)))
})

test_that("move_row, after first row", {
  expect_snapshot(move_row(mini_diamond, 3:5, .after = 1))
})

test_that("move_row, .before=TRUE", {
  expect_snapshot(move_row(mini_diamond, 3:5, .before = TRUE))
})

test_that("move_row, beofre first row", {
  expect_snapshot(move_row(mini_diamond, 3:5, .before = 1))
})

test_that("move_row, beofre last row", {
  expect_snapshot(move_row(mini_diamond, 3:5, .before = nrow(mini_diamond)))
})

test_that("move_row", {
  expect_snapshot(move_row(mini_diamond, 3:5, .after = 8))
})


test_that("ordered_slice", {
  expect_snapshot(ordered_slice(mini_diamond, "id", c("id-3", "id-2")))
})

test_that("ordered_slice, with NA and dup", {
  expect_snapshot(
    ordered_slice(mini_diamond, "id", c("id-3", "id-2", "id-3", NA, NA))
  )
})

test_that("ordered_slice, with unknown id", {
  expect_snapshot(ordered_slice(mini_diamond, "id", c("id-3", "unknown-id")))
})

test_that("ordered_slice, pass column with duplication", {
  expect_error(ordered_slice(mini_diamond, "cut", c("Ideal")))
})
