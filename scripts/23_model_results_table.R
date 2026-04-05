#### Preamble ####

# Purpose: Save a table containing model results.
# Authors: Yang Lei, Indira Mishra, Benny Rochwerg, and Peiqing Yu
# Date: April 6, 2026
# Pre-requisites: Running of the files titled "00_load_packages.R",
# "01_num_hospitals_by_trauma.R", "02_process_trauma.R",
# "03_num_hospitals_by_emslevel.R", "04_process_emslevel.R",
# "05_num_hospitals_by_county.R", "06_process_county.R",
# "07_finish_processing_data.R", "08_figure_diverthours_by_year.R",
# "09_complete_cases_percentage.R", "10_num_unique_hospitals.R",
# "11_littles_mcar_test.R", "12_missing_data_heatmap.R",
# "13_diverthours_histogram.R", "14_overdispersion_check_tibble.R",
# "15_time_varying_covariates_check_tibble.R",
# "16_diverthours_trajectory_by_trauma.R",
# "17_analysis_of_response_profile_trauma.R",
# "18_diverthours_trajectory_by_emslevel.R",
# "19_analysis_of_response_profile_emslevel.R",
# "20_diverthours_trajectory_by_region.R", "21_fitting_model_using_gee.R",
# and "22_descriptive_statistics_table.R".

#### Save Table ####

# Load fitted model
model <-
  readRDS(
    here::here(
      "models/gee/model.rds"
    )
  )

# Create table
make_gee_table_ci <- function(fit, digits = 3) {
  
  tab <- broom::tidy(fit) %>%
    mutate(
      lower = estimate - 1.96 * std.error,
      upper = estimate + 1.96 * std.error,
      lower = exp(lower),
      upper = exp(upper),
      
      Term = case_when(
        term == "(Intercept)" ~ "Intercept",
        term == "year" ~ "Year",
        term == "stations" ~ "Number of stations",
        term == "admitrate" ~ "Admission rate",
        term == "emslevelComprehensive" ~ "EMS level: Comprehensive",
        term == "traumaLevel II/Level I" ~
          "Trauma center designation: Level II/Level I",
        term == "year:emslevelComprehensive" ~
          "Year × EMS level: Comprehensive",
        grepl("^region", term) ~ paste0("Region: ", gsub("region", "", term)),
        TRUE ~ term
      ),
      
      `Coefficient Estimate (SE)` = sprintf(
        "%.*f (%.*f)", digits, estimate, digits, std.error
      ),
      
      `RR Estimate (95% CI)` = sprintf(
        "%.*f (%.*f, %.*f)",
        digits, exp(estimate),
        digits, lower,
        digits, upper
      ),
      
      `p-value` = ifelse(p.value < 0.001, "<0.001", sprintf("%.3f", p.value))
    ) %>%
    select(Term, `Coefficient Estimate (SE)`, `RR Estimate (95% CI)`, `p-value`)
  
  kable(tab,
        format = "latex",
        align = c("l", "c", "c", "c"),
        booktabs = TRUE,
        linesep = "",
        col.names = c("Term",
                      "Coefficient Estimate (SE)",
                      "RR Estimate (95\\% CI)",
                      "\\textit{p}-value"),
        escape = FALSE) %>%
    kable_styling(full_width = FALSE, position = "center",
                  latex_options = c("striped", "scale_down", "hold_position",
                                    "center"),
                  font_size = 11)
}

table <- make_gee_table_ci(model)

# Save table
saveRDS(table,
        "tables/model_results_table.rds")