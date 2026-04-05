#### Preamble ####

# Purpose: Save a figure displaying the mean trajectory for the
# ambulance diversion hours by EMS level.
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
# "16_diverthours_trajectory_by_trauma.R", and
# "17_analysis_of_response_profile_trauma.R".

#### Save Figure ####

# Load dataset
ambulance <-
  readRDS(
    here::here(
      "data/processed/ambulance.rds"
    )
  )

# Create figure
figure <- ambulance %>%
  ggplot(aes(x = as.factor(year),
             y = diverthours,
             colour = emslevel)) +
  stat_summary(aes(group = emslevel),
               fun = mean,
               geom = "line") +
  stat_summary(aes(group = emslevel),
               fun = mean,
               geom = "point",
               size = 2) +
  labs(
    title =
      "Mean trajectory for the ambulance diversion hours by EMS level",
    x = "Year",
    y = "Mean diversion hours",
    colour = "Level"
  ) +
  theme_classic() +
  theme(plot.title = element_text(size = 11, hjust = 0.5, face = "bold"),
        legend.position = "bottom")

# Save figure
saveRDS(figure,
        "figures/diverthours_trajectory_by_emslevel.rds")