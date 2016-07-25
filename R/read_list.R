#' Reads a list of datasets
#' @param list_of_datasets A list of datasets (names of datasets are strings)
#' @param read_func A function, the read function to use to read the data
#' @return Does not return a value, but reads the datasets into the Global Environment
#' @examples
#' \donturn{
#' setwd("path/to/datasets/")
#' list_of_datasets <- list.files(pattern = "*.csv")
#' list_of_loaded_datasets <- read_list(list_of_datasets, read_and_assgin, read_func = read.csv)
#' }
read_list <- function(list_of_datasets, read_func){

	read_and_assign <- function(dataset, read_func){
		assign(
			strsplit(dataset, ".", fixed = TRUE)[[1]][1],
			read_func(dataset))
	}

	# invisible is used to suppress the unneeded output
	invisible(sapply(list_of_datasets, read_and_assign, read_func = read_func))
}
