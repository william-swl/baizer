
#' `%nin%`, a logical operator for not in calculation
#'
#' @param left left element
#' @param right right element
#'
#' @return logical value, if left is not in right
#' @export
#'
#' @examples 0 %nin% 1:4
`%nin%` <- function(left, right) {
  purrr::negate(`%in%`)(left, right)
}
