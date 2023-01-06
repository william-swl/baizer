test_that("c2r", {
  expect_snapshot(head(mini_diamond) %>% c2r("id"))
})

test_that("r2c", {
  expect_identical(
    all(head(mini_diamond) == head(mini_diamond) %>%
      c2r("id") %>%
      r2c("id")),
    TRUE
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
