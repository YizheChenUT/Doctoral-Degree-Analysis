#### Preamble ####
# Purpose: Simulates a dataset including state, estimated totals and difference
# Author: Yizhe Chen
# Date: 21 Nov 2024
# Contact: Yizhe Chen
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? No


#### Workspace setup ####
library(tidyverse)
set.seed(853)  # For reproducibility


#### Simulate data ####
# State names based on STATEICP
states <- paste("State", 1:50)

# Create a simulated dataset
simulated_data <- tibble(
  STATEICP = 1:50,  # State identifiers
  estimated_doctoral = sample(100:2000, 50, replace = TRUE),  # Simulated doctoral estimates
  estimate_total = round(runif(50, min = 10000, max = 50000), 2),  # Simulated total estimates
  count_doctoral = sample(100:2000, 50, replace = TRUE),  # Simulated actual doctoral counts
  difference = round(runif(50, min = 5000, max = 10000), 2),  # Simulated differences
  state = states,  # State names
)

#### Save data ####
write_csv(simulated_data, "data/simulated_data.csv")

