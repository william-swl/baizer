
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


#' the index of nth different character
#'
#' @param s1 string1
#' @param s2 string2
#' @param nth return the index of nth different character.
#' if `0` return all the indices
#'
#' @return the index of differences
#' @export
#'
#' @examples diff_index("ATTC", "ATAC")
diff_index <- function(s1, s2, nth = 0) {
  if (length(s1) != 1 || length(s2) != 1) {
    stop("Need 1 length character!")
  }
  if (nchar(s1) != nchar(s2)) {
    stop("Need strings of same nchar")
  }
  diff_index <- which(
    unlist(stringr::str_split(s1, "")) != unlist(stringr::str_split(s2, ""))
  )
  if (nth == 0) {
    return(diff_index)
  } else if (nth > 0) {
    return(diff_index[nth])
  }
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
