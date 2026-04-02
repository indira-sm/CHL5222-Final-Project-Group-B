# This File produces the results table (Table 2) in the manuscript

library(dplyr)
library(broom)
library(knitr)
library(kableExtra)

make_gee_table_ci <- function(fit, digits = 3,
                              caption = "Results from model fitted using GEE model") {
  
  tab <- broom::tidy(fit) %>%
    mutate(
      lower = estimate - 1.96 * std.error,
      upper = estimate + 1.96 * std.error,
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
      
      `Estimate (SE)` = sprintf(
        "%.*f (%.*f)", digits, estimate, digits, std.error
      ),
      
      `RR (95% CI)` = sprintf(
        "%.*f (%.*f, %.*f)",
        digits, exp(estimate),
        digits, lower,
        digits, upper
      ),
      
      `p-value` = ifelse(p.value < 0.001, "<0.001", sprintf("%.3f", p.value))
    ) %>%
    select(Term, `Estimate (SE)`, `RR (95% CI)`, `p-value`)
  
  kable(tab,
        align = c("l", "c", "c", "c"),
        caption = caption,
        booktabs = TRUE,
        linesep = "") %>%
    kable_styling(full_width = FALSE, position = "center")
}

model <- readRDS("gee_fit.rds")
make_gee_table_ci(model)
