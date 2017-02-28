#' Is x around y?
#' @param x The value to test
#' @param y Value of interest
#' @param eps The threshold
#' @return TRUE if x is in the interval (y - eps, y + eps)
#' @export
#' @examples
#' around(2, 3, 0.5)
#' around(2, 3, 1)
around <- function(x, y, eps){
	ifelse(x > y - eps,
	ifelse(x < y + eps,
		   TRUE,
		   FALSE),
	FALSE)
}
