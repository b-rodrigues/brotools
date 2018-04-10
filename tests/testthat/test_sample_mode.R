test_that("Test sample mode",{
	expected_mode <- sample_mode(c(1,1,6,8))
  actual_mode <- 1
	expect_equal(expected_mode, actual_mode)
})
