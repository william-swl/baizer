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
  # build fomular
  fomular_str <- stringr::str_c(
    deparse(substitute(y)), "~", deparse(substitute(x))
  )
  # if .by=NULL, will not test in group
  res <- df %>% dplyr::group_by({{ .by }})
  # test
  if (method == "wilcoxon") {
    res <- res %>% rstatix::wilcox_test(as.formula(fomular_str),
      paired = paired,
      alternative = alternative, ...
    )
  }
  res <- res %>% rstatix::add_significance("p",
    symbols = c("****", "***", "**", "*", "NS")
  )

  return(res)
}
