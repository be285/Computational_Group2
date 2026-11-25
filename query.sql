-- ============================================================
-- query.sql
-- HPDM172 Group 2 - SQL queries
-- Xuening Chang (CX branch)
--
-- Needs: Coursework.sql, medications.sql, prescriptions_table.sql
-- and extra_tables_partB.sql loaded first (Part B uses the
-- extra tables/columns in that file).
-- Example values (hospital names, IDs) can be changed to
-- look up a different hospital / patient / doctor.
-- ============================================================

USE hospital_db;


-- ============================================================
-- Part A
-- ============================================================

-- all doctors based at a particular hospital
SELECT *
FROM doctors
WHERE hospital_name = 'Ashford Children Hospital';

-- all prescriptions for a particular patient, by prescription date
SELECT *
FROM Prescriptions
WHERE PatientID = 493
ORDER BY PrescriptionDate DESC;

-- all prescriptions that a particular doctor has prescribed
SELECT *
FROM Prescriptions
WHERE DoctorID = 91;

-- all prescriptions, ordered by patient name
SELECT *
FROM Prescriptions
JOIN patients
  ON Prescriptions.PatientID = patients.patient_id
ORDER BY patients.patient_firstname, patients.patient_surname;


-- ============================================================
-- Part B
-- Each query is saved as a stored procedure so it has a name
-- and can be reused with different inputs, e.g.
--     CALL mailing_list_for_hospital('Ashford Children Hospital');
-- Example calls are at the bottom of the file.
-- ============================================================

DELIMITER //

-- 1. Add a new patient and register them with a doctor.
--    patient_id is AUTO_INCREMENT so we don't give it a value.
--    The SELECT afterwards shows the new patient.
DROP PROCEDURE IF EXISTS add_new_patient //
CREATE PROCEDURE add_new_patient(
    IN p_firstname VARCHAR(150),
    IN p_surname   VARCHAR(150),
    IN p_dob       DATE,
    IN p_address   VARCHAR(255),
    IN p_doctor_id INT UNSIGNED
)
BEGIN
    INSERT INTO patients (patient_firstname, patient_surname, date_of_birth, patient_address, doctor_id)
    VALUES (p_firstname, p_surname, p_dob, p_address, p_doctor_id);

    SELECT *
    FROM patients
    WHERE patient_id = LAST_INSERT_ID();
END //


-- 2. Change the address of an existing patient
DROP PROCEDURE IF EXISTS update_patient_address //
CREATE PROCEDURE update_patient_address(
    IN p_patient_id  INT UNSIGNED,
    IN p_new_address VARCHAR(255)
)
BEGIN
    UPDATE patients
    SET patient_address = p_new_address
    WHERE patient_id = p_patient_id;

    SELECT patient_id, patient_firstname, patient_surname, patient_address
    FROM patients
    WHERE patient_id = p_patient_id;
END //


-- 3. Names and addresses of all patients registered to doctors
--    at one hospital (a mailing list). Patients aren't linked to
--    hospitals directly, so we go patient -> doctor -> hospital.
DROP PROCEDURE IF EXISTS mailing_list_for_hospital //
CREATE PROCEDURE mailing_list_for_hospital(IN p_hospital VARCHAR(150))
BEGIN
    SELECT p.patient_firstname, p.patient_surname, p.patient_address
    FROM patients p
    JOIN doctors d ON p.doctor_id = d.doctor_id
    WHERE d.hospital_name = p_hospital
    ORDER BY p.patient_surname, p.patient_firstname;
END //


-- 4. Doctors at Teaching hospitals accredited between 2015 and 2024
DROP PROCEDURE IF EXISTS doctors_at_teaching_hospitals_2015_2024 //
CREATE PROCEDURE doctors_at_teaching_hospitals_2015_2024()
BEGIN
    SELECT d.doctor_id, d.doctor_firstname, d.doctor_surname,
           h.Name AS hospital, h.AccreditationYear
    FROM doctors d
    JOIN Hospitals h ON d.hospital_name = h.Name
    WHERE h.Type = 'Teaching'
      AND h.AccreditationYear BETWEEN 2015 AND 2024
    ORDER BY h.Name, d.doctor_surname;
END //


