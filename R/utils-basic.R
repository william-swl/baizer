
#' not in calculation operator
#'
#' @param left left element
#' @param right right element
#'
#' @return logical value, TRUE if left is not in right
#' @export
#'
#' @examples 0 %nin% 1:4
`%nin%` <- function(left, right) {
  purrr::negate(`%in%`)(left, right)
}


#' not equal calculation operator, support NA
#'
#' @param x value x
#' @param y value y
#'
#' @return logical value, TRUE if x and y are not equal
#' @export
#'
#' @examples 1 %neq% NA
`%neq%` <- function(x, y) {
  (x != y | (is.na(x) & !is.na(y)) | (is.na(y) & !is.na(x))) &
    !(is.na(x) & is.na(y))
}



#' dump a named vector into character
#'
#' @param named_vector a named vector
#' @param front_name if TRUE, put names to former
#' @param collapse collapse separator
#'
#' @return character
#' @export
#'
#' @examples collapse_vector(c(e = 1:4), front_name = TRUE, collapse = ";")
collapse_vector <- function(named_vector, front_name = TRUE, collapse = ",") {
  if (is.null(names(named_vector))) {
    stop("Not a named vector!")
  }
  if (front_name == TRUE) {
    named_vector %>%
      purrr::map2_chr(names(.), ., ~ stringr::str_glue("{.x}({.y})")) %>%
      stringr::str_c(collapse = collapse)
  } else if (front_name == FALSE) {
    named_vector %>%
      purrr::map2_chr(names(.), ., ~ stringr::str_glue("{.y}({.x})")) %>%
      stringr::str_c(collapse = collapse)
  }
}


#' the index of different character
#'
#' @param s1 string1
#' @param s2 string2
#' @param nth just return nth index
#' @param ignore_case ignore upper or lower cases
#' @return list of different character indices
#' @export
#'
#' @examples diff_index("AAAA", "ABBA")
diff_index <- function(s1, s2, nth = NULL, ignore_case = FALSE) {
  if (ignore_case == TRUE) {
    s1 <- stringr::str_to_upper(s1)
    s2 <- stringr::str_to_upper(s2)
  }
  if (any(nchar(s1) != nchar(s2))) {
    dif_nchar <- which(nchar(s1) != nchar(s2))
    stop(
      stringr::str_c(
        c("strings have different nchar:", dif_nchar),
        collapse = " "
      )
    )
  }

  idx <- purrr::map2(
    stringr::str_split(s1, ""),
    stringr::str_split(s2, ""), `!=`
  ) %>%
    purrr::map(which)

  if (is.null(nth)) {
    return(idx)
  } else {
    res <- purrr::map(idx, ~ .x[nth], .default = NA)
    return(res)
  }
}


#' the index of identical character
#'
#' @param s1 string1
#' @param s2 string2
#' @param nth just return nth index
#' @param ignore_case ignore upper or lower cases
#' @return list of identical character indices
#' @export
#'
#' @examples same_index("AAAA", "ABBA")
same_index <- function(s1, s2, nth = NULL, ignore_case = FALSE) {
  if (ignore_case == TRUE) {
    s1 <- stringr::str_to_upper(s1)
    s2 <- stringr::str_to_upper(s2)
  }
  if (any(nchar(s1) != nchar(s2))) {
    dif_nchar <- which(nchar(s1) != nchar(s2))
    stop(
      stringr::str_c(c("strings have different nchar:", dif_nchar),
        collapse = " "
      )
    )
  }

  idx <- purrr::map2(
    stringr::str_split(s1, ""),
    stringr::str_split(s2, ""), `==`
  ) %>%
    purrr::map(which)

  if (is.null(nth)) {
    return(idx)
  } else {
    res <- purrr::map(idx, ~ .x[nth], .default = NA)
    return(res)
  }
}


#' fetch character from strings
#'
#' @param s strings
#' @param index_list index of nth character,
#' can be output of `diff_index` or `same_index`
#' @param na.rm remove NA values from results or not
#' @param collapse optional string used to combine
#' the characters from a same string
#'
#' @return list of characters
#' @export
#'
#' @examples fetch_char(rep("ABC", 3), list(1, 2, 3))
fetch_char <- function(s, index_list, na.rm = FALSE, collapse = FALSE) {
  res <- purrr::map2(
    s, index_list,
    ~ {
      stringr::str_sub(.x, .y, .y)
    }
  )

  if (na.rm == TRUE) {
    res <- res %>% purrr::map(~ .x[!is.na(.x)])
  }

  if (collapse != FALSE) {
    res <- res %>% purrr::map(~ stringr::str_c(.x, collapse = collapse))
  }

  return(res)
}


#' trans fixed string into regular expression string
#'
#' @param p raw fixed pattern
#'
#' @return regex pattern
#' @export
#'
#' @examples fix_to_regex("ABC|?(*)")
fix_to_regex <- function(p) {
  special_char <- c("^$|()[]{}?*+.") %>%
    stringr::str_split("") %>%
    unlist()
  replace_dict <- special_char %>% stringr::str_c("\\", .)
  names(replace_dict) <- special_char
  stringr::str_replace_all(p, pattern = stringr::fixed(replace_dict))
}



#' detect possible duplication in a vector, ignore case,
#' blank and special character
#'
#' @param vector vector possibly with duplication
#' @param index return duplication index
#'
#' @return duplication sub-vector
#' @export
#'
#' @examples detect_dup(c("a", "C_", "c -", "#A"))
detect_dup <- function(vector, index = FALSE) {
  modified_vector <- vector %>%
    stringr::str_to_lower() %>%
    stringr::str_extract_all("[\\w]+") %>%
    purrr::map_chr(~ stringr::str_c(.x, collapse = "")) %>%
    stringr::str_replace_all("_", "")
  dup_index <- duplicated(modified_vector) |
    duplicated(modified_vector, fromLast = TRUE)
  dup_order <- order(modified_vector[dup_index])
  res <- vector[dup_index][dup_order]

  if (index == TRUE) {
    return(dup_index)
  } else {
    return(res)
  }
}


#' extract key and values for a character vector
#'
#' @param v character vector
#' @param sep separator between key and value
#' @param key_loc key location
#' @param value_loc value location
#'
#' @return a named character vector
#' @export
#'
#' @examples extract_kv(c("x: 1", "y: 2"))
extract_kv <- function(v, sep = ": ", key_loc = 1, value_loc = 2) {
  df <- v %>%
    stringr::str_split(sep) %>%
    data.frame()
  key <- unname(unlist(df[key_loc, ]))
  value <- unname(unlist(df[value_loc, ]) %>% as.character())
  names(value) <- key

  return(value)
}


#' farthest point sampling (FPS) for a vector
#'
#' @param v vector
#' @param n sample size
#' @param method `round|floor|ceiling`, the method used when trans to integer
#'
#' @return sampled vector
#' @export
#'
#' @examples fps_vector(1:10, 4)
fps_vector <- function(v, n, method = "round") {
  len <- length(v)
  stopifnot(n <= len)
  idx <- seq(1, len, length.out = n)
  if (method == "round") {
    idx <- round(idx)
  } else if (method == "floor") {
    idx <- floor(idx)
  } else if (method == "ceiling") {
    idx <- ceiling(idx)
  }

  return(v[idx])
}
