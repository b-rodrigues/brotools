#' Merges more than two datasets together using `Reduce()`
#' @description This function is useful to merge a lot of datasets together. It uses `dplyr` join
#' functions internally.
#' Inspired by: http://novicemetrics.blogspot.lu/2011/04/merging-multiple-data-files-into-one.html
#' @param list_of_loaded_datasets A list of loaded datasets
#' @param read_func A function, the read function to use to read the data
#' @param join_func A function, the join function to use to join the data together
#' @param ... Further parameters to pass to the join function
#' @return Returns the merged datasets
#' @export
#' @examples
#' \dontrun{
#' setwd("path/to/datasets/")
#' list_of_datasets <- ls(pattern = "expr") # "expr" is a character string common to
#' every data set (for example, suppose all you loaded data sets are of the form *_entrep_*)
#' list_of_loaded_datasets <- read_list(list_of_datasets, read_func = read.csv)
#' merged_data <- multi_join(list_of_loaded_datasets, full_join, by = "some_var")
#' If you have a list of lists of datasets, you can merge the lists like this:
#' lapply(hu, multi_join, read_csv, full_join)
#' }
multi_join <- function(list_of_loaded_data, read_func, join_func, ...){

	require("readr")
	require("dplyr")

	output <- Reduce(function(x, y) {join_func(x, y, ...)}, list_of_loaded_data)

	return(output)
}