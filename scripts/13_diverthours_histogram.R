#### Preamble ####

# Purpose: Store a histogram of diversion hours (the diverthours variable)
# by year to check that annual diverthours is non-negative and right-skewed.
# Authors: Yang Lei, Indira Mishra, Benny Rochwerg, and Peiqing Yu
# Date: April 6, 2026
# Pre-requisites: Running of the files titled "00_load_packages.R",
# "01_num_hospitals_by_trauma.R", "02_process_trauma.R",
# "03_num_hospitals_by_emslevel.R", "04_process_emslevel.R",
# "05_num_hospitals_by_county.R", "06_process_county.R",
# "07_finish_processing_data.R", "08_figure_diverthours_by_year.R",
# "09_complete_cases_percentage.R", "10_num_unique_hospitals.R",
# "11_littles_mcar_test.R", and "12_missing_data_heatmap.R".

#### Store Histogram ####

# Load dataset
ambulance <-
  readRDS(
    here::here(
      "data/processed/ambulance.rds"
    )
  )

# Obtain histogram
diverthours_histogram <-
  ggplot(ambulance, aes(x = diverthours)) +
  geom_histogram(binwidth = 500,
                 center = 250) +
  facet_wrap(~ year, ncol = 3) +
  labs(
    title = "Histogram of ambulance diversion status hours by year",
    x = "Diversion hours",
    y = "Frequency"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold")
  )

# Save histogram
saveRDS(diverthours_histogram,
        "figures/diverthours_histogram.rds")