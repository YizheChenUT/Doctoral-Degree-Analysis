#### Preamble ####
# Purpose: Tests the structure and validity of the cleaned dataset.
# Author: Yizhe Chen
# Date: 21 Nov 2024
# Contact: yz.chen@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` and `testthat` packages must be installed and loaded
# Any other information needed? No

#### Workspace setup ####
library(tidyverse)
library(testthat)

# Read data from Parquet file
test_data <- read_csv("data/comparison_results.csv")


#### Test data ####
test_that("Dataset has the correct structure", {
  # Check that the dataset has the expected columns
  expected_columns <- c(
    "STATEICP", "estimated_doctoral", "estimate_total",
    "count_doctoral", "difference"
  )
  expect_equal(names(test_data), expected_columns)
  
  # Check that there are rows in the dataset
  expect_gt(nrow(test_data), 0)
})

test_that("Column values are within expected ranges", {
  # Check that STATEICP is an integer between 1 and 98
  expect_true(all(test_data$STATEICP >= 1 & test_data$STATEICP <= 98))
  
  # Check that estimated_doctoral is non-negative
  expect_true(all(test_data$estimated_doctoral >= 0))
  
  # Check that estimate_total is greater than or equal to count_doctoral
  expect_true(all(test_data$estimate_total >= test_data$count_doctoral))
  
  # Check that difference is non-negative
  expect_true(all(test_data$difference >= 0))
})

test_that("Logical relationships hold", {
  # Check that the sum of count_doctoral is less than or equal to the sum of estimate_total
  expect_true(sum(test_data$count_doctoral) <= sum(test_data$estimate_total))
  
  # Check that difference matches the expected calculation (estimate_total - count_doctoral)
  calculated_difference <- test_data$estimate_total - test_data$count_doctoral
  expect_equal(round(test_data$difference, 2), round(calculated_difference, 2))
})