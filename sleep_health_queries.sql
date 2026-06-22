-- Kristen's SQL Summer Project
-- data analysis on sleep health

--  NOTE: the general basis of comparison should be the quality of sleep.
-- presence of sleep disorders can be a supporting outcome variable since both are measures of sleep health,
-- and sleep disorders have a close relationship to sleep health and quality. 

-- SECTION 1: EXPLORATION OF VARIABLES
-- total number of responses
SELECT COUNT(*) AS Entries FROM Sleep_health_and_lifestyle_dataset

-- quantitative variables
-- NOTE: utilise this to decide cutoffs for binning
-- 1. age (MIN: 27, MAX: 59, AVG: 42)
SELECT MIN(Age), MAX(Age), ROUND(AVG(Age), 0)
FROM Sleep_health_and_lifestyle_dataset

-- 2. sleep duration (MIN: 5.8, MAX: 8.5, AVG: 7.1)
SELECT MIN("Sleep Duration"), MAX("Sleep Duration"), ROUND(AVG("Sleep Duration"), 1) 
FROM Sleep_health_and_lifestyle_dataset

-- 3. physical activity level (MIN: 30, MAX: 90, AVG: 59)
SELECT MIN("Physical Activity Level"), MAX("Physical Activity Level"), ROUND(AVG("Physical Activity Level"), 0) 
FROM Sleep_health_and_lifestyle_dataset

-- 4. heart rate (MIN: 65, MAX: 86, AVG: 70)
SELECT MIN("Heart Rate"), MAX("Heart Rate"), ROUND(AVG("Heart Rate"), 0) 
FROM Sleep_health_and_lifestyle_dataset

-- 5. daily steps (MIN: 3000, MAX: 10000, AVG: 6817)
SELECT MIN("Daily Steps"), MAX("Daily Steps"), ROUND(AVG("Daily Steps"), 0) 
FROM Sleep_health_and_lifestyle_dataset

-- 6. sleep quality (MIN: 4, MAX: 9, AVG: 7)
SELECT MIN("Quality of Sleep"), MAX("Quality of Sleep"), ROUND(AVG("Quality of Sleep"), 0) 
FROM Sleep_health_and_lifestyle_dataset


SELECT Occupation, COUNT(*) FROM Sleep_health_and_lifestyle_dataset GROUP BY Occupation

-- SECTION 2: QUALITY CHECKS
-- NOTE: presence of two observations with identical attributes but diff. person ID
SELECT DISTINCT * FROM Sleep_health_and_lifestyle_dataset WHERE Occupation = "Sales Representative"
-- can include in README to say something like:
-- "Duplicate checks revealed no exact duplicate records. Some responses shared identical attribute values but had unique Person IDs,
-- so they were retained as separate individuals."

-- ALSO TO NOTE: BMI categories in dataset are inconsistent with those stated in the Kaggle description.
SELECT DISTINCT "BMI Category" FROM Sleep_health_and_lifestyle_dataset
-- instead of changing the values, can document in README: 
-- "The dataset description references an 'Underweight' category. However, the downloaded dataset contains th categories 'Normal', 'Normal Weight',
-- 'Overweight' and 'Obese', with no underweight observations. As the original BMI values are unavailable, the intended categorisation cannot be verified.
-- Hence, the analysis will use the categories as provided in the dataset."


-- SECTION 3: MAIN QUERIES
-- PART I: SLEEP QUALITY (primary outcome)
-- sleep quality as categorical
SELECT "Quality of Sleep",
COUNT(*) AS People,
ROUND(COUNT(*) * 100.0/SUM(COUNT(*)) OVER(), 2) AS Percentage
FROM Sleep_health_and_lifestyle_dataset
GROUP BY "Quality of Sleep"

-- categorical variables
-- average sleep quality by gender.
SELECT Gender, ROUND(AVG("Quality of Sleep"), 1) AS "Average Sleep Quality" 
FROM Sleep_health_and_lifestyle_dataset 
GROUP BY Gender
ORDER BY "Average Sleep Quality" DESC

-- average sleep quality by occupation
SELECT Occupation, ROUND(AVG("Quality of Sleep"), 1) AS "Average Sleep Quality" 
FROM Sleep_health_and_lifestyle_dataset 
GROUP BY Occupation
ORDER BY "Average Sleep Quality" DESC

-- average sleep quality by BMI Category *important insight
SELECT "BMI Category", ROUND(AVG("Quality of Sleep"), 1) AS "Average Sleep Quality" 
FROM Sleep_health_and_lifestyle_dataset 
GROUP BY "BMI Category"
ORDER BY "Average Sleep Quality" DESC

-- average sleep quality by stress level
SELECT "Stress Level", ROUND(AVG("Quality of Sleep"), 1) AS "Average Sleep Quality"
FROM Sleep_health_and_lifestyle_dataset 
GROUP BY "Stress Level"
ORDER BY "Average Sleep Quality" DESC

-- quantitative variables (binning)
-- NOTE: SQL does not recognise chained comparisons
-- average sleep quality by age 
-- do ORDER BY "Average Sleep Quality" DESC if necessary

