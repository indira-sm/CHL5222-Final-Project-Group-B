#### Preamble ####

# Purpose: Store the percentage of complete cases from the dataset.
# Authors: Yang Lei, Indira Mishra, Benny Rochwerg, and Peiqing Yu
# Date: April 6, 2026
# Pre-requisites: Running of the files titled "00_load_packages.R",
# "01_num_hospitals_by_trauma.R", "02_process_trauma.R",
# "03_num_hospitals_by_emslevel.R", "04_process_emslevel.R",
# "05_num_hospitals_by_county.R", "06_process_county.R",
# "07_finish_processing_data.R", and "08_figure_diverthours_by_year.R".

#### Store Complete Cases Percentage ####

# Load dataset
ambulance <-
  readRDS(
    here::here(
      "data/processed/ambulance.rds"
    )
  )

# Calculate percentage of complete cases
complete_cases_percentage <- ambulance %>%
  group_by(id) %>%
  summarize(nobs = n_distinct(year)) %>%
  summarize(total_hospitals = n(),
            complete_cases = sum(nobs == 3),
            complete_cases_percentage =
              (complete_cases / total_hospitals) * 100
  ) %>%
  select(complete_cases_percentage)

complete_cases_percentage <- complete_cases_percentage[[1]]

# Store percentage of complete cases
saveRDS(complete_cases_percentage,
        "values/complete_cases_percentage.rds")