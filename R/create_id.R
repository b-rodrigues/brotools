#' Creates a group id. Especially useful in the case of panel data
#' @param list_of_loaded_datasets A list of loaded datasets
#' @param list_of_variables A list of variables by which to group
#' @return A data frame with the column `group_id` added to it
#' @export
#' @examples
#' \dontrun{
#' setwd("path/to/datasets/")
#' list_of_datasets <- ls(pattern = "expr") # "expr" is a character string common to
#' every data set (for example, suppose all you loaded data sets are of the form *_entrep_*)
#' list_of_loaded_datasets <- group_id(list_of_datasets)
#' updated_list <- all_data_to_upper(list_of_loaded_datasets)
#' }
create_group_id <- function(list_of_loaded_datasets, list_of_variables){

print("to implement")
}
