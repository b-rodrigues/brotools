#' Filter a list of conditions
#' @param dataset A `data.frame` object
#' @param variable The variable to filter
#' @param list_values An atomic vector giving the conditions we want to filter by
#' @return A list containing the filtered `data.frame`s.
#' @export
#' @importFrom dplyr `%>%` filter_
#' @examples
#' data(mtcars)
#' map_filter(mtcars, "cyl", c(4, 6))
map_filter <- function(dataset, variable, list_values){

  for_one_dataset <- function(dataset, variable, value){
    filter_criteria <- lazyeval::interp(~y == x, .values=list(y = as.name(variable), x =  value))
    dataset %>%
      filter_(filter_criteria) -> out
    return(out)
  }

  out <- purrr::map(list_values, for_one_dataset, dataset = dataset, variable = variable)

  return(out)
}
