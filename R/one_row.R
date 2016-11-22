#' Keep only one row per individual
#' @param dataframe A `data.frame` object
#' @param id_var A character object specifying the variable identifying individuals
#' @return A `data.frame` object with only one line per individual
#' @export
#' @examples
#' dataframe <- as.data.frame(list("id" = c(rep(1, 3), rep(2, 4)), "x1" = rnorm(7)))
#' new_df <- one_row(dataframe, "id")
one_row <- function(dataframe, id_var){
  stopifnot(is.character(id_var))
  out <- dataframe[!duplicated(dataframe[id_var]), ]
  return(out)
}
