#' Reads a list of datasets
#' @param list_of_datasets A list of datasets (names of datasets are strings)
#' @param read_func A function, the read function to use to read the data
#' @param parallelize Parallelize the code
#' @param ... Further arguments passed to read_func
#' @return Returns a list of the datasets
#' @export
#' @examples
#' \dontrun{
#' setwd("path/to/datasets/")
#' list_of_datasets <- list.files(pattern = "*.csv")
#' list_of_loaded_datasets <- read_list(list_of_datasets, read_func = read.csv)
#' }
read_list <- function(list_of_datasets,  read_func, ..., parallelize = TRUE){

  stopifnot(length(list_of_datasets)>0)

  read_and_assign <- function(dataset, read_func){
    dataset_name <- as.name(dataset)
    dataset_name <- read_func(dataset, ...)
  }
  if (parallelize == TRUE) {
    clusters <- parallel::detectCores() %>%
      parallel::makeCluster()
    doParallel::registerDoParallel(clusters)
    output <- invisible(
      pbapply::pblapply(list_of_datasets,
                        read_and_assign,
                        read_func = read_func,
                        cl = clusters)
    )
    parallel::stopCluster(clusters)
  } else if (parallelize == FALSE) {
    # invisible is used to suppress the unneeded output
    output <- invisible(
      pbapply::pblapply(list_of_datasets,
                        read_and_assign,
                        read_func = read_func))
  }

  # Remove what's after the "." at the end of the data set names and what's before any / for url files.
  names_of_datasets <- list_of_datasets %>% str_replace_all(".*/|\\..*", "")
  names(output) <- names_of_datasets
  return(output)
}



