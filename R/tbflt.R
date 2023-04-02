
#' create a tbflt object to save filter conditions
#'
#' `tbflt()` can save a series of filter conditions, and support
#' logical operating among conditions
#'
#' @param x any expression
#' @param .env environment
#'
#' @return tbflt
#' @export
#'
#' @examples
#' c1 <- tbflt(cut == "Fair")
#'
#' c2 <- tbflt(x > 8)
#'
#' !c1
#'
#' c1 | c2
#'
#' c1 & c2
#'
tbflt <- function(x = expression(), .env = NULL) {
  x <- enquo(x)
  if (!is.null(.env)) {
    x <- quo_set_env(x, .env)
  }
  structure(x, class = c("tbflt", "quosure", "formula"))
}



#' @export
`&.tbflt` <- function(e1, e2) {
  env1 <- quo_get_env(e1)
  env2 <- quo_get_env(e2)
  e1 <- quo_get_expr(e1)
  e2 <- quo_get_expr(e2)

  res_env <- env_clone(env1)
  env_coalesce(res_env, env2)

  tbflt(!!e1 & !!e2, .env = res_env)
}

#' @export
`|.tbflt` <- function(e1, e2) {
  env1 <- quo_get_env(e1)
  env2 <- quo_get_env(e2)
  e1 <- quo_get_expr(e1)
  e2 <- quo_get_expr(e2)

  res_env <- env_clone(env1)
  env_coalesce(res_env, env2)

  tbflt(!!e1 | !!e2, .env = res_env)
}

#' @export
`!.tbflt` <- function(x) {
  env <- quo_get_env(x)
  x <- quo_get_expr(x)
  tbflt(!(!!x), .env = env)
}



#' apply tbflt on dplyr filter
#'
#' @param .data tibble
#' @param tbflt tbflt object
#' @param .by group by, same as `.by` argument in `dplyr::filter`
#' @param usecol if `TRUE` (default), use the default behavior of
#' `dplyr::filter()`, which allows the usage of same variable in
#' colnames, and filter by the data column. If `FALSE`, will check
#' whether the variables on the right side of `==,>,<,>=,<=` have
#' same names as columns and raise error, for the sake of
#' more predictable results. You can always ignore this argument if
#' you know how to use `.env` or `!!`
#'
#' @return tibble
#' @export
#'
#' @examples
#' c1 <- tbflt(cut == "Fair")
#'
#' c2 <- tbflt(x > 8)
#'
#' mini_diamond %>%
#'   filterC(c1) %>%
#'   head(5)
#'
#' mini_diamond %>% filterC(c1 & c2)
#'
#'
#'
#' x <- 8
#' cond <- tbflt(y > x)
#'
#' # variable `x` not used because of column `x` in `mini_diamond`
#' filterC(mini_diamond, cond)
#'
#' # will raise error because `x`  is on the right side of `>`
#' # filterC(mini_diamond, cond, usecol=FALSE)
#'
#' # if you know how to use `.env` or `!!`, forget argument `usecol`!
#' cond <- tbflt(y > !!x)
#' filterC(mini_diamond, cond)
#'
#' cond <- tbflt(y > .env$x)
#' filterC(mini_diamond, cond)
#'
filterC <- function(.data, tbflt = NULL, .by = NULL, usecol = TRUE) { # nolint
  if (!is.null(tbflt)) {
    # extract the right part of each subexpression
    right_in_expr <- expr_pileup(quo_get_expr(tbflt)) %>%
      stringr::str_split("==|>|<|>=|<=") %>%
      purrr::map_chr(
        ~ ifelse(length(.x) == 2, stringr::str_trim(.x[2]), NA)
      )
    samecol <- intersect(right_in_expr, colnames(.data))

    if (length(samecol) > 0 && usecol == FALSE) {
      stop(stringr::str_glue("same columns in tbflt expression: {samecol}"))
    }

    dplyr::filter(.data, eval(tbflt), .by = .by)
  } else {
    .data
  }
}
