-- Kristen's SQL Summer Project
-- data analysis on sleep health

--  NOTE: the general basis of comparison should be the quality of sleep.
-- presence of sleep disorders can be a supporting outcome variable since both are measures of sleep health,
-- and sleep disorders have a close relationship to sleep health and quality.


-- SECTION 1: EXPLORATION OF VARIABLES
-- distribution here (both categorical and quantitative), range in Section 2
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


-- SECTION 3: MAIN QUERIES

-- PART I: SLEEP QUALITY (primary outcome)
-- categorical variables
-- 1. average sleep quality by gender.
SELECT Gender, ROUND(AVG("Quality of Sleep"), 1) AS "Average Sleep Quality" 
FROM Sleep_health_and_lifestyle_dataset 
GROUP BY Gender
ORDER BY "Average Sleep Quality" DESC;

-- 2. average sleep quality by occupation
SELECT Occupation, ROUND(AVG("Quality of Sleep"), 1) AS "Average Sleep Quality" 
FROM Sleep_health_and_lifestyle_dataset 
GROUP BY Occupation
ORDER BY "Average Sleep Quality" DESC;

-- 3. average sleep quality by BMI Category *important insight
SELECT "BMI Category", ROUND(AVG("Quality of Sleep"), 1) AS "Average Sleep Quality" 
FROM Sleep_health_and_lifestyle_dataset 
GROUP BY "BMI Category"
ORDER BY "Average Sleep Quality" DESC;

-- 4. average sleep quality by stress level
SELECT "Stress Level", ROUND(AVG("Quality of Sleep"), 1) AS "Average Sleep Quality"
FROM Sleep_health_and_lifestyle_dataset 
GROUP BY "Stress Level"
ORDER BY "Average Sleep Quality" DESC;

-- quantitative variables (binning)
-- 5. average sleep quality by age
SELECT
CASE 
	WHEN Age <= 30 THEN "20–30"
	WHEN Age <= 40 THEN "31–40"
	WHEN Age <= 50 THEN "41–50"
	WHEN Age <= 60 THEN "51–60"
END AS "Age range",
ROUND(AVG("Quality of Sleep"), 1) AS "Average Sleep Quality"
FROM Sleep_health_and_lifestyle_dataset
GROUP BY "Age range"
ORDER BY "Age range";

-- 6. average sleep quality by sleep duration
SELECT
CASE
	WHEN "Sleep Duration" <= 6 THEN "5–6 hours"
	WHEN "Sleep Duration" <= 7 THEN "6.1–7 hours"
	WHEN "Sleep Duration" <= 8 THEN "7.1–8 hours"
	WHEN "Sleep Duration" <= 9 THEN "8.1–9 hours"
END AS "Sleep duration range",
ROUND(AVG("Quality of Sleep"), 1) AS "Average Sleep Quality"
FROM Sleep_health_and_lifestyle_dataset
GROUP BY "Sleep duration range";
	
-- 7. average sleep quality by physical activity level
SELECT 
CASE
	WHEN "Physical Activity Level" <= 40 THEN "30–40"
	WHEN "Physical Activity Level" <= 50 THEN "41–50"
	WHEN "Physical Activity Level" <= 60 THEN "51–60"
	WHEN "Physical Activity Level" <= 70 THEN "61–70"
	WHEN "Physical Activity Level" <= 80 THEN "71–80"
	WHEN "Physical Activity Level" <= 90 THEN "81–90"
END AS "Physical activity level range",
ROUND(AVG("Quality of Sleep"), 1) AS "Average Sleep Quality"
FROM Sleep_health_and_lifestyle_dataset
GROUP BY "Physical activity level range";

-- 8. average sleep quality by heart rate
SELECT 
CASE
	WHEN "Heart Rate" <= 70 THEN "60–70"
	WHEN "Heart Rate" <= 80 THEN "71–80"
	WHEN "Heart Rate" <= 90 THEN "81–90"
END AS "Heart rate range",
ROUND(AVG("Quality of Sleep"), 1) AS "Average Sleep Quality"
FROM Sleep_health_and_lifestyle_dataset
GROUP BY "Heart rate range";

-- 9. average sleep quality by daily steps
SELECT 
CASE
	WHEN "Daily Steps" <= 4000 THEN "3000–4000"
	WHEN "Daily Steps" <= 5000 THEN "4100–5000"
	WHEN "Daily Steps" <= 6000 THEN "5100–6000"
	WHEN "Daily Steps" <= 7000 THEN "6100–7000"
	WHEN "Daily Steps" <= 8000 THEN "7100–8000"
	WHEN "Daily Steps" <= 9000 THEN "8100–9000"
	WHEN "Daily Steps" <= 10000 THEN "9100–10000"
END AS "Daily step range",
ROUND(AVG("Quality of Sleep"), 1) AS "Average Sleep Quality"
FROM Sleep_health_and_lifestyle_dataset
GROUP BY "Daily step range";


-- PART II: SLEEP DISORDERS (categorical) (supporting outcome)
-- this part was done by placing each sleep disorder as a separate column instead of row (which I initially did and found the result quite lengthy)
-- conditional aggregation

