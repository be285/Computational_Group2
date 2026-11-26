# Computational_Group2
Group Coding Assignment, Computational Skills for Health and Life Sciences, HPDM172, The University of Exeter

Project Commenced: 16.11.2026
Last Updated: 9.12.2026
Group 2

Coursework.sql is a database containing tables 'Hospitals', 'Doctors', 'Patient', 'Medications', 'Prescriptions', 'Disease', 'Appointments' and 'Lab_Results'.
Fields and connections between these tables are illustrated as figure 'Entity_Relationship_diagram.pptx'.

Use files via SQL commands 'SELECT' and 'DESCRIBE'.

SQL Queries:

Print a list of all doctors based at a particular hospital. 
• Print a list of all prescriptions for a particular patient, ordered by the prescription 
date. 
• Print a list of all prescriptions that a particular doctor has prescribed. 
• Print a table showing all prescriptions ordered by the patient name alphabetically. 
Add a new customer to the database, including being registered with one of the 
doctors. 
• Modify address details of an existing customer.  
• Print a list of all patient names and addresses for patients registered to doctors 
based at one particular hospital - that could be used for posting information mail to 
all of one hospital’s registered patients. 
• Print a list of all doctors based at Teaching hospitals which were accredited between 
2015-2024. 
• List all patients who may have a particular disease based on which medication they 
have been prescribed. 
• List all doctors based at who specialize in a particular disease. 
• List all lab results for all patients over the age of 60. 
• Print a list of all appointments for a given patient. 
• Print a list of all appointments for a given doctor.  
• Print all prescriptions made from a particular hospital ordered alphabetically by the 
name of the medication being prescribed - The output of this SQL query should 
include only these 4 columns: the medication name, the name of doctor who 
prescribed it, the name of the patient, and the name of hospital. 
• Print a list of all lab results from all hospitals that were accredited between 2013
2020. 
• Identify which doctor has made the most prescriptions. 
• Print a list of all doctors at the hospital with biggest size (number of beds). 
• A list of all hospital names which were accredited prior to 2015 and do have 
Emergency Service facilities. 
• A list of patients registered with doctors who are based at hospital with <400 beds.
 

This branch has the SQL queries from the brief:

- `query.sql` - the 4 Part A queries and the 15 Part B queries
- `extra_tables_partB.sql` - extra columns and tables that some of the Part B queries need
- `query_results.md` - **the results of every query** (Part A and Part B), with the SQL and the full output table for each one
- `show_results.sql` - the script used to run all the queries and save the results

### Why the extra tables?

Some Part B queries ask for things our database didn't have yet:
the year a hospital was accredited, whether it has an Emergency Service,
diseases, doctor specialisms and lab results. So `extra_tables_partB.sql` adds:

| Table / column | Used for |
|---|---|
| `Hospitals.AccreditationYear`, `Hospitals.EmergencyService` | doctors at Teaching hospitals accredited 2015-2024, lab results from hospitals accredited 2013-2020, hospitals accredited before 2015 with Emergency Service |
| `diseases`, `disease_medications` | patients who may have a disease based on their medication |
| `doctor_specialisms` | doctors who specialise in a disease |
| `lab_test_types`, `lab_results` | lab results for patients over 60, lab results by hospital |

Appointments are not created here - the queries use the `appointments` table
Sadia added to `Coursework.sql`.
All the data in `extra_tables_partB.sql` is made-up test data.

### How to run

All the files needed are on this branch (the other branches - main,
patientsanddoctors, Medications and prescriptions-table - have been merged in).
Load them in this order (in MySQL, e.g. `mysql -u <user> -p`):

```sql
source Coursework.sql              -- Hospitals, doctors, patients, appointments (be285, sadiaf20)
USE hospital_db;
source medications.sql             -- Medications (praveenas23)
source prescriptions_table.sql     -- Prescriptions (Aash23-bit)
source extra_tables_partB.sql      -- extra tables for Part B
source query.sql                   -- the queries
```

`extra_tables_partB.sql` adds columns with `ALTER TABLE`, so it should be run
once on a freshly built database.

### Part A queries

