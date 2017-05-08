library("testthat")
library("brotools")
library("readr")
library("stringr")
library("tibble")

#setwd("inst/tests/")

data_sets <- list.files(pattern = "2001")

data_list <- read_list(data_sets, read_csv, col_types = cols())

test_that("Test add year column",{
	data_list_result <- add_year_column(data_list)
	expect <- rep(2001, nrow(data_list$test_data_activ_2001))
	actual <- data_list_result$test_data_activ_2001$ANNEE
	expect_equal(expect, actual)
})


test_that("Test add year column; ANNEE already present",{
	colnames(data_list$test_data_activ_2001) <- c(
		"NUMENTREP", "origin", "chi", "per", "col1", "col2876",
		"ANNEE", "col_rem1", "col_rem2", "NACE", "NACE1", "NACE2")
	data_list_result <- add_year_column(data_list)
	expect <- 12
	actual <- length(colnames(data_list_result$test_data_activ_2001))
	expect_equal(expect, actual)
})
