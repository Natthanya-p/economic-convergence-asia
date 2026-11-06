library(tidyverse)
library(ggrepel)

# Load the cleaned GDP per capita dataset
gdp <- read_csv("Data/gdp_per_capita_clean.csv")

# Plot GDP per capita over time for each economy
gdp_levels_plot <- ggplot(
  gdp,
  aes(
    x = year,
    y = gdp_per_capita,
    color = country
  )
) +
  geom_line(linewidth = 1) +
  labs(
    title = "GDP per Capita in East and Southeast Asia",
    subtitle = "1990–2025",
    x = "Year",
    y = "GDP per Capita (constant 2021 international $)",
    color = "Economy"
  ) +
  theme_minimal()

gdp_levels_plot

# Save the figure
ggsave(
  "Figures/gdp_per_capita_levels.png",
  plot = gdp_levels_plot,
  width = 10,
  height = 6,
  dpi = 300
)

# Index GDP per capita to 1990 = 100 for each economy
gdp_indexed <- gdp %>%
  group_by(country) %>%
  mutate(
    gdp_index = 100 * gdp_per_capita / first(gdp_per_capita)
  ) %>%
  ungroup()

gdp_indexed %>%
  filter(year == 1990) %>%
  select(country, year, gdp_index)

# Plot GDP per capita relative to each economy's 1990 level
gdp_index_plot <- ggplot(
  gdp_indexed,
  aes(
    x = year,
    y = gdp_index,
    color = country
  )
) +
  geom_line(linewidth = 1) +
  labs(
    title = "GDP per Capita Growth Since 1990",
    subtitle = "1990 = 100 for each economy",
    x = "Year",
    y = "GDP per Capita Index (1990 = 100)",
    color = "Economy"
  ) +
  theme_minimal()

gdp_index_plot

# Save the indexed GDP per capita figure
ggsave(
  "Figures/gdp_per_capita_index.png",
  plot = gdp_index_plot,
  width = 10,
  height = 6,
  dpi = 300
)

# Plot initial GDP per capita against subsequent economic growth
convergence_plot <- ggplot(
  convergence_data,
  aes(
    x = log(initial_gdp),
    y = avg_annual_growth
  )
) +
  geom_point(size = 3) +
  geom_smooth(
    method = "lm",
    se = FALSE
  ) +
  geom_text_repel(
    aes(label = country),
    size = 3.5
  ) +
  labs(
    title = "Initial Income and Subsequent Economic Growth",
    subtitle = "East and Southeast Asian economies, 1990–2025",
    x = "Log GDP per Capita in 1990",
    y = "Average Annual GDP per Capita Growth (%)"
  ) +
  theme_minimal()

convergence_plot

# Save the convergence scatterplot
ggsave(
  "Figures/convergence_scatterplot.png",
  plot = convergence_plot,
  width = 10,
  height = 6,
  dpi = 300
)
