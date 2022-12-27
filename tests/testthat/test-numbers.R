test_that("round_string", {
  expect_identical(round_string(1.1, 2), "1.10")
  expect_identical(round_string(1.104, 2), "1.10")
  expect_identical(round_string(10, 2), "10.00")
  expect_identical(round_string(-9, 2), "-9.00")
  expect_identical(round_string(-9.213, 2), "-9.21")
  expect_identical(round_string(-0.523, 0), "-1")
  expect_identical(round_string("-0.5237", 3), "-0.524")
})


test_that("float_to_percent", {
  expect_identical(float_to_percent(0.12, 0), "12%")
  expect_identical(float_to_percent(0, 2), "0.00%")
  expect_identical(float_to_percent(1.37, 2), "137.00%")
  expect_identical(float_to_percent("-12.215", 0), "-1222%")
})
