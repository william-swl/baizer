
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
  purrr::map2_chr(
    x, digits,
    ~ formatC(round(.x, digits = .y), digits = .y, format = "f")
  ) %>%
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
  if (any(digits < 1)) {
    stop("digits must more than 0!")
  }

  x <- as.double(x)

  # for the 0.000000000000 numbers, keep the longest digits
  max_digits <- log10(abs(x)) %>%
    floor() %>%
    abs() %>%
    max()
  max_digits <- max_digits + digits + 1
  pre <- formatC(x, digits = max_digits, format = "f", flag = "#")

  # extract the digits, maybe 1 extra
  p <- paste0("^[-0\\.]*[\\d\\.]{", digits + 1, "}")
  pre2 <- stringr::str_extract(pre, p)

  # the correct digits
  pre2_corr <- stringr::str_sub(pre2, end = nchar(pre2) - 1)
  pre3 <- ifelse(
    # three conditions should remove 1 digits: 1000, 1000., 0.1000
    !stringr::str_detect(pre2, "\\.") |
      stringr::str_detect(pre2, "\\.$") |
      stringr::str_detect(pre2, "^-*0\\."),
    pre2_corr, pre2
  )

  # if there is ., get the digits after .
  fractional_digits <- pre3 %>%
    stringr::str_split("\\.") %>%
    purrr::map_dbl(~ nchar(.x[2]))
  fractional_digits[is.na(fractional_digits)] <- 0


  integer_part <- pre2 %>%
    stringr::str_split("\\.") %>%
    purrr::map_chr(1)
  integer_digits <- integer_part %>%
    stringr::str_replace("^-", "") %>%
    nchar()
  true_for_large_integer_part <- purrr::map2_chr(
    pre, digits,
    ~ signif(as.double(.x), digits = .y) %>% as.character()
  )
  true_for_small_integer_part <- round_string(pre, fractional_digits)


  res <- ifelse(integer_digits >= digits,
    true_for_large_integer_part,
    true_for_small_integer_part
  )

  return(res)
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
#' @param to_double use double output
#'
#' @return float character or double of x
#' @export
#'
#' @examples percent_to_float("12%")
percent_to_float <- function(x, digits = 2, to_double = FALSE) {
  if (any(!stringr::str_detect(x, "^[-\\d\\.]+%$"))) {
    stop("Not a percent number character!")
  }
  x <- stringr::str_replace(x, "%", "") %>% as.double()
  x <- round_string(x / 100, digits)
  if (to_double == TRUE) {
    x <- as.double(x)
  }

  return(x)
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
