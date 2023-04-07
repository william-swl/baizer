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
#' @param trans scale transformation
#' @param paired paired samples or not
#' @param .by super-group
#' @param method test method, 'wilcoxon' as default
#' @param alternative one of "two.sided" (default), "greater" or "less"
#' @inheritParams rstatix::wilcox_test
#'
#' @return test result tibble
#' @export
#'
#' @examples stat_test(mini_diamond, y = price, x = cut, .by = clarity)
stat_test <- function(df, y, x, trans = "identity",
                      paired = FALSE, alternative = "two.sided",
                      method = "wilcoxon", .by = NULL, ...) {
  y <- rlang::enquo(y)
  x <- rlang::enquo(x)
  .by <- rlang::enquo(.by)

  # if the real x column levels not match to factor levels
  # rstatix will throw an error
  factor_levels <- df[[quo_name(x)]] %>% levels()
  real_levels <- df[[quo_name(x)]] %>% unique()

  if (!is.null(factor_levels) &&
    (length(factor_levels) != length(real_levels))) {
    stop("please reset the factor levels to match the data!")
  }

  res <- df


  # trans
  if (trans == "log10") {
    res <- dplyr::mutate(res, !!y := log10(!!y))
  }

  # fomula
  fomular_str <- stringr::str_c(rlang::quo_name(y), "~", rlang::quo_name(x))

  # super-group
  res <- res %>% dplyr::group_by({{ .by }})

  # test
  if (method == "wilcoxon") {
    res <- res %>% rstatix::wilcox_test(stats::as.formula(fomular_str),
      paired = paired,
      alternative = alternative, ...
    )
  } else if (method == "t") {
    res <- res %>% rstatix::t_test(stats::as.formula(fomular_str),
      paired = paired,
      alternative = alternative, ...
    )
  }

  res <- res %>% rstatix::add_significance(
    "p",
    symbols = c("****", "***", "**", "*", "NS")
  )

  return(res)
}




#' fold change calculation which returns a extensible tibble
#'
#' @param df tibble
#' @param y value
#' @param x sample test group
#' @param .by super-group
#' @param method `'mean'|'median'|'geom_mean'`, the summary method
#' @param signif_digits fold change signif digits
#' @param rev_div reverse division
#'
#' @return fold change result tibble
#' @export
#'
#' @examples stat_fc(mini_diamond, y = price, x = cut, .by = clarity)
stat_fc <- function(df, y, x, method = "mean", .by = NULL,
                    rev_div = FALSE, signif_digits = 2) {
  y <- rlang::enquo(y)
  x <- rlang::enquo(x)
  .by <- rlang::enquo(.by)

  # only keep necessary columns
  df <- df %>% dplyr::select({{ y }}, {{ x }}, {{ .by }})

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

  df <- df %>% dplyr::summarise("{{y}}" := # nolint
    func({{ y }}), .by = c({{ .by }}, {{ x }}))

  # full join
  if (rlang::quo_is_null(.by)) {
    # create auxiliary column
    df <- df %>% dplyr::mutate(by = "")
    by <- "by"
  } else {
    by <- rlang::quo_name(.by)
  }

  res <- dplyr::full_join(df, df,
    by = by,
    suffix = c("_1", "_2"), multiple = "all",
    relationship = "many-to-many"
  )

  # fold change
  ycol1 <- stringr::str_c(rlang::quo_name(y), "_1")
  ycol2 <- stringr::str_c(rlang::quo_name(y), "_2")
  res <- res %>%
    dplyr::mutate(
      fc = .data[[ycol1]] / .data[[ycol2]]
    )
  # reverse div
  if (rev_div) {
    res <- res %>% dplyr::mutate(fc = 1 / .data[["fc"]])
  }

  res <- res %>% dplyr::mutate(
    fc_fmt = signif_string(.data$fc, signif_digits) %>%
      stringr::str_c("x")
  )

  # remove auxiliary column
  if (rlang::quo_is_null(.by)) {
    res <- res %>% dplyr::select(-tidyselect::all_of(by))
  }

  # rename
  rename_vector <- c(
    stringr::str_c(rlang::quo_name(x), c("_1", "_2")),
    ycol1, ycol2
  )
  names(rename_vector) <- c("group1", "group2", "y1", "y2")
  res <- res %>% dplyr::rename(rename_vector)

  # relocate
  res <- res %>% dplyr::select(
    {{ .by }}, tidyselect::matches("group\\d"), tidyselect::matches("y\\d"),
    tidyselect::starts_with("fc")
  )


  return(res)
}
