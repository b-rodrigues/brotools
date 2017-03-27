#' Reads in and cleans the names of the columns of Excel files
#' @param path_to_excel Path to an Excel file
#' @param ... Further arguments passed to readxl::read_excel()
#' @return A data.frame containing the read Excel file
#' @description This is an helper function that simply reads in an Excel file and cleans the names
#'   of the columns in one step. The user does not need to run this by itself, but it is called by
#'   `read_workbook()`.
#' @examples
#' \dontrun{
#' read_excel_clean("my_excel_file.xlsx")
#' }
read_excel_clean <- function(path_to_excel, ...){
    janitor::clean_names(readxl::read_excel(path_to_excel, ...))
}
