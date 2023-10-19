#' generate all combinations
#'
#' @param x vector
#' @param n numbers of element to combine
#'
#' @return all combinations
#' @export
#'
#' @examples gen_combn(1:4, n = 2)
#'
gen_combn <- function(x, n = 2) {
  res <- combn(x, n) %>%
    as.data.frame() %>%
    as.list() %>%
    unname()
  return(res)
}

#' geometric mean
#'
#' @param x value
#' @param na.rm remove NA or not
#'
#' @return geometric mean value
#' @export
#'
#' @examples geom_mean(1, 9)
geom_mean <- function(x, na.rm = TRUE) {
  exp(mean(log(x), na.rm = na.rm))
}


#' statistical test which returns a extensible tibble
#'
#' @param df tibble
#' @param y value
#' @param x sample test group
#' @param .by super-group
#' @param trans scale transformation
#' @param paired paired samples or not
#' @param paired_by a column for pair
#' @param method test method, 'wilcoxon' as default, one of `t|wilcoxon`
#' @param alternative one of "two.sided" (default), "greater" or "less"
#' @param ns_symbol symbol of nonsignificant, 'NS' as default
#' @param exclude_func a function has two arguments and return bool value, used
#' if paired=TRUE and will keep the comparation pairs which return TRUE by this
#' function.
#' @param digits significant figure digits of p value
#' If the data pair of a single test returns TRUE, then exclude this pair
#' @return test result tibble
#' @export
#'
#' @examples stat_test(mini_diamond, y = price, x = cut, .by = clarity)
stat_test <- function(df, y, x, .by = NULL, trans = "identity",
                      paired = FALSE, paired_by = NULL,
                      alternative = "two.sided", exclude_func = NULL,
                      method = "wilcoxon", ns_symbol = "NS", digits = 2) {
  y <- rlang::enquo(y)
  x <- rlang::enquo(x)
  paired_by <- rlang::enquo(paired_by)
  .by <- rlang::enquo(.by)

  if (paired == TRUE && quo_is_null(paired_by)) {
    stop("please use paired_by to assign a column for pairs!")
  }

  # arrange to keep a right order
  if (!quo_is_null(paired_by)) {
    df <- df %>% arrange(!!paired_by)
  }
  df <- df %>% arrange(!!x)
  if (!quo_is_null(.by)) {
    df <- df %>% arrange(!!.by)
  }

  df <- df %>% select(!!x, !!y, !!.by)

  # trans
  if (trans == "log10") {
    df <- dplyr::mutate(df, !!y := log10(!!y))
  }


  # define stat function for each .by
  stat_in_super_group <- function(df_in_super_group) {
    xs <- df_in_super_group %>%
      dplyr::pull(!!x) %>%
      unique() %>%
      as.character()
    res_in_super_group <- combn(xs, 2) %>% t()
    colnames(res_in_super_group) <- c("group1", "group2")
    res_in_super_group <- res_in_super_group %>%
      as_tibble() %>%
      filter(.data[["group1"]] != .data[["group2"]])
    x2n <- df_in_super_group %>%
      count(!!x) %>%
      dplyr::pull(.data[["n"]], !!x)

    # number in each group
    res_in_super_group <- res_in_super_group %>%
      mutate(n1 = x2n[.data[["group1"]]], n2 = x2n[.data[["group2"]]])

    # split tibble
    ydata_list <- names(x2n) %>% map(~ df_in_super_group %>%
      filter(!!x == .x) %>%
      dplyr::pull(!!y))
    names(ydata_list) <- names(x2n)

    # ydata, each list term for each row in res_in_super_group
    ydata1 <- ydata_list[res_in_super_group[["group1"]]]
    ydata2 <- ydata_list[res_in_super_group[["group2"]]]

    # test
    if (method == "wilcoxon") {
      test_func <- stats::wilcox.test
    } else if (method == "t") {
      test_func <- stats::t.test
    }

    single_test <- function(y1, y2) {
      # exclude specific test pair
      if (!is.null(exclude_func) && (paired == TRUE)) {
        exclude_mask <- map2_lgl(y1, y2, exclude_func)
        print(str_glue(
          "exclude {sum(exclude_mask)} data pair because of exclude_func"
        ))
        y1 <- y1[!exclude_mask]
        y2 <- y2[!exclude_mask]
      }

      # if one side of test is NA set
      if (all(is.na(y1)) || all(is.na(y2))) {
        single_test_pvalue <- NA
      } else {
        single_test_pvalue <- test_func(y1, y2,
          paired = paired,
          alternative = alternative
        )$p.value
      }

      return(single_test_pvalue)
    }

    pvalue <- suppressWarnings({
      map2_dbl(ydata1, ydata2, single_test)
    })


    # add symbol
    symbols <- tibble(
      plim = c(1.01, 0.05, 0.01, 0.001, 0.0001),
      psymbol = c(ns_symbol, "*", "**", "***", "****")
    )

    res_in_super_group <- res_in_super_group %>%
      mutate(p = pvalue) %>%
      left_join(symbols, by = join_by(closest(p < plim))) %>% # nolint
      mutate(p = signif_string(p, digits = digits)) %>%
      filter(!is.na(.data[["p"]]))

    res_in_super_group <- res_in_super_group %>%
      mutate(y = quo_name(y), .before = 1)

    return(res_in_super_group)
  }


  if (!quo_is_null(.by)) {
    bys <- df %>%
      dplyr::pull(!!.by) %>%
      unique()
    df_list <- bys %>% map(~ df %>% filter(!!.by == .x))
    res <- map2_dfr(
      df_list, bys,
      ~ stat_in_super_group(.x) %>%
        mutate(!!.by := .y) %>%
        relocate(!!.by, .after = y)
    )
  } else {
    res <- stat_in_super_group(df)
  }
  return(res)
}



