#' statistical test which returns a extensible tibble
#'
#' @param df tibble
#' @param y value
#' @param x sample test group
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
stat_test <- function(df, y, x, paired = FALSE, alternative = "two.sided",
                      method = "wilcoxon", .by = NULL, ...) {
  y <- rlang::enquo(y)
  x <- rlang::enquo(x)
  .by <- rlang::enquo(.by)

  # fomular
  fomular_str <- stringr::str_c(rlang::quo_name(y), "~", rlang::quo_name(x))

  # super-group
  if (!rlang::quo_is_null(.by)) {
    res <- df %>% dplyr::group_by({{ .by }})
  }

  # test
  if (method == "wilcoxon") {
    res <- res %>% rstatix::wilcox_test(stats::as.formula(fomular_str),
      paired = paired,
      alternative = alternative, ...
    )
  }
  res <- res %>% rstatix::add_significance("p",
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
#'
#' @return fold change result tibble
#' @export
#'
#' @examples stat_fc(mini_diamond, y = price, x = cut, .by = clarity)
stat_fc <- function(df, y, x, .by = NULL) {
  # only keep necessary columns
  df <- df %>% dplyr::select({{ y }}, {{ x }}, {{ .by }})

  y <- rlang::enquo(y)
  x <- rlang::enquo(x)
  .by <- rlang::enquo(.by)

  if (rlang::quo_is_null(.by)) {
    # create auxiliary column
    df <- df %>% dplyr::mutate(by = "")
    by <- "by"
  } else {
    by <- rlang::quo_name(.by)
  }

  res <- dplyr::full_join(df, df,
    by = by,
    suffix = c("_1", "_2"), multiple = "all"
  )
  c1 <- stringr::str_c(rlang::quo_name(y), "_1")
  c2 <- stringr::str_c(rlang::quo_name(y), "_2")
  fc_col <- stringr::str_c("fc_", rlang::quo_name(y))
  res <- res %>%
    dplyr::mutate(
      "fc_{{y}}" := .data[[c1]] / .data[[c2]], # nolint
      "fc_{{y}}_fmt" := signif_string(.data[[fc_col]], 2) %>% # nolint
        stringr::str_c("x")
    )

  # remove auxiliary column
  if (rlang::quo_is_null(.by)) {
    res <- res %>% dplyr::select(-by)
  }

  # relocate
  res <- res %>% dplyr::select(
    {{ .by }}, tidyselect::contains(rlang::quo_name(x)),
    tidyselect::contains(rlang::quo_name(y)), tidyselect::contains("fc")
  )

  return(res)
}
