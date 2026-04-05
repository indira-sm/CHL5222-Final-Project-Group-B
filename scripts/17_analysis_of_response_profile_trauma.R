#### Preamble ####

# Purpose: Save results of an analysis of response profile model for
# trauma.
# Authors: Yang Lei, Indira Mishra, Benny Rochwerg, and Peiqing Yu
# Date: April 6, 2026
# Pre-requisites: Running of the files titled "00_load_packages.R",
# "01_num_hospitals_by_trauma.R", "02_process_trauma.R",
# "03_num_hospitals_by_emslevel.R", "04_process_emslevel.R",
# "05_num_hospitals_by_county.R", "06_process_county.R",
# "07_finish_processing_data.R", "08_figure_diverthours_by_year.R",
# "09_complete_cases_percentage.R", "10_num_unique_hospitals.R",
# "11_littles_mcar_test.R", "12_missing_data_heatmap.R",
# "13_diverthours_histogram.R", "14_overdispersion_check_tibble.R",
# "15_time_varying_covariates_check_tibble.R", and
# "16_diverthours_trajectory_by_trauma.R".

#### Save Results ####

# Load dataset
ambulance <-
  readRDS(
    here::here(
      "data/processed/ambulance.rds"
    )
  )

# Fit model
model <- gls(diverthours ~ trauma * year,
             corr = corSymm(form = ~ time | id),
             weights = varIdent(form = ~ 1 | year),
             method = "REML",
             data = ambulance)

# Obtain results
results <- Anova(model)

# Save results
saveRDS(results,
        "models/analysis_of_response_profile/trauma.rds")

# trauma:year p-value > 0.05 so we do not have sufficient evidence to conclude
# that the patterns of change differ between the groups and thus a
# trauma:year interaction term was not included in the model fitted using GEE