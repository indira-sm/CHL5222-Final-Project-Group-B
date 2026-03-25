library(tidyverse)
library(geepack)

# Load data
ambulance <- read.csv("ambulance.txt", sep="")


# Refactor categorical variables with descriptive labels
ambulance_data <- ambulance %>%
  mutate(
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
# variance substantially greater than mean - overdispersion factor for Poisson model


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

# combine county to region
ambulance_data <- ambulance_data %>%
  mutate(
  region = case_when(
    # Bay Area
    county %in% c("Alameda", "Contra Costa", "Marin", "San Francisco", 
                  "San Mateo", "Santa Clara", "Santa Cruz", "Sonoma") ~ "Bay Area",
    
    # Southern California
    county %in% c("Los Angeles", "Orange", "Riverside", "San Bernardino", 
                  "San Diego", "Ventura") ~ "Southern CA",
    
    # Central Valley & Sacramento area
    county %in% c("Kern", "Merced", "Placer", "Sacramento", 
                  "San Joaquin", "Stanislaus", "Inyo") ~ "Central Valley",
    
    # Central Coast
    county %in% c("Monterey", "San Benito", "San Luis Obispo", 
                  "Santa Barbara") ~ "Central Coast",
    
    TRUE ~ "Unknown" # Safety check for missing counties
  ),
  region = factor(region),
  trauma_comb = case_when(
    trauma %in% c("LEVEL I", "LEVEL II") ~ "LEVEL I/II",
    trauma %in% c("LEVEL III", "0") ~ "LEVEL III/NA"
  )
)
table(ambulance_data$region)
table(ambulance_data$trauma_comb)

ambulance_data %>%
  group_by(year, trauma_comb) %>%
  summarise(avg_hours = mean(diverthours)) %>%
  ggplot(aes(x = year, y = avg_hours, color = trauma_comb)) +
  geom_point() + geom_line() +
  labs(title = "Mean Diversion Hours by Grouped Trauma Designation")
# Significant separation between new trauma levels

# Refit the GLMM model
glm_refined <- glmer(diverthours ~ year_c + stations + trauma_comb + 
                           emslevel + region + admitrate + (1 + year_c | id), 
                         data = ambulance_data,
                         family = poisson(link = "log"), 
                         nAGQ = 1, # Laplace approximation is required for multiple random effects
                         control = glmerControl(optimizer = "bobyqa"))

summary(glm_refined)

anova(glmm_ambulance, glm_refined) 
# strongly reject the null hypothesis that the simpler model is adequate


# Extract standardized residuals
rhat <- resid(glm_refined) 

# Create the Normal Q-Q plot
qqnorm(rhat, pch = 1) 
# Add a reference line
qqline(rhat, col = "steelblue", lwd = 2)











# # Model Fitting (GEE - Population Averaged)
# library(geepack)
# 
# # Fit the marginal model with an initial AR1 structure
# gee_model <- geeglm(diverthours ~ year_c + admitrate + stations + ems_f + trauma_f, 
#                     id = id, 
#                     data = ambulance_data, 
#                     family = poisson(link = "log"), 
#                     corstr = "ar1")
# # 5. Variance Pattern and Covariance Selection
# # Compare different working correlation structures using the Quasi-likelihood Information Criterion (QIC)
# 
# # Compare Unstructured, AR1, and Exchangeable
# model_unstr <- update(gee_model, corstr = "unstructured")
# model_exch  <- update(gee_model, corstr = "exchangeable")
# 
# # Select the model with the smallest QIC
# qic_comp <- data.frame(
#   Structure = c("AR1", "Unstructured", "Exchangeable"),
#   QIC = c(QIC(gee_model)["QIC"], QIC(model_unstr)["QIC"], QIC(model_exch)["QIC"])
# )
# print(qic_comp)
# # 6. Model Diagnostics
# # Assess the assumptions of the final model using standardized residuals and checking for normality of random effects (if using a GLMM)
# 
# # 1. Standardized residuals vs Predicted Mean
# # For GLMM (lme4), use resid(model, type = "normalized")
# # For GEE, assess the robust standard errors in the summary
# summary(gee_model)
# 
# # 2. Check for autocorrelation in residuals (Lagged Plot)
# ambulance_data %>%
#   mutate(res = resid(gee_model)) %>%
#   group_by(id) %>%
#   mutate(res_lag = lag(res)) %>%
#   ggplot(aes(x = res_lag, y = res)) +
#   geom_point() +
#   labs(title = "Lagged Residual Plot to Check for Serial Dependence")
# # Key Target of Inference: If you choose the GEE results, your interpretation will focus on population-averaged effects (e.g., the average change in diversion hours for all California hospitals)
# # . If you use glmer for a Mixed Effects model, your focus will be on subject-specific effects for any given hospital
