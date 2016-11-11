#' Reads a list of datasets
#' @param list_of_datasets A list of datasets (names of datasets are strings)
#' @param read_func A function, the read function to use to read the data
#' @param ... Further arguments passed to read_func
#' @return Returns a list of the datasets
#' @export
#' @examples
#' \dontrun{
#' setwd("path/to/datasets/")
#' list_of_datasets <- list.files(pattern = "*.csv")
#' list_of_loaded_datasets <- read_list(list_of_datasets, read_func = read.csv)
#' }
read_list <- function(list_of_datasets, read_func, ...){

	stopifnot(length(list_of_datasets)>0)

	read_and_assign <- function(dataset, read_func){
		dataset_name <- as.name(dataset)
		dataset_name <- read_func(dataset, ...)
	}

	# invisible is used to suppress the unneeded output
	output <- invisible(
		sapply(list_of_datasets,
			   read_and_assign, read_func = read_func, simplify = FALSE, USE.NAMES = TRUE))

	# Remove the ".csv" at the end of the data set names
	names_of_datasets <- c(unlist(strsplit(list_of_datasets, "[.]"))[c(T, F)])
	names(output) <- names_of_datasets
	return(output)
}
