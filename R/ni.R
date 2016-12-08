#' «Not in» operator. Taken from a stackoverflow answer by user `baptiste`
#' @param x An object
#' @param y A list of objects
#' @return True or False
#' @export
#' @examples
#' 3 %ni% seq(5, 10)
`%ni%` <- Negate(`%in%`)
