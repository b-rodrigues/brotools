#' Imports data from StatTransfer
#' @param dat The file containing the data, in the .dat format
#' @param stsd The file containing the schema, in the .stsd format
#' @param ... Further options passed down to methods
#' @return A data frame
#' @export
#' @importFrom stringr str_replace_all str_extract str_remove_all
#' @importFrom data.table fread
#' @importFrom purrr discard map2_df is_empty
#' @importFrom lubridate parse_date_time
#' @examples
#' \dontrun{
#' read_transfer("mtcars.dat", "mtcars.stsd")
#' }
read_transfer <- function(dat, stsd, n = -1L, ok = TRUE, warn = TRUE,
              encoding = "unknown", skipNul = FALSE, sep = ",", locale = Sys.getlocale("LC_TIME"), ...){

  dat_file <- data.table::fread(file = dat, sep = sep, encoding = encoding, ...)

  meta_data <- readLines(con = stsd, n = n, ok = ok, warn = warn, encoding = encoding, skipNul = skipNul)

  meta_data_end <- which(meta_data == "VALUE LABELS")

  meta_data_end <- ifelse(purrr::is_empty(meta_data_end), length(meta_data), meta_data_end)

  meta_data <- meta_data[1:(meta_data_end - 1)]

  variable_names <- stringr::str_extract(meta_data, "\\b(\\w+)\\b") %>%
    purrr::discard(is.na)

  variable_types <- stringr::str_extract(meta_data, "\\(.*\\)") %>%
    purrr::discard(is.na)

  date_formats <- variable_types %>%
    stringr::str_extract(".*%.*") %>%
    stringr::str_remove_all("\\(|\\)")

  variable_types <- variable_types %>%
    stringr::str_replace_all(".*A.*", "character") %>%
    stringr::str_replace_all(".*F.*", "numeric") %>%
    stringr::str_replace_all(".*%.*", "POSIXct")

  variables_start <- which(variable_names == "VARIABLES") + 1

  var_names <- variable_names[seq(variables_start, length(variable_names))]

  colnames(dat_file) <- var_names

  dat_file[dat_file == "?"] <- NA


  set_col_type <- function(column, type, date_format = NA, locale = locale){
    if(type == "character"){
      as.character(column)
    } else if (type == "numeric"){
      as.numeric(column)
    } else if (type == "POSIXct"){
      as.POSIXct(lubridate::parse_date_time(x = column, orders = date_format, locale = locale))
    }
  }

  if(all(is.na(date_formats))){
    purrr::map2_df(dat_file, variable_types, set_col_type)
  } else {
    purrr::pmap_df(
      list(
        column = dat_file, type = variable_types, date_format = date_formats
      ),
      set_col_type, locale = locale)
  }
}