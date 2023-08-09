test_that("c2r", {
  expect_snapshot(head(mini_diamond) %>% c2r("id"))
})


test_that("c2r, column index", {
  expect_identical(
    all(head(mini_diamond) %>% c2r("id") == head(mini_diamond) %>% c2r(1)),
    TRUE
  )
})



test_that("r2c", {
  expect_identical(
    all(head(mini_diamond) == head(mini_diamond) %>%
      c2r("id") %>%
      r2c("id")),
    TRUE
  )
})

test_that("fancy_count, one column", {
  expect_snapshot(
    fancy_count(mini_diamond, cut)
  )
})


test_that("fancy_count, ext_fmt='count'", {
  expect_snapshot(
    fancy_count(mini_diamond, cut, ext = clarity, ext_fmt = "count")
  )
})

test_that("fancy_count, ext_fmt='ratio'", {
  expect_snapshot(
    fancy_count(mini_diamond, cut, ext = clarity, ext_fmt = "ratio")
  )
})

test_that("fancy_count, ext_fmt='clean'", {
  expect_snapshot(
    fancy_count(mini_diamond, cut, ext = clarity, ext_fmt = "clean")
  )
})

test_that("fancy_count, sort=FALSE", {
  expect_snapshot(
    fancy_count(mini_diamond, cut, ext = clarity, sort = FALSE)
  )
})

test_that("fancy_count, three column", {
  expect_snapshot(
    fancy_count(mini_diamond, cut, clarity, ext = id) %>% print(n = Inf)
  )
})



test_that("expand_df", {
  expect_snapshot(
    fancy_count(mini_diamond, cut, ext = clarity) %>%
      split_column(name_col = cut, value_col = clarity) %>%
      print(n = Inf)
  )
})



test_that("move_row, .after=TRUE", {
  expect_snapshot(move_row(mini_diamond, 3:5, .after = TRUE) %>% print(n = Inf))
})

test_that("move_row, after last row", {
  expect_snapshot(
    move_row(mini_diamond, 3:5, .after = nrow(mini_diamond)) %>% print(n = Inf)
  )
})

test_that("move_row, after first row", {
  expect_snapshot(move_row(mini_diamond, 3:5, .after = 1) %>% print(n = Inf))
})

test_that("move_row, .before=TRUE", {
  expect_snapshot(
    move_row(mini_diamond, 3:5, .before = TRUE) %>% print(n = Inf)
  )
})

test_that("move_row, beofre first row", {
  expect_snapshot(
    move_row(mini_diamond, 3:5, .before = 1) %>% print(n = Inf)
  )
})

test_that("move_row, beofre last row", {
  expect_snapshot(
    move_row(mini_diamond, 3:5, .before = nrow(mini_diamond)) %>%
      print(n = Inf)
  )
})

test_that("move_row", {
  expect_snapshot(move_row(mini_diamond, 3:5, .after = 8) %>% print(n = Inf))
})


test_that("ordered_slice", {
  expect_snapshot(ordered_slice(mini_diamond, id, c("id-3", "id-2")))
})

test_that("ordered_slice, with NA and dup", {
  expect_snapshot(
    ordered_slice(mini_diamond, id, c("id-3", "id-2", "id-3", NA, NA))
  )
})

test_that("ordered_slice, with unknown id", {
  expect_snapshot(
    ordered_slice(mini_diamond, id, c("id-3", "unknown-id"))
  )
})

test_that("ordered_slice, remove dup", {
  expect_snapshot(
    ordered_slice(mini_diamond, id,
      c("id-3", "id-2", NA, "id-3", "unknown-id", NA),
      dup.rm = TRUE
    )
  )
})

test_that("ordered_slice, remove NA", {
  expect_snapshot(
    ordered_slice(mini_diamond, id,
      c("id-3", "id-2", NA, "id-3", "unknown-id", NA),
      na.rm = TRUE
    )
  )
})

test_that("ordered_slice, remove dup and NA", {
  expect_snapshot(
    ordered_slice(mini_diamond, id,
      c("id-3", "id-2", NA, "id-3", "unknown-id", NA),
      na.rm = TRUE, dup = TRUE
    )
  )
})

test_that("ordered_slice, pass column with duplication", {
  expect_error(ordered_slice(mini_diamond, cut, c("Ideal")))
})

test_that("hist_bins", {
  vector <- dplyr::pull(mini_diamond, price, id)
  expect_error(hist_bins(c("a", "b")))
  expect_snapshot(hist_bins(vector) %>% print(n = Inf))
})

test_that("hist_bins, lim", {
  vector <- dplyr::pull(mini_diamond, price, id)
  expect_error(hist_bins(vector, lim = c(2000, 18000)))
  expect_snapshot(hist_bins(vector, lim = c(0, 20000)) %>% print(n = Inf))
})

test_that("hist_bins, breaks", {
  vector <- dplyr::pull(mini_diamond, price, id)
  expect_error(hist_bins(vector, breaks = seq(2000, 18000, length.out = 11)))
  expect_snapshot(hist_bins(vector, breaks = seq(0, 20000, length.out = 11)) %>%
    print(n = Inf))
})


test_that("as_tibble_md", {
  x <- "
  | col1 | col2 | col3 |
  | ---- | ---- | ---- |
  | v1   | v2   | v3   |
  | r1   | r2   | r3   |
  "
  expect_snapshot(as_tibble_md(x))
})