-- 5. Patients who may have a disease, based on the medication
--    they were prescribed (uses disease_medications to know
--    which drugs are used for which disease).
--    DISTINCT so a patient only appears once even if they got
--    more than one of the drugs; the drugs are listed together.
DROP PROCEDURE IF EXISTS patients_who_may_have_disease //
CREATE PROCEDURE patients_who_may_have_disease(IN p_disease VARCHAR(150))
BEGIN
    SELECT p.patient_id, p.patient_firstname, p.patient_surname,
           GROUP_CONCAT(DISTINCT m.MedicationName ORDER BY m.MedicationName SEPARATOR ', ') AS medications
    FROM patients p
    JOIN Prescriptions pr        ON pr.PatientID = p.patient_id
    JOIN Medications m           ON m.MedicationID = pr.MedicationID
    JOIN disease_medications dm  ON dm.medication_id = pr.MedicationID
    JOIN diseases dis            ON dis.disease_id = dm.disease_id
    WHERE dis.disease_name = p_disease
    GROUP BY p.patient_id, p.patient_firstname, p.patient_surname
    ORDER BY p.patient_surname, p.patient_firstname;
END //


-- 6. Doctors who specialise in a particular disease, and the
--    hospital they are based at
DROP PROCEDURE IF EXISTS doctors_specialising_in_disease //
CREATE PROCEDURE doctors_specialising_in_disease(IN p_disease VARCHAR(150))
BEGIN
    SELECT d.doctor_id, d.doctor_firstname, d.doctor_surname, d.hospital_name
    FROM doctors d
    JOIN doctor_specialisms ds ON ds.doctor_id = d.doctor_id
    JOIN diseases dis          ON dis.disease_id = ds.disease_id
    WHERE dis.disease_name = p_disease
    ORDER BY d.hospital_name, d.doctor_surname;
END //


-- 7. Lab results for all patients over 60.
--    Age is worked out from date of birth every time the query
--    runs (TIMESTAMPDIFF counts full years), so it stays correct.
DROP PROCEDURE IF EXISTS lab_results_patients_over_60 //
CREATE PROCEDURE lab_results_patients_over_60()
BEGIN
    SELECT p.patient_id, p.patient_firstname, p.patient_surname,
           TIMESTAMPDIFF(YEAR, p.date_of_birth, CURDATE()) AS age,
           t.test_name, lr.test_date, lr.result_value, t.unit, lr.result_flag
    FROM lab_results lr
    JOIN patients p       ON p.patient_id = lr.patient_id
    JOIN lab_test_types t ON t.test_type_id = lr.test_type_id
    WHERE TIMESTAMPDIFF(YEAR, p.date_of_birth, CURDATE()) > 60
    ORDER BY age DESC, p.patient_id, lr.test_date;
END //


-- 8. All appointments for a given patient
DROP PROCEDURE IF EXISTS appointments_for_patient //
CREATE PROCEDURE appointments_for_patient(IN p_patient_id INT UNSIGNED)
BEGIN
    SELECT a.appointment_id, a.appointment_datetime,
           CONCAT(d.doctor_firstname, ' ', d.doctor_surname) AS doctor,
           d.hospital_name
    FROM appointments a
    JOIN doctors d ON d.doctor_id = a.doctor_id
    WHERE a.patient_id = p_patient_id
    ORDER BY a.appointment_datetime;
END //


-- 9. All appointments for a given doctor
DROP PROCEDURE IF EXISTS appointments_for_doctor //
CREATE PROCEDURE appointments_for_doctor(IN p_doctor_id INT UNSIGNED)
BEGIN
    SELECT a.appointment_id, a.appointment_datetime,
           p.patient_id,
           CONCAT(p.patient_firstname, ' ', p.patient_surname) AS patient
    FROM appointments a
    JOIN patients p ON p.patient_id = a.patient_id
    WHERE a.doctor_id = p_doctor_id
    ORDER BY a.appointment_datetime;
END //


-- 10. All prescriptions made from one hospital, A-Z by medication.
--     The brief says only these 4 columns: medication, doctor,
--     patient and hospital. The hospital is the prescribing
--     doctor's hospital.
DROP PROCEDURE IF EXISTS prescriptions_from_hospital_by_medication //
CREATE PROCEDURE prescriptions_from_hospital_by_medication(IN p_hospital VARCHAR(150))
BEGIN
    SELECT m.MedicationName                                    AS medication,
           CONCAT(d.doctor_firstname, ' ', d.doctor_surname)   AS doctor,
           CONCAT(p.patient_firstname, ' ', p.patient_surname) AS patient,
           d.hospital_name                                     AS hospital
    FROM Prescriptions pr
    JOIN Medications m ON m.MedicationID = pr.MedicationID
    JOIN doctors d     ON d.doctor_id = pr.DoctorID
    JOIN patients p    ON p.patient_id = pr.PatientID
    WHERE d.hospital_name = p_hospital
    ORDER BY m.MedicationName, patient;
END //


