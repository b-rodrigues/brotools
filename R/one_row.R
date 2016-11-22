#' Keep only one row per individual
#' @param dataframe A `data.frame` object
#' @param id_var A character object specifying the variable identifying individuals
#' @param min_na
#' @return A `data.frame` object with only one line per individual
#' @export
#' @examples
#' dataframe <- as.data.frame(list("id" = c(rep(1, 3), rep(2, 4)), "x1" = rnorm(7)))
#' new_df <- one_row(dataframe, "id")
one_row <- function(dataframe, id_var, min_na){
  library("dplyr")
  library("purrr")

  stopifnot(is.character(id_var))

  sum_na <- function(x){
    return(sum(is.na(x)))
  }

  # Count number of NAs by row

  dataframe %>% by_row(sum_na, .collate = "cols") -> dataframe

  dataframe %>%
    group_by_(id_var) %>%
    filter(.out == min(.out)) %>%
    select(-.out) -> dataframe

  out <- dataframe[!duplicated(dataframe[id_var]), ]
  return(out)
}