test_that("as_md_table", {
  expect_snapshot(mini_diamond %>% head(5) %>% as_md_table())
})


test_that("ref_level", {
  cut_level <- mini_diamond %>%
    dplyr::pull(cut) %>%
    unique()
  df <- mini_diamond %>%
    dplyr::mutate(cut = factor(cut, cut_level)) %>%
    dplyr::mutate(cut0 = stringr::str_c(cut, "xxx")) %>%
    ref_level(cut0, cut)
  expect_identical(levels(df$cut0), stringr::str_c(levels(df$cut), "xxx"))
})


test_that("cross_count", {
  expect_snapshot(cross_count(mini_diamond, cut, clarity))
})

test_that("cross_count, method='rowr'", {
  expect_snapshot(cross_count(mini_diamond, cut, clarity, method = "rowr"))
})

test_that("cross_count, method='colr'", {
  expect_snapshot(cross_count(mini_diamond, cut, clarity, method = "colr"))
})


test_that("list2df, method='row'", {
  x <- list(
    c("a", "1"),
    c("b", "2"),
    c("c", "3")
  )
  expect_snapshot(list2df(x, colnames = c("char", "num")))
})



test_that("list2df, method='col'", {
  x <- list(
    c("a", "b", "c"),
    c("1", "2", "3")
  )

  expect_snapshot(list2df(x, method = "col"))
})


test_that("exist_matrix", {
  x <- 1:5 %>% map(~ gen_char(to = "k", n = 5, random = TRUE, seed = .x))
  expect_snapshot(exist_matrix(x))
})

test_that("exist_matrix, sort_items", {
  x <- 1:5 %>% map(
    ~ str_c(
      gen_char(to = "d", n = 3, random = TRUE, seed = .x),
      gen_char(from = "o", n = 3, random = TRUE, seed = .x) %>% str_to_upper()
    )
  )
  expect_snapshot(exist_matrix(x, sort_items = ~ str_sub(.x, start = 2)))
})

test_that("seriate_df", {
  x <- mini_diamond %>%
    dplyr::select(id, dplyr::where(is.numeric)) %>%
    dplyr::mutate(
      dplyr::across(
        dplyr::where(is.numeric),
        ~ round(.x / max(.x), 4)
      )
    ) %>%
    c2r("id")
  expect_snapshot(seriate_df(x))
})


test_that("dx_tb", {
  x <- tibble::tibble(
    c1 = c("NA", NA, "a", "b"),
    c2 = c("c", "d", "e", "NULL"),
    c3 = c("T", "F", "F", "T"),
    c4 = c("T", "F", "F", NA),
    c5 = c("", " ", "\t", "\n")
  )


  expect_snapshot(dx_tb(x))
})


test_that("gen_tb", {
  expect_snapshot(gen_tb(fill = "str", nrow = 3, ncol = 4, len = 3, seed = 123))
})

test_that("diff_tb", {
  tb1 <- gen_tb(fill = "int", seed = 1)
  tb2 <- gen_tb(fill = "int", seed = 3)

  expect_snapshot(diff_tb(tb1, tb2))
})

test_that("diff_tb, delete", {
  expect_snapshot(diff_tb(mini_diamond, mini_diamond[1:90, ]))
})

test_that("diff_tb, add", {
  expect_snapshot(diff_tb(mini_diamond[1:90, ], mini_diamond))
})

test_that("diff_tb, add columns", {
  expect_snapshot(diff_tb(mini_diamond[1:5, -3], mini_diamond[1:5, ]))
})


test_that("tdf", {
  expect_snapshot(tdf(head(mini_diamond)))
})

test_that("tdf, with rownames", {
  expect_snapshot(tdf(c2r(head(mini_diamond), "id")))
})

test_that("uniq_in_cols", {
  expect_snapshot(uniq_in_cols(mini_diamond))
})


test_that("left_expand", {
  tb1 <- head(mini_diamond, 4)
  tb2 <- tibble(
    id = c("id-2", "id-4", "id-5"),
    carat = 1:3,
    price = c(1000, 2000, 3000),
    newcol = c("new2", "new4", "new5")
  )
  expect_snapshot(left_expand(tb1, tb2, by = "id"))
})

test_that("full_expand", {
  tb1 <- head(mini_diamond, 4)
  tb2 <- tibble(
    id = c("id-2", "id-4", "id-5"),
    carat = 1:3,
    price = c(1000, 2000, 3000),
    newcol = c("new2", "new4", "new5")
  )
  expect_snapshot(full_expand(tb1, tb2, by = "id"))
})

test_that("inner_expand", {
  tb1 <- head(mini_diamond, 4)
  tb2 <- tibble(
    id = c("id-2", "id-4", "id-5"),
    carat = 1:3,
    price = c(1000, 2000, 3000),
    newcol = c("new2", "new4", "new5")
  )
  expect_snapshot(inner_expand(tb1, tb2, by = "id"))
})


test_that("rewrite_na", {
  tb1 <- tibble(
    id = c("id-1", "id-2", "id-3", "id-4"),
    group = c("a", "b", "a", "b"),
    price = c(0, -200, 3000, NA),
    type = c("large", "none", "small", "none")
  )
  tb2 <- tibble(
    id = c("id-1", "id-2", "id-3", "id-4"),
    group = c("a", "b", "a", "b"),
    price = c(1, 2, 3, 4),
    type = c("l", "x", "x", "m")
  )
  expect_snapshot(rewrite_na(tb1, tb2, by = c("id", "group")))
})
