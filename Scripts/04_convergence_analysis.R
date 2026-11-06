library(tidyverse)

# Load the cleaned GDP per capita dataset
gdp <- read_csv("Data/gdp_per_capita_clean.csv")

# Create one observation per economy for convergence analysis
convergence_data <- gdp %>%
  group_by(country) %>%
  summarise(
    initial_gdp = first(gdp_per_capita),
    final_gdp = last(gdp_per_capita),
    years = last(year) - first(year),
    avg_annual_growth = 100 *
      (log(final_gdp) - log(initial_gdp)) / years
  )

convergence_data

# Estimate absolute beta-convergence
beta_model <- lm(
  avg_annual_growth ~ log(initial_gdp),
  data = convergence_data
)

# Display regression results
summary(beta_model)

# Calculate 95% confidence intervals for the regression coefficients
confint(beta_model)

# Calculate Cook's distance to identify influential observations
cooks_d <- cooks.distance(beta_model)

cooks_d

# Match Cook's distance values to each economy
influence_data <- convergence_data %>%
  mutate(cooks_distance = cooks_d) %>%
  arrange(desc(cooks_distance))

influence_data %>%
  select(country, cooks_distance)

# Sensitivity analysis: re-estimate the model excluding influential economies

beta_no_china <- lm(
  avg_annual_growth ~ log(initial_gdp),
  data = convergence_data %>%
    filter(country != "China")
)

beta_no_singapore <- lm(
  avg_annual_growth ~ log(initial_gdp),
  data = convergence_data %>%
    filter(country != "Singapore")
)

beta_no_both <- lm(
  avg_annual_growth ~ log(initial_gdp),
  data = convergence_data %>%
    filter(!country %in% c("China", "Singapore"))
)

summary(beta_no_china)
summary(beta_no_singapore)
summary(beta_no_both)

# Create a table comparing baseline and sensitivity results
robustness_results <- tibble(
  model = c(
    "Baseline",
    "Excluding China",
    "Excluding Singapore",
    "Excluding China & Singapore"
  ),
  
  beta = c(
    coef(beta_model)[2],
    coef(beta_no_china)[2],
    coef(beta_no_singapore)[2],
    coef(beta_no_both)[2]
  ),
  
  p_value = c(
    summary(beta_model)$coefficients[2, 4],
    summary(beta_no_china)$coefficients[2, 4],
    summary(beta_no_singapore)$coefficients[2, 4],
    summary(beta_no_both)$coefficients[2, 4]
  ),
  
  r_squared = c(
    summary(beta_model)$r.squared,
    summary(beta_no_china)$r.squared,
    summary(beta_no_singapore)$r.squared,
    summary(beta_no_both)$r.squared
  )
)

robustness_results

# Display regression diagnostic plots
par(mfrow = c(2, 2))
plot(beta_model)
par(mfrow = c(1, 1))

# Save robustness results
write_csv(
  robustness_results,
  "Data/robustness_results.csv"
)
