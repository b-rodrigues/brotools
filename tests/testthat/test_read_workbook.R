library("testthat")
library("prepareEUBCS")

path_to_workbook <- Sys.glob("*.xlsx")

test_that("Test read workbook: is it a list?", {
  workbook <- read_workbook(path_to_workbook)
  expect_type(workbook, "list")
})

test_that("Test read workbook: is the list of the correct length?", {
  workbook <- read_workbook(path_to_workbook)
  number_of_sheets <- length(readxl::excel_sheets(path_to_workbook))
  expect_equal(number_of_sheets, length(workbook))
})