The 4 Part A queries are plain `SELECT` statements at the top of `query.sql`.
To look up a different hospital / patient / doctor, change the value in the `WHERE`.

| Task from the brief | How it works | Example value |
|---|---|---|
| All doctors based at a particular hospital | `doctors` filtered by `hospital_name` | `'Ashford Children Hospital'` |
| All prescriptions for a particular patient, ordered by prescription date | `Prescriptions` filtered by `PatientID`, `ORDER BY PrescriptionDate DESC` | patient `493` |
| All prescriptions a particular doctor has prescribed | `Prescriptions` filtered by `DoctorID` | doctor `91` |
| All prescriptions ordered by patient name | `Prescriptions` joined to `patients`, `ORDER BY` first name then surname | - |

```sql
SELECT * FROM doctors WHERE hospital_name = 'Ashford Children Hospital';

SELECT * FROM Prescriptions WHERE PatientID = 493 ORDER BY PrescriptionDate DESC;

SELECT * FROM Prescriptions WHERE DoctorID = 91;

SELECT *
FROM Prescriptions
JOIN patients ON Prescriptions.PatientID = patients.patient_id
ORDER BY patients.patient_firstname, patients.patient_surname;
```

### Part B queries

Each Part B query is saved as a stored procedure, so it has a clear name and
can be run again with different inputs using `CALL`.

| Task from the brief | Procedure | Example |
|---|---|---|
| Add a new patient, registered with a doctor | `add_new_patient` | `CALL add_new_patient('Ryan', 'Morgan', '1988-04-12', '12 Queen Street, Exeter, EX4 3SR', 25);` |
| Change an existing patient's address | `update_patient_address` | `CALL update_patient_address(17, '5 Pennsylvania Road, Exeter, EX4 6BH');` |
| Names and addresses of patients at one hospital (mailing list) | `mailing_list_for_hospital` | `CALL mailing_list_for_hospital('Ashford Children Hospital');` |
| Doctors at Teaching hospitals accredited 2015-2024 | `doctors_at_teaching_hospitals_2015_2024` | `CALL doctors_at_teaching_hospitals_2015_2024();` |
| Patients who may have a disease (from their medication) | `patients_who_may_have_disease` | `CALL patients_who_may_have_disease('Asthma');` |
| Doctors who specialise in a disease | `doctors_specialising_in_disease` | `CALL doctors_specialising_in_disease('Type 2 diabetes');` |
| Lab results for patients over 60 | `lab_results_patients_over_60` | `CALL lab_results_patients_over_60();` |
| Appointments for a patient | `appointments_for_patient` | `CALL appointments_for_patient(1);` |
| Appointments for a doctor | `appointments_for_doctor` | `CALL appointments_for_doctor(1);` |
| Prescriptions from one hospital, A-Z by medication (4 columns) | `prescriptions_from_hospital_by_medication` | `CALL prescriptions_from_hospital_by_medication('Harbourview General Hospital');` |
| Lab results from hospitals accredited 2013-2020 | `lab_results_hospitals_accredited_2013_2020` | `CALL lab_results_hospitals_accredited_2013_2020();` |
| Doctor with the most prescriptions | `doctor_with_most_prescriptions` | `CALL doctor_with_most_prescriptions();` |
| Doctors at the hospital with the most beds | `doctors_at_biggest_hospital` | `CALL doctors_at_biggest_hospital();` |
| Hospitals accredited before 2015 with Emergency Service | `hospitals_accredited_before_2015_with_emergency` | `CALL hospitals_accredited_before_2015_with_emergency();` |
| Patients at hospitals with fewer than 400 beds | `patients_at_hospitals_under_400_beds` | `CALL patients_at_hospitals_under_400_beds();` |

A few notes:
- `add_new_patient` and `update_patient_address` change the data, so they are
  not run automatically at the end of `query.sql`.
- `doctor_with_most_prescriptions` shows every doctor tied for first place
  (with our data three doctors have 10 prescriptions each).
- A lab result belongs to the hospital of the doctor who ordered the test.

All queries were tested on MySQL 8.0 on the module's Ubuntu VM.
