# Project Title: Hospital Patient Analytics & Billing Optimization

## Project Overview:
In this project, I analyzed hospital patient data to uncover patterns in medical conditions, treatment costs, and patient demographics. I provided actionable insights that can help hospitals optimize patient care, reduce costs, and improve resource allocation.

## Key Objectives:

- Identify trends in patient age, gender, and medical conditions.
- Determine the most common medical conditions by age group.
- Analyze average billing amounts by medical condition and insurance provider.
- Identify factors contributing to high medical costs.
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

### Data Preparation: Creating the Patients Table

The SQL query provided is used to create a `patients` table, which stores various details about hospital patients. The table is structured with the following columns:

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


#### Data Cleaning Process

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

### Data Analysis:

#### **Age Group Distribution**

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

#### **Trend in Patient's Gender**

The following SQL query is designed to analyze the gender distribution within the patient population, providing critical insights into how male and female patients are represented in the dataset:

```sql
-- Trend in patient's gender
SELECT gender, 
       COUNT(*) 
FROM patients
GROUP BY gender 
ORDER BY gender DESC;
```

#### **Trend in Medical Condition**

The following SQL query analyzes the distribution of **medical conditions** across patients, providing valuable insights into the prevalence of different health issues in the patient population:

```sql
-- Trend in Medical Condition
SELECT medical_condition, 
       COUNT(*) 
FROM patients
GROUP BY medical_condition 
ORDER BY medical_condition DESC;
