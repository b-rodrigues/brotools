library("testthat")
library("brunoUtils")
library("readr")
library("stringr")
library("tibble")
library("dplyr")
library("prepareMultiprod")

#setwd("inst/tests/")

dataset <- as_data_frame(list("id" = c(rep(1, 3), rep(2, 4)),
                              "x1" = c(88, 88, NA, rep(99, 4)),
                              "x2" = c(rep(888, 3), c(NA, NA, 999, 999)),
                              "x3" = c(rep(8888, 3), c(NA, NA, 9999, 9999))))


test_that("Test one row",{

  data_out <- one_row(dataset, "id")

  expected <- as_data_frame(list("id" = c(1, 2),
                                "x1" = c(88, 99),
                                "x2" = c(888, 999),
                                "x3" = c(8888, 9999)))

  expect_equal(expected, data_out)

})
