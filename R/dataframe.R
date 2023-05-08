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
                        ext_fmt = "count", sort = FALSE, digits = 2) {
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



#' remove columns by the ratio of NA
#'
#' @param df tibble
#' @param max_ratio max NA ratio, default as 1 which remove the columns only
#' have NA
#'
#' @return tibble
#' @export
#'
#' @examples # remove_nacol(df)
remove_nacol <- function(df, max_ratio = 1) {
  keep <- which(colSums(is.na(df)) < max_ratio * nrow(df))
  res <- df[, keep]
  return(res)
}

#' remove rows by the ratio of NA
#'
#' @param df tibble
#' @param max_ratio max NA ratio, default as 1 which remove the rows only
#' have NA
#'
#' @return tibble
#' @export
#'
#' @examples # remove_narow(df)
remove_narow <- function(df, max_ratio = 1) {
  keep <- which(rowSums(is.na(df)) < max_ratio * ncol(df))
  res <- df[keep, ]
  return(res)
}



#' separate numeric x into bins
#'
#' @param x numeric vector
#' @param bins bins number, defaults to 10
#' @param sort sort the result tibble
#' @param lim the min and max limits of bins, default as `c(min(x), max(x))`
#' @param breaks assign breaks directly and will ignore `bins` and `lim`
#'
#' @return tibble
#' @export
#'
#' @examples
#'
#' x <- dplyr::pull(mini_diamond, price, id)
#'
#' hist_bins(x, bins = 20)
#'
hist_bins <- function(x, bins = 10, lim = c(min(x), max(x)), # nolint
                      breaks = NULL, sort = FALSE) {
  if (!is.numeric(x)) {
    stop("please use numerice vector!")
  }

  if (lim[1] > min(x) || lim[2] < max(x)) {
    stop(
      "the full interval assigned by lim or breaks must cover min(x) to max(x)!"
    )
  }

  if (!is.null(breaks) &&
    (breaks[1] > min(x) || breaks[length(breaks)] < max(x))) {
    stop("the global interval assigned by lim or breaks
         must include min(x) to max(x)!")
  }

  if (is.null(breaks)) {
    breaks <- seq(lim[1], lim[2], length.out = bins + 1)
  }

  dfbin <- tibble(
    start = breaks[1:(length(breaks) - 1)],
    end = breaks[2:length(breaks)]
  ) %>%
    dplyr::mutate(bin = seq_len(dplyr::n()))

  if (is.null(names(x))) {
    dfvec <- as_tibble(x)
  } else {
    dfvec <- as_tibble(x, rownames = "id")
  }

  dfres <- dfvec %>% dplyr::left_join(
    dfbin,
    by = dplyr::join_by(
      between(value, start, end, bounds = "(]") # nolint
    )
  )

  fill_row <- which(!is.na(dfres[["value"]]) & is.na(dfres[["bin"]]))

  dfres[fill_row, c("start", "end", "bin")] <-
    dfbin[1, c("start", "end", "bin")]

  if (sort == TRUE) {
    dfres <- dplyr::arrange(dfres, .data[["value"]])
  }

  return(dfres)
}



#' trans a table in markdown format into tibble
#'
#' @param x character string
#'
#' @return tibble
#' @export
#'
#' @examples
#'
#' x <- "
#' col1 | col2 | col3 |
#' | ---- | ---- | ---- |
#' | v1   | v2   | v3   |
#' | r1   | r2   | r3   |
#' "
#'
#' as_tibble_md(x)
#'
as_tibble_md <- function(x) {
  if (length(x) > 1) {
    stop("input shoule be a string!")
  }

  mdlist <- x %>%
    # remove blank on two sides
    stringr::str_replace_all(c("^\\s+?" = "", "\\s+?$" = "")) %>%
    # clean header sep row
    stringr::str_replace_all(c("\n[\\|\\t -]+?\n" = "\n")) %>%
    # row sep
    stringr::str_replace_all(c("\\t* *\\|\\t* *\n\\t* *\\|\\t* *" = "\n")) %>%
    # clean extra blank characters
    stringr::str_replace_all(c("\\|\\t* *" = "\\|", "\\t* *\\|" = "\\|")) %>%
    # remove first and last |
    stringr::str_replace_all(c("^\\|" = "", "\\|$" = "")) %>%
    # delim
    stringr::str_replace_all("\\|", "\t") %>%
    # sep row
    stringr::str_split("\n") %>%
    unlist() %>%
    # sep col
    stringr::str_split("\t")

  md_names <- mdlist[[1]]

  md_tb <- mdlist[-1]

  res <- md_tb %>%
    purrr::map_dfr(function(x) {
      names(x) <- md_names
      x <- tibble::as_tibble_row(x)
      return(x)
    })

  return(res)
}


#' trans a tibble into markdown format table
#'
#' @param x tibble
#' @param show show result instead of return the markdown string, TRUE as
#' default
#'
#' @return NULL or markdown string
#' @export
#'
#' @examples
#'
#' mini_diamond %>%
#'   head(5) %>%
#'   as_md_table()
#'
as_md_table <- function(x, show = TRUE) {
  if (!is.data.frame(x)) {
    stop("input should be a tibble")
  }

  header_row <- colnames(x)

  sep_row <- rep("-", ncol(x))

  mdlist <- x %>% t()
  colnames(mdlist) <- stringr::str_c("c", seq_along(x[[1]]))
  mdlist <- mdlist %>%
    as_tibble() %>%
    as.list()

  mdlist <- c(list(header_row, sep_row), mdlist)

  res <- mdlist %>%
    purrr::map_chr(
      ~ stringr::str_c(.x, collapse = " | ") %>%
        stringr::str_c("| ", ., " |")
    ) %>%
    stringr::str_c(collapse = "\n")
  if (show == TRUE) {
    cat(res)
  } else {
    return(res)
  }
}



#' relevel a target column by another reference column
#'
#' @param x tibble
#' @param col target column
#' @param ref reference column
#'
#' @return tibble
#' @export
#'
#' @examples
#'
#' cut_level <- mini_diamond %>%
#'   dplyr::pull(cut) %>%
#'   unique()
#'
#' mini_diamond %>%
#'   dplyr::mutate(cut = factor(cut, cut_level)) %>%
#'   dplyr::mutate(cut0 = stringr::str_c(cut, "xxx")) %>%
#'   ref_level(cut0, cut)
ref_level <- function(x, col, ref) {
  col <- enquo(col)
  ref <- enquo(ref)

  ref_levels <- levels(x[[quo_name(ref)]])
  ref2col <- x %>%
    dplyr::pull({{ col }}, {{ ref }}) %>%
    uniq()

  if (length(ref2col) != length(ref_levels)) {
    diff <- setdiff(ref_levels, names(ref2col)) %>%
      stringr::str_c(collapse = ", ")
    stop(stringr::str_c("unmatched between ref and col: ", diff))
  }

  col_levels <- ref2col[ref_levels]

  res <- x %>% dplyr::mutate(!!col := factor(!!col, levels = col_levels))

  return(res)
}


#' count two columns as a cross-tabulation table
#' @param df tibble
#' @param row the column as rownames in the output
#' @param col the column as colnames in the output
#' @param method one of `n|count, rowr|row_ratio, colr|col_ratio`
#' @param digits 	the digits of ratios
#'
#' @return data.frame
#' @export
#'
#' @examples
#' cross_count(mini_diamond, cut, clarity)
#'
#' # show the ratio in the row
#' cross_count(mini_diamond, cut, clarity, method = "rowr")
#'
#' # show the ratio in the col
#' cross_count(mini_diamond, cut, clarity, method = "colr")
#'
cross_count <- function(df, row, col, method = "n", digits = 2) {
  row <- enquo(row)
  col <- enquo(col)
  if (quo_is_null(row) || quo_is_null(col)) {
    stop("Please input row and column of the output!")
  }

  if (method %in% c("n", "count")) {
    res <- df %>% fancy_count({{ row }}, {{ col }})
    res <- res %>% pivot_wider(
      id_cols = -all_of("r"),
      names_from = {{ col }}, values_from = "n"
    )
  } else if (method %in% c("rowr", "row_ratio")) {
    res <- df %>%
      dplyr::group_by({{ row }}) %>%
      fancy_count({{ row }}, {{ col }}, digits = digits)
    res <- res %>% pivot_wider(
      id_cols = -all_of("n"),
      names_from = {{ col }}, values_from = "r"
    )
  } else if (method %in% c("colr", "col_ratio")) {
    res <- df %>%
      dplyr::group_by({{ col }}) %>%
      fancy_count({{ row }}, {{ col }}, digits = digits)
    res <- res %>% pivot_wider(
      id_cols = -all_of("n"),
      names_from = {{ col }}, values_from = "r"
    )
  }
  res <- res %>% c2r(quo_name(row))
  return(res)
}
