# Project Title: Hospital Patient Analytics

## Introduction

Hospitals today face numerous challenges, including rising healthcare costs, resource constraints, and the growing complexity of patient care. These issues can lead to inefficiencies and a reduction in the quality of care. In this analysis, my goal was to provide valuable insights into how hospitals can better manage their resources and optimize their costs. By analyzing available data, I identified areas where cost-saving measures could be implemented without compromising patient care, helping hospital administrators make more informed decisions.

## Project Overview:
In this project, I analyzed hospital patient data to uncover patterns in medical conditions, treatment costs, and patient demographics. I provided actionable insights that can help hospitals optimize patient care, reduce costs, and improve resource allocation.

## Key Objectives:

- Identify trends in patient age, gender, and medical conditions.
- Determine the most common medical conditions by age group.
- Provide the list and count of hospitals with more than one patients
- Analyze average billing amounts by medical condition and insurance provider.
- Evaluate average length of stay based on medical condition and admission type.
- Compare test results with discharge dates to analyze recovery times.

## **Dataset Description**

The dataset used in this project contains healthcare-related data including patient demographics, medical conditions, and treatment information. It provides key insights into patient admissions, medical costs, and hospital resource utilization. The dataset consists of the following attributes:

- **Name**: The full name of the patient.
- **Age**: The patient's age at the time of admission.
- **Gender**: The gender of the patient.
- **Blood Type**: The patient's blood type (e.g., A+, O-, etc.).
- **Medical Condition**: The primary medical condition diagnosed for the patient.
- **Date of Admission**: The date the patient was admitted to the hospital.
- **Doctor**: The name or ID of the doctor assigned to the patient.
- **Hospital**: The name of the hospital where the treatment was provided.
- **Insurance Provider**: The name of the insurance provider covering the patient's medical expenses.
- **Billing Amount**: The total amount billed for the patient's treatment and services during their hospital stay.
- **Room Number**: The room number assigned to the patient during their hospitalization.
- **Admission Type**: The type of admission (e.g., emergency, planned, urgent).
- **Discharge Date**: The date the patient was discharged from the hospital.
- **Medication**: A list of medications prescribed to the patient during their stay.
- **Test Results**: Results from any diagnostic tests performed on the patient.

