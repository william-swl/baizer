#' wrapper of tibble::column_to_rownames
#'
#' @param df tibble
#' @param col a col name
#'
#' @return data.frame
#' @export
#'
#' @examples mini_diamond %>% c2r("id")
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
#' @examples mini_diamond %>%
#'   c2r("id") %>%
#'   r2c("id")
r2c <- function(df, col = "") {
  df %>%
    tibble::rownames_to_column(col) %>%
    tibble::as_tibble()
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
#' @examples fancy_count(mini_diamond, "cut", "clarity")
fancy_count <- function(df, main_group, fine_group,
                        fine_fmt = "count", sort = TRUE) {
  fine_group_count <- df %>%
    dplyr::count(.data[[main_group]], .data[[fine_group]], sort = sort) %>%
    dplyr::group_split(.data[[main_group]]) %>%
    purrr::map_dfr(
      function(x) {
        v <- c(
          dplyr::pull(x, .data[[main_group]]) %>% unique(),
          sum(x$n),
          if (fine_fmt == "count") {
            dplyr::pull(x, .data$n, .data[[fine_group]]) %>% collapse_vector()
          } else if (fine_fmt == "ratio") {
            round(
              dplyr::pull(x, .data$n, .data[[fine_group]]) / sum(x$n),
              2
            ) %>% collapse_vector()
          } else if (fine_fmt == "clean") {
            dplyr::pull(x, .data[[fine_group]]) %>%
              stringr::str_c(collapse = ",")
          }
        )
        names(v) <- c(main_group, "n", fine_group)
        return(v)
      }
    )

  # ratio
  res <- fine_group_count %>%
    dplyr::mutate(
      n = as.integer(.data$n),
      r = round(.data$n / sum(.data$n), 2), .after = "n"
    )

  # sort the main_group
  if (sort == TRUE) {
    res <- res %>% dplyr::arrange(dplyr::desc(.data$n))
  }

  return(res)
}

#' better slice by an ordered vector
#'
#' @param df tibble
#' @param by slice by this column, this value must has no duplicated value
#' @param ordered_vector ordered vector
#' @param na.rm remove NA or unknown values from ordered vector
#' @param dup.rm remove duplication values from ordered vector
#'
#' @return sliced tibble
#' @export
#'
#' @examples ordered_slice(mini_diamond, "id", c("id-3", "id-2"))
ordered_slice <- function(df, by, ordered_vector,
                          na.rm = FALSE, dup.rm = FALSE) {
  if (any(duplicated(df[[by]]))) {
    stop("Column values not unique!")
  }

  index <- match(ordered_vector, df[[by]])
  na_count <- sum(is.na(index))
  dup_count <- sum(duplicated(index))

  if (na_count > 0) {
    warning(stringr::str_c(na_count, " NA values!"), immediate. = TRUE)
  }

  if (dup_count > 0) {
    warning(stringr::str_c(dup_count, " duplicated values!"), immediate. = TRUE)
  }

  if (na.rm == TRUE) {
    index <- stats::na.omit(index)
  }

  if (dup.rm == TRUE) {
    index <- unique(index)
  }

  return(df[index, ])
}
