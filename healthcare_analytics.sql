-- HEALTHCARE PATIENT ANALYTICS
-- ===========================================================
-- DATA PREPARATION
-- ===========================================================
-- Creating table
CREATE TABLE patients (
    Name VARCHAR(100),
    Age INT,
    Gender VARCHAR(10),
    Blood_Type VARCHAR(5),
    Medical_Condition TEXT,
    Date_of_Admission DATE,
    Doctor VARCHAR(100),
    Hospital VARCHAR(100),
    Insurance_Provider VARCHAR(100),
    Billing_Amount DECIMAL(10,2),
    Room_Number VARCHAR(10),
    Admission_Type VARCHAR(50),
    Discharge_Date DATE,
    Medication TEXT,
    Test_Results TEXT
);

-- ===========================================================
-- DATA CLEANING
-- ===========================================================
-- Count of the data
SELECT COUNT(*)
FROM patients;

-- Count of unique records
SELECT COUNT(*) AS count_of_distinct 
FROM (SELECT DISTINCT * FROM patients);

-- Creating a table without duplicates using 'CTAS'
CREATE TABLE patients_clean AS 
SELECT DISTINCT * FROM patients;

-- Dropping uncleaned table
DROP TABLE patients;

-- Changing table name
ALTER TABLE patients_clean RENAME TO patients;

-- Retrieving data
SELECT * 
FROM patients;

-- Formatting case to title case 
UPDATE patients 
SET name = INITCAP(name);

-- ===========================================================
-- IDENTIFY TRENDS IN PATIENT AGE, GENDER, AND MEDICAL CONDITIONS
-- ===========================================================
-- Age group
SELECT 
    CASE
        WHEN age BETWEEN 13 AND 18 THEN 'Teens'
        WHEN age BETWEEN 19 AND 35 THEN 'Young_Adults'
        WHEN age BETWEEN 36 AND 59 THEN 'Mid_Aged_Adults'
        WHEN age BETWEEN 60 AND 89 THEN 'Old'
    END AS Age_Group,
    COUNT(*)
FROM patients
GROUP BY Age_Group
ORDER BY count DESC;

-- Trend in patient's gender
SELECT gender, 
    COUNT(*) 
FROM patients
GROUP BY gender 
ORDER BY gender DESC;

-- Trend in Medical Condition
SELECT medical_condition, 
    COUNT(*) 
FROM patients
GROUP BY medical_condition 
ORDER BY count DESC;

-- ===========================================================
-- MOST COMMON MEDICAL CONDITIONS BY AGE GROUP
-- ===========================================================
SELECT medical_condition,
    CASE
        WHEN age BETWEEN 13 AND 18 THEN 'Teens'
        WHEN age BETWEEN 19 AND 35 THEN 'Young_Adults'
        WHEN age BETWEEN 36 AND 59 THEN 'Mid_Aged_Adults'
        WHEN age BETWEEN 60 AND 89 THEN 'Old'
    END AS Age_Group,
    COUNT(*)
FROM patients
GROUP BY medical_condition, Age_Group
ORDER BY count DESC;

-- ===========================================================
-- PROVIDE LIST AND COUNT OF HOSPITALS WITH MORE THAN ONE PATIENT
-- ===========================================================
-- List
WITH hospital_count AS (
    SELECT HOSPITAL, count(*) AS counts
    FROM patients
    GROUP BY hospital
)
SELECT *
FROM hospital_count
WHERE counts > 1;

-- Count
WITH hospital_count AS (
    SELECT HOSPITAL, count(*) AS counts
    FROM patients
    GROUP BY hospital
)
SELECT COUNT(*)
FROM hospital_count
WHERE counts > 1;

-- Blood Type distribution
SELECT Blood_Type, COUNT(*) AS patient_count
FROM patients
GROUP BY Blood_Type;

-- ===========================================================
-- AVERAGE BILLING AMOUNTS BY MEDICAL CONDITION AND INSURANCE PROVIDER
-- ===========================================================
SELECT medical_condition, insurance_provider,
    ROUND(AVG(billing_amount), 0) AS avg_cost
FROM patients
GROUP BY medical_condition, insurance_provider
ORDER BY avg_cost DESC ;

