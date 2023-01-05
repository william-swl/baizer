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


test_that("collapse_vector", {
  expect_identical(collapse_vector(c(e=1:4), front_name = TRUE,  collapse=';'),
                   "e1(1);e2(2);e3(3);e4(4)")
  expect_identical(collapse_vector(c(e=1:4), front_name = FALSE,  collapse=';'),
                   "1(e1);2(e2);3(e3);4(e4)")
})


test_that("diff_index", {
  expect_identical(diff_index('ATTC', 'ATAC'), as.integer(3))
  expect_identical(diff_index('AATC', 'ATAC'), as.integer(c(2, 3)))
  expect_identical(diff_index('AATC', 'ATAC', 2), as.integer(3))
  expect_identical(diff_index('AATC', 'ATAC', 10), NA_integer_)
  expect_error(diff_index('AATC', c('ATAC', 'AAGC')))
  expect_error(diff_index('AATC', 'ACT'))
})


test_that("fix_to_regex", {
  expect_identical(fix_to_regex('ABC|?(*)'), 'ABC\\|\\?\\(\\*\\)')
})
