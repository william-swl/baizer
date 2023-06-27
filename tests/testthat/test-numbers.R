test_that("int_digits", {
  expect_equal(
    int_digits(c(
      1.1, 1.14, 1.151, 10, 10.5, 10.51, 10.52, 115, 115.5, 6.9785,
      0.5273, 0.526, -0.5273, -9, 9, 9.213, -9.213,
      0.0000000000000002, 2451, 2450, -2451, -2450
    )),
    c(
      11, 11.4, 11.51, 10, 10.5, 10.51, 10.52, 11.5, 11.55, 69.785,
      52.73, 52.6, -52.73, -90, 90, 92.13, -92.13,
      20, 24.51, 24.5, -24.51, -24.5
    )
  )

  expect_identical(
    int_digits(c(
      1.1, 1.14, 1.151, 10, 10.5, 10.51, 10.52, 115, 115.5, 6.9785,
      0.5273, 0.526, -0.5273, -9, 9, 9.213, -9.213,
      0.0000000000000002, 2451, 2450, -2451, -2450
    ), scale_factor = TRUE),
    c(
      10, 10, 10, 1, 1, 1, 1, 0.1, 0.1, 10,
      100, 100, 100, 10, 10, 10, 10,
      100000000000000000, 0.01, 0.01, 0.01, 0.01
    )
  )
})

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
  expect_identical(
    is.na(round_string(c(NA, NULL, NA))), c(TRUE, TRUE)
  )
})


