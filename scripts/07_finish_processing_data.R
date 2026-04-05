#### Preamble ####

# Purpose: Finish processing the ambulance dataset and save the processed
# dataset.
# Authors: Yang Lei, Indira Mishra, Benny Rochwerg, and Peiqing Yu
# Date: April 6, 2026
# Pre-requisites: Running of the files titled "00_load_packages.R",
# "01_num_hospitals_by_trauma.R", "02_process_trauma.R",
# "03_num_hospitals_by_emslevel.R", "04_process_emslevel.R",
# "05_num_hospitals_by_county.R", and "06_process_county.R".

#### Finish Processing Dataset ####

# Load dataset
ambulance <-
  readRDS(
    here::here(
      "data/processed/ambulance.rds"
    )
  )

# Add label to stations variable
label(ambulance$stations) <- "Number of stations"

# Add label to diverthours variable
label(ambulance$diverthours) <- "Diversion status hours"

# Add label to admitrate variable
label(ambulance$admitrate) <- "Admission rate"

# Sort data by id and year
ambulance <- ambulance %>%
  arrange(id, year) %>%
  ungroup()

# Add variable time to the dataset representing the measurement occasion
# number for each hospital
ambulance <- ambulance %>%
  group_by(id) %>%
  mutate(time = row_number()) %>%
  ungroup()

# Keep only the relevant variables
ambulance <- ambulance %>%
  select(year,
         id,
         trauma,
         emslevel,
         stations,
         diverthours,
         admitrate,
         region,
         time)

# Save dataset
saveRDS(ambulance,
        "data/processed/ambulance.rds")