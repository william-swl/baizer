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
#' @param ... only remove rows according to these columns,
#' refer to `dplyr::select()`
#'
#' @return tibble
#' @export
#'
#' @examples # remove_narow(df)
remove_narow <- function(df, ..., max_ratio = 1) {
  if (length(enexprs(...)) == 0) {
    df_sel <- df
  } else {
    df_sel <- dplyr::select(df, ...)
  }

  keep <- which(rowSums(is.na(df_sel)) < max_ratio * ncol(df_sel))
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

  # sort
  row_vec <- df[[quo_name(row)]]
  col_vec <- df[[quo_name(col)]]
  if (is.factor(row_vec)) {
    row_ord <- levels(row_vec)
  } else {
    row_ord <- unique(row_vec) %>% sort()
  }
  # the col_ord should be character for column selection
  if (is.factor(col_vec)) {
    col_ord <- levels(col_vec) %>% as.character()
  } else {
    col_ord <- unique(col_vec) %>%
      sort() %>%
      as.character()
  }

  res <- res %>%
    dplyr::mutate("{{row}}" := factor({{ row }}, row_ord)) %>% # nolint
    # use any_of, to avoid extra factor levels error
    select({{ row }}, any_of(col_ord))

  # return
  res <- res %>% c2r(quo_name(row))
  return(res)
}


#' trans list into tibble
#'
#' @param x list
#' @param colnames colnames of the output
#' @param method one of `row, col`, set each item as row or col, default as row
#'
#' @return tibble
#' @export
#'
#' @examples
#' x <- list(
#'   c("a", "1"),
#'   c("b", "2"),
#'   c("c", "3")
#' )
#'
#' list2tibble(x, colnames = c("char", "num"))
#'
#' x <- list(
#'   c("a", "b", "c"),
#'   c("1", "2", "3")
#' )
#'
#' list2tibble(x, method = "col")
list2tibble <- function(x, colnames = NULL, method = "row") {
  suppressMessages({
    if (method == "row") {
      res <- map_dfr(x, ~ as_tibble_row(.x, .name_repair = "unique"))
    } else if (method == "col") {
      res <- map_dfc(x, ~ as_tibble_col(.x))
    } else {
      stop("method should be one of row, col")
    }
  })

  if (is.null(colnames)) {
    colnames <- str_c("V", seq_len(ncol(res)))
  }
  colnames(res) <- colnames
  return(res)
}


#' generate a matrix to show whether the item in each element of a list
#'
#' @param x list of character vectors
#' @param n_lim n limit to keep items in result
#' @param n_top only keep top n items in result
#' @param sort_items function to sort the items, item frequency by default
#'
#' @return tibble
#' @export
#'
#' @examples
#' x <- 1:5 %>% purrr::map(
#'   ~ gen_char(to = "k", n = 5, random = TRUE, seed = .x)
#' )
#' exist_matrix(x)
#'
exist_matrix <- function(x, n_lim = 0, n_top = NULL, sort_items = NULL) {
  # character elements
  if (any(map_chr(x, class) != "character")) {
    stop("all elements of x should be character vectors!")
  }


  if (is.null(names(x))) {
    names(x) <- seq_along(x)
  }

  count_tb <- x %>%
    unlist() %>%
    as_tibble() %>%
    dplyr::count(value) %>%
    dplyr::arrange(dplyr::desc(.data[["n"]]))

  # keep top n, or keep items whose n > n_lim
  if (!is.null(n_top)) {
    count_tb <- count_tb %>% dplyr::slice(seq_len(n_top))
  } else {
    count_tb <- count_tb %>% dplyr::filter(.data[["n"]] > n_lim)
  }

  items <- count_tb[["value"]]

  # remove NA
  items <- items[!is.na(items)]

  if (!is.null(sort_items)) {
    items <- sortf(items, sort_items)
  }

  res <- x %>%
    purrr::map(~ items %in% .x) %>%
    as.data.frame()

  colnames(res) <- names(x)
  rownames(res) <- items

  res <- res %>%
    t() %>%
    as_tibble(rownames = NA)

  return(res)
}


#' dataframe rows seriation, which will reorder the rows in a better pattern
#'
#' @param x dataframe
#'
#' @return seriated dataframe
#' @export
#'
#' @examples
#' x <- mini_diamond %>%
#'   dplyr::select(id, dplyr::where(is.numeric)) %>%
#'   dplyr::mutate(
#'     dplyr::across(
#'       dplyr::where(is.numeric),
#'       ~ round(.x / max(.x), 4)
#'     )
#'   ) %>%
#'   c2r("id")
#'
#' seriate_df(x)
#'
seriate_df <- function(x) {
  row_ord <- seriation::seriate(x)[[1]][["order"]]
  return(x[row_ord, ])
}


