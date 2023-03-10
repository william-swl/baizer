
#' create a tbflt object to save filter conditions
#'
#' `tbflt()` can save a series of filter conditions, and support
#' logical operating among conditions
#'
#' @param x any expression
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
tbflt <- function(x = expression()) {
  x <- enexpr(x)
  structure(x, class = "tbflt")
}

#' @export
print.tbflt <- function(x, ...) {
  print(unclass(x), ...)
}

#' @export
`&.tbflt` <- function(e1, e2) {
  e1 <- unclass(e1)
  e2 <- unclass(e2)
  expr(!!e1 & !!e2)
}

#' @export
`|.tbflt` <- function(e1, e2) {
  e1 <- unclass(e1)
  e2 <- unclass(e2)
  expr(!!e1 | !!e2)
}

#' @export
`!.tbflt` <- function(x) {
  x <- unclass(x)
  call("!", x)
}



#' apply tbflt on dplyr filter
#'
#' @param .data tibble
#' @param tbflt tbflt object
#' @param .by group by, same as `.by` argument in `dplyr::filter`
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
filterC <- function(.data, tbflt = NULL, .by = NULL) { # nolint
  if (!is.null(tbflt)) {
    dplyr::filter(.data, eval(tbflt), .by = .by)
  } else {
    .data
  }
}
