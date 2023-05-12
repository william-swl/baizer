#' add #' into each line of codes for roxygen examples
#'
#' @param x codes
#'
#' @return NULL
#' @export
#'
#' @examples
#'
#' roxygen_fmt(
#'   "
#' code line1
#' code line2
#' "
#' )
#'
roxygen_fmt <- function(x) {
  res <- str_split(x, "\\n")[[1]] %>%
    str_c(collapse = "\n#' ")
  cat(res)
}


#' use aliases for function arguments
#'
#' @param ... aliases of an argument
#' @param default a alias with a default value
#'
#' @return the finally value of this argument across all aliases
#' @export
#'
#' @examples
#'
#' # set y, z as aliases of x when create a function
#' func <- function(x = 1, y = NULL, z = NULL) {
#'   x <- alias_arg(x, y, z, default = x)
#'   return(x)
#' }
alias_arg <- function(..., default = NULL) {
  default <- enquo(default)
  aliases <- enexprs(...)
  aliases_char <- as.character(aliases)
  values <- list(...)
  names(values) <- aliases_char

  if (length(quo_name(default)) > 1) {
    stop("should only have one default value!")
  }

  value_idx <- which(
    purrr::map_lgl(values, ~ !is.null(.x)) &
      (quo_name(default) != aliases_char)
  )

  if (length(value_idx) > 1) {
    stop(
      "please assign only one of ",
      stringr::str_c(aliases_char, collapse = ",")
    )
  } else if (length(value_idx) == 1) {
    return(values[[value_idx]])
  } else if (length(value_idx) == 0) {
    return(values[[quo_name(default)]])
  }
}



#' check arguments by custom function
#'
#' @param ... arguments
#' @param n how many arguments should meet the custom conditions
#' @param fun custom conditions defined by a function
#'
#' @return logical value
#' @export
#'
#' @examples
#' x <- 1
#' y <- 3
#' z <- NULL
#'
#' func <- function(x = NULL, y = NULL, z = NULL) {
#'   if (check_arg(x, y, z, n = 2)) {
#'     print("As expected, two arguments is not NULL")
#'   }
#'
#'   if (check_arg(x, y, z, n = 1, method = ~ .x < 2)) {
#'     print("As expected, one argument less than 2")
#'   }
#' }
#'
check_arg <- function(..., n = 2, fun = not.null) {
  res <- map_lgl(c(...), fun) %>% sum()
  res == n
}