-- average sleep quality by age
SELECT
CASE 
	WHEN Age BETWEEN 20 AND 30 THEN "20–30"
	WHEN Age BETWEEN 31 AND 40 THEN "31–40"
	WHEN Age BETWEEN 41 AND 50 THEN "41–50"
	WHEN Age BETWEEN 51 AND 60 THEN "51–60"
END AS "Age range",
ROUND(AVG("Quality of Sleep"), 1) AS "Average Sleep Quality"
FROM Sleep_health_and_lifestyle_dataset
GROUP BY "Age range"

-- average sleep quality by sleep duration
SELECT
CASE
	WHEN "Sleep Duration" BETWEEN 5 AND 6 THEN "5–6 hours"
	WHEN "Sleep Duration" BETWEEN 6.1 AND 7 THEN "6.1–7 hours"
	WHEN "Sleep Duration" BETWEEN 7.1 AND 8 THEN "7.1–8 hours"
	WHEN "Sleep Duration" BETWEEN 8.1 AND 9 THEN "8.1–9 hours"
END AS "Sleep duration range",
ROUND(AVG("Quality of Sleep"), 1) AS "Average Sleep Quality"
FROM Sleep_health_and_lifestyle_dataset
GROUP BY "Sleep duration range"
	
-- average sleep quality by physical activity level
SELECT 
CASE
	WHEN "Physical Activity Level" BETWEEN 30 AND 40 THEN "30–40"
	WHEN "Physical Activity Level" BETWEEN 41 AND 50 THEN "41–50"
	WHEN "Physical Activity Level" BETWEEN 51 AND 60 THEN "51–60"
	WHEN "Physical Activity Level" BETWEEN 61 AND 70 THEN "61–70"
	WHEN "Physical Activity Level" BETWEEN 71 AND 80 THEN "71–80"
	WHEN "Physical Activity Level" BETWEEN 81 AND 90 THEN "81–90"
END AS "Physical activity level range",
ROUND(AVG("Quality of Sleep"), 1) AS "Average Sleep Quality"
FROM Sleep_health_and_lifestyle_dataset
GROUP BY "Physical activity level range"

-- average sleep quality by heart rate
SELECT 
CASE
	WHEN "Heart Rate" BETWEEN 60 AND 70 THEN "60–70"
	WHEN "Heart Rate" BETWEEN 71 AND 80 THEN "71–80"
	WHEN "Heart Rate" BETWEEN 81 AND 90 THEN "81–90"
END AS "Heart rate range",
ROUND(AVG("Quality of Sleep"), 1) AS "Average Sleep Quality"
FROM Sleep_health_and_lifestyle_dataset
GROUP BY "Heart rate range"

-- average sleep quality by daily steps
SELECT 
CASE
	WHEN "Daily Steps" BETWEEN 3000 AND 4000 THEN "3000–4000"
	WHEN "Daily Steps" BETWEEN 4100 AND 5000 THEN "4100–5000"
	WHEN "Daily Steps" BETWEEN 5100 AND 6000 THEN "5100–6000"
	WHEN "Daily Steps" BETWEEN 6100 AND 7000 THEN "6100–7000"
	WHEN "Daily Steps" BETWEEN 7100 AND 8000 THEN "7100–8000"
	WHEN "Daily Steps" BETWEEN 8100 AND 9000 THEN "8100–9000"
	WHEN "Daily Steps" BETWEEN 9100 AND 10000 THEN "9100–10000"
END AS "Daily step range",
ROUND(AVG("Quality of Sleep"), 1) AS "Average Sleep Quality"
FROM Sleep_health_and_lifestyle_dataset
GROUP BY "Daily step range"


-- PART II: SLEEP DISORDERS (categorical) (supporting outcome)
-- this part was done by putting each sleep disorder as a separate column instead of row (which I initially did and found the result quite lengthy)
-- conditional aggregation

-- IMPORTANT: OVER() takes all grouped counts and sums them across the entire set. 
-- OVER() only applies to SUM(COUNT(*)) i.e. aggregate functions
-- multiply by 100.0 to prevent truncation of decimals.
SELECT "Sleep Disorder", COUNT(*) AS People, ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS Percentage
FROM Sleep_health_and_lifestyle_dataset
GROUP BY "Sleep Disorder"

-- categorical variables (BMI category, stress level)
-- prevalence of sleep disorder by BMI category
SELECT "BMI Category",
	ROUND(100.0 * SUM(CASE WHEN "Sleep Disorder" = "None" THEN 1 ELSE 0 END) / COUNT(*), 1) AS "None %",
	ROUND(100.0 * SUM(CASE WHEN "Sleep Disorder" = "Insomnia" THEN 1 ELSE 0 END) / COUNT(*), 1) AS "Insomnia %",
	ROUND(100.0 * SUM(CASE WHEN "Sleep Disorder" = "Sleep Apnea" THEN 1 ELSE 0 END) / COUNT(*), 1) AS "Sleep Apnea %"
FROM Sleep_health_and_lifestyle_dataset
GROUP BY "BMI Category"

