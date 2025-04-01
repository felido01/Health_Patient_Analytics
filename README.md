# Project Title: Hospital Patient Analytics & Billing Optimization

## Project Overview:
In this project, you'll analyze hospital patient data to uncover patterns in medical conditions, treatment costs, and patient demographics. Your goal is to provide actionable insights that can help hospitals optimize patient care, reduce costs, and improve resource allocation.

## Key Objectives:

### 1. Patient Demographics Analysis:
- Identify trends in patient age, gender, and medical conditions.
- Determine the most common medical conditions by age group.

### 2. Billing & Insurance Insights:
- Analyze average billing amounts by medical condition and insurance provider.
- Identify factors contributing to high medical costs.

### 3. Hospital Resource Management:
- Examine room allocation efficiency (private vs. shared rooms).
- Evaluate average length of stay based on medical condition and admission type.

### 4. Doctor & Treatment Effectiveness:
- Assess patient outcomes based on doctor assignments and medications.
- Compare test results with discharge dates to analyze recovery times.

# **Patient Data Cleaning and Transformation**

## **Project Overview**
This project focuses on cleaning and transforming patient records stored in a relational database. The dataset contains patient information such as name, age, medical condition, admission details, and billing information. The cleaning process ensures that the data is accurate, consistent, and free from duplicates.

---

## **Step 1: Table Creation**
We begin by creating a `patients` table to store patient records. The table consists of fields such as `Name`, `Age`, `Gender`, `Medical_Condition`, `Doctor`, `Billing_Amount`, and other relevant details.

---

## **Step 2: Data Cleaning**
To ensure the dataset is well-structured, we perform the following cleaning operations:

### **1. Counting Records**
- We first determine the total number of records in the table.
- Then, we count the number of distinct records to check for duplicate entries.

### **2. Removing Duplicates**
- A new table, `patients_clean`, is created using the `CREATE TABLE AS SELECT DISTINCT` (CTAS) method, ensuring only unique records are retained.
- The original `patients` table is dropped to remove any duplicate records.

### **3. Renaming the Cleaned Table**
- The cleaned table `patients_clean` is renamed back to `patients` so that future queries remain consistent.

### **4. Retrieving the Cleaned Data**
- The cleaned dataset is queried to verify that it contains the expected records.

---

## **Step 3: Data Formatting**
To maintain consistency in name formatting, we update the `name` column to follow title case. This ensures that names are properly capitalized (e.g., "john doe" → "John Doe").

---

## **Conclusion**
By implementing these cleaning and transformation steps, we ensure that the patient dataset is structured, free of duplicates, and formatted correctly. This enhances data accuracy and makes it easier for further analysis and reporting.
