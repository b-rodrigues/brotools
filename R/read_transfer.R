#' Imports data from StatTransfer
#' @param dat The file containing the data, in the .dat format
#' @param stsd The file containing the schema, in the .stsd format
#' @param ... Further options passed down to methods
#' @return A data frame
#' @export
#' @importFrom stringr str_replace_all str_extract
#' @importFrom data.table fread
#' @importFrom purrr discard map2_df is_empty
#' @examples
#' \dontrun{
#' read_transfer("mtcars.dat", "mtcars.stsd")
#' }
read_transfer <- function(dat, stsd, n = -1L, ok = TRUE, warn = TRUE,
						  encoding = "unknown", skipNul = FALSE, sep = ",", ...){

  dat_file <- data.table::fread(file = dat, sep = sep, ...)

  meta_data <- readLines(con = stsd, n = n, ok = ok, warn = warn, encoding = encoding, skipNul = skipNul)

  meta_data_end <- which(meta_data == "VALUE LABELS")

  meta_data_end <- ifelse(purrr::is_empty(meta_data_end), length(meta_data), meta_data_end)

  meta_data <- meta_data[1:(meta_data_end - 1)]

  variable_names <- stringr::str_extract(meta_data, "\\b(\\w+)\\b") %>%
    purrr::discard(is.na)

  variable_types <- stringr::str_extract(meta_data, "\\(.*\\)") %>%
    purrr::discard(is.na)

  variable_types <- variable_types %>%
    stringr::str_replace_all(".*A.*", "character") %>%
    stringr::str_replace_all(".*F.*", "numeric")

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

  purrr::map2_df(dat_file, variable_types, set_col_type)

}