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
#' @param method test method, 'wilcoxon' as default
#' @param alternative one of "two.sided" (default), "greater" or "less"
#' @param ns_symbol symbol of nonsignificant, 'NS' as default
#'
#' @return test result tibble
#' @export
#'
#' @examples stat_test(mini_diamond, y = price, x = cut, .by = clarity)
stat_test <- function(df, y, x, .by = NULL, trans = "identity",
                      paired = FALSE, alternative = "two.sided",
                      method = "wilcoxon", ns_symbol = "NS") {
  y <- rlang::enquo(y)
  x <- rlang::enquo(x)
  .by <- rlang::enquo(.by)

  stat_ingroup <- function(df_ingroup) {
    # remove NA
    df_ingroup <- df_ingroup %>%
      filter(!is.na(!!y)) %>%
      select(!!x, !!y, !!.by)
    # trans
    if (trans == "log10") {
      df_ingroup <- dplyr::mutate(df_ingroup, !!y := log10(!!y))
    }

    xs <- df_ingroup %>%
      arrange(!!x) %>%
      dplyr::pull(!!x) %>%
      unique() %>%
      as.character()
    res_ingroup <- combn(xs, 2) %>% t()
    colnames(res_ingroup) <- c("group1", "group2")
    res_ingroup <- res_ingroup %>%
      as_tibble() %>%
      filter(.data[["group1"]] != .data[["group2"]])
    x2n <- df_ingroup %>%
      count(!!x) %>%
      dplyr::pull(.data[["n"]], !!x)

    # number in each group
    res_ingroup <- res_ingroup %>%
      mutate(n1 = x2n[.data[["group1"]]], n2 = x2n[.data[["group2"]]])

    # split tibble
    ydata_list <- names(x2n) %>% map(~ df_ingroup %>%
      filter(!!x == .x) %>%
      dplyr::pull(!!y))
    names(ydata_list) <- names(x2n)

    # ydata
    ydata1 <- ydata_list[unname(unlist(res_ingroup["group1"]))]
    ydata2 <- ydata_list[unname(unlist(res_ingroup["group2"]))]

    # test
    pvalue <- suppressWarnings({
      map2_dbl(
        ydata1, ydata2,
        ~ wilcox.test(.x, .y,
          paired = paired,
          alternative = alternative
        )$p.value
      )
    })


    # add symbol
    symbols <- tibble(
      plim = c(1.01, 0.05, 0.01, 0.001, 0.0001),
      symbol = c(ns_symbol, "*", "**", "***", "****")
    )

    res_ingroup <- res_ingroup %>%
      mutate(p = pvalue) %>%
      left_join(symbols, by = join_by(closest(p < plim))) # nolint

    res_ingroup <- res_ingroup %>% mutate(y = quo_name(y), .before = 1)

    return(res_ingroup)
  }

  if (!quo_is_null(.by)) {
    bys <- df %>%
      arrange(!!.by) %>%
      dplyr::pull(!!.by) %>%
      unique()
    df_list <- bys %>% map(~ df %>% filter(!!.by == .x))
    res <- map2_dfr(
      df_list, bys,
      ~ stat_ingroup(.x) %>%
        mutate(!!.by := .y) %>%
        relocate(!!.by, .after = y)
    )
  } else {
    res <- stat_ingroup(df)
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
#'
#' @return fold change result tibble
#' @export
#'
#' @examples stat_fc(mini_diamond, y = price, x = cut, .by = clarity)
stat_fc <- function(df, y, x, method = "mean", .by = NULL,
                    rev_div = FALSE, digits = 2, fc_fmt = "short") {
  y <- rlang::enquo(y)
  x <- rlang::enquo(x)
  .by <- rlang::enquo(.by)

  stat_ingroup <- function(df_ingroup) {
    # only keep necessary columns
    df_ingroup <- df_ingroup %>% dplyr::select({{ y }}, {{ x }})

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

    df_ingroup <- df_ingroup %>%
      dplyr::summarise("{{y}}" := # nolint
        func({{ y }}), .by = {{ x }}) %>%
      rename(x = {{ x }}, y = {{ y }})

    xs <- df_ingroup %>%
      arrange(.data[["x"]]) %>%
      dplyr::pull(.data[["x"]]) %>%
      unique() %>%
      as.character()
    res_ingroup <- combn(xs, 2) %>% t()
    colnames(res_ingroup) <- c("group1", "group2")
    res_ingroup <- res_ingroup %>%
      as_tibble() %>%
      filter(.data[["group1"]] != .data[["group2"]])

    res_ingroup <- res_ingroup %>%
      left_join(df_ingroup, by = c("group1" = "x")) %>%
      left_join(df_ingroup, by = c("group2" = "x"), suffix = c("1", "2"))

    res_ingroup <- res_ingroup %>% dplyr::mutate(
      fc = .data[["y1"]] / .data[["y2"]]
    )

    # reverse div
    if (rev_div) {
      res_ingroup <- res_ingroup %>% dplyr::mutate(fc = 1 / .data[["fc"]])
    }


    # fc format
    if (fc_fmt == "short") {
      res_ingroup <- res_ingroup %>% dplyr::mutate(
        fc_fmt = signif_round_string(.data$fc, digits) %>%
          stringr::str_c("x")
      )
    } else if (fc_fmt == "signif") {
      res_ingroup <- res_ingroup %>% dplyr::mutate(
        fc_fmt = signif_string(.data$fc, digits) %>%
          stringr::str_c("x")
      )
    } else if (fc_fmt == "round") {
      res_ingroup <- res_ingroup %>% dplyr::mutate(
        fc_fmt = round_string(.data$fc, digits) %>%
          stringr::str_c("x")
      )
    } else {
      stop("fc_fmt should be one of short,signif,round")
    }

    res_ingroup <- res_ingroup %>% mutate(y = quo_name(y), .before = 1)

    return(res_ingroup)
  }


  if (!quo_is_null(.by)) {
    bys <- df %>%
      arrange(!!.by) %>%
      dplyr::pull(!!.by) %>%
      unique()
    df_list <- bys %>% map(~ df %>% filter(!!.by == .x))
    res <- map2_dfr(
      df_list, bys,
      ~ stat_ingroup(.x) %>%
        mutate(!!.by := .y) %>%
        relocate(!!.by, .after = y)
    )
  } else {
    res <- stat_ingroup(df)
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
