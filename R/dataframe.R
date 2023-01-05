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
  df %>% tibble::rownames_to_column(col) %>% tibble::as_tibble()
}


#' better count to show a main column and a fine column
#'
#' @param df tibble
#' @param main_group main column as main group
#' @param fine_group fine column as subgroup
#' @param fine_fmt output fine column format, `count|ratio|clean`
#' @param sort sort by frequency or not
#'
#' @return tibble
#' @export
#'
#' @examples fancy_count(mini_diamond, 'cut', 'clarity')
fancy_count <- function(df, main_group, fine_group, fine_fmt='count', sort=TRUE) {
  fine_group_count <- df %>%
    dplyr::count(.data[[main_group]], .data[[fine_group]], sort=sort) %>%
    dplyr::group_split(.data[[main_group]]) %>%
    purrr::map_dfr(
      function(x){
        v <- c(
          dplyr::pull(x, .data[[main_group]]) %>% unique,
          sum(x$n),
          if (fine_fmt=='count') {
            dplyr::pull(x, n, .data[[fine_group]]) %>% collapse_vector
          } else if (fine_fmt=='ratio') {
            round(dplyr::pull(x, n, .data[[fine_group]]) / sum(x$n), 2) %>% collapse_vector
          } else if (fine_fmt=='clean') {
            dplyr::pull(x, .data[[fine_group]]) %>% stringr::str_c(collapse = ',')
          }
        )
        names(v) <- c(main_group, 'n', fine_group)
        return (v)
      }
    )

  # ratio
  res <- fine_group_count %>%
    dplyr::mutate(n=as.integer(n), r=round(n/sum(n), 2), .after=n)

  # sort the main_group
  if (sort==TRUE) {
    res <- res %>% dplyr::arrange(desc(n))
  }

  return (res)

}
