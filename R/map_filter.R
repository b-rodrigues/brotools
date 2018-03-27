#' Filter a list of conditions
#' @param dataset A `data.frame` object
#' @param variable The variable to filter
#' @param list_values An atomic vector giving the conditions we want to filter by
#' @return A list containing the filtered `data.frame`s.
#' @export
#' @examples
#' data(mtcars)
#' map_filter(mtcars, "cyl", c(4, 6))
map_filter <- function(dataset, variable, list_values, rbind = FALSE){
  variable <- rlang::enquo(variable)

  for_one_dataset <- function(dataset, variable, value){
    dataset %>%
      filter(rlang::UQ(variable) == value)
    }

  if (rbind) {
  	mapfun <- purrr::map_df
  } else {
  	mapfun <- purrr::map
  }

  mapfun(list_values, for_one_dataset, dataset = dataset, variable = variable)

}
