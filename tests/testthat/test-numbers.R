test_that("round_string", {
  expect_identical(
    round_string(c(1.1, 1.1041, 1.1051, 10, -9, -9.213, 0.0000002), 2),
    c("1.10", "1.10", "1.11", "10.00", "-9.00", "-9.21", "0.00")
  )
  expect_identical(round_string(-0.523, 0), "-1")
  expect_identical(round_string("-0.5237", 3), "-0.524")
  expect_identical(
    round_string(c(0.265, 26.5), c(2, 0)),
    c("0.26", "26")
  )
  expect_identical(
    round_string(c(0.2651, 26.51), c(2, 0)),
    c("0.27", "27")
  )
})


test_that("signif_string", {
  expect_identical(
    signif_string(
      c(
        1.1, 1.14, 1.151, 10, 10.5, 10.51, 10.52, 115, 115.5, 6.9785,
        0.5273, 0.526, -0.5273, -9, 9, 9.213, -9.213,
        0.0000000000000002
      ),
      2
    ),
    c(
      "1.1", "1.1", "1.2", "10", "10", "11", "11", "120", "120", "7.0",
      "0.53", "0.53", "-0.53", "-9.0", "9.0", "9.2", "-9.2",
      "0.00000000000000020"
    )
  )
  expect_error(signif_string(-0.523, 0))
  expect_identical(
    signif_string(
      c(-0.5237, 0.5237, -0.0100, 0.0100, 1116.21, -1116.21),
      3
    ),
    c("-0.524", "0.524", "-0.0100", "0.0100", "1120", "-1120")
  )
  expect_identical(
    signif_string(c(0.265, 26.5, 2650), 2),
    c("0.26", "26", "2600")
  )
  expect_identical(
    signif_string(c(0.2651, 26.51, 2651), 2),
    c("0.27", "27", "2700")
  )
})


test_that("float_to_percent", {
  expect_identical(
    float_to_percent(c(0.12, -12.215), 0),
    c("12%", "-1222%")
  )
  expect_identical(
    float_to_percent(c(0, 1.37), 2),
    c("0.00%", "137.00%")
  )
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


test_that("adjacent_div", {
  expect_identical(
    adjacent_div(10^c(1:3), n_div = 10),
    c(
      10, 20, 30, 40, 50, 60, 70, 80, 90, 100,
      100, 200, 300, 400, 500, 600, 700, 800, 900, 1000
    )
  )
  expect_identical(
    adjacent_div(10^c(1:3), n_div = 10, .unique = TRUE),
    c(
      10, 20, 30, 40, 50, 60, 70, 80, 90, 100,
      200, 300, 400, 500, 600, 700, 800, 900, 1000
    )
  )
})
