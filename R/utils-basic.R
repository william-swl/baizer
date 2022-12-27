
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
