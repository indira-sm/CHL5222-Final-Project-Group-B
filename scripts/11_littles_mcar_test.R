#### Preamble ####

# Purpose: Store the p-value from Little's MCAR test.
# Authors: Yang Lei, Indira Mishra, Benny Rochwerg, and Peiqing Yu
# Date: April 6, 2026
# Pre-requisites: Running of the files titled "00_load_packages.R",
# "01_num_hospitals_by_trauma.R", "02_process_trauma.R",
# "03_num_hospitals_by_emslevel.R", "04_process_emslevel.R",
# "05_num_hospitals_by_county.R", "06_process_county.R",
# "07_finish_processing_data.R", "08_figure_diverthours_by_year.R",
# "09_complete_cases_percentage.R", and "10_num_unique_hospitals.R".

#### Perform Test and Store p-value ####

# Load dataset
ambulance <-
  readRDS(
    here::here(
      "data/processed/ambulance.rds"
    )
  )

# Perform test and obtain p-value
test_results <- ambulance %>%
  select(year, id, diverthours) %>%
  pivot_wider(
    names_from = year,
    names_prefix = "y", # y = diverthours
    values_from = diverthours
  ) %>%
  select(-id) %>%
  mcar_test()

p_value <- test_results[1, "p.value"][[1]]

# Save p-value
saveRDS(p_value,
        "values/littles_mcar_test_p_value.rds")