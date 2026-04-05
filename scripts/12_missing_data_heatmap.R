#### Preamble ####

# Purpose: Store a heatmap of the missing data pattern.
# Authors: Yang Lei, Indira Mishra, Benny Rochwerg, and Peiqing Yu
# Date: April 6, 2026
# Pre-requisites: Running of the files titled "00_load_packages.R",
# "01_num_hospitals_by_trauma.R", "02_process_trauma.R",
# "03_num_hospitals_by_emslevel.R", "04_process_emslevel.R",
# "05_num_hospitals_by_county.R", "06_process_county.R",
# "07_finish_processing_data.R", "08_figure_diverthours_by_year.R",
# "09_complete_cases_percentage.R", "10_num_unique_hospitals.R", and
# "11_littles_mcar_test.R".

#### Store Missing Data Heatmap ####

# Load dataset
ambulance <-
  readRDS(
    here::here(
      "data/processed/ambulance.rds"
    )
  )

# Obtain missing data heatmap
missing_data_heatmap <- ambulance %>%
  select(year, id, diverthours) %>%
  pivot_wider(names_from = year,
              names_prefix = "y", # y = diverthours
              values_from = diverthours) %>%
  select(-id) %>%
  md.pattern()

missing_data_heatmap <- recordPlot()

# Save missing data heatmap
saveRDS(missing_data_heatmap,
        "figures/missing_data_heatmap.rds")