-- categorical variables (BMI category, stress level)
-- 1. prevalence of sleep disorder by BMI category
SELECT "BMI Category",
	ROUND(100.0 * SUM(CASE WHEN "Sleep Disorder" = 'None' THEN 1 ELSE 0 END) / COUNT(*), 1) AS "None %",
	ROUND(100.0 * SUM(CASE WHEN "Sleep Disorder" = 'Insomnia' THEN 1 ELSE 0 END) / COUNT(*), 1) AS "Insomnia %",
	ROUND(100.0 * SUM(CASE WHEN "Sleep Disorder" = 'Sleep Apnea' THEN 1 ELSE 0 END) / COUNT(*), 1) AS "Sleep Apnea %"
FROM Sleep_health_and_lifestyle_dataset
GROUP BY "BMI Category";

-- 2. prevalence of sleep disorder by stress level
SELECT "Stress Level",
	ROUND(100.0 * SUM(CASE WHEN "Sleep Disorder" = 'None' THEN 1 ELSE 0 END) / COUNT(*), 1) AS "None %",
	ROUND(100.0 * SUM(CASE WHEN "Sleep Disorder" = 'Insomnia' THEN 1 ELSE 0 END) / COUNT(*), 1) AS "Insomnia %",
	ROUND(100.0 * SUM(CASE WHEN "Sleep Disorder" = 'Sleep Apnea' THEN 1 ELSE 0 END) / COUNT(*), 1) AS "Sleep Apnea %"
FROM Sleep_health_and_lifestyle_dataset
GROUP BY "Stress Level";

-- quantitative variables
-- IMPORTANT: CTEs were used in defining groups for quantitative variables.
-- 3. prevalence of sleep disorder by age 
WITH age_ranges AS (
	SELECT *,
	CASE 
		WHEN Age <= 30 THEN "20–30"
		WHEN Age <= 40 THEN "31–40"
		WHEN Age <= 50 THEN "41–50"
		WHEN Age <= 60 THEN "51–60"
	END AS "Age range"
	FROM Sleep_health_and_lifestyle_dataset
)
SELECT "Age range", 
	ROUND(100.0 * SUM(CASE WHEN "Sleep Disorder" = 'None' THEN 1 ELSE 0 END) / COUNT(*), 1) AS "None %",
	ROUND(100.0 * SUM(CASE WHEN "Sleep Disorder" = 'Insomnia' THEN 1 ELSE 0 END) / COUNT(*), 1) AS "Insomnia %",
	ROUND(100.0 * SUM(CASE WHEN "Sleep Disorder" = 'Sleep Apnea' THEN 1 ELSE 0 END) / COUNT(*), 1) AS "Sleep Apnea %"
FROM age_ranges
GROUP BY "Age range";

-- 4. prevalence of sleep disorder by sleep duration
WITH sleep_durations AS (
	SELECT *,
	CASE
		WHEN "Sleep Duration" <= 6 THEN "5–6 hours"
		WHEN "Sleep Duration" <= 7 THEN "6.1–7 hours"
		WHEN "Sleep Duration" <= 8 THEN "7.1–8 hours"
		WHEN "Sleep Duration" <= 9 THEN "8.1–9 hours"
	END AS "Sleep duration range"
	FROM Sleep_health_and_lifestyle_dataset
)
SELECT "Sleep duration range", 
	ROUND(100.0 * SUM(CASE WHEN "Sleep Disorder" = 'None' THEN 1 ELSE 0 END) / COUNT(*), 1) AS "None %",
	ROUND(100.0 * SUM(CASE WHEN "Sleep Disorder" = 'Insomnia' THEN 1 ELSE 0 END) / COUNT(*), 1) AS "Insomnia %",
	ROUND(100.0 * SUM(CASE WHEN "Sleep Disorder" = 'Sleep Apnea' THEN 1 ELSE 0 END) / COUNT(*), 1) AS "Sleep Apnea %"
FROM sleep_durations
GROUP BY "Sleep duration range";

-- 5. prevalence of sleep disorder by physical activity level
WITH pal_groups AS (
	SELECT *,
	CASE
		WHEN "Physical Activity Level" <= 40 THEN "30–40"
		WHEN "Physical Activity Level" <= 50 THEN "41–50"
		WHEN "Physical Activity Level" <= 60 THEN "51–60"
		WHEN "Physical Activity Level" <= 70 THEN "61–70"
		WHEN "Physical Activity Level" <= 80 THEN "71–80"
		WHEN "Physical Activity Level" <= 90 THEN "81–90"
	END AS "Physical activity level range"
	FROM Sleep_health_and_lifestyle_dataset
)
SELECT "Physical activity level range", 
	ROUND(100.0 * SUM(CASE WHEN "Sleep Disorder" = 'None' THEN 1 ELSE 0 END) / COUNT(*), 1) AS "None %",
	ROUND(100.0 * SUM(CASE WHEN "Sleep Disorder" = 'Insomnia' THEN 1 ELSE 0 END) / COUNT(*), 1) AS "Insomnia %",
	ROUND(100.0 * SUM(CASE WHEN "Sleep Disorder" = 'Sleep Apnea' THEN 1 ELSE 0 END) / COUNT(*), 1) AS "Sleep Apnea %"
FROM pal_groups
GROUP BY "Physical activity level range";

-- combining sleep quality and presence of sleep disorder:
-- average sleep quality by sleep disorder
SELECT "Sleep Disorder", ROUND(AVG("Quality of Sleep"), 2) AS "Average Sleep Quality"
FROM Sleep_health_and_lifestyle_dataset
GROUP BY "Sleep Disorder"
ORDER BY "Average Sleep Quality" DESC;
