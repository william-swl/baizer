
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




#' whether the expression is an atomic one
#'
#' @param ex expression
#'
#' @return logical value
#' @export
#'
#' @examples
#' atomic_expr(rlang::expr(x))
#'
#' atomic_expr(rlang::expr(!x))
#'
#' atomic_expr(rlang::expr(x + y))
#'
#' atomic_expr(rlang::expr(x > 1))
#'
#' atomic_expr(rlang::expr(!x + y))
#'
#' atomic_expr(rlang::expr(x > 1 | y < 2))
#'
atomic_expr <- function(ex) {
  if (!is_expression(ex)) {
    stop("not an expression object!")
  }

  if (length(ex) > 1) {
    if (purrr::map_lgl(as.list(ex), ~ length(.x) == 1) %>% all() == TRUE) {
      return(TRUE)
    } else {
      return(FALSE)
    }
  } else if (length(ex) == 1) {
    return(TRUE)
  } else {
    stop("error!")
  }
}



#' pileup the subexpressions which is atomic
#'
#' @param ex expression
#'
#' @return the character vector of subexpressions
#' @export
#'
#' @examples
#' ex <- rlang::expr(a == 2 & b == 3 | !b & x + 2)
#' expr_pileup(ex)
#'
expr_pileup <- function(ex) {
  if (!is_expression(ex)) {
    stop("not an expression object!")
  }

  if (atomic_expr(ex)) {
    return(deparse(ex))
  }

  res <- c()
  for (i in as.list(ex)) {
    if (atomic_expr(i)) {
      res <- c(res, deparse(i))
    } else {
      res <- c(res, expr_pileup(i))
    }
  }

  return(res)
}


#' regex match
#'
#' @param x vector
#' @param pattern regex pattern
#' @param group regex gruop, 1 as default. when group=-1,
#' return full matched tibble
#'
#' @return vector or tibble
#' @export
#'
#' @examples
#' v <- stringr::str_c("id", 1:3, c("A", "B", "C"))
#'
#' reg_match(v, "id(\\d+)(\\w)")
#'
#' reg_match(v, "id(\\d+)(\\w)", group = 2)
#'
#' reg_match(v, "id(\\d+)(\\w)", group = -1)
#'
reg_match <- function(x, pattern, group = 1) {
  res <- suppressMessages(
    stringr::str_match(x, pattern) %>%
      tibble::as_tibble(.name_repair = "unique")
  )
  res <- res %>% rlang::set_names(c(
    "match",
    stringr::str_c("group", seq_along(colnames(res))[-ncol(res)])
  ))
  if (group == -1) {
    return(res)
  } else if (ncol(res) == 1) {
    return(dplyr::pull(res, 1))
  } else {
    return(dplyr::pull(res, group + 1))
  }
}



#' split vector into list
#'
#' @param vector vector
#' @param breaks split breaks
#' @param bounds "(]" as default, can also be "[), []"
#'
#' @return list
#' @export
#'
#' @examples
#' split_vector(1:10, c(3, 7))
#' split_vector(stringr::str_split("ABCDEFGHIJ", "") %>% unlist(),
#'   c(3, 7),
#'   bounds = "[)"
#' )
split_vector <- function(vector, breaks, bounds = "(]") {
  margins <- c(1, breaks, length(vector))

  split_index <- purrr::map2(
    margins[seq_along(margins)[-length(margins)]],
    margins[seq_along(margins)[-1]],
    ~ .x:.y
  )

  if (bounds == "(]") {
    process_index <- seq_along(split_index)[-1]
    split_index[process_index] <- split_index[process_index] %>%
      purrr::map(~ .x[-1])
  } else if (bounds == "[)") {
    process_index <- seq_along(split_index)[-length(split_index)]
    split_index[process_index] <- split_index[process_index] %>%
      purrr::map(~ .x[-length(.x)])
  }

  purrr::map(split_index, ~ vector[.x])
}

#' group chracter vector by a regex pattern
#'
#' @param x character vector
#' @param pattern regex pattern, '\\w' as default
#'
#' @return list
#' @export
#'
#' @examples
#' v <- c(
#'   stringr::str_c("A", c(1, 2, 9, 10, 11, 12, 99, 101, 102)),
#'   stringr::str_c("B", c(1, 2, 9, 10, 21, 32, 99, 101, 102))
#' ) %>% sample()
#'
#' group_vector(v)
#'
#' group_vector(v, pattern = "\\w\\d")
#'
#' group_vector(v, pattern = "\\w(\\d)")
#'
#' # unmatched part will alse be stored
#' group_vector(v, pattern = "\\d{2}")
#'
group_vector <- function(x, pattern = "\\w") {
  if (!is.character(x)) {
    stop("x must be a character vector")
  }

  # matched part and unmatched part
  reg_result <- x %>% reg_match(pattern)
  match <- reg_result[!is.na(reg_result)]
  x_match <- x[!is.na(reg_result)] # nolint
  unmatch <- reg_result[is.na(reg_result)]
  x_unmatch <- x[is.na(reg_result)]

  group <- match %>%
    unique() %>%
    sort()
  res <- group %>% purrr::map(~ x_match[match == .x])
  names(res) <- group

  if (length(unmatch) > 0) {
    res <- c(res, list(unmatch = x_unmatch))
  }

  return(res)
}


#' sort by a function
#'
#' @param x vector
#' @param func a function used by the sort
#' @param group_pattern a regex pattern to group by, only aviable if x is a
#' character vector
#'
#' @return vector
#' @export
#'
#' @examples
#' sortf(c(-2, 1, 3), abs)
#'
#' v <- stringr::str_c("id", c(1, 2, 9, 10, 11, 12, 99, 101, 102)) %>% sample()
#'
#' sortf(v, function(x) reg_match(x, "\\d+") %>% as.double())
#'
#' sortf(v, ~ reg_match(.x, "\\d+") %>% as.double())
#'
#' v <- c(
#'   stringr::str_c("A", c(1, 2, 9, 10, 11, 12, 99, 101, 102)),
#'   stringr::str_c("B", c(1, 2, 9, 10, 21, 32, 99, 101, 102))
#' ) %>% sample()
#'
#' sortf(v, ~ reg_match(.x, "\\d+") %>% as.double(), group_pattern = "\\w")
#'
sortf <- function(x, func, group_pattern = NULL) {
  if (!is.null(group_pattern) && is.character(x)) {
    x <- group_vector(x, group_pattern)
    sort_ord <- x %>%
      purrr::map(func) %>%
      purrr::map(order)
    res <- purrr::map2(x, sort_ord, ~ .x[.y]) %>%
      unlist() %>%
      unname()
  } else {
    sort_ord <- x %>%
      purrr::map(func) %>%
      unlist() %>%
      order()
    res <- x[sort_ord]
  }


  return(res)
}
