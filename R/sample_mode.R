#' Returns the mode of a vector
#' @param x A list of values
#' @param na.rm Should NAs be removed? FALSE by default
#' @return Returns the mode of x, either a numeric if x is a list of numerics, or a character if
#' x is a list of characters
#' @export
#' @examples
#' x <- c(3,3,3,4,5,NA, NA, NA, NA, NA)
#' sample_mode(x, na.rm = TRUE)
sample_mode <- function(x, na.rm = FALSE){
  x <- ifelse(na.rm, x[!is.na(x)], x)
  ux <- unique(x)
  index <- which.max(tabulate(match(x, ux)))

  ux[index]
}
