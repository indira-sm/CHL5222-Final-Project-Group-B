#### Preamble ####

# Purpose: Save a figure displaying the mean trajectory for the
# ambulance diversion hours from 2013 to 2015.
# Authors: Yang Lei, Indira Mishra, Benny Rochwerg, and Peiqing Yu
# Date: April 6, 2026
# Pre-requisites: Running of the files titled "00_load_packages.R",
# "01_num_hospitals_by_trauma.R", "02_process_trauma.R",
# "03_num_hospitals_by_emslevel.R", "04_process_emslevel.R",
# "05_num_hospitals_by_county.R", "06_process_county.R", and
# "07_finish_processing_data.R".

#### Save Figure ####

# Load dataset
ambulance <-
  readRDS(
    here::here(
      "data/processed/ambulance.rds"
    )
  )

# Create figure
mean_year <- ambulance %>%
  group_by(year) %>%
  summarise(mean_div = mean(diverthours, na.rm = TRUE))

figure <- ggplot(mean_year, aes(x = factor(year), y = mean_div, group = 1)) +
  geom_line() +
  geom_point(size = 2) +
  labs(
    title = "Mean ambulance diversion status hours over time",
    x = "Year",
    y = "Mean diversion hours"
  ) +
  theme_classic() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold")
  )

# Save figure
saveRDS(figure,
        "figures/figure_diverthours_by_year.rds")