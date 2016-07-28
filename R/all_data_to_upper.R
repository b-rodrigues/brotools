#' Converts column names to upper case for a given list of datasets
#' @param list_of_loaded_datasets A list of loaded datasets
#' @return Changes the datasets in place, with column names converted to upper case
#' @export
#' @examples
#' \dontrun{
#' setwd("path/to/datasets/")
#' list_of_datasets <- ls(pattern = "expr") # "expr" is a character string common to
#' every data set (for example, suppose all you loaded data sets are of the form *_entrep_*)
#' list_of_loaded_datasets <- read_list(list_of_datasets, read_func = read.csv)
#' updated_list <- all_data_to_upper(list_of_loaded_datasets)
#' }
all_data_to_upper <- function(list_of_loaded_datasets){

	invisible(lapply(
		list_of_loaded_datasets,
		function(x) {colnames(x) <- toupper(colnames(x)); x}))

}