#' diagnosis a tibble for character NA, NULL, all T/F column, blank in cell
#'
#' @param x tibble
#'
#' @return list
#' @export
#'
#' @examples
#' x <- tibble::tibble(
#'   c1 = c("NA", NA, "a", "b"),
#'   c2 = c("c", "d", "e", "NULL"),
#'   c3 = c("T", "F", "F", "T"),
#'   c4 = c("T", "F", "F", NA),
#'   c5 = c("", " ", "\t", "\n")
#' )
#'
#' dx_tb(x)
#'
dx_tb <- function(x) {
  res <- list(
    chr_na = as_tibble(which(x == "NA", arr.ind = TRUE)),
    chr_null = as_tibble(which(x == "NULL", arr.ind = TRUE)),
    only_tf = x %>%
      map_lgl(~ all(.x %in% c("T", "F", NA))) %>%
      which() %>%
      unname(),
    blank_in_cell = unlist(x) %>% str_subset("^\\s+$") %>% unique()
  )

  res[["stat"]] <- res %>% map_dbl(
    ~ if (is_tibble(.x)) nrow(.x) else length(.x)
  )

  res[["pass"]] <- if (sum(res[["stat"]]) == 0) TRUE else FALSE

  return(res)
}



#' generate tibbles
#'
#' @param nrow number of rows
#' @param ncol number of columns
#' @param fill fill by, one of `float, int, char, str`
#' @param colnames names of columns
#' @param seed random seed
#' @param ... parameters of `rnorm, gen_char, gen_str`
#'
#' @return tibble
#' @export
#'
#' @examples
#' gen_tb()
#'
#' gen_tb(fill = "str", nrow = 3, ncol = 4, len = 3)
gen_tb <- function(nrow = 3, ncol = 4, fill = "float",
                   colnames = NULL, seed = NULL, ...) {
  suppressWarnings({
    withr::with_seed(seed, {
      if (fill == "float") {
        df <- matrix(rnorm(nrow * ncol, ...), nrow = nrow) %>% as_tibble()
      } else if (fill == "int") {
        df <- matrix(floor(rnorm(nrow * ncol, ...) * 10), nrow = nrow) %>%
          as_tibble()
      } else if (fill == "char") {
        df <- matrix(gen_char(n = nrow * ncol, random = TRUE, ...),
          nrow = nrow
        ) %>% as_tibble()
      } else if (fill == "str") {
        df <- matrix(gen_str(n = nrow * ncol, seed = seed, ...),
          nrow = nrow
        ) %>% as_tibble()
      }
    })
  })


  return(df)
}



#' differences between two tibbles
#'
#' @param old old tibble
#' @param new new tibble
#'
#' @return comparation tibble
#' @export
#'
#' @examples
#' tb1 <- gen_tb(fill = "int", seed = 1)
#'
#' tb2 <- gen_tb(fill = "int", seed = 3)
#'
#' diff_tb(tb1, tb2)
#'
diff_tb <- function(old, new) {
  p <- waldo::compare(old, new)
  compare_list <- p[[1]] %>%
    str_split("\n") %>%
    unlist() %>%
    # clear format
    str_replace_all("\033\\[\\d+?m", "") %>%
    # clear extra space
    str_replace_all("new|old", "") %>%
    str_replace_all("^([+-]) \\[(\\d+), \\]", "\\1[\\2,]") %>%
    # split
    str_split(" +")

  res <- compare_list[3:length(compare_list)] %>%
    list2tibble(colnames = c("compare", compare_list[[2]][-1]))

  return(res)
}


#' transpose a dataframe
#'
#' @param x dataframe
#' @param colnames column names of the transposed dataframe
#'
#' @return dataframe
#' @export
#'
#' @examples
#'
#' x <- c2r(mini_diamond, "id")
#' tdf(x)
#'
tdf <- function(x, colnames = NULL) {
  res <- as_tibble(
    cbind(item = colnames(x), t(x))
  )

  if (!is.null(colnames)) {
    colnames(res) <- colnames
  }

  return(res)
}



#' count unique values in each column
#'
#' @param x tibble
#'
#' @return tibble
#' @export
#'
#' @examples
#'
#' uniq_in_cols(mini_diamond)
#'
uniq_in_cols <- function(x) {
  res <- map(x, ~ length(unique(.x))) %>%
    as_tibble() %>%
    tdf(colnames = c("col", "uniqe_values"))

  return(res)
}
