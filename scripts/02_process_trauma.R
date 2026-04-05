#### Preamble ####

# Purpose: Save the ambulance dataset after processing the trauma variable.
# Authors: Yang Lei, Indira Mishra, Benny Rochwerg, and Peiqing Yu
# Date: April 6, 2026
# Pre-requisites: Running of the files titled "00_load_packages.R" and
# "01_num_hospitals_by_trauma.R".

#### Process Trauma Variable ####

# Load dataset
ambulance <- read.table(file = here::here("data/raw/ambulance.txt"),
                        header = TRUE)

# Convert trauma variable to a factor with two levels
# (None/Level III, the reference level, and Level II/Level I)
ambulance <- ambulance %>%
  mutate(
    trauma = fct_collapse(as.factor(trauma),
                          "None/Level III" = c("0", "LEVEL III"),
                          "Level II/Level I" = c("LEVEL II", "LEVEL I")
    )
  )

# Add label to trauma variable
label(ambulance$trauma) <- "Trauma center designation"

# Save dataset
saveRDS(ambulance,
        "data/processed/ambulance.rds")