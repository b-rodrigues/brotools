library("testthat")
library("brotools")
library("readr")

test_that("Test around, FALSE",{
	expect_false(around(2, 3, 0.5))
})

test_that("Test around, TRUE",{
	expect_true(around(2, 3, 2))
})