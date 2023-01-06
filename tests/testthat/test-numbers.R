test_that("round_string", {
  expect_identical(round_string(1.1, 2), "1.10")
  expect_identical(round_string(1.1041, 2), "1.10")
  expect_identical(round_string(1.1051, 2), "1.11")
  expect_identical(round_string(10, 2), "10.00")
  expect_identical(round_string(-9, 2), "-9.00")
  expect_identical(round_string(-9.213, 2), "-9.21")
  expect_identical(round_string(0.0000002, 2), "0.00")
  expect_identical(round_string(-0.523, 0), "-1")
  expect_identical(round_string("-0.5237", 3), "-0.524")
})

test_that("signif_string", {
  expect_identical(signif_string(1.1, 2), "1.1")
  expect_identical(signif_string(1.14, 2), "1.1")
  expect_identical(signif_string(1.151, 2), "1.2")
  expect_identical(signif_string(10, 2), "10")
  expect_identical(signif_string(-9, 2), "-9.0")
  expect_identical(signif_string(-9.213, 2), "-9.2")
  expect_identical(signif_string(0.0000002, 2), "0.00000020")
  expect_error(signif_string(-0.523, 0))
  expect_identical(signif_string("-0.5237", 3), "-0.524")
})


test_that("float_to_percent", {
  expect_identical(float_to_percent(0.12, 0), "12%")
  expect_identical(float_to_percent(0, 2), "0.00%")
  expect_identical(float_to_percent(1.37, 2), "137.00%")
  expect_identical(float_to_percent("-12.215", 0), "-1222%")
})

test_that("percent_to_float", {
  expect_identical(percent_to_float("12%"), "0.12")
  expect_identical(percent_to_float("12%", 4), "0.1200")
  expect_identical(percent_to_float("-12.251%", 3), "-0.123")
  expect_error(percent_to_float(1.37))
})


test_that("signif_round_string", {
  expect_identical(signif_round_string(0.03851), "0.04")
  expect_identical(signif_round_string(0.000002, 3), "0.00000200")
  expect_identical(signif_round_string(20.526, 2, "short"), "21")
  expect_identical(signif_round_string(20.526, 2, "long"), "20.53")
})


test_that("is.zero", {
  expect_identical(is.zero(0.0213), FALSE)
  expect_identical(is.zero("0.000"), TRUE)
  expect_identical(is.zero(NULL), NULL)
  expect_identical(is.zero(NA), NA)
  expect_error(is.zero("NASD"))
  expect_error(is.zero("NULL"))
})


test_that("number_fun_wrapper", {
  expect_identical(
    number_fun_wrapper(">=2.134%", function(x) round(x, 2)), ">=2.13%"
  )
  expect_identical(
    number_fun_wrapper(c(">=2.134%", "~0.2451"), function(x) round(x, 2)),
    c(">=2.13%", "~0.25")
  )
  expect_identical(
    number_fun_wrapper(">=2.134|",
      function(x) round(x, 2),
      suffix_ext = "|"
    ),
    ">=2.13|"
  )
})
