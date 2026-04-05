#### Preamble ####

# Purpose: Create a table of descriptive statistics to summarize the
# distribution of the outcome and covariates.
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
# "20_diverthours_trajectory_by_region.R", and "21_fitting_model_using_gee.R".

#### Create Table ####

# This table was created in report.qmd due to formatting issues but the code
# is reproduced here for completeness

# # Load dataset
# ambulance <-
#   readRDS(
#     here::here(
#       "data/processed/ambulance.rds"
#     )
#   )
# 
# # Display table
# table1(~ diverthours + trauma + emslevel + stations + admitrate + region |
#          as.factor(year),
#        data = ambulance) %>%
#   t1kable(format = "latex", booktabs = TRUE) |>
#   kable_styling(latex_options = c("striped", "scale_down", "hold_position",
#                                   "center"),
#                 font_size = 11)