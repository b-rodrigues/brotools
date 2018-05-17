#' Imports data from StatTransfer
#' @param dat The file containing the data, in the .dat format
#' @param stsd The file containing the schema, in the .stsd format
#' @param ... Further options passed down to methods
#' @return A data frame
#' @export
#' @importFrom stringr str_replace_all str_extract
#' @importFrom purrr map2_df
#' @examples
#' \dontrun{
#' read_transfer("mtcars.dat", "mtcars.stsd")
#' }
read_transfer <- function(dat, stsd, n = -1L, ok = TRUE, warn = TRUE,
						  encoding = "unknown", skipNul = FALSE, ...){

  dat_file <- read.table(dat, ...)

  meta_data <- readLines(con = stsd, n = -1L, ok = TRUE, warn = TRUE,
  					   encoding = "unknown", skipNul = FALSE)

  variable_names <- str_extract(meta_data, "\\b(\\w+)\\b") %>%
    discard(is.na)

  variable_types <- str_extract(meta_data, "\\(.*\\)") %>%
    discard(is.na)

  variable_types <- variable_types %>%
    str_replace_all(".*A.*", "character") %>%
    str_replace_all(".*F.*", "numeric")

  variables_start <- which(variable_names == "VARIABLES") + 1

  var_names <- variable_names[seq(variables_start, length(variable_names))]

  colnames(dat_file) <- var_names

  dat_file[dat_file == "?"] <- NA

  set_col_type <- function(column, type){
    if(type == "character"){
      as.character(column)
    } else if (type == "numeric"){
      as.numeric(column)
    }
  }
  map2_df(dat_file, variable_types, set_col_type)

}