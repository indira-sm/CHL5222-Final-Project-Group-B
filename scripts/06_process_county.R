#### Preamble ####

# Purpose: Save the ambulance dataset after processing the county variable.
# Authors: Yang Lei, Indira Mishra, Benny Rochwerg, and Peiqing Yu
# Date: April 6, 2026
# Pre-requisites: Running of the files titled "00_load_packages.R",
# "01_num_hospitals_by_trauma.R", "02_process_trauma.R",
# "03_num_hospitals_by_emslevel.R", "04_process_emslevel.R", and
# "05_num_hospitals_by_county.R".

#### Process County Variable ####

# Load dataset
ambulance <-
  readRDS(
    here::here(
      "data/processed/ambulance.rds"
    )
  )

# Consolidate counties into regions
region1 <- c("Butte", "Colusa", "El Dorado", "Glenn", "Lassen", "Modoc",
             "Nevada", "Placer", "Plumas", "Sacramento", "Shasta", "Sierra",
             "Siskiyou", "Sutter", "Tehama", "Yolo", "Yuba")

region2 <- c("Del Norte", "Humboldt", "Lake", "Mendocino", "Napa", "Sonoma",
             "Trinity")

region3 <- c("Alameda", "Contra Costa", "Marin", "San Francisco", "San Mateo",
             "Santa Clara", "Solano")

region4 <- c("Alpine", "Amador", "Calaveras", "Madera", "Mariposa", "Merced",
             "Mono", "San Joaquin", "Stanislaus", "Tuolumne")

region5 <- c("Monterey", "San Benito", "San Luis Obispo", "Santa Barbara",
             "Santa Cruz", "Ventura")

region6 <- c("Fresno", "Inyo", "Kern", "Kings", "Tulare")

region7 <- c("Riverside", "San Bernardino")

region8 <- c("Los Angeles")

region9 <- c("Orange")

region10 <- c("Imperial", "San Diego")

ambulance <- ambulance %>%
  mutate(
    region = case_when(
      county %in% region1 ~ 1,
      county %in% region2 ~ 2,
      county %in% region3 ~ 3,
      county %in% region4 ~ 4,
      county %in% region5 ~ 5,
      county %in% region6 ~ 6,
      county %in% region7 ~ 7,
      county %in% region8 ~ 8,
      county %in% region9 ~ 9,
      county %in% region10 ~ 10),
    region = factor(region,
                    levels = c("1",
                               "2",
                               "3",
                               "4",
                               "5",
                               "6",
                               "7",
                               "8",
                               "9",
                               "10"),
                    labels = c("Superior California",
                               "North Coast",
                               "San Francisco Bay Area",
                               "Northern San Joaquin Valley",
                               "Central Coast",
                               "Southern San Joaquin Valley",
                               "Inland Empire",
                               "Los Angeles County",
                               "Orange County",
                               "San Diego - Imperial")))

# Add label to region variable
label(ambulance$region) <- "Region"

# Save dataset
saveRDS(ambulance,
        "data/processed/ambulance.rds")