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

test_that("%eq%", {
  expect_identical(0 %eq% 0, TRUE)
  expect_identical(0 %eq% 1, FALSE)
  expect_identical(0 %eq% NA, FALSE)
  expect_identical(NA %eq% NA, TRUE)
  expect_identical(NULL %eq% NA, logical(0))
  expect_identical(NA %eq% NULL, logical(0))
  expect_identical("" %eq% " ", FALSE)
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


test_that("slice_char", {
  x <- c("A", "B", "C", "D", "E")
  expect_identical(slice_char(x, "A", "D"), c("A", "B", "C", "D"))
  expect_identical(slice_char(x, "D", "A"), rev(c("A", "B", "C", "D")))

  x <- c("A", "B", "C", "C", "A", "D", "D", "E", "A")
  expect_identical(
    slice_char(x, "B", "E"),
    c("B", "C", "C", "A", "D", "D", "E")
  )
  expect_error(slice_char(x, "A", "E"))
  expect_identical(
    slice_char(x, "A", "E", unique = TRUE),
    c("A", "B", "C", "C", "D", "D", "E")
  )
})


test_that("diff_index", {
  expect_identical(diff_index("AAAA", "ABBA"), list(as.integer(c(2, 3))))
  expect_identical(
    diff_index("AAAA", "abba", ignore_case = TRUE),
    list(as.integer(c(2, 3)))
  )
  expect_identical(diff_index("AAAA", "ABBA", 2), list(as.integer(3)))
  expect_identical(diff_index("AAAA", "ABBB", 2:3), list(as.integer(c(3, 4))))
  expect_identical(diff_index("AAAA", "ABBA", 10), list(NA_integer_))
  expect_identical(
    diff_index(c("ABBA", "AABB"), "AAAA"),
    list(as.integer(c(2, 3)), as.integer(c(3, 4)))
  )
  expect_identical(
    diff_index(c("ABBB", "BBBA"), "AAAA", nth = c(1, 3)),
    list(as.integer(c(2, 4)), as.integer(c(1, 3)))
  )
  expect_error(diff_index("AAAA", "AAB"))
})

test_that("same_index", {
  expect_identical(same_index("AAAA", "ABBA"), list(as.integer(c(1, 4))))
  expect_identical(
    same_index("AAAA", "abba", ignore_case = TRUE),
    list(as.integer(c(1, 4)))
  )
  expect_identical(same_index("AAAA", "ABBA", 2), list(as.integer(4)))
  expect_identical(same_index("AAAA", "ABAA", 2:3), list(as.integer(c(3, 4))))
  expect_identical(same_index("AAAA", "ABBA", 10), list(NA_integer_))
  expect_identical(
    same_index(c("ABBA", "AABB"), "AAAA"),
    list(as.integer(c(1, 4)), as.integer(c(1, 2)))
  )
  expect_identical(
    same_index(c("BAAA", "AAAB"), "AAAA", nth = c(1, 3)),
    list(as.integer(c(2, 4)), as.integer(c(1, 3)))
  )
  expect_error(same_index("AAAA", "AAB"))
})

test_that("fetch_char", {
  expect_identical(
    fetch_char(rep("ABC", 3), list(1, 2, 3)),
    list("A", "B", "C")
  )
  str1 <- c("ABCD", "AAEF")
  str2 <- c("AAAA", "AAAA")
  expect_identical(
    fetch_char(str1, diff_index(str1, str2)),
    list(c("B", "C", "D"), c("E", "F"))
  )
  expect_identical(
    fetch_char(str1, diff_index(str1, str2, nth = 1:3), na.rm = FALSE),
    list(c("B", "C", "D"), c("E", "F", NA))
  )
  expect_identical(
    fetch_char(str1, diff_index(str1, str2, nth = 1:5), na.rm = TRUE),
    list(c("B", "C", "D"), c("E", "F"))
  )
  expect_identical(
    fetch_char(str1, diff_index(str1, str2, nth = 1:5),
      na.rm = TRUE, collapse = ","
    ),
    list(c("B,C,D"), c("E,F"))
  )
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



test_that("atomic_expr", {
  expect_identical(atomic_expr(expr(x)), TRUE)
  expect_identical(atomic_expr(expr(!x)), TRUE)
  expect_identical(atomic_expr(expr(x + y)), TRUE)
  expect_identical(atomic_expr(expr(x > 1)), TRUE)
  expect_identical(atomic_expr(expr(x & y)), TRUE)
  expect_identical(atomic_expr(expr(!x & y)), FALSE)
  expect_identical(atomic_expr(expr(!x + y)), FALSE)
  expect_identical(atomic_expr(expr(x > 1 | y < 2)), FALSE)
})



test_that("expr_pileup", {
  ex <- expr(a == 2 & b == 3 | !b & x + 2)
  expect_identical(
    expr_pileup(ex),
    c("|", "&", "a == 2", "b == 3", "&", "!b", "x + 2")
  )
})


test_that("split_vector", {
  expect_identical(split_vector(1:10, c(3, 7)), list(1:3, 4:7, 8:10))
  expect_identical(
    split_vector(stringr::str_split("ABCDEFGHIJ", "") %>% unlist(),
      c(3, 7),
      bounds = "[)"
    ),
    list(c("A", "B"), c("C", "D", "E", "F"), c("G", "H", "I", "J"))
  )
})


test_that("reg_match", {
  v <- stringr::str_c("id", 1:3, c("A", "B", "C"))
  expect_identical(reg_match(v, "id(\\d+)(\\w)"), c("1", "2", "3"))
  expect_identical(reg_match(v, "id(\\d+)(\\w)", group = 2), c("A", "B", "C"))
  expect_identical(
    reg_match(v, "id(\\d+)(\\w)", group = -1),
    tibble(
      match = v,
      group1 = c("1", "2", "3"),
      group2 = c("A", "B", "C")
    )
  )
})

test_that("reg_join", {
  expect_identical(
    reg_join(c("A_12.B", "C_3.23:2"), "[A-Za-z]+"), c("AB", "C")
  )
  expect_identical(
    reg_join(c("A_12.B", "C_3.23:2"), "\\w+"), c("A_12B", "C_3232")
  )
  expect_identical(
    reg_join(c("A_12.B", "C_3.23:2"), "\\d+", sep = ","), c("12", "3,23,2")
  )
  expect_identical(
    reg_join(c("A_12.B", "C_3.23:2"), "\\d", sep = ","),
    c("1,2", "3,2,3,2")
  )
})


test_that("group_vector", {
  v <- c(
    "A11", "A10", "A102", "A101", "A1", "B10", "A9", "B32", "B1", "A99",
    "A12", "B21", "B102", "B2", "B9", "A2", "B101", "B99"
  )

  expect_identical(
    group_vector(v),
    list(
      A = c("A11", "A10", "A102", "A101", "A1", "A9", "A99", "A12", "A2"),
      B = c("B10", "B32", "B1", "B21", "B102", "B2", "B9", "B101", "B99")
    )
  )

  expect_identical(
    group_vector(v, pattern = "\\w\\d"),
    list(
      A1 = c("A11", "A10", "A102", "A101", "A1", "A12"),
      A2 = c("A2"),
      A9 = c("A9", "A99"),
      B1 = c("B10", "B1", "B102", "B101"),
      B2 = c("B21", "B2"),
      B3 = c("B32"),
      B9 = c("B9", "B99")
    )
  )

  expect_identical(
    group_vector(v, pattern = "\\d"),
    group_vector(v, pattern = "\\w(\\d)")
  )

  expect_identical(
    group_vector(v, pattern = "\\d{2}"),
    list(
      `10` = c("A10", "A102", "A101", "B10", "B102", "B101"),
      `11` = c("A11"),
      `12` = c("A12"),
      `21` = c("B21"),
      `32` = c("B32"),
      `99` = c("A99", "B99"),
      unmatch = c("A1", "A9", "B1", "B2", "B9", "A2")
    )
  )
})


test_that("sortf", {
  expect_identical(sortf(c(-2, 1, 3), abs), c(1, -2, 3))
  v <- stringr::str_c("id", c(1, 2, 9, 10, 11, 12, 99, 101, 102)) %>% sample()
  expect_identical(
    sortf(v, function(x) reg_match(x, "\\d+") %>% as.double()),
    c("id1", "id2", "id9", "id10", "id11", "id12", "id99", "id101", "id102")
  )
  expect_identical(
    sortf(v, function(x) reg_match(x, "\\d+") %>% as.double()),
    sortf(v, ~ reg_match(.x, "\\d+") %>% as.double())
  )

  v <- c(
    stringr::str_c("A", c(1, 2, 9, 10, 11, 12, 99, 101, 102)),
    stringr::str_c("B", c(1, 2, 9, 10, 21, 32, 99, 101, 102))
  ) %>% sample()
  expect_identical(
    sortf(v, ~ reg_match(.x, "\\d+") %>% as.double(), group_pattern = "\\w"),
    c(
      "A1", "A2", "A9", "A10", "A11", "A12", "A99", "A101", "A102",
      "B1", "B2", "B9", "B10", "B21", "B32", "B99", "B101", "B102"
    )
  )
})

test_that("group_vector", {
  v1 <- c(TRUE, FALSE, TRUE)
  v2 <- c(FALSE, TRUE)
  expect_identical(
    pileup_logical(v1, v2), c(FALSE, FALSE, TRUE)
  )
})


test_that("uniq", {
  v <- c(a = 1, b = 2, c = 3, b = 2, a = 1)
  expect_identical(
    uniq(v), c(a = 1, b = 2, c = 3)
  )
  v <- c(a = 1, b = 2, c = 3)
  expect_identical(
    uniq(v), c(a = 1, b = 2, c = 3)
  )
})


test_that("replace_item", {
  x <- list(A = 1, B = 3)
  y <- list(A = 9, C = 10)
  expect_identical(replace_item(x, y), list(A = 9, B = 3))
  expect_identical(
    replace_item(x, y, keep_extra = TRUE),
    list(A = 9, B = 3, C = 10)
  )

  x <- list(a = 1, b = list(c = "a", d = FALSE, f = list(x = 0, z = 30)))
  y <- list(a = 3, e = 2, b = list(d = TRUE, f = list(x = 10, y = 20)))
  expect_identical(
    replace_item(x, y, keep_extra = TRUE),
    list(a = 3, b = list(
      c = "a", d = TRUE,
      f = list(x = 10, z = 30, y = 20)
    ), e = 2)
  )

  expect_error(replace_item(x, c(A = 9, C = 10)))
  expect_error(replace_item(c(A = 1, B = 3), c(A = 9, C = 10, A = 80)))
})

test_that("gen_char", {
  expect_identical(gen_char(from = "g", n = 5), c("g", "h", "i", "j", "k"))
  expect_identical(gen_char(to = "g", n = 5), c("c", "d", "e", "f", "g"))
  expect_identical(gen_char(from = "g", to = "j"), c("g", "h", "i", "j"))
  expect_identical(gen_char(n = 3, random = TRUE, seed = 1), c("y", "d", "g"))
  expect_true(all(
    gen_char(from = "t", n = 5, random = TRUE) %in%
      slice_char(letters, from = "t")
  ))
  expect_true(all(
    gen_char(
      from = "x", n = 5, random = TRUE,
      allow_dup = FALSE, add = c("+", "-")
    ) %in%
      slice_char(c(letters, c("+", "-")), from = "x")
  ))
  expect_error(gen_char(from = "a", to = "b", n = 3))
  expect_error(gen_char(from = "x", n = 10, random = TRUE, allow_dup = FALSE))
})


test_that("rng2seq", {
  expect_identical(
    rng2seq(c("1-5", "2")),
    list(c("1", "2", "3", "4", "5"), "2")
  )
})


test_that("top_item", {
  expect_identical(
    gen_char(n = 10, to = "g", random = TRUE, seed = 10) %>%
      top_item(n = 10),
    c("g", "c", "a", "b", "d", "f")
  )
})

test_that("melt_vector", {
  expect_identical(
    melt_vector(c(NA, 2, 3), method = "first"), 2
  )
  expect_identical(
    melt_vector(c(NA, 2, 3), method = "sum"), 5
  )
  expect_identical(
    melt_vector(c(NA, 2, 3), method = ","), "2,3"
  )
  expect_identical(
    melt_vector(c(NA, 2, Inf), method = ",", invalid = Inf), NA_character_
  )
  expect_identical(
    melt_vector(c(3, 2, Inf), method = ",", invalid = Inf), "3,2"
  )
  expect_identical(
    melt_vector(c(NA, 2, Inf), invalid = c(Inf, NA)), 2
  )
  expect_identical(
    melt_vector(c(NA, 2, Inf), method = ",", invalid = c(Inf, NA)), "2"
  )
})

test_that("combn_vector", {
  x1 <- c(1, 2, NA, NA)
  x2 <- c(3, NA, 2, NA)
  x3 <- c(4, NA, NA, 3)
  expect_identical(
    combn_vector(x1, x2, x3, method = "sum"),
    c(8, 2, 2, 3)
  )
})


test_that("broadcast_vector", {
  expect_identical(broadcast_vector(c(1, 2, 3), 5), c(1, 2, 3, 1, 2))
})


test_that("max_depth", {
  expect_identical(max_depth(list(a = list(b = list(c = 1), d = 2, e = 3))), 3)
})

test_that("str_replace_loc", {
  expect_identical(str_replace_loc("abcde", 1, 3, "A"), "Ade")
  expect_identical(str_replace_loc("abcde", 1, 10, "A"), "A")
  expect_identical(
    str_replace_loc(c("abcde", "ABCDE"), 1, 3, "A"), c("Ade", "ADE")
  )
  expect_error(str_replace_loc("abcde", 4, 3, "A"))
})

test_that("swap_vecname", {
  v <- c("a" = "A", "b" = "B", "c" = "C")
  expect_identical(
    swap_vecname(v),
    c("A" = "a", "B" = "b", "C" = "c")
  )
})
