-- ============================================================
-- show_results.sql
-- HPDM172 Group 2 - runs every query once so the results can be
-- saved (this is how query_results.md was made).
--
-- Run on a freshly built database AFTER query.sql (so the stored
-- procedures exist). In MySQL:
--     tee query_output.txt
--     source show_results.sql
--     notee
-- Note: Part B 1 and 2 change the data (adds patient 601 and
-- changes patient 17's address).
-- ============================================================

USE hospital_db;

-- ---------------- Part A ----------------

SELECT 'A1 doctors at a particular hospital' AS query_name;
SELECT *
FROM doctors
WHERE hospital_name = 'Ashford Children Hospital';

SELECT 'A2 prescriptions for a particular patient, by date' AS query_name;
SELECT *
FROM Prescriptions
WHERE PatientID = 493
ORDER BY PrescriptionDate DESC;

SELECT 'A3 prescriptions by a particular doctor' AS query_name;
SELECT *
FROM Prescriptions
WHERE DoctorID = 91;

SELECT 'A4 all prescriptions ordered by patient name' AS query_name;
SELECT *
FROM Prescriptions
JOIN patients
  ON Prescriptions.PatientID = patients.patient_id
ORDER BY patients.patient_firstname, patients.patient_surname;

-- ---------------- Part B ----------------

SELECT 'B1 add_new_patient' AS query_name;
CALL add_new_patient('Ryan', 'Morgan', '1988-04-12', '12 Queen Street, Exeter, EX4 3SR', 25);

SELECT 'B2 update_patient_address (before)' AS query_name;
SELECT patient_id, patient_firstname, patient_surname, patient_address
FROM patients
WHERE patient_id = 17;

SELECT 'B2 update_patient_address (after)' AS query_name;
CALL update_patient_address(17, '5 Pennsylvania Road, Exeter, EX4 6BH');

SELECT 'B3 mailing_list_for_hospital' AS query_name;
CALL mailing_list_for_hospital('Ashford Children Hospital');

SELECT 'B4 doctors_at_teaching_hospitals_2015_2024' AS query_name;
CALL doctors_at_teaching_hospitals_2015_2024();

SELECT 'B5 patients_who_may_have_disease' AS query_name;
CALL patients_who_may_have_disease('Asthma');

SELECT 'B6 doctors_specialising_in_disease' AS query_name;
CALL doctors_specialising_in_disease('Type 2 diabetes');

SELECT 'B7 lab_results_patients_over_60' AS query_name;
CALL lab_results_patients_over_60();

SELECT 'B8 appointments_for_patient' AS query_name;
CALL appointments_for_patient(1);

SELECT 'B9 appointments_for_doctor' AS query_name;
CALL appointments_for_doctor(1);

SELECT 'B10 prescriptions_from_hospital_by_medication' AS query_name;
CALL prescriptions_from_hospital_by_medication('Harbourview General Hospital');

SELECT 'B11 lab_results_hospitals_accredited_2013_2020' AS query_name;
CALL lab_results_hospitals_accredited_2013_2020();

SELECT 'B12 doctor_with_most_prescriptions' AS query_name;
CALL doctor_with_most_prescriptions();

SELECT 'B13 doctors_at_biggest_hospital' AS query_name;
CALL doctors_at_biggest_hospital();

SELECT 'B14 hospitals_accredited_before_2015_with_emergency' AS query_name;
CALL hospitals_accredited_before_2015_with_emergency();

SELECT 'B15 patients_at_hospitals_under_400_beds' AS query_name;
CALL patients_at_hospitals_under_400_beds();
