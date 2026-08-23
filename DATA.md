# Data Source

This project uses the **Average SAT Scores for NYC Public Schools** dataset from NYC Open Data, accessed through a Kaggle mirror.

**Dataset source:**  
https://www.kaggle.com/datasets/nycopendata/high-schools

The dataset contains school-level information for New York City public high schools, including:

- School name and identifiers
- Borough and location
- Student enrollment
- Number of SAT test takers
- Average SAT Math score
- Average SAT Reading score
- Average SAT Writing score

For the final SAT Math analyses, **375 schools with non-missing SAT Math scores** were retained. :contentReference[oaicite:0]{index=0}

## Reproducing the Analysis

1. Download the dataset from the source above.
2. Save the CSV file in the same folder as `sat_analysis.R`.
3. Rename the file:

   `Average NYC SAT Scores.csv`

4. Run `sat_analysis.R` in R or RStudio.

The R script performs the data cleaning, statistical analyses, and visualizations used in the research project.

## Note

The raw dataset is not stored directly in this repository. This repository contains the analysis code and documentation needed to reproduce the project using the publicly available source data.
