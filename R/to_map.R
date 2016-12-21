#' Generalizes functions to work on lists of data
#' @param func A function
#' @return A function that works on lists of data
#' @export
#' @examples
#' \dontrun{
#' setwd("path/to/datasets/")
#' list_of_datasets <- list.files(pattern = "*.csv")
#' list_of_loaded_datasets <- read_list(list_of_datasets, read_func = read.csv)
#' # To get the summary statistics of all variables for all the datasets in the list:
#' summarymap <- to_map(summary)
#' summarymap(list_of_loaded_datasets)
#' # To get the summary statistics of a single variable for all the datasets in the list:
#' summarymap(list_of_loaded_datasets, "variable")
#' # This is equivalent to
#' purrr::map(list_of_loaded_datasets, (function(x) summary(x$variable)))
#' }
to_map <- function(func){
	function(list, column, ...){
		if(missing(column)){
			res <- purrr::map(list, (function(x) func(x, ...)))
		} else {
			res <- purrr::map(list, (function(x) func(x[column], ...)))
		}
		res
	}
}
