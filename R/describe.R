#' Compute descriptive statistics for a data frame.
#' @param df The data frame to summarise.
#' @param ... Optional. Columns in the data frame
#' @return A data frame with descriptive statistics. If you are only interested in certain columns
#' you can add these columns.
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
      gather(variable, value) %>%
      group_by(variable) %>%
      summarise_all(funs(mean = mean(value, na.rm = TRUE),
                         sd = sd(value, na.rm = TRUE),
                         min = min(value, na.rm = TRUE),
                         max = max(value, na.rm = TRUE),
                         q25 = quantile(value, 0.25, na.rm = TRUE),
                         median = quantile(value, 0.5, na.rm = TRUE),
                         q75 = quantile(value, 0.75, na.rm = TRUE),
                         n_missing = sum(is.na(value)))) %>%
      mutate(type = "Numeric") %>%
      select(variable, type, everything())
  }

  describe_character_or_factors <- function(df, type){
    df %>%
      gather(variable, value) %>%
      group_by(variable) %>%
      summarise_all(funs(n_missing = sum(is.na(value)),
                         n_unique = length(unique(value)))) %>%
      mutate(type = type) %>%
      select(variable, type, everything())
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
      gather(variable, value) %>%
      group_by(variable) %>%
      summarise_all(funs(n_missing = sum(is.na(unique(unlist(value)))),
                         n_unique = length(unique(unlist(value))))) %>%
      mutate(type = "List") %>%
      select(variable, type, everything())
  }

  possibly_describe_numeric <- purrr::possibly(describe_numeric, otherwise = empty_frame)
  possibly_describe_character <- purrr::possibly(describe_character, otherwise = empty_frame)
  possibly_describe_factor <- purrr::possibly(describe_factor, otherwise = empty_frame)
  possibly_describe_list <- purrr::possibly(describe_list, otherwise = empty_frame)

  df_numeric <- possibly_describe_numeric(df)
  df_character <- possibly_describe_character(df)
  df_factor <- possibly_describe_factor(df)
  df_list <- possibly_describe_list(df)

  list(df_numeric, df_character, df_factor, df_list) %>%
    dplyr::bind_rows()

}
