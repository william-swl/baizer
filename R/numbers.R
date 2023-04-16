#' trans numbers to a fixed integer digit length
#'
#' @param x number
#' @param digits integer digit length
#' @param scale_factor return the scale_factor instead of value
#'
#' @return number
#' @export
#'
#' @examples int_digits(0.0332, 1)
int_digits <- function(x, digits = 2, scale_factor = FALSE) {
  xp10 <- floor(log10(abs(x)))
  sf <- 10^(digits - xp10 - 1)
  if (scale_factor == TRUE) {
    return(sf)
  } else {
    return(x * sf)
  }
}



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
  if (digits < 1) {
    stop("digits must more than 0!")
  }

  x <- as.double(x)

  # trans to 0.xx
  trans <- int_digits(x, digits = 0)
  trans_scale <- int_digits(x, digits = 0, scale_factor = TRUE)

  x <- round(trans, digits) / trans_scale

  round_digits <- log10(trans_scale) + digits
  round_digits <- ifelse(round_digits < 0, 0, round_digits)

  res <- round_string(x, round_digits)
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
      ifelse(!stringr::str_detect(x, "^[-\\d\\.]+$"),
        stop("Not a number!"),
        {
          res <- ifelse(is.na(x), NA,
            stringr::str_detect(x, "^[-0\\.]+$")
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
#' @param full_large keep full digits for large number
#' @param full_small keep full digits for small number
#'
#' @return signif or round strings
#' @export
#'
#' @examples signif_round_string(1.214, 2)
signif_round_string <- function(x, digits = 2, format = "short",
                                full_large = TRUE, full_small = FALSE) {
  if (digits <= 0) {
    stop("significant or round digits should be larger than 0!")
  }
  x <- as.double(x)
  round_x <- round_string(x, digits)
  signif_x <- signif_string(x, digits)

  if (format == "short") {
    res <- ifelse(nchar(round_x) <= nchar(signif_x), round_x, signif_x)
  } else if (format == "long") {
    res <- ifelse(nchar(round_x) >= nchar(signif_x), round_x, signif_x)
  }

  # for large number
  if (full_large == TRUE && format == "short") {
    large_number_fmt <- round_string(x, 0)
    res <- ifelse(abs(x) > 10^digits, large_number_fmt, res)
  }

  # for small number
  if (full_small == TRUE && format == "short") {
    res <- ifelse(abs(x) < 0.1^digits, signif_x, res)
  }

  return(res)
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


#' correct the numbers to a target ratio
#'
#' @param raw the raw numbers
#' @param target the target ratio
#' @param digits the result digits
#'
#' @return corrected number vector
#' @export
#'
#' @examples
#' correct_ratio(c(10, 10), c(3, 5))
#'
#' # support ratio as a float
#' correct_ratio(c(100, 100), c(0.2, 0.8))
#'
#' # more numbers
#' correct_ratio(10:13, c(2, 3, 4, 6))
#'
#' # with digits after decimal point
#' correct_ratio(c(10, 10), c(1, 4), digits = 1)
correct_ratio <- function(raw, target, digits = 0) {
  targets <- (raw / target) %>%
    purrr::map(~ round(target * .x, digits = digits))
  targets_allow <- targets %>% purrr::map_lgl(~ all(raw - .x >= 0))
  if (sum(targets_allow) != 1) {
    print("Multiple results!")
  }
  res <- targets[targets_allow] %>%
    unlist() %>%
    unname()

  return(res)
}
