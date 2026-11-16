Economic Convergence in East and Southeast Asia

Project Overview

This project studies economic convergence in nine East and Southeast Asian economies between 1990 and 2025. GDP per capita data is obtained from the World Bank.

The analysis questions whether economies with lower initial income levels grew faster subsequently, as predicted by the theory of β-convergence.

The project is written in R for data cleaning, visualization, regression analysis and robustness check

## Methodology

- Data on GDP per capita for nine East and Southeast Asian economies were collected from the World Development Indicators (WDI) database maintained by the World Bank.
- The average annual growth rate of GDP per capita from 1990 to 2025 was calculated using logarithmic growth rates.
- Graphs were created to illustrate GDP per capita levels, relative growth, and the relationship between initial income and subsequent growth.
- Ordinary least squares (OLS) regression analysis was used to examine β-convergence.
- Robustness tests were conducted by excluding potentially influential economies.

## Key Results

- The baseline regression analysis produced a negative β coefficient of −1.2363, consistent with β-convergence.
- The relationship was statistically significant at the 5% level (p = 0.0290).
- Initial income explained approximately 51.7% of the variation in average annual growth among the nine economies (R² = 0.5172).
- Robustness tests revealed that the strength and statistical significance of the relationship were sensitive to the exclusion of specific economies, particularly China and Singapore.

In summary, the results provide suggestive evidence of β-convergence but do not establish whether σ-convergence occurred.

## Project Structure

```text
Asia_Eco_Conv/
├── Scripts/
│   ├── 01_download_data.R
│   ├── 02_clean_data.R
│   ├── 03_exploratory_analysis.R
│   └── 04_convergence_analysis.R
├── Data/
│   ├── gdp_per_capita_raw.csv
│   ├── gdp_per_capita_clean.csv
│   └── robustness_results.csv
├── Figures/
│   ├── gdp_per_capita_levels.png
│   ├── gdp_per_capita_index.png
│   └── convergence_scatterplot.png
├── Report/
│   └── economic_convergence_report.html
├── economic_convergence_report.Rmd
└── README.md
```

## Reproducing the Analysis

This project was developed using R and RStudio.

1. Download or clone this GitHub repository.
2. Open `Asia_Eco_Conv.Rproj` in RStudio.
3. Install the required R packages: `WDI`, `tidyverse`, and `ggrepel`.
4. Run the scripts in the `Scripts/` folder in numerical order:
   - `01_download_data.R`
   - `02_clean_data.R`
   - `03_exploratory_analysis.R`
   - `04_convergence_analysis.R`
5. Open `economic_convergence_report.Rmd` to review the analysis and generate the report.

The completed HTML report is available in the `Report/` folder.

## Full Research Report

[View the Full Research Report](https://natthanya-p.github.io/economic-convergence-asia/Report/economic_convergence_report.html)


