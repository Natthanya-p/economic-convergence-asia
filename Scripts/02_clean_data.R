library(tidyverse)

gdp_raw <- read_csv("Data/gdp_per_capita_raw.csv")

gdp_clean <- gdp_raw %>%
  select(-iso2c) %>% #Remove the column iso2c
  rename(gdp_per_capita = NY.GDP.PCAP.PP.KD) %>% #Rename the GDP variables
  arrange(country, year) %>% #Put the years in chronological order
  mutate(log_gdp_per_capita = log(gdp_per_capita)) # Create the natural logarithm of GDP per capita  

head(gdp_clean) # Preview the cleaned dataset

# Creating annual GDP per capita growth rates separately for each country
gdp_clean <- gdp_clean %>%
  group_by(country) %>%
  mutate(
    annual_growth = 100 * (log_gdp_per_capita - lag(log_gdp_per_capita))
  ) %>%
  ungroup()

head(gdp_clean)

sum(is.na(gdp_clean$annual_growth)) # Check that there are 9 missing growth values

summary(gdp_clean) #Displaying summary statistics

range(gdp_clean$year) # Verify that the dataset covers 1990–2025

n_distinct(gdp_clean$country) # Verify that all nine economies are included

# Save the cleaned dataset for use in later analysis
write_csv(gdp_clean, "Data/gdp_per_capita_clean.csv")