test_that("signif_string", {
  expect_identical(
    signif_string(
      c(
        1.1, 1.14, 1.151, 10, 10.5, 10.51, 10.52, 115, 115.5, 6.9785,
        0.5273, 0.526, -0.5273, -9, 9, 9.213, -9.213,
        0.0000000000000002, 2451, 2450, -2451, -2450
      ),
      2
    ),
    c(
      "1.1", "1.1", "1.2", "10", "10", "11", "11", "120", "120", "7.0",
      "0.53", "0.53", "-0.53", "-9.0", "9.0", "9.2", "-9.2",
      "0.00000000000000020", "2500", "2500", "-2500", "-2500"
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
  expect_identical(
    is.na(signif_string(c(NA, NULL, NA))), c(TRUE, TRUE)
  )
})

test_that("signif_floor", {
  expect_identical(
    signif_floor(c(78351, -78351, 3.79879, -3.79879, 0.003124), 3),
    c(78300, -78400, 3.79, -3.8, 0.00312)
  )
  expect_identical(
    signif_floor(c(78351.1543, -78351.1543, 3.79879, -3.79879), 7),
    c(78351.15, -78351.16, 3.79879, -3.79879)
  )
})

test_that("signif_ceiling", {
  expect_identical(
    signif_ceiling(c(78321, -78321, 3.1234, -3.1234, 0.003124), 3),
    c(78400, -78300, 3.13, -3.12, 0.00313)
  )
  expect_identical(
    signif_ceiling(c(78351.1543, -78351.1543, 3.79879, -3.79879), 7),
    c(78351.16, -78351.15, 3.79879, -3.79879)
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
  v <- c(
    1.1, 1.14, 1.151, 10, 10.5, 10.51, 10.52, 115, 115.5, 6.9785,
    0.5273, 0.526, -0.5273, -9, 9, 9.213, -9.213,
    0.0000000000000002, 2451, 2450, -2451, -2450
  )

  expect_identical(
    signif_round_string(v),
    c(
      "1.1", "1.1", "1.2", "10", "10", "11", "11", "115", "116", "7.0",
      "0.53", "0.53", "-0.53", "-9.0", "9.0", "9.2", "-9.2",
      "0.00", "2451", "2450", "-2451", "-2450"
    )
  )

  expect_identical(
    signif_round_string(v, format = "long"),
    c(
      "1.10", "1.14", "1.15", "10.00", "10.50", "10.51", "10.52",
      "115.00", "115.50", "6.98",
      "0.53", "0.53", "-0.53", "-9.00", "9.00", "9.21", "-9.21",
      "0.00000000000000020", "2451.00", "2450.00", "-2451.00", "-2450.00"
    )
  )

  expect_identical(
    signif_round_string(v, full_large = FALSE),
    c(
      "1.1", "1.1", "1.2", "10", "10", "11", "11", "120", "120", "7.0",
      "0.53", "0.53", "-0.53", "-9.0", "9.0", "9.2", "-9.2",
      "0.00", "2500", "2500", "-2500", "-2500"
    )
  )

  expect_identical(
    signif_round_string(v, full_small = TRUE),
    c(
      "1.1", "1.1", "1.2", "10", "10", "11", "11", "115", "116", "7.0",
      "0.53", "0.53", "-0.53", "-9.0", "9.0", "9.2", "-9.2",
      "0.00000000000000020", "2451", "2450", "-2451", "-2450"
    )
  )
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


test_that("correct_ratio", {
  expect_identical(
    correct_ratio(c(10, 10), c(3, 5)),
    c(6, 10)
  )
  expect_identical(
    correct_ratio(c(100, 100), c(0.2, 0.8)),
    c(25, 100)
  )
  expect_identical(
    correct_ratio(10:13, c(2, 3, 4, 6)),
    c(4, 6, 9, 13)
  )
  expect_identical(
    correct_ratio(c(10, 10), c(1, 4), digits = 1),
    c(2.5, 10.0)
  )
})


test_that("near_ticks", {
  expect_identical(near_ticks(3462, level = 10), c(3460, 3465, 3470))
  expect_identical(near_ticks(-3462, level = 10), c(-3470, -3465, -3460))
  expect_equal(near_ticks(0.325, level = 0.1), c(0.3, 0.35, 0.4))
  expect_equal(near_ticks(0.325, level = 0.01), c(0.32, 0.325, 0.33))
})

test_that("nearest_tick", {
  expect_identical(nearest_tick(3462, level = 10), 3460)
  expect_identical(nearest_tick(3462, level = 10, side = "right"), 3465)
  expect_identical(nearest_tick(-3462, level = 10), -3460)
  expect_identical(nearest_tick(-3463, level = 10), -3465)
})

test_that("generate_ticks", {
  expect_identical(
    generate_ticks(c(176, 264), expect_ticks = 10),
    c(175, 185, 195, 205, 215, 225, 235, 245, 255, 265)
  )
  expect_identical(
    generate_ticks(c(0.1, 11), expect_ticks = 5),
    c(0, 5, 10, 15)
  )
})


test_that("pos_int_split", {
  expect_identical(pos_int_split(12, 3), c(4, 4, 4))
  expect_identical(pos_int_split(11, 3), c(4, 4, 3))
  expect_identical(pos_int_split(12, 3, method = c(1, 2, 3)), c(2, 4, 6))
})


test_that("gen_outlier", {
  x <- seq(0, 100, 1)
  iqr <- IQR(x)
  high_threshold <- boxplot.stats(x)$stats[4] + 1.5 * iqr
  low_threshold <- boxplot.stats(x)$stats[2] - 1.5 * iqr

  o1 <- gen_outlier(x, 10, lim = c(-80, 160))
  o2 <- gen_outlier(x, 10, lim = c(-80, 160), assign_n = c(0.1, 0.9))
  o3 <- gen_outlier(x, 10, lim = c(-80, 160), side = "low")


  expect_true(all((o1 >= -80 & o1 <= low_threshold) |
    (o1 >= high_threshold & o1 <= 160)))
  expect_true(which((o2 >= -80 & o2 <= low_threshold)) == 1)
  expect_true(all((o3 >= -80 & o3 <= low_threshold)))
})


test_that("mm_norm", {
  expect_identical(mm_norm(c(1, 3, 4)) %>% round(2), c(0, 0.67, 1))
  expect_identical(
    mm_norm(c(1, 3, 4), low = 1, high = 10) %>% round(2),
    c(1, 7, 10)
  )
  expect_identical(
    mm_norm(c(1, 3, NA), low = 1, high = 4) %>% round(2),
    c(1, 4, NA)
  )
})
