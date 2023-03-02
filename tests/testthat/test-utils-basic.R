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


test_that("%neq%", {
  expect_identical(0 %neq% 0, FALSE)
  expect_identical(0 %neq% 1, TRUE)
  expect_identical(0 %neq% NA, TRUE)
  expect_identical(NA %neq% NA, FALSE)
  expect_identical(NULL %neq% NA, logical(0))
  expect_identical(NA %neq% NULL, logical(0))
  expect_identical("" %neq% " ", TRUE)
})


test_that("collapse_vector", {
  expect_identical(
    collapse_vector(c(e = 1:4), front_name = TRUE, collapse = ";"),
    "e1(1);e2(2);e3(3);e4(4)"
  )
  expect_identical(
    collapse_vector(c(e = 1:4), front_name = FALSE, collapse = ";"),
    "1(e1);2(e2);3(e3);4(e4)"
  )
})


test_that("diff_index", {
  expect_identical(diff_index("ATTC", "ATAC"), as.integer(3))
  expect_identical(diff_index("AATC", "ATAC"), as.integer(c(2, 3)))
  expect_identical(diff_index("AATC", "ATAC", 2), as.integer(3))
  expect_identical(diff_index("AATC", "ATAC", 10), NA_integer_)
  expect_error(diff_index("AATC", c("ATAC", "AAGC")))
  expect_error(diff_index("AATC", "ACT"))
})


test_that("fix_to_regex", {
  expect_identical(fix_to_regex("ABC|?(*)"), "ABC\\|\\?\\(\\*\\)")
})



test_that("detect_dup", {
  expect_identical(
    detect_dup(c("a", "C_", "c -", "#A")),
    c("a", "#A", "C_", "c -")
  )
})


test_that("extract_kv", {
  expect_identical(
    extract_kv(c("x: 1", "y: 2")), c("x" = "1", "y" = "2")
  )
})

test_that("fps_vector", {
  expect_equal(fps_vector(1:10, 1), c(1))
  expect_equal(fps_vector(1:10, 2), c(1, 10))
  expect_equal(fps_vector(1:10, 4), c(1, 4, 7, 10))
  expect_equal(fps_vector(c(1, 2, NA), 2), c(1, NA))
  expect_equal(fps_vector(c(1, 2, NULL), 2), c(1, 2))
  expect_error(fps_vector(1:10, 12))
  expect_error(fps_vector(1, 2, NULL, 3))
})
