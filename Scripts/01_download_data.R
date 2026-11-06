library(WDI)

countries <- c(
  "CHN",  # China
  "JPN",  # Japan
  "KOR",  # South Korea
  "SGP",  # Singapore
  "MYS",  # Malaysia
  "THA",  # Thailand
  "IDN",  # Indonesia
  "PHL",  # Philippines
  "VNM"   # Vietnam
)

gdp_data <- WDI(
  country = countries,
  indicator = "NY.GDP.PCAP.PP.KD",
  start = 1990,
  end = 2025
)

View(gdp_data)

dim(gdp_data)

head(gdp_data)

sum(is.na(gdp_data$NY.GDP.PCAP.PP.KD)) #check if any value is missing.

#Saving this in the data folder
write.csv(
  gdp_data,
  "Data/gdp_per_capita_raw.csv",
  row.names = FALSE
)









