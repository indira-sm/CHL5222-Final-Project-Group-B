#### Preamble ####

# Purpose: Save a tibble containing the number of hospitals by
# trauma center designation.
# Authors: Yang Lei, Indira Mishra, Benny Rochwerg, and Peiqing Yu
# Date: April 6, 2026
# Pre-requisite: Running of the file titled "00_load_packages.R".

#### Store Tibble ####

# Load dataset
ambulance <- read.table(file = here::here("data/raw/ambulance.txt"),
                        header = TRUE)

# Create tibble
num_hospitals_by_trauma <- ambulance %>%
  group_by(trauma) %>%
  summarize(n = n_distinct(id))

# Save tibble
saveRDS(num_hospitals_by_trauma,
        "tibbles/num_hospitals_by_trauma.rds")