-- prevalence of sleep disorder by stress level
SELECT "Stress Level",
	ROUND(100.0 * SUM(CASE WHEN "Sleep Disorder" = "None" THEN 1 ELSE 0 END) / COUNT(*), 1) AS "None %",
	ROUND(100.0 * SUM(CASE WHEN "Sleep Disorder" = "Insomnia" THEN 1 ELSE 0 END) / COUNT(*), 1) AS "Insomnia %",
	ROUND(100.0 * SUM(CASE WHEN "Sleep Disorder" = "Sleep Apnea" THEN 1 ELSE 0 END) / COUNT(*), 1) AS "Sleep Apnea %"
FROM Sleep_health_and_lifestyle_dataset
GROUP BY "Stress Level"

-- quantitative variables
-- IMPORTANT: CTEs were used in defining groups for quantitative variables.
-- prevalence of sleep disorder by age 
WITH age_ranges AS (
	SELECT *,
	CASE 
		WHEN Age BETWEEN 20 AND 30 THEN "20–30"
		WHEN Age BETWEEN 31 AND 40 THEN "31–40"
		WHEN Age BETWEEN 41 AND 50 THEN "41–50"
		WHEN Age BETWEEN 51 AND 60 THEN "51–60"
	END AS "Age range"
	FROM Sleep_health_and_lifestyle_dataset
)
SELECT "Age range", 
	ROUND(100.0 * SUM(CASE WHEN "Sleep Disorder" = "None" THEN 1 ELSE 0 END) / COUNT(*), 1) AS "None %",
	ROUND(100.0 * SUM(CASE WHEN "Sleep Disorder" = "Insomnia" THEN 1 ELSE 0 END) / COUNT(*), 1) AS "Insomnia %",
	ROUND(100.0 * SUM(CASE WHEN "Sleep Disorder" = "Sleep Apnea" THEN 1 ELSE 0 END) / COUNT(*), 1) AS "Sleep Apnea %"
FROM age_ranges
GROUP BY "Age range"

-- prevalence of sleep disorder by sleep duration
WITH sleep_durations AS (
	SELECT *,
	CASE
		WHEN "Sleep Duration" BETWEEN 5 AND 6 THEN "5–6 hours"
		WHEN "Sleep Duration" BETWEEN 6.1 AND 7 THEN "6.1–7 hours"
		WHEN "Sleep Duration" BETWEEN 7.1 AND 8 THEN "7.1–8 hours"
		WHEN "Sleep Duration" BETWEEN 8.1 AND 9 THEN "8.1–9 hours"
	END AS "Sleep duration range"
	FROM Sleep_health_and_lifestyle_dataset
)
SELECT "Sleep duration range", 
	ROUND(100.0 * SUM(CASE WHEN "Sleep Disorder" = "None" THEN 1 ELSE 0 END) / COUNT(*), 1) AS "None %",
	ROUND(100.0 * SUM(CASE WHEN "Sleep Disorder" = "Insomnia" THEN 1 ELSE 0 END) / COUNT(*), 1) AS "Insomnia %",
	ROUND(100.0 * SUM(CASE WHEN "Sleep Disorder" = "Sleep Apnea" THEN 1 ELSE 0 END) / COUNT(*), 1) AS "Sleep Apnea %"
FROM sleep_durations
GROUP BY "Sleep duration range"

-- prevalence of sleep disorder by physical activity level
WITH pal_groups AS (
	SELECT *,
	CASE
		WHEN "Physical Activity Level" BETWEEN 30 AND 40 THEN "30–40"
		WHEN "Physical Activity Level" BETWEEN 41 AND 50 THEN "41–50"
		WHEN "Physical Activity Level" BETWEEN 51 AND 60 THEN "51–60"
		WHEN "Physical Activity Level" BETWEEN 61 AND 70 THEN "61–70"
		WHEN "Physical Activity Level" BETWEEN 71 AND 80 THEN "71–80"
		WHEN "Physical Activity Level" BETWEEN 81 AND 90 THEN "81–90"
	END AS "Physical activity level range"
	FROM Sleep_health_and_lifestyle_dataset
)
SELECT "Physical activity level range", 
	ROUND(100.0 * SUM(CASE WHEN "Sleep Disorder" = "None" THEN 1 ELSE 0 END) / COUNT(*), 1) AS "None %",
	ROUND(100.0 * SUM(CASE WHEN "Sleep Disorder" = "Insomnia" THEN 1 ELSE 0 END) / COUNT(*), 1) AS "Insomnia %",
	ROUND(100.0 * SUM(CASE WHEN "Sleep Disorder" = "Sleep Apnea" THEN 1 ELSE 0 END) / COUNT(*), 1) AS "Sleep Apnea %"
FROM pal_groups
GROUP BY "Physical activity level range"

-- combining sleep quality and presence of sleep disorder:
-- average sleep quality by sleep disorder
SELECT "Sleep Disorder", ROUND(AVG("Quality of Sleep"), 2) AS "Average Sleep Quality"
FROM Sleep_health_and_lifestyle_dataset
GROUP BY "Sleep Disorder"
ORDER BY "Average Sleep Quality" DESC
