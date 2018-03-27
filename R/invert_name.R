#' Inverts a surname name to name surname (or vice versa)
#' @param name The name to invert.
#' @param sep The separator of the name.
#' @param position Integer separating the given name from the last name.
#' @param to_title Should the result be converted to title? (John Doe instead of john doe)
#' @param out_sep The separator for the output.
#' @return A string with the surname and name inverted
#' @export
#' @examples
#' name <- "RODRIGUES BRUNO"
#' invert_name(name)
#' invert_name(name, to_title = TRUE)
#' invert_name("Bruno.Rodrigues", sep = "\\.")
#' invert_name("Bruno.Rodrigues", sep = "\\.", out_sep = " ")
#' invert_name("John Middlename Doe", sep = " ", position = 2)
invert_name <- function(name, sep = " ", position = 1,  to_title = FALSE, out_sep = " "){
  split_name <- stringr::str_split(name, sep, simplify = TRUE)

  name_1 <- paste(split_name[1:position], collapse = out_sep)
  name_2 <- paste(split_name[(position+1):length(split_name)], collapse = out_sep)

  inverted_name <- paste(name_2, name_1, collapse = out_sep)
  if (to_title) {
    stringr::str_to_title(inverted_name)
  } else {
    inverted_name
  }
}