-- ===========================================================
-- EVALUATE AVERAGE LENGTH OF STAY BASED ON MEDICAL CONDITION AND ADMISSION TYPE
-- ===========================================================
ALTER TABLE patients ADD COLUMN days_of_stay INT;

UPDATE patients
SET days_of_stay = Discharge_Date - Date_of_Admission;

-- Max days of stay
SELECT MAX(days_of_stay)
FROM patients;

-- Length of stay groupings
SELECT 
    CASE 
        WHEN days_of_stay BETWEEN 1 AND 5 THEN '1-5'
        WHEN days_of_stay BETWEEN 6 AND 10 THEN '6-10'
        WHEN days_of_stay BETWEEN 11 AND 15 THEN '11-15'
        WHEN days_of_stay BETWEEN 16 AND 20 THEN '16-20'
        WHEN days_of_stay BETWEEN 21 AND 25 THEN '21-25'
        WHEN days_of_stay BETWEEN 26 AND 30 THEN '26-30'
    END AS group_of_stay,
    COUNT(*)
FROM patients
GROUP BY group_of_stay;

-- Length of stay groupings by medical condition and admission type
SELECT medical_condition, admission_type,
    CASE 
        WHEN days_of_stay BETWEEN 1 AND 5 THEN '1-5'
        WHEN days_of_stay BETWEEN 6 AND 10 THEN '6-10'
        WHEN days_of_stay BETWEEN 11 AND 15 THEN '11-15'
        WHEN days_of_stay BETWEEN 16 AND 20 THEN '16-20'
        WHEN days_of_stay BETWEEN 21 AND 25 THEN '21-25'
        WHEN days_of_stay BETWEEN 26 AND 30 THEN '26-30'
    END AS group_of_stay,
    COUNT(*) AS patients_count,
    ROUND(STDDEV(days_of_stay),0) AS std,
    ROUND(AVG(days_of_stay),0) AS avg_days
FROM patients
GROUP BY medical_condition, admission_type, group_of_stay;

-- ===========================================================
-- COMPARE TEST RESULTS WITH DISCHARGE DATES TO ANALYZE RECOVERY TIMES
-- ===========================================================
SELECT test_results,
    CASE 
        WHEN days_of_stay BETWEEN 1 AND 5 THEN '1-5'
        WHEN days_of_stay BETWEEN 6 AND 10 THEN '6-10'
        WHEN days_of_stay BETWEEN 11 AND 15 THEN '11-15'
        WHEN days_of_stay BETWEEN 16 AND 20 THEN '16-20'
        WHEN days_of_stay BETWEEN 21 AND 25 THEN '21-25'
        WHEN days_of_stay BETWEEN 26 AND 30 THEN '26-30'
    END AS group_of_stay,
    COUNT(*)
FROM patients
WHERE test_results = 'Normal'
GROUP BY test_results, group_of_stay;

SELECT test_results,
    CASE 
        WHEN days_of_stay BETWEEN 1 AND 5 THEN '1-5'
        WHEN days_of_stay BETWEEN 6 AND 10 THEN '6-10'
        WHEN days_of_stay BETWEEN 11 AND 15 THEN '11-15'
        WHEN days_of_stay BETWEEN 16 AND 20 THEN '16-20'
        WHEN days_of_stay BETWEEN 21 AND 25 THEN '21-25'
        WHEN days_of_stay BETWEEN 26 AND 30 THEN '26-30'
    END AS group_of_stay,
    COUNT(*)
FROM patients
WHERE test_results = 'Abnormal'
GROUP BY test_results, group_of_stay;

SELECT test_results,
    CASE 
        WHEN days_of_stay BETWEEN 1 AND 5 THEN '1-5'
        WHEN days_of_stay BETWEEN 6 AND 10 THEN '6-10'
        WHEN days_of_stay BETWEEN 11 AND 15 THEN '11-15'
        WHEN days_of_stay BETWEEN 16 AND 20 THEN '16-20'
        WHEN days_of_stay BETWEEN 21 AND 25 THEN '21-25'
        WHEN days_of_stay BETWEEN 26 AND 30 THEN '26-30'
    END AS group_of_stay,
    COUNT(*)
FROM patients
WHERE test_results = 'Inconclusive'
GROUP BY test_results, group_of_stay;


--FELIX IDOWU