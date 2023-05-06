#' use aliases for function arguments
#'
#' @param ... aliases of an argument
#' @param with_default a alias with a default value
#'
#' @return the finally value of this argument across all aliases
#' @export
#'
#' @examples
#'
#' # set y, z as aliases of x when create a function
#' func <- function(x = 1, y = NULL, z = NULL) {
#'   x <- alias_arg(x, y, with_default = x)
#'   return(x)
#' }
alias_arg <- function(..., with_default = NULL) {
  with_default <- enquo(with_default)
  aliases <- enexprs(...)
  aliases_char <- as.character(aliases)
  values <- list(...)
  names(values) <- aliases_char

  if (length(quo_name(with_default)) > 1) {
    stop("should only have one default value!")
  }

  value_idx <- which(
    purrr::map_lgl(values, ~ !is.null(.x)) &
      (quo_name(with_default) != aliases_char)
  )

  if (length(value_idx) > 1) {
    stop(
      "please assign only one of ",
      stringr::str_c(aliases_char, collapse = ",")
    )
  } else if (length(value_idx) == 1) {
    return(values[[value_idx]])
  } else if (length(value_idx) == 0) {
    return(values[[quo_name(with_default)]])
  }
}