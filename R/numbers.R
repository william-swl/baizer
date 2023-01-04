
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
  formatC(x, digits=digits, format='fg', flag='#') %>%
    ifelse(stringr::str_detect(., '\\.$'),
           stringr::str_replace(., '\\.', ''), .)
}

#' if a number only have zeros
#'
#' @param x number
#'
#' @return all zero or not
#' @export
#'
#' @examples is.all_zero('0.00')
is.all_zero <- function(x) {
  if (!is.null(x)){
    x <- as.character(x)
    if (is.na(x)){
      return (NA)
    } else if (!stringr::str_detect(x, '^[\\d\\.]+$')) {
      stop('No a number!')
    } else {
      r <- stringr::str_match_all(x, '\\d') %>% unlist %>%
        as.integer %>% sum == 0
      return (r)
    }
  } else { return (NULL) }
}




#' signif or round strings
#'
#' @param x number
#' @param digits signif or round digits
#' @param format short or long
#'
#' @return signif or round strings
#' @export
#'
#' @examples signif_round_string(0.03851)
signif_round_string <- function(x, digits=2, format='short') {
  if (digits <= 0) {
    stop('Significant or round digits should be larger than 0!')
  }
  x <- as.double(x)
  round_x <- round_string(x, digits)
  signif_x <- signif_string(x, digits)

  if (format=='short') {
    return (ifelse(nchar(round_x) < nchar(signif_x) & (!is.all_zero(round_x)),
                   round_x, signif_x))
  } else if (format=='long') {
    return (ifelse(nchar(round_x) < nchar(signif_x), signif_x, round_x))
  }

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
  if (stringr::str_detect(x, '^[-\\d\\.]+%$')) {
    x <- stringr::str_replace(x, '%', '') %>% as.double
    round_string(x / 100, digits)
  } else {
    stop('Not a percent number character!')
  }
}

