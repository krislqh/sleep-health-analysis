# Sleep Health and Lifestyle Analysis

## 1. Project Overview & Background
(context and goals)
(it’s important to establish the importance of sleep health before going into the project as my “why”) 
Sleep is a fundamental component of overall health. (yap abit about effects of neglecting sleep) Examining various factors that can relate to sleep health enables … 

This project explores the relationships between sleep health indicators and various lifestyle and health variables using exploratory data analysis (EDA) in SQL and Tableau Public. 

## 2. Dataset Structure & Quality Checks
(show screenshot of each variable with corresponding data type, mention missing/inconsistent data)

Title: Sleep Health and Lifestyle Dataset (Sourced from Kaggle)

This dataset contains 374 observations as well as details on demographics, sleep metrics, health indicators and sleep disorder status for each observation.
(insert screenshot here)

Data Validation
1. The dataset contains two BMI categories labelled “Normal”/”Normal Weight” despite the dataset description indicating an “Underweight” category. Given that no numerical values for weight, height for BMI were provided, the categories have been preserved to avoid making unsupported assumptions. 
2. Duplicate checks found no repeated Person ID values, indicating that each record represents a unique individual. However, through manual checks, it was found that several observations shared identical attribute values while having different Person IDs. As this is a synthetic dataset created for illustrative purposes, these records were treated as distinct individuals and were retained in the analysis.

## 3. Methodology & Project Workflow
Tools used: SQLite, DB Browser for SQLite, Tableau Public, GitHub

Workflow:
- Browsed Kaggle for viable healthcare datasets
- Prepared GitHub and DB Browser for SQLite
- Wrote SQL queries for data exploration and analysis
- Ran through queries to prioritise Tableau visualisations 
- Interpreted visualisations and documented key findings
- Created and published dashboard on Tableau Public
- Wrote README


## 4. Executive Summary
(overview of findings, dashboard screenshot)

Key findings:
- Individuals with insomnia report lower sleep quality and shorter sleep durations on average compared to those without sleep disorders.
- Sleep quality demonstrated a clear negative relationship with stress levels, where people who have higher stress levels consistently reported poorer sleep quality.
- Higher BMI categories tend to report lower sleep quality.


## 5. Insights Deep Dive
(narrowing down of narrative into key findings)

- Overweight and obese individuals have a substantially higher prevalence of sleep disorders. Additionally, in the Overweight and Obese categories, there is a slightly higher proportion of people with sleep apnea than with insomnia.
- Overweight and Obese individuals with sleep apnea appear to have the highest sleep quality out of other individuals in the same BMI categories. However, given the nature of sleep apnea, it is essential to factor in other health indicators (blood oxygen saturation, time spent in non-REM and REM stages of sleep etc.) to reliably determine sleep quality. 


## 6. Caveats and Assumptions
(sample size, the data has been intentionally fabricated for illustrative purposes so presence of several observations with identical attributes but diff. Person IDs -> it may not accurately reflect actual real-life statistics, correlation does not imply causation)


## 7. Possible Improvements
(choose a larger dataset with more observations/additional sleep metrics)
