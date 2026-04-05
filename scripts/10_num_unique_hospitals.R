#### Preamble ####

# Purpose: Store the number of unique hospitals in the dataset.
# Authors: Yang Lei, Indira Mishra, Benny Rochwerg, and Peiqing Yu
# Date: April 6, 2026
# Pre-requisites: Running of the files titled "00_load_packages.R",
# "01_num_hospitals_by_trauma.R", "02_process_trauma.R",
# "03_num_hospitals_by_emslevel.R", "04_process_emslevel.R",
# "05_num_hospitals_by_county.R", "06_process_county.R",
# "07_finish_processing_data.R", "08_figure_diverthours_by_year.R", and
# "09_complete_cases_percentage.R".

#### Store Number of Unique Hospitals ####

# Load dataset
ambulance <-
  readRDS(
    here::here(
      "data/processed/ambulance.rds"
    )
  )

# Calculate number of unique hospitals
num_unique_hospitals <- length(unique(ambulance$id))

# Store number of unique hospitals
saveRDS(num_unique_hospitals,
        "values/num_unique_hospitals.rds")