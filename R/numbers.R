
#' from float number to fixed digits character
#'
#' @param x number
#' @param digits hold n digits after the decimal point
#'
#' @return character
#' @export
#'
#' @examples round_string(1.1, 2)
round_string <- function(x, digits = 2) {
  x <- as.double(x)
  format(round(x, digits), nsmall = digits)
}


#' from float number to percent number
#'
#' @param x number
#' @param digits hold n digits after the decimal point
#'
#' @return percent value of x
#' @export
#'
#' @examples float_to_percent(0.12)
float_to_percent <- function(x, digits = 2) {
  x <- as.double(x)
  (100 * x) %>%
    round_string(digits) %>%
    stringr::str_c("%")
}
