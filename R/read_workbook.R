#' Reads an Excel workbook file into a list object
#' @param path_to_excel Path to an Excel file
#' @return A list of data.frame objects where each data.frame object is an Excel sheet
#' @description This reads in an entire Excel workbook into a list of data frames. Each data frame
#'   is one the sheets that constitute the Excel workbook. This is the closest representation to
#'   an Excel workbook that is possible in R.
#' @export
#' @examples
#' \dontrun{
#' excel_workbook <- read_workbook("my_excel_file.xlsx")
#' }
read_workbook <- function(path_to_excel){
  sheets <- readxl::excel_sheets(path_to_excel)
  output <- purrr::map(sheets, read_excel_clean, path = path_to_excel)
  names(output) <- sheets
  return(output)
}
