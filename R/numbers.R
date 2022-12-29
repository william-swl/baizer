
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
  formatC(x, digits=digits, format='f')
}

#' from float number to fixed significant digits character
#'
#' @param x number
#' @param digits hold n significant digits
#'
#' @return character
#' @export
#'
#' @examples signif_string(1.1, 2)
signif_string <- function(x, digits = 2) {
  if (digits <= 0) {
    stop('Significant digits should be larger than 0!')
  }
  x <- as.double(x)
  formatC(x, digits=digits, format='g', flag='#') %>%
    ifelse(stringr::str_detect(., '\\.$'),
           stringr::str_replace(., '\\.', ''), .)
}


#' from float number to percent number
#'
#' @param x number
#' @param digits hold n digits after the decimal point
#'
#' @return percent character of x
#' @export
#'
#' @examples float_to_percent(0.12)
float_to_percent <- function(x, digits = 2) {
  x <- as.double(x)
  (100 * x) %>%
    round_string(digits) %>%
    stringr::str_c("%")
}

#' from percent number to float number
#'
#' @param x percent number character
#' @param digits hold n digits after the decimal point
#'
#' @return float character of x
#' @export
#'
#' @examples percent_to_float('12%')
percent_to_float <- function(x, digits = 2) {
  if (str_detect(x, '^[-\\d\\.]+%$')) {
    x <- stringr::str_replace(x, '%', '') %>% as.double
    round_string(x / 100, digits)
  } else {
    stop('Not a percent number character!')
  }
}

