#This file produces the figures available in the final manuscript

# Loading packages
library(dplyr)
library(ggplot2)

#read data
ambulance <- read.csv("ambulance_final_data.csv", header = TRUE)

# Figure 1
mean_year <- ambulance %>%
  group_by(year) %>%
  summarise(mean_div = mean(diverthours, na.rm = TRUE))

ggplot(mean_year, aes(x = factor(year), y = mean_div, group = 1)) +
  geom_line(size = 1.1, colour = "#2C3E50") +
  geom_point(size = 3, colour = "#2C3E50") +
  labs(
    title = "Mean Ambulance Diversion Hours Over Time",
    x = "Year",
    y = "Mean Diversion Hours"
  ) +
  theme_classic(base_size = 13) +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold")
  )

# Figure 2
mean_ems <- ambulance %>%
  group_by(year, emslevel) %>%
  summarise(mean_div = mean(diverthours, na.rm = TRUE), .groups = "drop")

ggplot(mean_ems, aes(x = factor(year), y = mean_div, colour = emslevel, group = emslevel)) +
  geom_line(size = 1.1) +
  geom_point(size = 2.5) +
  labs(
    title = "Mean Diversion Hours by EMS Level",
    x = "Year",
    y = "Mean Diversion Hours",
    colour = "EMS Level"
  ) +
  theme_classic(base_size = 13) +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    legend.position = "right"
  )

# Figure 3
mean_region <- ambulance %>%
  group_by(year, region) %>%
  summarise(mean_div = mean(diverthours, na.rm = TRUE), .groups = "drop")

ggplot(mean_region, aes(x = factor(year), y = mean_div, colour = region, group = region)) +
  geom_line(size = 1) +
  geom_point(size = 2) +
  labs(
    title = "Mean Diversion Hours by Region",
    x = "Year",
    y = "Mean Diversion Hours",
    colour = "Region"
  ) +
  theme_classic(base_size = 13) +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    legend.position = "right"
  )
