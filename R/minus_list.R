#' Substracts elements from lists of elements
#' @param list An atomic vector of elements
#' @param string An element (or an atomic vector of elements) to remove from list
#' @return An atomic vector of elements
#' @export
#' @examples
#' fruits <- c("Apple", "Pineapple", "Lettuce", "Kiwi", "Artichoke")
#' fruits %-l% c("Lettuce", "Artichoke")
`%-l%` <- function(list, string){
	list[-which(list %in% string)]
}