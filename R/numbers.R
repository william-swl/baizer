
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
  formatC(x, digits = digits, format = "f") %>%
    stringr::str_trim()
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
    stop("Significant digits should be larger than 0!")
  }
  x <- as.double(x)
  formatC(x, digits = digits, format = "fg", flag = "#") %>%
    stringr::str_trim() %>%
    ifelse(stringr::str_detect(., "\\.$"),
      stringr::str_replace(., "\\.", ""), .
    )
}

#' if a number only have zeros
#'
#' @param x number
#'
#' @return all zero or not
#' @export
#'
#' @examples is.zero(c("0.000", "0.102", NA))
is.zero <- function(x) {
  ifelse(
    is.null(x),
    return(x),
    {
      x <- as.character(x)
      ifelse(!stringr::str_detect(x, "^[\\d\\.]+$"),
        stop("No a number!"),
        {
          res <- ifelse(is.na(x), NA,
            stringr::str_detect(x, "^[0\\.]+$")
          )
          return(res)
        }
      )
    }
  )
}





#' signif or round string depend on the character length
#'
#' @param x number
#' @param digits signif or round digits
#' @param format short or long
#'
#' @return signif or round strings
#' @export
#'
#' @examples signif_round_string(0.03851)
signif_round_string <- function(x, digits = 2, format = "short") {
  if (digits <= 0) {
    stop("Significant or round digits should be larger than 0!")
  }
  x <- as.double(x)
  round_x <- round_string(x, digits)
  signif_x <- signif_string(x, digits)

  if (format == "short") {
    return(ifelse(nchar(round_x) < nchar(signif_x) & (!is.zero(round_x)),
      round_x, signif_x
    ))
  } else if (format == "long") {
    return(ifelse(nchar(round_x) < nchar(signif_x), signif_x, round_x))
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
#' @examples percent_to_float("12%")
percent_to_float <- function(x, digits = 2) {
  if (stringr::str_detect(x, "^[-\\d\\.]+%$")) {
    x <- stringr::str_replace(x, "%", "") %>% as.double()
    round_string(x / 100, digits)
  } else {
    stop("Not a percent number character!")
  }
}



#' wrapper of the functions to process number string with prefix and suffix
#'
#' @param x number string vector with prefix and suffix
#' @param fun process function
#' @param prefix_ext prefix extension
#' @param suffix_ext suffix extension
#' @param verbose print more details
#'
#' @return processed number with prefix and suffix
#' @export
#'
#' @examples number_fun_wrapper(">=2.134%", function(x) round(x, 2))
number_fun_wrapper <- function(x, fun = ~.x, prefix_ext = NULL,
                               suffix_ext = NULL, verbose = FALSE) {
  prefix <- c(
    c(">=", "<=", "!=", "~=", "=", ">", "<", "~"),
    fix_to_regex(prefix_ext)
  )
  suffix <- c(c("%%", "%"), fix_to_regex(suffix_ext))

  pattern <- stringr::str_c(
    "(^", stringr::str_c(prefix, collapse = "|"), "{0,1})",
    "([\\d\\.]+)",
    "(", stringr::str_c(suffix, collapse = "|"), "{0,1}$)"
  )

  match <- stringr::str_match(x, pattern)

  if (verbose == TRUE) {
    print(match)
  }

  modify_number <- as.double(match[, 3]) %>%
    purrr::map_chr(~ fun(.x) %>% as.character())

  res <- stringr::str_c(match[, 2], modify_number, match[, 4])

  return(res)
}


#' expand a number vector according to the adjacent two numbers
#'
#' @param v number vector
#' @param n_div how many divisions expanded by two numbers
#' @param .unique only keep unique numbers
#'
#' @return new number vector
#' @export
#'
#' @examples adjacent_div(10^c(1:3), n_div = 10)
adjacent_div <- function(v, n_div = 10, .unique = FALSE) {
  res <- purrr::map2(
    v[1:(length(v) - 1)], v[2:length(v)],
    ~ seq(.x, .y, length.out = n_div)
  ) %>% unlist()

  if (.unique == TRUE) {
    res <- unique(res)
  }

  return(res)
}
