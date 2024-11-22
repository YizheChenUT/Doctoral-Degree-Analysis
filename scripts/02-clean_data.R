#### Preamble ####
# Purpose: Cleans the data from IPUMS.
# Author: Yizhe Chen
# Date: 2 Nov 2024
# Contact: yz.chen@mail.utoronto.ca
# License: MIT
# Pre-requisites: Must have downloaded the raw data.
# Any other information needed? No

#### Workspace setup ####
library(tidyverse)
library(ipumsr)

#### Clean data ####
data <- read_csv("data/usa_00003.csv")

# Filter for respondents with a doctoral degree (EDUCD == "Doctoral degree")
doctoral_data <- data %>% 
  filter(EDUCD == "116") %>%
  group_by(STATEICP) %>%
  summarize(count_doctoral = n())

total_california <- 391171

# Calculate ratio for California
ratio_california <- doctoral_data %>% 
  filter(STATEICP == "71") %>% 
  pull(count_doctoral) / total_california

# Apply the ratio to estimate total respondents in other states
estimates <- doctoral_data %>%
  mutate(estimate_total = count_doctoral / ratio_california)

# Make a comparison
difference <- estimate_total - count_doctoral

# Add column
comparison <- estimates %>%
  rename(estimated_doctoral = count_doctoral) %>%
  left_join(doctoral_data, by = "STATEICP") %>%
  mutate(difference)

#### Save data ####
write_csv(comparison, "data/comparison_results.csv")
