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
  res <- purrr::map2_chr(x, digits, ~ formatC(round(.x, digits = .y),
    digits = .y, format = "f"
  )) %>% stringr::str_trim()

  res <- ifelse(res == "NA", NA_character_, res)
  return(res)
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
  round_digits <- ifelse(round_digits < 0 | is.na(round_digits),
    0, round_digits
  )

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

#' signif while use floor
#'
#' @param x number
#' @param digits digits
#'
#' @return number
#' @export
#'
#' @examples signif_floor(3.19, 2)
signif_floor <- function(x, digits = 2) {
  if (any(digits < 1)) {
    stop("digits must more than 1!")
  }

  x <- as.double(x)
  trans_x <- int_digits(x, digits = digits)
  scale_factor <- int_digits(x, digits = digits, scale_factor = TRUE)

  res <- floor(trans_x) / scale_factor
  return(res)
}


#' signif while use ceiling
#'
#' @param x number
#' @param digits digits
#'
#' @return number
#' @export
#'
#' @examples signif_ceiling(3.11, 2)
signif_ceiling <- function(x, digits = 2) {
  if (any(digits < 1)) {
    stop("digits must more than 1!")
  }

  x <- as.double(x)
  trans_x <- int_digits(x, digits = digits)
  scale_factor <- int_digits(x, digits = digits, scale_factor = TRUE)

  res <- ceiling(trans_x) / scale_factor
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




#' the ticks near a number
#'
#' @param x number
#' @param level the level of ticks, such as 1, 10, 100, etc.
#' @param div number of divisions
#'
#' @return number vector of ticks
#' @export
#'
#' @examples near_ticks(3462, level = 10)
near_ticks <- function(x, level = NULL, div = 2) {
  if (length(x) > 1) {
    stop("the length of x must be 1!")
  }

  x <- as.double(x)

  if (is.null(level)) {
    level <- 10^ceiling(log10(x))
  }
  ticks <- seq(0, 10^ceiling(log10(level)), length.out = div + 1)
  scale_factor <- ticks[length(ticks)]
  base_number <- floor(x / scale_factor) * scale_factor
  res <- ticks + base_number

  return(res)
}



#' the nearest ticks around a number
#'
#' @param x number
#' @param side default as 'both', can be 'both|left|right'
#' @param level the level of ticks, such as 1, 10, 100, etc.
#' @param div number of divisions
#'
#' @return nearest tick number
#' @export
#'
#' @examples nearest_tick(3462, level = 10)
nearest_tick <- function(x, side = "both", level = NULL, div = 2) {
  x <- as.double(x)
  ticks <- near_ticks(x, level = level, div = div)
  dist <- ticks - x

  if (side == "both") {
    tick <- ticks[abs(dist) == min(abs(dist))]
  } else if (side == "left") {
    l1 <- dist <= 0
    left_dist <- dist[l1]
    l2 <- abs(left_dist) == min(abs(left_dist))
    tick <- ticks[pileup_logical(l1, l2)]
  } else if (side == "right") {
    l1 <- dist >= 0
    right_dist <- dist[l1]
    l2 <- abs(right_dist) == min(abs(right_dist))
    tick <- ticks[pileup_logical(l1, l2)]
  }

  return(tick)
}




#' generate ticks for a number vector
#'
#' @param x number vector
#' @param expect_ticks expected number of ticks, may be a little different from
#' the result
#'
#' @return ticks number
#' @export
#'
#' @examples generate_ticks(c(176, 198, 264))
generate_ticks <- function(x, expect_ticks = 10) {
  level <- 10^ceiling(log10(max(x) - min(x)))
  left <- nearest_tick(min(x), level = level, side = "left", div = 20)
  right <- nearest_tick(max(x), level = level, side = "right", div = 20)
  step <- nearest_tick((right - left) / expect_ticks, side = "right")

  res <- seq(left, right, by = step)
  return(res)
}



#' split a positive integer number as a number vector
#'
#' @param x positive integer
#' @param n length of the output
#' @param method should be one of `average, random`, or a number vector which
#' length is n
#' @return number vector
#' @export
#'
#' @examples
#' pos_int_split(12, 3, method = "average")
#'
#' pos_int_split(12, 3, method = "random")
#'
#' pos_int_split(12, 3, method = c(1, 2, 3))
#'
pos_int_split <- function(x, n, method = "average") {
  x <- as.integer(x)
  if (x <= 0) {
    stop("x should be a positive integer!")
  }

  if (is.numeric(method) == TRUE && length(method) == n) {
    res <- round(x * method / sum(method))
  } else if (method == "average") {
    res <- rep(floor(x / n), n)
    res[seq_len(x %% n)] <- res[seq_len(x %% n)] + 1
  } else if (method == "random") {
    while (TRUE) {
      res <- sample(1:x, n, replace = TRUE)
      if (sum(res) == x) break
    }
  } else {
    stop("please input a valid method!")
  }
  return(res)
}


#' generate outliers from a series of number
#'
#' @param x number vector
#' @param n number of outliers to generate
#' @param digits the digits of outliers
#' @param side should be one of `both, low, high`
#' @param lim a two-length vector to assign the limitations of the outliers
#' if method is `both`, the outliers will be limited in
#' \[lim\[1\], low_outlier_threshold] and \[high_outlier_threshold, lim\[2\]\]
#' ;
#' if method is `low`, the outliers will be limited in
#' \[lim\[1\], min(low_outlier_threshold, lim\[2\])]
#' ;
#' if method is `high`, the outliers will be limited in
#' \[max(high_outlier_threshold, lim\[1\]), lim\[2\]]
#' @param assign_n manually assign the number of low outliers or
#' high outliers when method is `both`
#' @param only_out only return outliers
#'
#' @return number vector of outliers
#' @export
#'
#' @examples
#' x <- seq(0, 100, 1)
#'
#' gen_outlier(x, 10)
#'
#' # generation limits
#' gen_outlier(x, 10, lim = c(-80, 160))
#'
#' # assign the low and high outliers
#' gen_outlier(x, 10, lim = c(-80, 160), assign_n = c(0.1, 0.9))
#'
#' # just generate low outliers
#' gen_outlier(x, 10, side = "low")
#'
#' # return with raw vector
#' gen_outlier(x, 10, only_out = FALSE)
#'
gen_outlier <- function(x, n, digits = 0, side = "both",
                        lim = NULL, assign_n = NULL, only_out = TRUE) {
  x <- as.double(x)
  iqr <- IQR(x)
  high_threshold <- boxplot.stats(x)$stats[4] + 1.5 * iqr
  low_threshold <- boxplot.stats(x)$stats[2] - 1.5 * iqr
  if (is.null(lim)) {
    lim <- c(low_threshold - 3 * iqr, high_threshold + 3 * iqr)
  } else if (length(lim) != 2) {
    stop("the length of lim should be 2!")
  }


  if (side == "both") {
    if (!is.null(assign_n) && length(assign_n) == 2) {
      nvec <- pos_int_split(n, 2, method = assign_n)
    } else {
      nvec <- pos_int_split(n, 2, method = "average")
    }

    if (lim[1] > low_threshold) {
      stop(str_c("lim[1] should smaller than ", round(low_threshold, digits)))
    }
    if (lim[2] < high_threshold) {
      stop(str_c("lim[2] should larger than ", round(high_threshold, digits)))
    }

    res <- c(
      runif(nvec[1], min = lim[1], max = low_threshold),
      runif(nvec[2], min = high_threshold, max = lim[2])
    )
  } else if (side == "low") {
    res <- runif(n, min = lim[1], max = min(low_threshold, lim[2]))
  } else if (side == "high") {
    res <- runif(n, min = max(high_threshold, lim[1]), max = lim[2])
  }

  res <- round(res, digits)

  if (only_out == FALSE) {
    res <- c(res, x)
  }

  return(res)
}