-- 11. Lab results from all hospitals accredited between 2013 and
--     2020. A result belongs to the hospital of the doctor who
--     ordered the test (lab_results.doctor_id).
DROP PROCEDURE IF EXISTS lab_results_hospitals_accredited_2013_2020 //
CREATE PROCEDURE lab_results_hospitals_accredited_2013_2020()
BEGIN
    SELECT h.Name AS hospital, h.AccreditationYear,
           lr.lab_result_id,
           CONCAT(p.patient_firstname, ' ', p.patient_surname) AS patient,
           t.test_name, lr.test_date, lr.result_value, t.unit, lr.result_flag
    FROM lab_results lr
    JOIN doctors d        ON d.doctor_id = lr.doctor_id
    JOIN Hospitals h      ON h.Name = d.hospital_name
    JOIN patients p       ON p.patient_id = lr.patient_id
    JOIN lab_test_types t ON t.test_type_id = lr.test_type_id
    WHERE h.AccreditationYear BETWEEN 2013 AND 2020
    ORDER BY h.Name, lr.test_date;
END //


-- 12. The doctor who has made the most prescriptions.
--     We don't just use LIMIT 1, because if two or more doctors
--     have the same top number they should all be shown.
DROP PROCEDURE IF EXISTS doctor_with_most_prescriptions //
CREATE PROCEDURE doctor_with_most_prescriptions()
BEGIN
    SELECT d.doctor_id, d.doctor_firstname, d.doctor_surname, d.hospital_name,
           COUNT(*) AS number_of_prescriptions
    FROM Prescriptions pr
    JOIN doctors d ON d.doctor_id = pr.DoctorID
    GROUP BY d.doctor_id, d.doctor_firstname, d.doctor_surname, d.hospital_name
    HAVING COUNT(*) = (
        SELECT MAX(n)
        FROM (SELECT COUNT(*) AS n FROM Prescriptions GROUP BY DoctorID) AS counts
    )
    ORDER BY d.doctor_id;
END //


-- 13. All doctors at the biggest hospital (most beds).
--     Compared with MAX(Size) so it still works if two hospitals
--     ever have the same number of beds.
DROP PROCEDURE IF EXISTS doctors_at_biggest_hospital //
CREATE PROCEDURE doctors_at_biggest_hospital()
BEGIN
    SELECT d.doctor_id, d.doctor_firstname, d.doctor_surname,
           h.Name AS hospital, h.Size AS beds
    FROM doctors d
    JOIN Hospitals h ON h.Name = d.hospital_name
    WHERE h.Size = (SELECT MAX(Size) FROM Hospitals)
    ORDER BY d.doctor_surname;
END //


-- 14. Hospitals accredited before 2015 that have an Emergency
--     Service (non-accredited ones have a NULL year so they
--     are left out automatically)
DROP PROCEDURE IF EXISTS hospitals_accredited_before_2015_with_emergency //
CREATE PROCEDURE hospitals_accredited_before_2015_with_emergency()
BEGIN
    SELECT Name, Type, AccreditationYear
    FROM Hospitals
    WHERE AccreditationYear < 2015
      AND EmergencyService = TRUE
    ORDER BY Name;
END //


-- 15. Patients registered with doctors at hospitals with fewer
--     than 400 beds
DROP PROCEDURE IF EXISTS patients_at_hospitals_under_400_beds //
CREATE PROCEDURE patients_at_hospitals_under_400_beds()
BEGIN
    SELECT p.patient_id, p.patient_firstname, p.patient_surname,
           d.hospital_name, h.Size AS beds
    FROM patients p
    JOIN doctors d   ON d.doctor_id = p.doctor_id
    JOIN Hospitals h ON h.Name = d.hospital_name
    WHERE h.Size < 400
    ORDER BY h.Size, d.hospital_name, p.patient_surname;
END //

DELIMITER ;


-- ============================================================
-- Example calls (Part B)
-- 1 and 2 change the data, so run them on purpose only:
-- CALL add_new_patient('Ryan', 'Morgan', '1988-04-12', '12 Queen Street, Exeter, EX4 3SR', 25);
-- CALL update_patient_address(17, '5 Pennsylvania Road, Exeter, EX4 6BH');
-- ============================================================
CALL mailing_list_for_hospital('Ashford Children Hospital');
CALL doctors_at_teaching_hospitals_2015_2024();
CALL patients_who_may_have_disease('Asthma');
CALL doctors_specialising_in_disease('Type 2 diabetes');
CALL lab_results_patients_over_60();
CALL appointments_for_patient(1);
CALL appointments_for_doctor(1);
CALL prescriptions_from_hospital_by_medication('Harbourview General Hospital');
CALL lab_results_hospitals_accredited_2013_2020();
CALL doctor_with_most_prescriptions();
CALL doctors_at_biggest_hospital();
CALL hospitals_accredited_before_2015_with_emergency();
CALL patients_at_hospitals_under_400_beds();
