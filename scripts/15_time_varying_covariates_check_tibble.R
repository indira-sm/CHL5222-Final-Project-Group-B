#### Preamble ####

# Purpose: Save a tibble containing covariates that change over time.
# Authors: Yang Lei, Indira Mishra, Benny Rochwerg, and Peiqing Yu
# Date: April 6, 2026
# Pre-requisites: Running of the files titled "00_load_packages.R",
# "01_num_hospitals_by_trauma.R", "02_process_trauma.R",
# "03_num_hospitals_by_emslevel.R", "04_process_emslevel.R",
# "05_num_hospitals_by_county.R", "06_process_county.R",
# "07_finish_processing_data.R", "08_figure_diverthours_by_year.R",
# "09_complete_cases_percentage.R", "10_num_unique_hospitals.R",
# "11_littles_mcar_test.R", "12_missing_data_heatmap.R",
# "13_diverthours_histogram.R", and "14_overdispersion_check_tibble.R".

#### Save Tibble ####

# Load dataset
ambulance <-
  readRDS(
    here::here(
      "data/processed/ambulance.rds"
    )
  )

# Create tibble
time_varying_covariates_check_tibble <- ambulance %>%
  group_by(id) %>%
  summarize(across(c(trauma,
                     emslevel,
                     stations,
                     admitrate,
                     region),
                   n_distinct)) %>%
  summarize(across(everything(), max)) %>%
  select(-id) %>%
  select(where(~.x > 1))

# Save tibble
saveRDS(time_varying_covariates_check_tibble,
        "tibbles/time_varying_covariates_check_tibble.rds")