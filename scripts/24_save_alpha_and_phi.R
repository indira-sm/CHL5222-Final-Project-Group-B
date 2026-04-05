#### Preamble ####

# Purpose: Save values of the estimated correlation parameter (alpha), the
# standard error of alpha, and the estimated scale parameter (phi)
# from the model fitted using GEE.
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
# "15_time_varying_covariates_check_tibble.R",
# "16_diverthours_trajectory_by_trauma.R",
# "17_analysis_of_response_profile_trauma.R",
# "18_diverthours_trajectory_by_emslevel.R",
# "19_analysis_of_response_profile_emslevel.R",
# "20_diverthours_trajectory_by_region.R", "21_fitting_model_using_gee.R",
# "22_descriptive_statistics_table.R", and "23_model_results_table.R".

#### Save Values ####

# Load fitted model
model <-
  readRDS(
    here::here(
      "models/gee/model.rds"
    )
  )

# Obtain values
alpha <- summary(model)$corr[, 1]
alpha_se <- summary(model)$corr[, 2]
phi <- summary(model)$dispersion[, 1]

# Save values
saveRDS(alpha,
        "values/alpha.rds")
saveRDS(alpha_se,
        "values/alpha_se.rds")
saveRDS(phi,
        "values/phi.rds")