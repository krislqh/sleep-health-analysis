-- File 1: Queries for Exploration, Validation and Quality Checks

-- SECTION 1: EXPLORATION OF VARIABLES
-- IMPORTANT: OVER() takes all grouped counts and sums them across the entire set. 
-- OVER() only applies to SUM(COUNT(*)) i.e. aggregate functions
-- multiply by 100.0 to prevent truncation of decimals.

-- 1.  total number of responses
SELECT COUNT(*) AS Entries FROM Sleep_health_and_lifestyle_dataset;

-- 2. gender distribution
SELECT Gender, COUNT(*) AS People,
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS Percentage
FROM Sleep_health_and_lifestyle_dataset 
GROUP BY Gender;

-- 3. occupation distribution
SELECT Occupation, COUNT(*) AS People,
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS Percentage
FROM Sleep_health_and_lifestyle_dataset 
GROUP BY Occupation
ORDER BY People DESC;

-- 4. sleep quality distribution
SELECT "Quality of Sleep", COUNT(*) AS People,
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS Percentage
FROM Sleep_health_and_lifestyle_dataset
GROUP BY "Quality of Sleep";

-- 5. BMI category distribution
SELECT "BMI Category", COUNT(*) AS People,
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS Percentage
FROM Sleep_health_and_lifestyle_dataset
GROUP BY "BMI Category";
-- NOTE: BMI categories in dataset are inconsistent with those stated in the Kaggle description.
-- to document in README: 
-- "The dataset description references an 'Underweight' category. However, the downloaded dataset contains the categories 'Normal', 'Normal Weight',
-- 'Overweight' and 'Obese', with no underweight observations. As the original BMI values are unavailable, the intended categorisation cannot be verified.
-- Hence, the analysis will use the categories as provided in the dataset."

-- 6. sleep disorder distribution
SELECT "Sleep Disorder", COUNT(*) AS People,
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS Percentage
FROM Sleep_health_and_lifestyle_dataset
GROUP BY "Sleep Disorder";


-- SECTION 2: QUALITY CHECKS

-- Range validation (quantitative variables)
-- this was used to decide cutoffs for binning in Section 3
-- 1. age (MIN: 27, MAX: 59, AVG: 42)
SELECT MIN(Age), MAX(Age), ROUND(AVG(Age), 0)
FROM Sleep_health_and_lifestyle_dataset;

-- 2. sleep duration (MIN: 5.8, MAX: 8.5, AVG: 7.1)
SELECT MIN("Sleep Duration"), MAX("Sleep Duration"), ROUND(AVG("Sleep Duration"), 1) 
FROM Sleep_health_and_lifestyle_dataset;

-- 3. physical activity level (MIN: 30, MAX: 90, AVG: 59)
SELECT MIN("Physical Activity Level"), MAX("Physical Activity Level"), ROUND(AVG("Physical Activity Level"), 0) 
FROM Sleep_health_and_lifestyle_dataset;

-- 4. heart rate (MIN: 65, MAX: 86, AVG: 70)
SELECT MIN("Heart Rate"), MAX("Heart Rate"), ROUND(AVG("Heart Rate"), 0) 
FROM Sleep_health_and_lifestyle_dataset;

-- 5. daily steps (MIN: 3000, MAX: 10000, AVG: 6817)
SELECT MIN("Daily Steps"), MAX("Daily Steps"), ROUND(AVG("Daily Steps"), 0) 
FROM Sleep_health_and_lifestyle_dataset;

-- 6. sleep quality (MIN: 4, MAX: 9, AVG: 7)
SELECT MIN("Quality of Sleep"), MAX("Quality of Sleep"), ROUND(AVG("Quality of Sleep"), 0) 
FROM Sleep_health_and_lifestyle_dataset;

-- Duplicate checks
SELECT "Person ID", COUNT(*)
FROM Sleep_health_and_lifestyle_dataset
GROUP BY "Person ID"
HAVING COUNT(*) > 1;
-- NOTE: presence of two observations with identical attributes but diff. person ID
-- to document in README:
-- "Duplicate checks found no repeated Person ID values, indicating that each record represents a unique individual.
-- However, through manual checks, it was found that several observations shared identical attribute values while having different Person IDs. 
-- Given that this is a synthetic dataset created for illustrative purposes, 
-- these records were treated as distinct individuals and were retained in the analysis."