For more details, you can access the dataset on [Kaggle](https://www.kaggle.com/datasets/prasad22/healthcare-dataset).


## Data Preparation: Creating the Patients Table

The SQL query below is used to create a patients table, which stores various details about hospital patients. It was written with respect to its appropriate datatype.

```sql
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
```

---
## Data Cleaning Process

To ensure the dataset is accurate, consistent, and free from duplicates, we followed a series of steps in the data cleaning process:

```sql
-- 1. Removing Duplicates Using CTAS
-- Creating a new table with distinct records
CREATE TABLE patients_clean AS
SELECT DISTINCT * FROM patients;

-- 2. Dropping the Original Table
-- Dropping the original patients table to avoid redundancy
DROP TABLE patients;

-- 3. Renaming the Cleaned Table
-- Renaming the cleaned table back to the original table name
ALTER TABLE patients_clean RENAME TO patients;

-- 4. Retrieving the Cleaned Data
-- Verifying that the cleaned table has been updated with distinct records
SELECT *
FROM patients;

-- 5. Formatting Patient Names to Title Case
-- Ensuring uniformity in patient name formatting (first letter of each word capitalized)
UPDATE patients
SET name = INITCAP(name);
```
The code removes duplicates from the patients table by creating a new table with only distinct records. It then deletes the original table to prevent redundancy and renames the cleaned table to the original name. After that, it retrieves the cleaned data to ensure everything is correct. Lastly, it updates patient names to title case, making sure all names are consistently formatted with the first letter capitalized.


---
## Data Analysis:

1. ### **Age Group Distribution**

The SQL query below categorizes patients into four age groups and counts the number of patients in each group:

```sql
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
```
I grouped the patients into four distinct age categories: "Old" (60-89 years), "Mid-Aged Adults" (36-59 years), "Young Adults" (19-35 years), and "Teens" (13-18 years). This classification helps to analyze the healthcare needs and trends across different life stages, with the majority of patients being in the "Old" category, followed by "Mid-Aged Adults." The "Young Adults" and "Teens" categories have fewer patients, suggesting that younger populations generally have fewer medical issues, but still require care for specific conditions.

2. ### **Trend in Patient's Gender**

The following SQL query is designed to analyze the gender distribution within the patient population, providing critical insights into how male and female patients are represented in the dataset:

```sql
-- Trend in patient's gender
SELECT gender, 
       COUNT(*) 
FROM patients
GROUP BY gender 
ORDER BY gender DESC;
```
From my analysis the ratio of Male to Female has a minimal deviation, It is gotten to be 27496:27470 respectively

3. ### **Trend in Medical Condition**

The following SQL query analyzes the distribution of **medical conditions** across patients, providing valuable insights into the prevalence of different health issues in the patient population:

```sql
-- Trend in Medical Condition
SELECT medical_condition, 
       COUNT(*) 
FROM patients
GROUP BY medical_condition 
ORDER BY medical_condition DESC;
```
There are 6 medical Conditions involved, they include "Obesity", "Hypertension", "Diabetes", "Cancer", "Asthma", "Arthritis" with Arthritis having the highest count 

4. ### ** The most common medical conditions by age group.**
The SQL query below is used to identify the most common medical conditions among different age groups of patients. It classifies patients into age groups (Teens, Young Adults, Mid-Aged Adults, and Old), then counts how many patients in each group have each medical condition. The result is sorted so that the most common conditions appear first, helping to understand which medical conditions are more prevalent in specific age groups.
```sql
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
```
#### From this query I uncovered:
- **Old**: The most common condition is **Diabetes** with 3,528 patients.
- **Mid-Aged Adults**: The most common condition is **Diabetes** with 3,329 patients.
- **Young Adults**: The most common condition is **Cancer** with 2,271 patients.
- **Teens**: The most common condition is **Obesity** with 158 patients.

5. ### **List and Count of Hospitals with More Than One Patient**

This SQL query helps to find out which hospitals have more than one patient:
```sql
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
```
It is divided into two main parts which are the List and Count Query. CTE(Common Table Expression) was utilized for both query

 **List of Hospitals**:
   - The query groups the patients by hospital and counts how many patients are assigned to each one.
   - It then filters out hospitals with only one patient, showing a list of hospitals that have more than one patient.

 **Count of Hospitals**:
   - After identifying hospitals with more than one patient, the second query counts how many hospitals meet this criteria.
   - This gives the total number of hospitals that have more than one patient.
     
6. ### Average Billing Amounts by Medical Condition and Insurance Provider

This query calculates the average billing amounts for each medical condition and insurance provider. It groups the data by both `medical_condition` and `insurance_provider`, allowing the query to compute the average billing amount for each combination. 

```sql
SELECT medical_condition, insurance_provider,
    ROUND(AVG(billing_amount), 0)
FROM patients
GROUP BY medical_condition, insurance_provider;
```
The `AVG(billing_amount)` function calculates the average of the billing amounts for each group. To ensure the results are easier to read, the `ROUND()` function rounds the average to zero decimal places.
The result of my analysis in summary reveals that Obesity has the highest average billing amounts, particularly with Cigna and Blue Cross. Hypertension, Asthma, and Diabetes also show significant costs across various insurance providers.

7. ### Evaluation of Average Length of Stay Based on Medical Condition and Admission Type

First, I calculated the **days of stay** for each patient by subtracting the **Date of Admission** from the **Discharge Date**. This difference was then added as a new column (`days_of_stay`) to the patients table.

Next, I grouped the patients into different categories based on the number of days they stayed in the hospital. These categories include ranges such as **1-5 days**, **6-10 days**, and so on. This grouping provides a clearer picture of the patients hospital stay durations.

Lastly,I analyzed the **length of stay** according to their **medical condition** and **admission type**. I calculated the **average length of stay** and **standard deviation** of days for each group, offering valuable insights into how the length of stay can differ based on these factors.
The code is as follows:
```sql
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
```
8. ### Comparing Test Results with Discharge Dates to Analyze Recovery Times

This SQL query analyzes the relationship between patients' **test results** and their **length of stay**. It categorizes patients based on their test results (Normal, Abnormal, or Inconclusive) and groups them into different categories based on how long they stayed in the hospital (1-5 days, 6-10 days, and so on). The query then counts how many patients fall into each group for each test result type. 

```sql
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
```
The analysis helps to understand if there is a pattern in the length of stay based on the test results, which can give insights into recovery times for patients with different diagnoses.

---
### Overall Conclusion

The analysis explored key patterns in patient data, focusing on medical conditions, billing amounts, hospital distribution, and recovery times. Key findings include:

1. **Medical Conditions by Age Group**: The analysis revealed that conditions like Diabetes and Hypertension are more prevalent in older adults, while younger patients tend to experience conditions such as Obesity and Asthma.

2. **Hospitals with More Than One Patient**: Hospitals with multiple patients were identified, offering insights into patient distribution and concentration across healthcare facilities.

3. **Billing Amounts by Medical Condition and Insurance Provider**: The evaluation of billing amounts highlighted significant variations in costs for different medical conditions, with Obesity and Diabetes leading to higher costs, particularly across certain insurance providers.

4. **Length of Stay Analysis**: By assessing the length of stay for patients based on medical conditions and admission type, notable differences in care duration were identified. Certain conditions led to longer hospital stays, with recovery times varying by admission type.

5. **Recovery Time Based on Test Results**: The analysis of test results (Normal, Abnormal, Inconclusive) provided insights into how recovery times are influenced by test outcomes, helping to understand the impact on patient care.

In conclusion, the analysis offered a comprehensive view of patient trends, billing patterns, hospital distribution, and recovery times, providing valuable insights for healthcare providers and administrators to optimize resource allocation, cost management, and patient care strategies.

---
### Data Privacy and Security

In a real-world application, patient data would be handled with the utmost care to ensure privacy and security. Key measures include:

1. **Anonymization**: Personally identifiable information (PII) would be anonymized or pseudonymized before analysis.
2. **Encryption**: Data would be encrypted both at rest and in transit to protect it from unauthorized access.
3. **Access Controls**: Role-based access would be enforced, with audit logs to track data access.
4. **Regulatory Compliance**: The project would comply with data protection regulations such as **HIPAA** or **GDPR**.
5. **Data Minimization**: Only necessary data would be collected and used.
6. **Data Deletion**: Patient data would be securely deleted after analysis.
7. **Security Audits**: Regular security assessments would ensure the system remains secure.
8. **User Consent**: Explicit consent would be obtained from patients for their data to be used.

These measures help protect patient confidentiality and ensure compliance with privacy laws.
