# Computational_Group2
Coursework, databases

## CX branch - SQL queries (Xuening Chang)

This branch has the SQL queries from the brief:

- `query.sql` - the 4 Part A queries and the 15 Part B queries
- `extra_tables_partB.sql` - extra columns and tables that some of the Part B queries need

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
Sadia added to `Coursework.sql` (patientsanddoctors branch).
All the data in `extra_tables_partB.sql` is made-up test data.

### How to run

Load the files in this order (in MySQL, e.g. `mysql -u <user> -p`):

```sql
source Coursework.sql              -- Hospitals, doctors, patients, appointments (patientsanddoctors branch)
USE hospital_db;
source medications.sql             -- Medications (Medications branch)
source prescriptions_table.sql     -- Prescriptions (prescriptions-table branch)
source extra_tables_partB.sql      -- extra tables for Part B (this branch)
source query.sql                   -- the queries (this branch)
```

`extra_tables_partB.sql` adds columns with `ALTER TABLE`, so it should be run
once on a freshly built database.

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
