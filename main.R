#### Preamble ####

# Purpose: Run the scripts used in this analysis.
# Authors: Yang Lei, Indira Mishra, Benny Rochwerg, and Peiqing Yu
# Date: April 6, 2026

#### Run Scripts ####

source("scripts/00_load_packages.R")
source("scripts/01_num_hospitals_by_trauma.R")
source("scripts/02_process_trauma.R")
source("scripts/03_num_hospitals_by_emslevel.R")
source("scripts/04_process_emslevel.R")
source("scripts/05_num_hospitals_by_county.R")
source("scripts/06_process_county.R")
source("scripts/07_finish_processing_data.R")
source("scripts/08_figure_diverthours_by_year.R")
source("scripts/09_complete_cases_percentage.R")
source("scripts/10_num_unique_hospitals.R")
source("scripts/11_littles_mcar_test.R")
source("scripts/12_missing_data_heatmap.R")
source("scripts/13_diverthours_histogram.R")
source("scripts/14_overdispersion_check_tibble.R")
source("scripts/15_time_varying_covariates_check_tibble.R")
source("scripts/16_diverthours_trajectory_by_trauma.R")
source("scripts/17_analysis_of_response_profile_trauma.R")
source("scripts/18_diverthours_trajectory_by_emslevel.R")
source("scripts/19_analysis_of_response_profile_emslevel.R")
source("scripts/20_diverthours_trajectory_by_region.R")
source("scripts/21_fitting_model_using_gee.R")
source("scripts/22_descriptive_statistics_table.R")
source("scripts/23_model_results_table.R")
source("scripts/24_save_alpha_and_phi.R")