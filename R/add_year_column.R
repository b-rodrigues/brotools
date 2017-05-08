#' Adds the year column
#' @param list_of_datasets A list containing named datasets
#' @return A list of datasets with the year column
#' @description This function works by extracting the year string contained in
#' the data set name and appending a new column to the data set with the numeric
#' value of the year. This means that the data sets have to have a name of the
#' form data_set_2001 or data_2001_europe, etc
#' @export
#' @examples
#' \dontrun{
#' #`list_of_data_sets` is a list containing named data sets
#' # For example, to access the first data set, called dataset_1 you would
#' # write
#' list_of_data_sets$dataset_1
#' add_year_column(list_of_data_sets)
#' }
add_year_column <- function(list_of_datasets){

  for_one_dataset <- function(dataset, dataset_name){
    if ("ANNEE" %in% colnames(dataset) | "Annee" %in% colnames(dataset)){
      return(dataset)
    } else {
      # Split the name of the data set and extract the number index
      index <- grep("\\d+", stringr::str_split(dataset_name, "[_.]", simplify = TRUE))
      # Get the year
      year <- as.numeric(stringr::str_split(dataset_name, "[_.]", simplify = TRUE)[index])
      # Add it to the data set
      dataset$ANNEE <- year
      return(dataset)
    }
  }

  output <- purrr::map2(list_of_datasets, names(list_of_datasets), for_one_dataset)

  return(output)
}
