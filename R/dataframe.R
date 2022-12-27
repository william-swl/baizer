#' wrapper of tibble::column_to_rownames
#'
#' @param df tibble
#' @param col a col name
#'
#' @return data.frame
#' @export
#'
#' @examples df %>% c2r("col")
c2r <- function(df, col = "") {
  df %>% tibble::column_to_rownames(col)
}

#' wrapper of tibble::rownames_to_column
#'
#' @param df tibble
#' @param col a col name
#'
#' @return tibble
#' @export
#'
#' @examples df %>% r2c("col")
r2c <- function(df, col = "") {
  df %>% tibble::rownames_to_column(col)
}
