
#' Title
#'
#' @param left
#' @param right
#'
#' @return logical value, if left is not in right
#' @export
#'
#' @examples 0 %nin% 1:4
`%nin%` <- function(left, right) {
  purrr::negate(`%in%`)(left, right)
}
