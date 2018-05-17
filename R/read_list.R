#' Reads a list of datasets
#' @param list_of_datasets A list of datasets (names of datasets are strings)
#' @param read_func A function, the read function to use to read the data
#' @param parallelize Parallelize the code
#' @param ... Further arguments passed to read_func
#' @return Returns a list of the datasets
#' @importFrom parallel detectCores makeCluster
#' @importFrom pbapply pblapply
#' @importFrom doParallel registerDoParallel
#' @importFrom stringr str_replace_all
#' @importFrom dplyr bind_rows
#' @export
#' @examples
#' \dontrun{
#' setwd("path/to/datasets/")
#' list_of_datasets <- list.files(pattern = "*.csv")
#' list_of_loaded_datasets <- read_list(list_of_datasets, read_func = read.csv)
#' }
read_list <- function(list_of_datasets,  read_func, ..., parallelize = FALSE, rbind = FALSE){

  stopifnot(length(list_of_datasets) > 0)

  read_and_assign <- function(dataset, read_func){
    dataset_name <- as.name(dataset)
    dataset_name <- read_func(dataset, ...)
  }

  if (parallelize) {
    message("Reading in data in parallel")
    clusters <- parallel::detectCores() %>%
      parallel::makeCluster()

    doParallel::registerDoParallel(clusters)

    output <- invisible( # invisible is used to suppress the unneeded output
      pbapply::pblapply(list_of_datasets,
                        read_and_assign,
                        read_func = read_func,
                        ...,
                        cl = clusters)
    )

    parallel::stopCluster(clusters)

  } else if (!parallelize) {
    output <- invisible(
      pbapply::pblapply(list_of_datasets,
                        read_and_assign,
                        read_func = read_func)
    )
  }

  # Remove what's after the "." at the end of the data set names and what's before any / for url files.
  names_of_datasets <- list_of_datasets %>%
    stringr::str_replace_all(".*/|\\..*", "")

  names(output) <- names_of_datasets

  if (rbind) {
    dplyr::bind_rows(output)
  } else {
    output
  }
}
