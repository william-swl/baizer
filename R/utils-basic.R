
#' `%nin%`, not in calculation operator
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


#' `%!=na%`, not equal calculation operator, support NA
#'
#' @param x value x
#' @param y value y
#'
#' @return logical value, TRUE if x and y are not equal
#' @export
#'
#' @examples NA %!=% NA
`%!=na%` <- function(x, y) {
  (x != y | (is.na(x) & !is.na(y)) | (is.na(y) & !is.na(x))) & !(is.na(x) & is.na(y))
}



#' dump a named vector into character
#'
#' @param named_vector a named vector
#' @param former_name if TRUE, put names to former
#' @param collapse collapse separator
#'
#' @return character
#' @export
#'
#' @examples vector_dump(c(e=1:4), former_name = TRUE,  collapse=';')
vector_dump <- function(named_vector, former_name=TRUE, collapse=','){
  if (is.null(names(named_vector))) {
    stop('Not a named vector!')
  }
  if (former_name==TRUE) {
    named_vector %>%
      purrr::map2_chr(names(.), ., ~str_glue('{.x}({.y})')) %>%
      str_c(collapse=collapse)
  } else if (former_name==FALSE) {
    named_vector %>%
      purrr::map2_chr(names(.), ., ~str_glue('{.y}({.x})')) %>%
      str_c(collapse=collapse)
  }
}
