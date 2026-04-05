#### Preamble ####

# Purpose: Save a tibble containing the number of hospitals by
# county.
# Authors: Yang Lei, Indira Mishra, Benny Rochwerg, and Peiqing Yu
# Date: April 6, 2026
# Pre-requisites: Running of the files titled "00_load_packages.R",
# "01_num_hospitals_by_trauma.R", "02_process_trauma.R",
# "03_num_hospitals_by_emslevel.R", and "04_process_emslevel.R".

#### Store Tibble ####

# Load dataset
ambulance <-
  readRDS(
    here::here(
      "data/processed/ambulance.rds"
    )
  )

# Create tibble
num_hospitals_by_county <- ambulance %>%
  group_by(county) %>%
  summarize(n = n_distinct(id))

# Save tibble
saveRDS(num_hospitals_by_county,
        "tibbles/num_hospitals_by_county.rds")