#' fold change calculation which returns a extensible tibble
#'
#' @param df tibble
#' @param y value
#' @param x sample test group
#' @param .by super-group
#' @param method `'mean'|'median'|'geom_mean'`, the summary method
#' @param rev_div reverse division
#' @param digits fold change digits
#' @param fc_fmt fold change format, one of short, signif, round
#' @param suffix suffix of fold change, `x` as default
#'
#' @return fold change result tibble
#' @export
#'
#' @examples stat_fc(mini_diamond, y = price, x = cut, .by = clarity)
stat_fc <- function(df, y, x, method = "mean", .by = NULL,
                    rev_div = FALSE, digits = 2, fc_fmt = "short",
                    suffix = "x") {
  y <- rlang::enquo(y)
  x <- rlang::enquo(x)
  .by <- rlang::enquo(.by)

  stat_in_super_group <- function(df_in_super_group) {
    # only keep necessary columns
    df_in_super_group <- df_in_super_group %>% dplyr::select({{ y }}, {{ x }})

    # smmarise
    if (method == "mean") {
      func <- function(x) mean(x, na.rm = TRUE)
    } else if (method == "median") {
      func <- function(x) median(x, na.rm = TRUE)
    } else if (method == "geom_mean") {
      func <- function(x) geom_mean(x, na.rm = TRUE)
    } else {
      stop("choose a method from mean, median and geom_mean")
    }

    df_in_super_group <- df_in_super_group %>%
      dplyr::summarise("{{y}}" := # nolint
        func({{ y }}), .by = {{ x }}) %>%
      rename(x = {{ x }}, y = {{ y }})

    xs <- df_in_super_group %>%
      arrange(.data[["x"]]) %>%
      dplyr::pull(.data[["x"]]) %>%
      unique() %>%
      as.character()
    res_in_super_group <- combn(xs, 2) %>% t()
    colnames(res_in_super_group) <- c("group1", "group2")
    res_in_super_group <- res_in_super_group %>%
      as_tibble() %>%
      filter(.data[["group1"]] != .data[["group2"]])

    res_in_super_group <- res_in_super_group %>%
      left_join(df_in_super_group, by = c("group1" = "x")) %>%
      left_join(df_in_super_group, by = c("group2" = "x"), suffix = c("1", "2"))

    res_in_super_group <- res_in_super_group %>% dplyr::mutate(
      fc = .data[["y1"]] / .data[["y2"]]
    )

    # reverse div
    if (rev_div) {
      res_in_super_group <- res_in_super_group %>%
        dplyr::mutate(fc = 1 / .data[["fc"]])
    }


    # fc format
    if (fc_fmt == "short") {
      res_in_super_group <- res_in_super_group %>% dplyr::mutate(
        fc_fmt = signif_round_string(.data$fc, digits) %>%
          stringr::str_c(suffix)
      )
    } else if (fc_fmt == "signif") {
      res_in_super_group <- res_in_super_group %>% dplyr::mutate(
        fc_fmt = signif_string(.data$fc, digits) %>%
          stringr::str_c(suffix)
      )
    } else if (fc_fmt == "round") {
      res_in_super_group <- res_in_super_group %>% dplyr::mutate(
        fc_fmt = round_string(.data$fc, digits) %>%
          stringr::str_c(suffix)
      )
    } else {
      stop("fc_fmt should be one of short,signif,round")
    }

    res_in_super_group <- res_in_super_group %>%
      mutate(y = quo_name(y), .before = 1) %>%
      filter(!is.na(.data[["fc"]]))

    return(res_in_super_group)
  }


  if (!quo_is_null(.by)) {
    bys <- df %>%
      arrange(!!.by) %>%
      dplyr::pull(!!.by) %>%
      unique()
    df_list <- bys %>% map(~ df %>% filter(!!.by == .x))
    res <- map2_dfr(
      df_list, bys,
      ~ stat_in_super_group(.x) %>%
        mutate(!!.by := .y) %>%
        relocate(!!.by, .after = y)
    )
  } else {
    res <- stat_in_super_group(df)
  }
  return(res)
}



#' calculate phi coefficient of two binary variables
#'
#' @param x 2x2 matrix or dataframe
#'
#' @return phi coefficient
#' @export
#'
#' @examples
#' data <- matrix(c(10, 8, 14, 18), nrow = 2)
#' stat_phi(data)
stat_phi <- function(x) {
  if (prod(dim(x)) != 4) {
    stop("the dim of x should be 2x2")
  }
  numerator <- x[1, 1] * x[2, 2] - x[1, 2] * x[2, 1]
  denominator <- sqrt(prod(colSums(x), rowSums(x)))
  return(numerator / denominator)
}
