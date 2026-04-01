# This File produces the results table (Table 2) in the manuscript

library(dplyr)
library(broom)
library(knitr)
library(kableExtra)

# Helper
make_gee_table_ci <- function(fit, digits = 3,
                              caption = "GEE model results (Rate Ratios)") {
  
  tab <- broom::tidy(fit) %>%
    mutate(
      lower = estimate - 1.96 * std.error,
      upper = estimate + 1.96 * std.error,
      
      estimate = exp(estimate),
      lower = exp(lower),
      upper = exp(upper),
      
      Term = case_when(
        term == "(Intercept)" ~ "Intercept",
        term == "year" ~ "Year",
        term == "stations" ~ "Number of Stations",
        term == "admitrate" ~ "Admission Rate",
        term == "emslevelComprehensive" ~ "EMS Level: Comprehensive (vs Basic/Standby)",
        term == "traumaLevel II/Level I" ~ "Trauma Level III/0 (vs I/II)",
        term == "year:emslevelComprehensive" ~ "Year × EMS Level: Comprehensive",
        grepl("^region", term) ~ paste0("Region: ", gsub("region", "", term)),
        TRUE ~ term
      ),
      
      `Estimate (RR)` = round(estimate, digits),
      SE = round(std.error, digits),
      CI = paste0("(", round(lower, digits), ", ", round(upper, digits), ")"),
      Wald = round(statistic, digits),
      `p-value` = ifelse(p.value < 0.001, "<0.001", sprintf("%.3f", p.value))
    ) %>%
    select(Term, `Estimate (RR)`, SE, CI, Wald, `p-value`)
  
  kable(tab,
        align = c("l", "c", "c", "c", "c", "c"),
        caption = caption,
        booktabs = TRUE,
        linesep = "") %>%
    kable_styling(full_width = FALSE, position = "center")
}

model <- readRDS("gee_fit.rds")
make_gee_table_ci(model)
