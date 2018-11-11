#' Compute descriptive statistics for a data frame.
#' @param df The data frame to summarise.
#' @param ... Optional. Columns in the data frame
#' @return A data frame with descriptive statistics. If you are only interested in certain columns
#' you can add these columns.
#' @import dplyr
#' @importFrom magrittr "%>%"
#' @importFrom tidyr gather
#' @importFrom assertthat is.date
#' @export
#' @examples
#' \dontrun{
#' describe(dataset)
#' describe(dataset, col1, col2)
#' }
describe <- function(df, ...){

  empty_frame <- tibble::tribble(~variable, ~type, ~n_missing, ~n_unique)

  if (nargs() > 1) df = dplyr::select(df, ...)

  describe_numeric <- function(df){
    df %>%
      select_if(is.numeric) %>%
      tidyr::gather(variable, value) %>%
      group_by(variable) %>%
      summarise_all(funs(mean = mean(value, na.rm = TRUE),
                         sd = sd(value, na.rm = TRUE),
                         nobs = length(value),
                         min = min(value, na.rm = TRUE),
                         max = max(value, na.rm = TRUE),
                         q05 = quantile(value, 0.05, na.rm = TRUE),
                         q25 = quantile(value, 0.25, na.rm = TRUE),
                         mode = as.character(brotools::sample_mode(value), na.rm = TRUE),
                         median = quantile(value, 0.5, na.rm = TRUE),
                         q75 = quantile(value, 0.75, na.rm = TRUE),
                         q95 = quantile(value, 0.95, na.rm = TRUE),
                         n_missing = sum(is.na(value)))) %>%
      mutate(type = "Numeric")
  }

  describe_character_or_factors <- function(df, type){
    df %>%
      tidyr::gather(variable, value) %>%
      group_by(variable) %>%
      summarise_all(funs(mode = brotools::sample_mode(value, na.rm = TRUE),
                         nobs = length(value),
                         n_missing = sum(is.na(value)),
                         n_unique = length(unique(value)))) %>%
      mutate(type = type)
  }

  describe_character <- function(df){
    df %>%
      select_if(is.character) %>%
      describe_character_or_factors(type = "Character")
  }

  describe_factor <- function(df){
    df %>%
      select_if(is.factor) %>%
      describe_character_or_factors(type = "Factor")
  }

  describe_list <- function(df){
    df %>%
      select_if(is.list) %>%
      tidyr::gather(variable, value) %>%
      group_by(variable) %>%
      summarise_all(funs(n_missing = sum(is.na(unique(unlist(value)))),
                         nobs = length(unlist(value)),
                         n_unique = length(unique(unlist(value))))) %>%
      mutate(type = "List")
  }

  describe_date <- function(df){
    df %>%
      select_if(assertthat::is.date) %>%
      tidyr::gather(variable, value) %>%
      group_by(variable) %>%
      summarise_all(funs(starting_date = min(value),
                         ending_date = max(value),
                         nobs = length(value),
                         n_missing = sum(is.na(value)),
                         n_unique = length(unique(value)))) %>%
      mutate(type = "Date")
  }

  possibly_describe_numeric <- purrr::possibly(describe_numeric, otherwise = empty_frame)
  possibly_describe_character <- purrr::possibly(describe_character, otherwise = empty_frame)
  possibly_describe_factor <- purrr::possibly(describe_factor, otherwise = empty_frame)
  possibly_describe_list <- purrr::possibly(describe_list, otherwise = empty_frame)
  possibly_describe_date <- purrr::possibly(describe_date, otherwise = empty_frame)

  df_numeric <- possibly_describe_numeric(df)
  df_character <- possibly_describe_character(df)
  df_factor <- possibly_describe_factor(df)
  df_list <- possibly_describe_list(df)
  df_date <- possibly_describe_date(df)

  list(df_numeric, df_character, df_factor, df_list, df_date) %>%
    bind_rows() %>%
    select(variable, type, nobs, mean, sd, mode, min, max, q05, q25, median, q75, q95, everything())
}
