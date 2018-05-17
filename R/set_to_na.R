#' This function sets values in one column to NA.
#' @param df A data frame
#' @param variable A character vector of the variable to work on.
#' @param indices An atomic vector of indices to set to NA.
#' @return The original data frame with NAs at the right places.
#' @description This function is useful to set unlikely values to NA.
set_one_col_to_na <- function(df, variable, indices){
	df[[variable]][indices] <- NA
	df
}

#' This function sets values to NA based on column names and indices
#' @param df A data frame
#' @param variables A character vector of the variables to work on. Ideally returned from validate::variables(validator_object)
#' @param list_indices A list indices to set to NA.
#' @return The original data frame with NAs at the right places.
#' @description This function is useful to set unlikely values to NA.
set_cols_to_na <- function(df, variables, list_indices){
	for(i in seq_along(variables)){
		df <- set_one_col_to_na(df, variables[i], list_indices[[i]])
	}
	df
}
