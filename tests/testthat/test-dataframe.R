test_that("c2r", {
  expect_snapshot(head(mini_diamond) %>% c2r('id'))
})

test_that("r2c", {
  expect_identical(
    all(head(mini_diamond) == head(mini_diamond) %>% c2r('id') %>% r2c('id')),
    TRUE
  )
})



test_that("fancy_count, fine_fmt='count'", {
  expect_snapshot(fancy_count(mini_diamond, 'cut', 'clarity', fine_fmt='count'))
})

test_that("fancy_count, fine_fmt='ratio'", {
  expect_snapshot(fancy_count(mini_diamond, 'cut', 'clarity', fine_fmt='ratio'))
})

test_that("fancy_count, fine_fmt='clean'", {
  expect_snapshot(fancy_count(mini_diamond, 'cut', 'clarity', fine_fmt='clean'))
})

test_that("fancy_count, sort=TRUE", {
  expect_snapshot(fancy_count(mini_diamond, 'cut', 'clarity', sort=TRUE))
})


