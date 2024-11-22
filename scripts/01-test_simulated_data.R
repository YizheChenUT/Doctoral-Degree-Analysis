#### Preamble ####
# Purpose: Tests the structure and validity of the simulated data.
# Author: Yizhe Chen
# Date: 21 Nov 2024
# Contact: yz.chen@mail.utoronto.ca
# License: MIT
# Pre-requisites:
# - The `tidyverse` package must be installed and loaded
# - 00-simulate_data.R must have been run
# Any other information needed? No


#### Workspace setup ####
library(tidyverse)
library(testthat)

# Load the simulated dataset
simulated_data <- read_csv("data/simulated_data.csv")

#### Test data ####
test_that("Simulated dataset has the correct structure", {
  # Check that the dataset has the expected columns
  expected_columns <- c(
    "STATEICP", "estimated_doctoral", "estimate_total",
    "count_doctoral", "difference", "state"
  )
  expect_equal(names(simulated_data), expected_columns)
  
  # Check that the dataset has 50 rows (one for each state)
  expect_equal(nrow(simulated_data), 50)
})

test_that("Simulated dataset values are within expected ranges", {
  # Check that STATEICP is an integer between 1 and 50
  expect_true(all(simulated_data$STATEICP >= 1 & simulated_data$STATEICP <= 50))
  
  # Check that estimated_doctoral is between 100 and 2000
  expect_true(all(simulated_data$estimated_doctoral >= 100 & simulated_data$estimated_doctoral <= 2000))
  
  # Check that estimate_total is between 10,000 and 50,000
  expect_true(all(simulated_data$estimate_total >= 10000 & simulated_data$estimate_total <= 50000))
  
  # Check that count_doctoral is between 100 and 2000
  expect_true(all(simulated_data$count_doctoral >= 100 & simulated_data$count_doctoral <= 2000))
  
  # Check that difference is between 5,000 and 10,000
  expect_true(all(simulated_data$difference >= 5000 & simulated_data$difference <= 10000))
})

test_that("Logical relationships between columns are valid", {
  # Check that count_doctoral does not exceed estimate_total
  expect_true(all(simulated_data$count_doctoral <= simulated_data$estimate_total))
  
  # Check that difference is non-negative
  expect_true(all(simulated_data$difference >= 0))
})

test_that("Categorical columns contain expected values", {
  # Check that state column contains unique names
  expect_equal(length(unique(simulated_data$state)), 50)
})

