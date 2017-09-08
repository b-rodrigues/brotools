#' Inverts a surname name to name surname (or vice versa)
#' @param name The name to invert
#' @param to_title Should the result be converted to title? (John Doe instead of john doe)
#' @return A string with the surname and name inverted
#' @export
#' @examples
#' name <- "RODRIGUES BRUNO"
#' invert_name(name)
#' invert_name(name, to_title = T)
invert_name <- function(name, to_title = F){
	split_name <- stringr::tr_split(name, " ", simplify = TRUE)
	inverted_name <- paste(split_name[2], split_name[1], sep = " ")
	if (to_title) {
		return(stringr::str_to_title(inverted_name))
	} else {
		return(inverted_name)
	}
}