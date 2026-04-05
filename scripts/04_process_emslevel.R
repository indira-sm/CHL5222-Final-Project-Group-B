#### Preamble ####

# Purpose: Save the ambulance dataset after processing the emslevel variable.
# Authors: Yang Lei, Indira Mishra, Benny Rochwerg, and Peiqing Yu
# Date: April 6, 2026
# Pre-requisites: Running of the files titled "00_load_packages.R",
# "01_num_hospitals_by_trauma.R", "02_process_trauma.R", and
# "03_num_hospitals_by_emslevel.R".

#### Process EMS Level Variable ####

# Load dataset
ambulance <-
  readRDS(
    here::here(
      "data/processed/ambulance.rds"
    )
  )

# Convert emslevel variable to a factor with two levels
# (Standby/Basic, the reference level, and Comprehensive)
ambulance <- ambulance %>%
  mutate(
    emslevel = fct_collapse(as.factor(emslevel),
                            "Standby/Basic" = c("Standby", "Basic"),
                            "Comprehensive" = c("Comprehensive")
    )
  )

# Add label to emslevel variable
label(ambulance$emslevel) <- "EMS level"

# Save dataset
saveRDS(ambulance,
        "data/processed/ambulance.rds")