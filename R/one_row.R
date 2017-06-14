#' Keep only one row per individual. Only keep the row with the least amount of NA in every column
#' @param dataframe A `data.frame` object
#' @param list_var An atomic vector of characters giving the variable combinations to keep
#' @return A `data.frame` object with only one line per individual
#' @export
#' @examples
#' dataframe <- as.data.frame(list("id" = c(rep(1, 3), rep(2, 4)), "x1" = rnorm(7)))
#' new_df <- one_row(dataframe, "id")
one_row <- function(dataframe, list_var){

  stopifnot(is.character(list_var))

  sum_na <- function(x){
    return(sum(is.na(x)))
  }

  # Count number of NAs by row

  dataframe %>% purrrlyr::by_row(sum_na, .collate = "cols") -> dataframe

  dataframe %>%
    dplyr::group_by_(list_var) %>%
    dplyr::filter(.out == min(.out)) %>%
    dplyr::select(-.out) -> dataframe

  out <- dataframe[!duplicated(dataframe[list_var]), ]
  return(out)
}
