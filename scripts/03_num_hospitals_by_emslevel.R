#### Preamble ####

# Purpose: Save a tibble containing the number of hospitals by
# EMS level.
# Authors: Yang Lei, Indira Mishra, Benny Rochwerg, and Peiqing Yu
# Date: April 6, 2026
# Pre-requisites: Running of the files titled "00_load_packages.R",
# "01_num_hospitals_by_trauma.R", and "02_process_trauma.R".

#### Store Tibble ####

# Load dataset
ambulance <-
  readRDS(
    here::here(
      "data/processed/ambulance.rds"
    )
  )

# Create tibble
num_hospitals_by_emslevel <- ambulance %>%
  group_by(emslevel) %>%
  summarize(n = n_distinct(id))

# Save tibble
saveRDS(num_hospitals_by_emslevel,
        "tibbles/num_hospitals_by_emslevel.rds")