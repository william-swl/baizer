test_that("%nin%", {
  expect_identical(0 %nin% 1:4, TRUE)
  expect_identical(2 %nin% 1:4, FALSE)
  expect_identical(NA %nin% NA, FALSE)
  expect_identical(1 %nin% NA, TRUE)
  expect_identical(1 %nin% NULL, TRUE)
  expect_identical(NA %nin% NULL, TRUE)
  expect_identical("" %nin% NA_character_, TRUE)
  expect_identical(NULL %nin% NULL, logical(0))
  expect_identical(NULL %nin% 1:2, logical(0))
  expect_identical(1 %nin% NULL, TRUE)
})


test_that("%!=na%", {
  expect_identical(0 %!=na% 0, FALSE)
  expect_identical(0 %!=na% 1, TRUE)
  expect_identical(0 %!=na% NA, TRUE)
  expect_identical(NA %!=na% NA, FALSE)
  expect_identical(NULL %!=na% NA, logical(0))
  expect_identical(NA %!=na% NULL, logical(0))
  expect_identical("" %!=na% " ", TRUE)
})
