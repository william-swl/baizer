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
  if (is.numeric(col)) {
    if (col > 0) {
      col <- colnames(df)[col]
    }
  }
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


#' fancy count to show an extended column
#'
#' @param df tibble
#' @param sort sort by frequency or not
#' @param ... other arguments from `dplyr::count()`
#' @param ext extended column
#' @param ext_fmt `count|ratio|clean`, output format of extended column
#' @param digits if `ext_fmt=ratio`, the digits of ratio
#'
#' @return count tibble
#' @export
#'
#' @examples
#' fancy_count(mini_diamond, cut, ext = clarity)
#'
#' fancy_count(mini_diamond, cut, ext = clarity, ext_fmt = "ratio")
#'
#' fancy_count(mini_diamond, cut, ext = clarity, ext_fmt = "clean")
#'
#' fancy_count(mini_diamond, cut, ext = clarity, sort = FALSE)
#'
#' fancy_count(mini_diamond, cut, clarity, ext = id) %>% head(5)
fancy_count <- function(df, ..., ext = NULL,
                        ext_fmt = "count", sort = TRUE, digits = 2) {
  # count and ratio column
  # do not sort to avoid different order against dplyr::group_split
  res <- dplyr::count(df, ...) %>%
    dplyr::mutate(r = round(.data$n / sum(.data$n), digits = digits))

  ext <- enquo(ext)
  ext_chr <- quo_name(ext)
  # if have extended column
  if (!quo_is_null(ext)) {
    count_list <- df %>%
      dplyr::group_split(...) %>%
      # a safe inline sort
      purrr::map(~ dplyr::count(.x, ext = eval(ext), sort = sort))


    if (ext_fmt == "clean") {
      # clean
      dfext <- count_list %>%
        purrr::map_chr(
          ~ dplyr::pull(.x, 1) %>% stringr::str_c(collapse = ",")
        ) %>%
        as_tibble_col(column_name = ext_chr)
    } else if (ext_fmt == "count") {
      # count
      dfext <- count_list %>%
        purrr::map_chr(
          ~ dplyr::pull(.x, 2, 1) %>% collapse_vector()
        ) %>%
        as_tibble_col(column_name = ext_chr)
    } else if (ext_fmt == "ratio") {
      # ratio
      dfext <- count_list %>%
        purrr::map_chr(
          ~ dplyr::mutate(.x, r = round(n / sum(n), 2)) %>%
            dplyr::pull("r", 1) %>%
            collapse_vector()
        ) %>%
        as_tibble_col(column_name = ext_chr)
    }

    # merge main count and extended column
    res <- dplyr::bind_cols(res, dfext)
  }


  # sort
  if (sort == TRUE) {
    res <- res %>% dplyr::arrange(dplyr::desc(.data$n))
  }

  return(res)
}


#' split a column and return a longer tibble
#'
#' @param df tibble
#' @param name_col repeat this as name column
#' @param value_col expand by this value column
#' @param sep separator in the string
#'
#' @return expanded tibble
#' @export
#'
#' @examples fancy_count(mini_diamond, cut, ext = clarity) %>%
#'   split_column(name_col = cut, value_col = clarity)
split_column <- function(df, name_col, value_col, sep = ",") {
  value_col <- enquo(value_col)
  name_col <- enquo(name_col)

  v <- df %>% dplyr::pull({{ value_col }}, {{ name_col }})
  l <- v %>% stringr::str_split(sep)
  res <- purrr::map2_dfr(
    names(v), l,
    ~ tibble::tibble(!!name_col := .x, !!value_col := .y)
  )

  return(res)
}

#' move selected rows to target location
#'
#' @param df tibble
#' @param rows selected rows indexes
#' @param .after `TRUE` will move selected rows to the last row,
#' or you can pass a target row index
#' @param .before `TRUE` will move selected rows to the first row,
#' or you can pass a target row index
#'
#' @return reordered tibble
#' @export
#'
#' @examples move_row(mini_diamond, 3:5, .after = 8)
move_row <- function(df, rows, .after = FALSE, .before = FALSE) {
  # error
  if (!is.numeric(rows)) {
    stop("please input row indexes!")
  }
  if (length(.after) != 1 || length(.before) != 1) {
    stop("the length of .after and .before should be 1")
  }
  if (.after %in% rows || .before %in% rows) {
    stop(".after and .before should not be in selected rows")
  }


  if (is.logical(.after) && .after == TRUE && .before == FALSE) {
    dplyr::bind_rows(df[-rows, ], df[rows, ])
  } else if (is.logical(.before) && .before == TRUE && .after == FALSE) {
    dplyr::bind_rows(df[rows, ], df[-rows, ])
  } else if (is.numeric(.after) || is.numeric(.before)) {
    if (is.numeric(.after) && .before == FALSE) {
      target <- .after
    } else if (is.numeric(.before) && .after == FALSE) {
      target <- .before
    }

    # sep rows
    rows_up <- rows[which(rows < target)]
    rows_down <- rows[which(rows > target)]

    # df_up
    if (target == 1) {
      df_up <- tibble::tibble(NULL)
    } else if (length(rows_up) == 0) {
      df_up <- df[1:(target - 1), ]
    } else if (length(rows_up) > 0) {
      df_up <- df[1:(target - 1), ][-rows_up, ]
    }

    # df_down
    if (target == nrow(df)) {
      df_down <- tibble::tibble(NULL)
    } else if (length(rows_down) == 0) {
      df_down <- df[(target + 1):nrow(df), ]
    } else if (length(rows_down) > 0) {
      df_down <- df[(target + 1):nrow(df), ][-(rows_down - target), ]
    }

    # bind rows
    if (is.numeric(.after) && .before == FALSE) {
      dplyr::bind_rows(df_up, df[target, ], df[rows, ], df_down)
    } else if (is.numeric(.before) && .after == FALSE) {
      dplyr::bind_rows(df_up, df[rows, ], df[target, ], df_down)
    }
  }
}



#' slice a tibble by an ordered vector
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
#' @examples ordered_slice(mini_diamond, id, c("id-3", "id-2"))
ordered_slice <- function(df, by, ordered_vector,
                          na.rm = FALSE, dup.rm = FALSE) {
  by <- enquo(by)
  by_chr <- quo_name(by)

  if (any(duplicated(df[[by_chr]]))) {
    stop("Column values not unique!")
  }

  index <- match(ordered_vector, df[[by_chr]])
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
