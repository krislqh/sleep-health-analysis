--  NOTE: the general basis of comparison should be the quality of sleep.
-- presence of sleep disorders can be a supporting outcome variable since both are measures of sleep health

-- SECTION 1: EXPLORATION OF VARIABLES
-- total number of responses
SELECT COUNT(*) AS Entries FROM Sleep_health_and_lifestyle_dataset

-- quantitative variables
-- NOTE: utilise this to decide cutoffs for binning
-- 1. age
SELECT MIN(Age), MAX(Age), ROUND(AVG(Age), 0) 
FROM Sleep_health_and_lifestyle_dataset

-- 2. sleep duration
SELECT MIN("Sleep Duration"), MAX("Sleep Duration"), ROUND(AVG("Sleep Duration"), 1) 
FROM Sleep_health_and_lifestyle_dataset

-- 3. physical activity level
SELECT MIN("Physical Activity Level"), MAX("Physical Activity Level"), ROUND(AVG("Physical Activity Level"), 0) 
FROM Sleep_health_and_lifestyle_dataset

-- 4. heart rate (not sure if necessary)
SELECT MIN("Heart Rate"), MAX("Heart Rate"), ROUND(AVG("Heart Rate"), 0) 
FROM Sleep_health_and_lifestyle_dataset

-- 5. daily steps
SELECT MIN("Daily Steps"), MAX("Daily Steps"), ROUND(AVG("Daily Steps"), 0) 
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
-- PART I: SLEEP QUALITY (quantitative) (primary outcome)
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

-- PART II: SLEEP DISORDERS (categorical) (supporting outcome)
-- prevalence of sleep disorder by gender.
SELECT Gender, "Sleep Disorder", ROUND(COUNT(*)*100.0 / SUM(COUNT(*)) OVER(PARTITION BY Gender), 2) AS Percentage
FROM Sleep_health_and_lifestyle_dataset 
GROUP BY "Gender", "Sleep Disorder"

-- prevalence of sleep disorder by occupation.
SELECT Occupation, "Sleep Disorder", ROUND(COUNT(*)*100.0 / SUM(COUNT(*)) OVER(PARTITION BY Occupation), 2) AS Percentage
FROM Sleep_health_and_lifestyle_dataset
GROUP BY "Occupation", "Sleep Disorder"

-- prevalence of sleep disorder by BMI category.
SELECT "BMI Category", "Sleep Disorder", ROUND(COUNT(*)*100.0 / SUM(COUNT(*)) OVER(PARTITION BY "BMI Category"), 2) AS Percentage
FROM Sleep_health_and_lifestyle_dataset
GROUP BY "BMI Category", "Sleep Disorder"

-- prevalence of sleep disorder by stress level. (weak to no correlation?)
SELECT "Stress Level", "Sleep Disorder", ROUND(COUNT(*)*100.0 / SUM(COUNT(*)) OVER(PARTITION BY "Stress Level"), 2) AS Percentage
FROM Sleep_health_and_lifestyle_dataset
GROUP BY "Stress Level", "Sleep Disorder"

-- IMPORTANT: OVER() takes all grouped counts and sums them across the entire set. 
-- OVER() only applies to SUM(COUNT(*)) i.e. aggregate functions
-- divide by 100.0 to prevent trunctation of decimals.
SELECT "Sleep Disorder", ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS Percentage
FROM Sleep_health_and_lifestyle_dataset
GROUP BY "Sleep Disorder"

-- combining sleep quality and presence of sleep disorder:
-- average sleep quality by sleep disorder
SELECT "Sleep Disorder", ROUND(AVG("Quality of Sleep"), 2) AS "Average Sleep Quality"
FROM Sleep_health_and_lifestyle_dataset
GROUP BY "Sleep Disorder"
ORDER BY "Average Sleep Quality" DESC