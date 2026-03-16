library(tidyverse)
library(geepack)

# Load data
ambulance <- read.csv("ambulance.txt", sep="")


# Refactor categorical variables with descriptive labels
ambulance_data <- ambulance %>%
  mutate(
    ems_f = factor(emslevel, levels = 1:3, labels = c("Standby", "Basic", "Comprehensive")),
    # Center the year variable to avoid collinearity
    year_c = year - 2014
  )

# Data Check and Descriptive Statistics - Analyze outcome distribution (diverthours) 
# Check overdispersion (Variance vs Mean)
ambulance_data %>%
  group_by(year) %>%
  summarise(mean_hours = mean(diverthours), var_hours = var(diverthours))
# Note: Given the increasing mean and variance, we should use a GLMM model with random slopes 
# or a Marginal GEE model with an overdispersion factor
# variance substantially greater than mean-overdispersion factor for Poisson model


# Count observations per hospital to check for unbalanced data
ambulance_data %>%
  group_by(id) %>%
  summarise(nobs = n()) %>%
  count(nobs)
# Note: we have extensive missing - only 119 hospitals have all values for 3 years
# This might be related to overcrowding.


# Data Transformation and Plotting

# Individual spaghetti plot for a subset of hospitals
ggplot(ambulance_data, aes(x = year, y = diverthours, group = id)) +
  geom_line(alpha = 0.3) +
  labs(title = "Individual Hospital Diversion Trajectories")
# Note: natural heterogeneity in individual trajectories - can't be captured by fixed effects alone
# Highly skewed diverthours - use log transformation or loglink in GLMM
# The "partial lines"(unbalanced missing) suggest the use of mixed effect model

# Mean response profile by Trauma Level
ambulance_data %>%
  group_by(year, trauma) %>%
  summarise(avg_hours = mean(diverthours)) %>%
  ggplot(aes(x = year, y = avg_hours, color = trauma)) +
  geom_point() + geom_line() +
  labs(title = "Mean Diversion Hours by Trauma Designation")
# Note: Level 1 Trauma centers have the highest diversion hours and 
# there is a general increasing trend across different trauma levels


library(lme4)

# Fit a Poisson GLMM with a log link
# Outcome: diverthours (count data)
# Fixed effects: year_c (centered), trauma (categorical), stations
# Random effects: (1 + year_c | id) accounts for both baseline and slope heterogeneity
# nAGQ: Set nAGQ = 1 to allow for random intercepts and slopes

glmm_ambulance <- glmer(diverthours ~ year_c + trauma + stations + (1 + year_c | id), 
                        data = ambulance_data, 
                        family = poisson(link = "log"), 
                        nAGQ = 1, # Laplace approximation is required for multiple random effects
                        control = glmerControl(optimizer = "bobyqa"))
summary(glmm_ambulance)
# Interpretation: statistically significant increasing trend in diversion hours - 
# rate ratio of exp(0.39)-->diversion hours increase by approximately 48% per year
# Compared to reference group (no trauma center), Level I centers have significantly higher log diversion hours
# For every additional station a hospital adds, 1% reduction in diversion
# Baseline variance 3.043 & slope var 0.44 --> substantial subject specific variability





















