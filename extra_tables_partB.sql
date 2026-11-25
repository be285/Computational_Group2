-- ============================================================
-- extra_tables_partB.sql
-- HPDM172 Group 2 - extra tables needed for the Part B queries
--
-- Some of the Part B queries need information our database
-- doesn't have yet, so this file adds it:
--   * Hospitals: accreditation year + emergency service
--   * diseases, disease_medications (which drug treats what)
--   * doctor_specialisms
--   * lab_test_types, lab_results
-- Appointments are NOT made here - we use the appointments
-- table already in Coursework.sql.
--
-- Run order (needs these tables first):
--   1. Coursework.sql            (Hospitals, doctors, patients, appointments)
--   2. medications.sql           (Medications)
--   3. prescriptions_table.sql   (Prescriptions)
--   4. this file
-- The ALTER TABLE part only works once, so run it on a freshly
-- built database. All the data below is made-up test data.
-- ============================================================

USE hospital_db;

-- If this file was run before, remove the tables it made
DROP TABLE IF EXISTS lab_results;
DROP TABLE IF EXISTS lab_test_types;
DROP TABLE IF EXISTS doctor_specialisms;
DROP TABLE IF EXISTS disease_medications;
DROP TABLE IF EXISTS diseases;


-- ------------------------------------------------------------
-- 1. Hospitals: accreditation year and emergency service
-- At the moment Accreditation is only 1/0, but the brief asks
-- about hospitals accredited "between 2015-2024", "between
-- 2013-2020" and "prior to 2015", so we need the year too.
-- Hospitals with Accreditation = 0 keep the year as NULL.
-- ------------------------------------------------------------
ALTER TABLE Hospitals
    ADD COLUMN AccreditationYear YEAR NULL AFTER Accreditation,
    ADD COLUMN EmergencyService BOOLEAN NOT NULL DEFAULT FALSE AFTER AccreditationYear;

-- years and emergency service for each of the 40 hospitals

UPDATE Hospitals SET AccreditationYear = 2019, EmergencyService = 1 WHERE Name = 'Ashford Children Hospital';
UPDATE Hospitals SET AccreditationYear = NULL, EmergencyService = 1 WHERE Name = 'Bluebell Children Hospital';
UPDATE Hospitals SET AccreditationYear = NULL, EmergencyService = 1 WHERE Name = 'Brookside General Hospital';
UPDATE Hospitals SET AccreditationYear = 2019, EmergencyService = 0 WHERE Name = 'Cedar Grove Psychiatric Hospital';
UPDATE Hospitals SET AccreditationYear = 2020, EmergencyService = 1 WHERE Name = 'Central City Teaching Hospital';
UPDATE Hospitals SET AccreditationYear = 2022, EmergencyService = 0 WHERE Name = 'Crescent Mental Health Hospital';
UPDATE Hospitals SET AccreditationYear = 2014, EmergencyService = 0 WHERE Name = 'Eastgate Specialist Hospital';
UPDATE Hospitals SET AccreditationYear = NULL, EmergencyService = 0 WHERE Name = 'Elmwood Rehabilitation Hospital';
UPDATE Hospitals SET AccreditationYear = 2009, EmergencyService = 0 WHERE Name = 'Fairview Psychiatric Hospital';
UPDATE Hospitals SET AccreditationYear = 2017, EmergencyService = 1 WHERE Name = 'Grand Central Hospital';
UPDATE Hospitals SET AccreditationYear = 2011, EmergencyService = 1 WHERE Name = 'Greenfield General Hospital';
UPDATE Hospitals SET AccreditationYear = 2021, EmergencyService = 1 WHERE Name = 'Harbourview General Hospital';
UPDATE Hospitals SET AccreditationYear = 2008, EmergencyService = 1 WHERE Name = 'Hawthorn General Hospital';
UPDATE Hospitals SET AccreditationYear = NULL, EmergencyService = 0 WHERE Name = 'Highland Specialist Hospital';
UPDATE Hospitals SET AccreditationYear = 2012, EmergencyService = 0 WHERE Name = 'Hillcrest Specialist Hospital';
UPDATE Hospitals SET AccreditationYear = 2024, EmergencyService = 1 WHERE Name = 'Kingsbridge General Hospital';
UPDATE Hospitals SET AccreditationYear = 2022, EmergencyService = 1 WHERE Name = 'Lakeside General Hospital';
UPDATE Hospitals SET AccreditationYear = 2016, EmergencyService = 1 WHERE Name = 'Little Oaks Children Hospital';
UPDATE Hospitals SET AccreditationYear = 2011, EmergencyService = 1 WHERE Name = 'Maple Leaf Specialist Hospital';
UPDATE Hospitals SET AccreditationYear = NULL, EmergencyService = 0 WHERE Name = 'Meadowlands Psychiatric Hospital';
UPDATE Hospitals SET AccreditationYear = 2009, EmergencyService = 1 WHERE Name = 'Millbrook General Hospital';
UPDATE Hospitals SET AccreditationYear = 2023, EmergencyService = 1 WHERE Name = 'Mountain View General Hospital';
UPDATE Hospitals SET AccreditationYear = 2021, EmergencyService = 1 WHERE Name = 'Northgate Teaching Hospital';
UPDATE Hospitals SET AccreditationYear = NULL, EmergencyService = 0 WHERE Name = 'Oakwood Mental Health Hospital';
UPDATE Hospitals SET AccreditationYear = 2023, EmergencyService = 1 WHERE Name = 'Parkview Teaching Hospital';
UPDATE Hospitals SET AccreditationYear = 2025, EmergencyService = 1 WHERE Name = 'Pinewood Children Hospital';
UPDATE Hospitals SET AccreditationYear = 2008, EmergencyService = 1 WHERE Name = 'Redwood Teaching Hospital';
UPDATE Hospitals SET AccreditationYear = 2020, EmergencyService = 1 WHERE Name = 'Riverside General Hospital';
UPDATE Hospitals SET AccreditationYear = NULL, EmergencyService = 0 WHERE Name = 'Rosewood Psychiatric Hospital';
UPDATE Hospitals SET AccreditationYear = 2020, EmergencyService = 1 WHERE Name = 'Royal Meadow Hospital';
UPDATE Hospitals SET AccreditationYear = NULL, EmergencyService = 1 WHERE Name = 'Seaview General Hospital';
UPDATE Hospitals SET AccreditationYear = 2021, EmergencyService = 1 WHERE Name = 'Silverstone General Hospital';
UPDATE Hospitals SET AccreditationYear = NULL, EmergencyService = 1 WHERE Name = 'Southside General Hospital';
UPDATE Hospitals SET AccreditationYear = 2022, EmergencyService = 1 WHERE Name = 'Springfield General Hospital';
UPDATE Hospitals SET AccreditationYear = 2021, EmergencyService = 1 WHERE Name = 'St Andrews Specialist Hospital';
UPDATE Hospitals SET AccreditationYear = 2018, EmergencyService = 0 WHERE Name = 'Sunrise Maternity Hospital';
UPDATE Hospitals SET AccreditationYear = 2022, EmergencyService = 1 WHERE Name = 'Valley View Teaching Hospital';
UPDATE Hospitals SET AccreditationYear = 2020, EmergencyService = 0 WHERE Name = 'Westbrook Children Hospital';
UPDATE Hospitals SET AccreditationYear = 2013, EmergencyService = 1 WHERE Name = 'Westfield Teaching Hospital';
UPDATE Hospitals SET AccreditationYear = NULL, EmergencyService = 0 WHERE Name = 'Willowbrook Maternity Hospital';


-- ------------------------------------------------------------
-- 2. diseases
-- ------------------------------------------------------------
CREATE TABLE diseases (
    disease_id   INT UNSIGNED NOT NULL AUTO_INCREMENT,
    disease_name VARCHAR(150) NOT NULL,
    PRIMARY KEY (disease_id),
    UNIQUE (disease_name)
);

INSERT INTO diseases (disease_id, disease_name) VALUES
(1,  'Hypertension'),
(2,  'Hypercholesterolaemia'),
(3,  'Type 1 diabetes'),
(4,  'Type 2 diabetes'),
(5,  'Asthma'),
(6,  'Heart failure'),
(7,  'Atrial fibrillation'),
(8,  'Depression'),
(9,  'Generalised anxiety disorder'),
(10, 'Osteoarthritis'),
(11, 'Hypothyroidism'),
(12, 'Allergic rhinitis'),
(13, 'Gastro-oesophageal reflux disease'),
(14, 'Bacterial chest infection'),
(15, 'Benign prostatic hyperplasia');


-- ------------------------------------------------------------
-- 3. disease_medications - which medication is used for which
-- disease. One drug can be used for more than one disease
-- (e.g. Bisoprolol, Insulin), so this is a many-to-many link.
-- medication_id is INT to match Medications.MedicationID.
-- ------------------------------------------------------------
CREATE TABLE disease_medications (
    disease_id    INT UNSIGNED NOT NULL,
    medication_id INT NOT NULL,
    PRIMARY KEY (disease_id, medication_id),
    FOREIGN KEY (disease_id)    REFERENCES diseases (disease_id),
    FOREIGN KEY (medication_id) REFERENCES Medications (MedicationID)
);

-- medication IDs are the ones in medications.sql
INSERT INTO disease_medications (disease_id, medication_id) VALUES
(1, 15), (1, 19), (1, 20), (1, 21), (1, 10),   -- Hypertension: Amlodipine, Hydrochlorothiazide, Ramipril, Losartan, Bisoprolol
(2, 1),  (2, 3),  (2, 12),                     -- Hypercholesterolaemia: Atorvastatin, Ezetimibe, Simvastatin
(3, 11),                                       -- Type 1 diabetes: Insulin
(4, 11), (4, 22),                              -- Type 2 diabetes: Insulin, Gliclazide
(5, 6),  (5, 13), (5, 18),                     -- Asthma: Salbutamol, Prednisolone, Montelukast
(6, 5),  (6, 7),  (6, 10),                     -- Heart failure: Furosemide, Spironolactone, Bisoprolol
(7, 23), (7, 10),                              -- Atrial fibrillation: Warfarin, Bisoprolol
(8, 16), (8, 24), (8, 28),                     -- Depression: Fluoxetine, Citalopram, Sertraline
(9, 28),                                       -- Anxiety: Sertraline
(10, 2), (10, 14), (10, 26), (10, 30),         -- Osteoarthritis: Diclofenac, Ibuprofen, Tramadol, Paracetamol
(11, 25),                                      -- Hypothyroidism: Levothyroxine
(12, 17), (12, 27),                            -- Allergic rhinitis: Cetirizine, Loratadine
(13, 29),                                      -- Reflux: Lansoprazole
(14, 4),  (14, 9),                             -- Chest infection: Doxycycline, Amoxicillin
(15, 8);                                       -- Prostate: Tamsulosin


-- ------------------------------------------------------------
-- 4. doctor_specialisms - which disease(s) each doctor
-- specialises in (every doctor has at least one)
-- ------------------------------------------------------------
CREATE TABLE doctor_specialisms (
    doctor_id  INT UNSIGNED NOT NULL,
    disease_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (doctor_id, disease_id),
    FOREIGN KEY (doctor_id)  REFERENCES doctors (doctor_id),
    FOREIGN KEY (disease_id) REFERENCES diseases (disease_id)
);

-- made-up test data
INSERT INTO doctor_specialisms (doctor_id, disease_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(4, 8),
(5, 5),
(5, 14),
(6, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 6),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 7),
(13, 13),
(14, 1),
(14, 14),
(15, 15),
(16, 1),
(17, 2),
(18, 3),
(19, 4),
(20, 5),
(21, 6),
(22, 7),
(23, 8),
(23, 14),
(24, 9),
(24, 15),
(25, 10),
(26, 3),
(26, 11),
(27, 12),
(28, 13),
(29, 14),
(30, 15),
(31, 1),
(32, 2),
(32, 7),
(33, 3),
(33, 11),
(34, 4),
(35, 5),
(35, 8),
(36, 6),
(36, 9),
(37, 7),
(38, 8),
(39, 9),
(40, 2),
(40, 10),
(41, 11),
(42, 4),
(42, 12),
(43, 13),
(44, 14),
(44, 15),
(45, 6),
(45, 15),
(46, 1),
(47, 2),
(47, 13),
(48, 3),
(48, 5),
(49, 4),
(50, 5),
(51, 6),
(51, 15),
(52, 7),
(53, 8),
(54, 9),
(55, 10),
(56, 11),
(57, 12),
(58, 9),
(58, 13),
(59, 14),
(60, 15),
(61, 1),
(62, 2),
(63, 3),
(63, 11),
(64, 3),
(64, 4),
(65, 5),
(66, 6),
(67, 7),
(68, 8),
(69, 9),
(70, 10),
(70, 12),
(71, 10),
(71, 11),
(72, 1),
(72, 12),
(73, 2),
(73, 13),
(74, 11),
(74, 14),
(75, 14),
(75, 15),
(76, 1),
(77, 2),
(78, 3),
(79, 4),
(80, 5),
(81, 2),
(81, 6),
(82, 7),
(83, 8),
(84, 9),
(85, 10),
(85, 11),
(86, 5),
(86, 11),
(87, 12),
(88, 7),
(88, 13),
(89, 2),
(89, 14),
(90, 15),
(91, 1),
(91, 5),
(92, 2),
(92, 3),
(93, 3),
(93, 4),
(94, 4),
(95, 5),
(96, 6),
(96, 14),
(97, 7),
(98, 7),
(98, 8),
(99, 9),
(99, 14),
(100, 10);


-- ------------------------------------------------------------
-- 5. lab_test_types - the tests that can be ordered, with the
-- unit and normal range (so a result can be flagged)
-- ------------------------------------------------------------
CREATE TABLE lab_test_types (
    test_type_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    test_name    VARCHAR(100) NOT NULL,
    unit         VARCHAR(20)  NOT NULL,
    normal_low   DECIMAL(8,2) NOT NULL,
    normal_high  DECIMAL(8,2) NOT NULL,
    PRIMARY KEY (test_type_id),
    UNIQUE (test_name)
);

INSERT INTO lab_test_types (test_type_id, test_name, unit, normal_low, normal_high) VALUES
(1,  'Haemoglobin',        'g/L',      115.00, 165.00),
(2,  'HbA1c',              'mmol/mol',  20.00,  42.00),
(3,  'Total cholesterol',  'mmol/L',     0.00,   5.00),
(4,  'TSH',                'mU/L',       0.40,   4.00),
(5,  'eGFR',               'mL/min',    90.00, 120.00),
(6,  'C-reactive protein', 'mg/L',       0.00,   5.00),
(7,  'Potassium',          'mmol/L',     3.50,   5.30),
(8,  'Sodium',             'mmol/L',   133.00, 146.00),
(9,  'ALT',                'U/L',        7.00,  56.00),
(10, 'Vitamin D',          'nmol/L',    50.00, 125.00);


-- ------------------------------------------------------------
-- 6. lab_results - one test result for one patient.
-- doctor_id is the doctor who ordered the test; we need it to
-- find which hospital a result came from (query 11), because
-- doctors are linked to hospitals but patients aren't directly.
-- ------------------------------------------------------------
CREATE TABLE lab_results (
    lab_result_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    patient_id    INT UNSIGNED NOT NULL,
    doctor_id     INT UNSIGNED NOT NULL,
    test_type_id  INT UNSIGNED NOT NULL,
    test_date     DATE         NOT NULL,
    result_value  DECIMAL(8,2) NOT NULL,
    result_flag   ENUM('Low', 'Normal', 'High') NOT NULL,
    PRIMARY KEY (lab_result_id),
    FOREIGN KEY (patient_id)   REFERENCES patients (patient_id),
    FOREIGN KEY (doctor_id)    REFERENCES doctors (doctor_id),
    FOREIGN KEY (test_type_id) REFERENCES lab_test_types (test_type_id)
);

-- made-up test data (tests from Dec 2024 to Nov 2026)
INSERT INTO lab_results (patient_id, doctor_id, test_type_id, test_date, result_value, result_flag) VALUES
(216, 16, 2, '2024-12-05', 31.28, 'Normal'),
(450, 50, 4, '2024-12-06', 1.2, 'Normal'),
(231, 31, 3, '2024-12-11', 3.43, 'Normal'),
(384, 84, 1, '2024-12-12', 152.57, 'Normal'),
(217, 17, 6, '2024-12-13', 0.47, 'Normal'),
(205, 5, 5, '2024-12-13', 92.32, 'Normal'),
(390, 90, 5, '2024-12-15', 111.31, 'Normal'),
(378, 78, 8, '2024-12-16', 150.59, 'High'),
(13, 13, 7, '2024-12-17', 4.45, 'Normal'),
(75, 27, 4, '2024-12-18', 0.34, 'Low'),
(500, 100, 10, '2024-12-19', 35.76, 'Low'),
(80, 80, 9, '2024-12-20', 39.63, 'Normal'),
(181, 81, 1, '2024-12-22', 133.37, 'Normal'),
(214, 14, 1, '2024-12-23', 108.92, 'Low'),
(293, 93, 1, '2024-12-23', 153.16, 'Normal'),
(358, 79, 9, '2024-12-25', 5.78, 'Low'),
(136, 36, 4, '2024-12-25', 3.24, 'Normal'),
(8, 8, 10, '2024-12-27', 88.92, 'Normal'),
(454, 54, 7, '2024-12-28', 3.63, 'Normal'),
(372, 72, 7, '2024-12-30', 3.09, 'Low'),
(14, 14, 5, '2025-01-01', 95.83, 'Normal'),
(110, 10, 5, '2025-01-04', 117.76, 'Normal'),
(194, 94, 4, '2025-01-05', 3.46, 'Normal'),
(394, 94, 10, '2025-01-07', 35.09, 'Low'),
(480, 35, 8, '2025-01-07', 145.76, 'Normal'),
(411, 22, 2, '2025-01-08', 41.16, 'Normal'),
(459, 59, 8, '2025-01-09', 135.61, 'Normal'),
(380, 80, 9, '2025-01-16', 41.25, 'Normal'),
(372, 72, 5, '2025-01-18', 118.12, 'Normal'),
(67, 67, 7, '2025-01-23', 4.43, 'Normal'),
(409, 9, 7, '2025-01-26', 3.75, 'Normal'),
(472, 72, 8, '2025-01-27', 130.39, 'Low'),
(123, 73, 5, '2025-01-28', 117.68, 'Normal'),
(62, 100, 10, '2025-01-28', 39.04, 'Low'),
(222, 22, 4, '2025-01-29', 0.22, 'Low'),
(237, 37, 10, '2025-01-29', 49.9, 'Low'),
(586, 38, 9, '2025-01-31', 5.6, 'Low'),
(33, 33, 7, '2025-01-31', 3.39, 'Low'),
(429, 29, 7, '2025-02-02', 3.53, 'Normal'),
(442, 42, 3, '2025-02-02', 0.53, 'Normal'),
(573, 73, 10, '2025-02-06', 34.65, 'Low'),
(385, 85, 4, '2025-02-07', 4.22, 'High'),
(48, 48, 10, '2025-02-09', 67.7, 'Normal'),
(428, 28, 5, '2025-02-10', 135.3, 'High'),
(485, 85, 9, '2025-02-11', 13.49, 'Normal'),
(324, 97, 7, '2025-02-11', 4.61, 'Normal'),
(51, 16, 4, '2025-02-12', 0.28, 'Low'),
(30, 42, 10, '2025-02-12', 120.55, 'Normal'),
(117, 17, 10, '2025-02-14', 84.82, 'Normal'),
(370, 92, 10, '2025-02-15', 69.1, 'Normal'),
(62, 100, 5, '2025-02-19', 93.6, 'Normal'),
(407, 7, 8, '2025-02-21', 142.65, 'Normal'),
(414, 14, 2, '2025-02-23', 47.19, 'High'),
(514, 14, 10, '2025-02-23', 116.64, 'Normal'),
(58, 23, 5, '2025-02-23', 92.69, 'Normal'),
(517, 17, 5, '2025-02-24', 95.45, 'Normal'),
(402, 2, 1, '2025-02-25', 154.7, 'Normal'),
(534, 34, 9, '2025-02-26', 52.91, 'Normal'),
(217, 17, 6, '2025-03-06', 4.85, 'Normal'),
(208, 8, 1, '2025-03-07', 113.73, 'Low'),
(569, 43, 3, '2025-03-07', 0.22, 'Normal'),
(380, 80, 10, '2025-03-07', 72.88, 'Normal'),
(414, 14, 7, '2025-03-07', 5.77, 'High'),
(240, 40, 6, '2025-03-08', 1.89, 'Normal'),
(56, 56, 4, '2025-03-08', 3.85, 'Normal'),
(141, 41, 10, '2025-03-08', 69.27, 'Normal'),
(321, 21, 2, '2025-03-11', 13.92, 'Low'),
(317, 17, 7, '2025-03-12', 6.37, 'High'),
(379, 79, 9, '2025-03-13', 23.67, 'Normal'),
(347, 47, 4, '2025-03-15', 3.01, 'Normal'),
(267, 67, 9, '2025-03-15', 10.73, 'Normal'),
(536, 36, 6, '2025-03-17', 0.72, 'Normal'),
(258, 58, 2, '2025-03-17', 24.43, 'Normal'),
(596, 96, 10, '2025-03-19', 43.58, 'Low'),
(341, 41, 7, '2025-03-19', 4.3, 'Normal'),
(192, 92, 10, '2025-03-22', 84.84, 'Normal'),
(19, 19, 1, '2025-03-24', 119.1, 'Normal'),
(109, 49, 9, '2025-03-24', 1.87, 'Low'),
(531, 31, 10, '2025-03-25', 124.68, 'Normal'),
(545, 45, 5, '2025-03-27', 102.96, 'Normal'),
(425, 25, 10, '2025-03-27', 112.07, 'Normal'),
(585, 85, 6, '2025-04-02', 4.54, 'Normal'),
(139, 39, 1, '2025-04-03', 149.5, 'Normal'),
(200, 100, 10, '2025-04-03', 62.2, 'Normal'),
(331, 31, 2, '2025-04-04', 15.0, 'Low'),
(440, 40, 1, '2025-04-07', 133.11, 'Normal'),
(110, 10, 7, '2025-04-08', 5.16, 'Normal'),
(265, 61, 4, '2025-04-08', 1.12, 'Normal'),
(525, 20, 6, '2025-04-10', 2.21, 'Normal'),
(126, 26, 9, '2025-04-12', 1.66, 'Low'),
(519, 19, 3, '2025-04-13', 0.88, 'Normal'),
(379, 100, 8, '2025-04-15', 143.52, 'Normal'),
(456, 80, 3, '2025-04-15', 3.4, 'Normal'),
(471, 71, 9, '2025-04-16', 71.91, 'High'),
(554, 54, 1, '2025-04-16', 127.35, 'Normal'),
(179, 79, 6, '2025-04-16', 1.9, 'Normal'),
(525, 25, 5, '2025-04-18', 104.8, 'Normal'),
(274, 74, 2, '2025-04-19', 37.95, 'Normal'),
(330, 30, 2, '2025-04-24', 22.3, 'Normal'),
(35, 35, 3, '2025-04-25', 3.56, 'Normal'),
(338, 22, 10, '2025-04-29', 97.82, 'Normal'),
(590, 90, 2, '2025-04-30', 17.86, 'Low'),
(63, 42, 4, '2025-05-02', 0.81, 'Normal'),
(144, 63, 9, '2025-05-02', 34.23, 'Normal'),
(48, 48, 10, '2025-05-03', 94.6, 'Normal'),
(463, 63, 4, '2025-05-06', 1.83, 'Normal'),
(139, 39, 5, '2025-05-08', 115.67, 'Normal'),
(27, 27, 10, '2025-05-15', 96.8, 'Normal'),
(155, 55, 3, '2025-05-15', 2.31, 'Normal'),
(380, 80, 5, '2025-05-15', 88.3, 'Low'),
(107, 7, 3, '2025-05-16', 0.67, 'Normal'),
(412, 12, 4, '2025-05-19', 0.28, 'Low'),
(461, 61, 7, '2025-05-20', 5.1, 'Normal'),
(257, 57, 8, '2025-05-21', 146.62, 'High'),
(343, 43, 9, '2025-05-24', 33.77, 'Normal'),
(354, 74, 1, '2025-05-26', 152.49, 'Normal'),
(127, 27, 5, '2025-05-28', 101.5, 'Normal'),
(205, 5, 1, '2025-05-30', 158.74, 'Normal'),
(177, 77, 7, '2025-05-30', 4.61, 'Normal'),
(521, 21, 3, '2025-05-31', 4.22, 'Normal'),
(407, 7, 9, '2025-06-02', 72.13, 'High'),
(309, 9, 10, '2025-06-03', 85.17, 'Normal'),
(381, 39, 1, '2025-06-03', 101.02, 'Low'),
(293, 93, 1, '2025-06-04', 124.21, 'Normal'),
(124, 24, 3, '2025-06-06', 4.85, 'Normal'),
(585, 85, 10, '2025-06-06', 115.27, 'Normal'),
(423, 23, 6, '2025-06-09', 1.06, 'Normal'),
(132, 32, 3, '2025-06-10', 4.74, 'Normal'),
(413, 13, 9, '2025-06-12', 34.54, 'Normal'),
(237, 37, 8, '2025-06-13', 141.94, 'Normal'),
(130, 30, 3, '2025-06-14', 5.46, 'High'),
(1, 28, 1, '2025-06-16', 123.07, 'Normal'),
(69, 69, 1, '2025-06-16', 163.35, 'Normal'),
(405, 5, 8, '2025-06-16', 140.22, 'Normal'),
(163, 63, 10, '2025-06-19', 70.4, 'Normal'),
(470, 70, 3, '2025-06-22', 5.31, 'High'),
(531, 31, 7, '2025-06-23', 3.34, 'Low'),
(450, 50, 9, '2025-06-23', 17.29, 'Normal'),
(433, 64, 8, '2025-06-25', 136.49, 'Normal'),
(459, 83, 2, '2025-06-29', 28.55, 'Normal'),
(340, 40, 3, '2025-06-30', 4.0, 'Normal'),
(597, 97, 4, '2025-06-30', 4.29, 'High'),
(245, 45, 2, '2025-07-01', 37.95, 'Normal'),
(79, 79, 5, '2025-07-02', 115.21, 'Normal'),
(341, 41, 5, '2025-07-03', 94.69, 'Normal'),
(384, 84, 6, '2025-07-08', 0.57, 'Normal'),
(149, 49, 2, '2025-07-08', 53.19, 'High'),
(185, 85, 3, '2025-07-09', 1.2, 'Normal'),
(10, 10, 2, '2025-07-09', 16.99, 'Low'),
(123, 52, 9, '2025-07-10', 7.42, 'Normal'),
(147, 47, 9, '2025-07-10', 16.09, 'Normal'),
(100, 100, 8, '2025-07-11', 145.39, 'Normal'),
(402, 84, 2, '2025-07-11', 29.63, 'Normal'),
(418, 18, 9, '2025-07-11', 36.19, 'Normal'),
(427, 27, 5, '2025-07-12', 131.29, 'High'),
(433, 54, 6, '2025-07-13', 0.89, 'Normal'),
(142, 42, 4, '2025-07-13', 2.39, 'Normal'),
(579, 79, 10, '2025-07-16', 76.17, 'Normal'),
(16, 16, 3, '2025-07-16', 5.63, 'High'),
(115, 15, 3, '2025-07-18', 0.78, 'Normal'),
(16, 16, 7, '2025-07-19', 4.59, 'Normal'),
(524, 24, 4, '2025-07-19', 3.18, 'Normal'),
(587, 87, 8, '2025-07-19', 144.86, 'Normal'),
(248, 48, 1, '2025-07-20', 132.17, 'Normal'),
(126, 26, 9, '2025-07-21', 38.43, 'Normal'),
(540, 40, 1, '2025-07-25', 160.32, 'Normal'),
(453, 53, 9, '2025-07-26', 15.83, 'Normal'),
(538, 38, 7, '2025-07-28', 4.48, 'Normal'),
(536, 36, 3, '2025-07-29', 0.45, 'Normal'),
(178, 8, 7, '2025-08-01', 4.66, 'Normal'),
(214, 14, 9, '2025-08-03', 29.46, 'Normal'),
(130, 30, 10, '2025-08-06', 121.97, 'Normal'),
(236, 36, 4, '2025-08-09', 1.67, 'Normal'),
(141, 20, 1, '2025-08-09', 160.05, 'Normal'),
(303, 32, 10, '2025-08-10', 52.71, 'Normal'),
(406, 6, 9, '2025-08-12', 69.11, 'High'),
(465, 65, 7, '2025-08-12', 4.6, 'Normal'),
(264, 64, 6, '2025-08-13', 2.54, 'Normal'),
(548, 48, 7, '2025-08-14', 4.05, 'Normal'),
(382, 82, 6, '2025-08-15', 2.21, 'Normal'),
(372, 85, 8, '2025-08-15', 143.86, 'Normal'),
(328, 93, 5, '2025-08-16', 122.72, 'High'),
(426, 26, 1, '2025-08-17', 131.01, 'Normal'),
(418, 83, 9, '2025-08-22', 15.18, 'Normal'),
(120, 20, 10, '2025-08-23', 56.78, 'Normal'),
(322, 22, 4, '2025-08-23', 1.51, 'Normal'),
(130, 30, 2, '2025-08-24', 46.74, 'High'),
(151, 51, 4, '2025-08-26', 0.54, 'Normal'),
(329, 29, 7, '2025-08-27', 3.2, 'Low'),
(468, 68, 9, '2025-08-28', 64.23, 'High'),
(74, 74, 10, '2025-08-29', 52.62, 'Normal'),
(594, 94, 2, '2025-08-30', 29.46, 'Normal'),
(59, 59, 8, '2025-08-31', 138.21, 'Normal'),
(204, 4, 3, '2025-09-01', 4.35, 'Normal'),
(95, 95, 2, '2025-09-03', 49.13, 'High'),
(35, 45, 9, '2025-09-06', 49.04, 'Normal'),
(138, 38, 6, '2025-09-08', 0.02, 'Normal'),
(494, 94, 6, '2025-09-09', 2.46, 'Normal'),
(586, 86, 1, '2025-09-10', 188.07, 'High'),
(65, 65, 2, '2025-09-10', 27.19, 'Normal'),
(187, 87, 6, '2025-09-12', 7.48, 'High'),
(319, 19, 4, '2025-09-13', 4.43, 'High'),
(335, 35, 2, '2025-09-15', 43.91, 'High'),
(77, 77, 4, '2025-09-15', 3.66, 'Normal'),
(303, 3, 10, '2025-09-16', 77.35, 'Normal'),
(140, 40, 8, '2025-09-16', 132.19, 'Low'),
(399, 99, 9, '2025-09-20', 54.32, 'Normal'),
(501, 1, 1, '2025-09-24', 111.14, 'Low'),
(206, 6, 9, '2025-09-25', 10.43, 'Normal'),
(176, 76, 7, '2025-09-25', 4.71, 'Normal'),
(576, 76, 5, '2025-09-27', 118.67, 'Normal'),
(37, 37, 10, '2025-09-27', 84.66, 'Normal'),
(18, 18, 5, '2025-10-01', 92.64, 'Normal'),
(339, 39, 10, '2025-10-02', 56.28, 'Normal'),
(131, 31, 1, '2025-10-05', 109.18, 'Low'),
(340, 40, 7, '2025-10-06', 4.52, 'Normal'),
(411, 11, 6, '2025-10-08', 0.25, 'Normal'),
(322, 22, 9, '2025-10-08', 26.76, 'Normal'),
(125, 25, 2, '2025-10-11', 20.13, 'Normal'),
(94, 94, 1, '2025-10-11', 139.03, 'Normal'),
(223, 23, 1, '2025-10-12', 152.4, 'Normal'),
(437, 37, 5, '2025-10-13', 97.21, 'Normal'),
(255, 55, 7, '2025-10-14', 3.76, 'Normal'),
(307, 7, 2, '2025-10-14', 19.82, 'Low'),
(295, 95, 10, '2025-10-14', 125.36, 'High'),
(198, 98, 10, '2025-10-16', 159.37, 'High'),
(583, 89, 5, '2025-10-18', 136.1, 'High'),
(218, 18, 1, '2025-10-18', 151.86, 'Normal'),
(305, 5, 9, '2025-10-18', 22.36, 'Normal'),
(262, 27, 7, '2025-10-20', 4.45, 'Normal'),
(574, 74, 6, '2025-10-23', 2.95, 'Normal'),
(562, 58, 9, '2025-10-23', 25.06, 'Normal'),
(394, 94, 6, '2025-10-26', 0.68, 'Normal'),
(296, 96, 9, '2025-10-27', 6.67, 'Low'),
(43, 87, 7, '2025-10-28', 4.41, 'Normal'),
(189, 89, 6, '2025-10-31', 4.81, 'Normal'),
(32, 32, 1, '2025-11-02', 130.17, 'Normal'),
(12, 12, 1, '2025-11-03', 125.29, 'Normal'),
(368, 68, 6, '2025-11-03', 7.44, 'High'),
(275, 75, 6, '2025-11-04', 2.85, 'Normal'),
(16, 56, 6, '2025-11-07', 1.74, 'Normal'),
(458, 58, 8, '2025-11-08', 139.57, 'Normal'),
(59, 59, 9, '2025-11-08', 4.99, 'Low'),
(197, 91, 7, '2025-11-10', 4.78, 'Normal'),
(93, 93, 7, '2025-11-11', 3.82, 'Normal'),
(287, 87, 1, '2025-11-12', 146.78, 'Normal'),
(128, 28, 5, '2025-11-12', 94.14, 'Normal'),
(195, 95, 2, '2025-11-14', 21.41, 'Normal'),
(510, 10, 10, '2025-11-16', 118.66, 'Normal'),
(542, 42, 3, '2025-11-16', 3.3, 'Normal'),
(310, 84, 8, '2025-11-18', 133.68, 'Normal'),
(123, 23, 9, '2025-11-23', 44.23, 'Normal'),
(74, 2, 8, '2025-11-26', 150.48, 'High'),
(243, 43, 10, '2025-11-27', 82.81, 'Normal'),
(498, 98, 10, '2025-11-27', 73.58, 'Normal'),
(115, 62, 4, '2025-11-28', 1.17, 'Normal'),
(482, 76, 2, '2025-11-30', 41.34, 'Normal'),
(420, 20, 2, '2025-11-30', 14.75, 'Low'),
(265, 65, 4, '2025-12-01', 1.24, 'Normal'),
(274, 74, 9, '2025-12-04', 84.56, 'High'),
(391, 91, 4, '2025-12-05', 2.08, 'Normal'),
(277, 70, 6, '2025-12-06', 6.37, 'High'),
(131, 31, 5, '2025-12-11', 116.59, 'Normal'),
(491, 91, 7, '2025-12-11', 3.5, 'Normal'),
(281, 81, 2, '2025-12-11', 17.05, 'Low'),
(186, 86, 10, '2025-12-11', 118.12, 'Normal'),
(298, 98, 6, '2025-12-13', 3.2, 'Normal'),
(395, 84, 1, '2025-12-14', 139.59, 'Normal'),
(254, 54, 2, '2025-12-15', 48.59, 'High'),
(44, 44, 8, '2025-12-15', 136.72, 'Normal'),
(535, 35, 6, '2025-12-16', 4.12, 'Normal'),
(402, 2, 2, '2025-12-17', 51.17, 'High'),
(255, 68, 10, '2025-12-19', 27.63, 'Low'),
(37, 37, 4, '2025-12-19', 0.72, 'Normal'),
(100, 100, 4, '2025-12-20', 1.55, 'Normal'),
(120, 20, 3, '2025-12-28', 0.89, 'Normal'),
(101, 46, 6, '2026-01-01', 1.85, 'Normal'),
(248, 48, 6, '2026-01-01', 7.42, 'High'),
(344, 44, 4, '2026-01-02', 1.11, 'Normal'),
(191, 91, 1, '2026-01-03', 103.22, 'Low'),
(175, 65, 6, '2026-01-06', 3.53, 'Normal'),
(191, 91, 4, '2026-01-09', 0.31, 'Low'),
(406, 6, 9, '2026-01-09', 73.1, 'High'),
(454, 54, 8, '2026-01-12', 144.22, 'Normal'),
(237, 37, 9, '2026-01-12', 66.92, 'High'),
(111, 11, 8, '2026-01-13', 135.97, 'Normal'),
(88, 95, 9, '2026-01-14', 33.51, 'Normal'),
(352, 52, 7, '2026-01-18', 5.62, 'High'),
(246, 46, 7, '2026-01-20', 3.55, 'Normal'),
(94, 94, 3, '2026-01-20', 5.65, 'High'),
(253, 53, 5, '2026-01-21', 105.83, 'Normal'),
(570, 12, 7, '2026-01-23', 4.55, 'Normal'),
(158, 58, 1, '2026-01-24', 127.61, 'Normal'),
(98, 98, 6, '2026-01-26', 0.38, 'Normal'),
(329, 29, 5, '2026-01-26', 112.88, 'Normal'),
(178, 78, 8, '2026-01-27', 146.79, 'High'),
(187, 81, 10, '2026-01-27', 42.45, 'Low'),
(158, 58, 6, '2026-01-28', 2.33, 'Normal'),
(504, 4, 4, '2026-02-02', 0.45, 'Normal'),
(384, 84, 9, '2026-02-03', 72.07, 'High'),
(225, 25, 2, '2026-02-07', 40.55, 'Normal'),
(547, 47, 3, '2026-02-09', 0.61, 'Normal'),
(434, 34, 4, '2026-02-10', 0.05, 'Low'),
(24, 79, 8, '2026-02-12', 141.52, 'Normal'),
(508, 8, 7, '2026-02-13', 4.16, 'Normal'),
(590, 29, 6, '2026-02-15', 4.01, 'Normal'),
(577, 77, 7, '2026-02-15', 4.38, 'Normal'),
(515, 15, 3, '2026-02-18', 2.5, 'Normal'),
(592, 92, 9, '2026-02-18', 72.53, 'High'),
(338, 38, 1, '2026-02-20', 139.96, 'Normal'),
(599, 2, 4, '2026-02-25', 5.28, 'High'),
(97, 97, 8, '2026-02-26', 131.08, 'Low'),
(112, 12, 8, '2026-02-28', 144.33, 'Normal'),
(89, 89, 3, '2026-02-28', 5.53, 'High'),
(185, 85, 3, '2026-03-01', 1.8, 'Normal'),
(74, 19, 4, '2026-03-01', 1.85, 'Normal'),
(568, 68, 1, '2026-03-01', 109.82, 'Low'),
(253, 98, 3, '2026-03-04', 4.04, 'Normal'),
(388, 88, 1, '2026-03-05', 158.71, 'Normal'),
(212, 12, 6, '2026-03-05', 0.41, 'Normal'),
(76, 76, 3, '2026-03-05', 2.42, 'Normal'),
(145, 45, 3, '2026-03-06', 4.29, 'Normal'),
(233, 84, 9, '2026-03-06', 4.63, 'Low'),
(414, 33, 7, '2026-03-07', 4.43, 'Normal'),
(347, 36, 10, '2026-03-09', 88.26, 'Normal'),
(556, 56, 4, '2026-03-10', 2.23, 'Normal'),
(497, 97, 7, '2026-03-10', 3.79, 'Normal'),
(591, 91, 3, '2026-03-14', 8.0, 'High'),
(382, 82, 7, '2026-03-14', 4.38, 'Normal'),
(289, 89, 8, '2026-03-19', 149.87, 'High'),
(351, 51, 8, '2026-03-22', 131.53, 'Low'),
(457, 26, 9, '2026-03-25', 17.29, 'Normal'),
(218, 18, 6, '2026-03-25', 5.98, 'High'),
(253, 53, 4, '2026-03-29', 0.92, 'Normal'),
(479, 79, 10, '2026-03-29', 33.6, 'Low'),
(83, 83, 5, '2026-03-30', 99.54, 'Normal'),
(438, 38, 10, '2026-04-02', 107.28, 'Normal'),
(470, 70, 3, '2026-04-06', 2.71, 'Normal'),
(195, 81, 6, '2026-04-08', 7.02, 'High'),
(460, 60, 8, '2026-04-09', 132.95, 'Low'),
(304, 4, 10, '2026-04-11', 93.13, 'Normal'),
(549, 49, 1, '2026-04-15', 192.04, 'High'),
(65, 80, 8, '2026-04-15', 146.53, 'High'),
(348, 48, 3, '2026-04-18', 4.7, 'Normal'),
(152, 52, 9, '2026-04-18', 24.34, 'Normal'),
(484, 28, 8, '2026-04-21', 130.49, 'Low'),
(371, 71, 1, '2026-04-27', 136.36, 'Normal'),
(529, 29, 9, '2026-04-29', 80.14, 'High'),
(297, 97, 6, '2026-04-29', 5.4, 'High'),
(107, 7, 7, '2026-04-29', 3.63, 'Normal'),
(61, 61, 10, '2026-04-29', 73.65, 'Normal'),
(302, 2, 4, '2026-04-30', 0.55, 'Normal'),
(70, 70, 4, '2026-04-30', 2.31, 'Normal'),
(449, 76, 9, '2026-05-01', 34.14, 'Normal'),
(152, 52, 2, '2026-05-04', 54.81, 'High'),
(521, 21, 4, '2026-05-07', 0.31, 'Low'),
(285, 85, 7, '2026-05-09', 4.27, 'Normal'),
(104, 4, 5, '2026-05-11', 104.02, 'Normal'),
(454, 92, 8, '2026-05-12', 137.04, 'Normal'),
(207, 2, 6, '2026-05-13', 3.45, 'Normal'),
(384, 84, 4, '2026-05-16', 3.19, 'Normal'),
(260, 60, 9, '2026-05-16', 76.59, 'High'),
(484, 44, 7, '2026-05-20', 4.18, 'Normal'),
(266, 66, 3, '2026-05-21', 5.93, 'High'),
(284, 4, 4, '2026-05-22', 0.02, 'Low'),
(350, 50, 5, '2026-05-22', 113.63, 'Normal'),
(183, 83, 3, '2026-05-23', 3.33, 'Normal'),
(58, 58, 2, '2026-05-23', 24.49, 'Normal'),
(21, 21, 8, '2026-05-23', 138.6, 'Normal'),
(306, 46, 2, '2026-05-26', 37.07, 'Normal'),
(2, 26, 1, '2026-05-27', 179.79, 'High'),
(310, 10, 7, '2026-05-29', 4.77, 'Normal'),
(580, 80, 8, '2026-05-29', 137.96, 'Normal'),
(554, 54, 7, '2026-05-29', 5.88, 'High'),
(588, 77, 1, '2026-05-30', 140.36, 'Normal'),
(372, 72, 5, '2026-05-31', 118.87, 'Normal'),
(47, 47, 1, '2026-06-01', 114.23, 'Low'),
(371, 71, 5, '2026-06-02', 135.15, 'High'),
(567, 67, 7, '2026-06-04', 4.57, 'Normal'),
(447, 44, 1, '2026-06-04', 162.31, 'Normal'),
(468, 68, 4, '2026-06-07', 3.3, 'Normal'),
(128, 28, 8, '2026-06-08', 135.73, 'Normal'),
(21, 21, 5, '2026-06-08', 84.97, 'Low'),
(239, 39, 4, '2026-06-16', 2.47, 'Normal'),
(33, 33, 10, '2026-06-18', 43.4, 'Low'),
(294, 94, 8, '2026-06-18', 138.06, 'Normal'),
(427, 22, 8, '2026-06-18', 138.18, 'Normal'),
(256, 56, 5, '2026-06-19', 113.87, 'Normal'),
(178, 78, 5, '2026-06-21', 109.2, 'Normal'),
(61, 83, 4, '2026-06-22', 2.76, 'Normal'),
(160, 60, 5, '2026-06-25', 93.56, 'Normal'),
(398, 98, 8, '2026-06-25', 136.3, 'Normal'),
(181, 81, 1, '2026-06-26', 134.74, 'Normal'),
(595, 95, 7, '2026-06-29', 3.82, 'Normal'),
(141, 41, 7, '2026-06-29', 5.26, 'Normal'),
(460, 76, 8, '2026-06-29', 141.69, 'Normal'),
(555, 53, 10, '2026-06-30', 63.96, 'Normal'),
(201, 66, 7, '2026-06-30', 3.74, 'Normal'),
(241, 41, 5, '2026-07-01', 114.75, 'Normal'),
(442, 42, 6, '2026-07-01', 2.62, 'Normal'),
(195, 95, 6, '2026-07-02', 2.63, 'Normal'),
(44, 44, 8, '2026-07-02', 136.48, 'Normal'),
(16, 16, 7, '2026-07-04', 4.77, 'Normal'),
(187, 87, 4, '2026-07-07', 3.38, 'Normal'),
(15, 15, 1, '2026-07-08', 161.41, 'Normal'),
(477, 77, 1, '2026-07-10', 118.52, 'Normal'),
(307, 7, 8, '2026-07-11', 135.21, 'Normal'),
(388, 88, 9, '2026-07-17', 53.88, 'Normal'),
(171, 71, 6, '2026-07-19', 0.77, 'Normal'),
(265, 65, 2, '2026-07-20', 35.01, 'Normal'),
(504, 4, 6, '2026-07-20', 0.16, 'Normal'),
(522, 22, 3, '2026-07-20', 3.33, 'Normal'),
(531, 21, 3, '2026-07-21', 2.32, 'Normal'),
(496, 77, 2, '2026-07-22', 23.12, 'Normal'),
(27, 27, 5, '2026-07-22', 105.09, 'Normal'),
(197, 97, 10, '2026-07-23', 149.79, 'High'),
(50, 50, 5, '2026-07-26', 93.56, 'Normal'),
(514, 14, 8, '2026-07-26', 145.55, 'Normal'),
(344, 44, 9, '2026-07-26', 33.86, 'Normal'),
(142, 42, 1, '2026-07-30', 122.79, 'Normal'),
(139, 65, 9, '2026-07-31', 29.55, 'Normal'),
(35, 35, 1, '2026-08-01', 107.64, 'Low'),
(339, 39, 6, '2026-08-03', 7.13, 'High'),
(172, 72, 6, '2026-08-03', 1.86, 'Normal'),
(402, 23, 1, '2026-08-04', 187.45, 'High'),
(85, 85, 7, '2026-08-05', 3.26, 'Low'),
(151, 51, 6, '2026-08-07', 1.54, 'Normal'),
(91, 91, 6, '2026-08-13', 4.35, 'Normal'),
(57, 57, 6, '2026-08-14', 6.81, 'High'),
(330, 30, 6, '2026-08-14', 4.6, 'Normal'),
(134, 34, 2, '2026-08-15', 16.91, 'Low'),
(25, 25, 10, '2026-08-16', 77.99, 'Normal'),
(34, 97, 2, '2026-08-18', 19.62, 'Low'),
(107, 7, 9, '2026-08-19', 40.89, 'Normal'),
(86, 85, 8, '2026-08-23', 150.2, 'High'),
(479, 79, 4, '2026-08-25', 3.26, 'Normal'),
(329, 29, 4, '2026-08-25', 5.96, 'High'),
(351, 51, 8, '2026-08-25', 143.47, 'Normal'),
(505, 5, 4, '2026-08-26', 3.22, 'Normal'),
(217, 20, 6, '2026-08-27', 0.15, 'Normal'),
(477, 77, 10, '2026-08-28', 31.76, 'Low'),
(221, 21, 7, '2026-08-29', 4.66, 'Normal'),
(505, 5, 4, '2026-08-30', 2.14, 'Normal'),
(170, 49, 9, '2026-09-01', 34.0, 'Normal'),
(330, 30, 9, '2026-09-04', 22.35, 'Normal'),
(353, 86, 8, '2026-09-06', 139.24, 'Normal'),
(577, 77, 7, '2026-09-06', 4.17, 'Normal'),
(98, 98, 8, '2026-09-07', 133.91, 'Normal'),
(196, 96, 4, '2026-09-08', 2.32, 'Normal'),
(597, 97, 4, '2026-09-09', 3.37, 'Normal'),
(170, 60, 8, '2026-09-09', 145.15, 'Normal'),
(141, 41, 5, '2026-09-12', 90.64, 'Normal'),
(78, 78, 2, '2026-09-13', 36.11, 'Normal'),
(325, 25, 2, '2026-09-13', 46.98, 'High'),
(581, 81, 6, '2026-09-14', 2.55, 'Normal'),
(423, 23, 1, '2026-09-17', 159.12, 'Normal'),
(393, 93, 4, '2026-09-21', 2.98, 'Normal'),
(393, 57, 7, '2026-09-22', 5.13, 'Normal'),
(65, 65, 5, '2026-09-23', 108.88, 'Normal'),
(165, 65, 9, '2026-09-24', 63.72, 'High'),
(38, 38, 8, '2026-09-24', 134.73, 'Normal'),
(219, 19, 4, '2026-09-25', 1.64, 'Normal'),
(117, 17, 9, '2026-09-26', 0.98, 'Low'),
(339, 39, 8, '2026-09-27', 139.15, 'Normal'),
(275, 80, 9, '2026-09-27', 13.86, 'Normal'),
(360, 8, 5, '2026-09-28', 101.37, 'Normal'),
(106, 6, 8, '2026-10-01', 140.66, 'Normal'),
(325, 25, 4, '2026-10-01', 0.05, 'Low'),
(108, 8, 3, '2026-10-04', 4.64, 'Normal'),
(269, 39, 8, '2026-10-04', 151.04, 'High'),
(138, 38, 1, '2026-10-07', 125.64, 'Normal'),
(21, 21, 1, '2026-10-08', 158.48, 'Normal'),
(542, 42, 2, '2026-10-09', 21.16, 'Normal'),
(32, 32, 9, '2026-10-09', 5.28, 'Low'),
(61, 61, 2, '2026-10-11', 41.15, 'Normal'),
(565, 44, 6, '2026-10-13', 2.5, 'Normal'),
(189, 52, 7, '2026-10-15', 3.6, 'Normal'),
(161, 61, 7, '2026-10-17', 4.26, 'Normal'),
(233, 33, 2, '2026-10-17', 14.84, 'Low'),
(107, 46, 7, '2026-10-19', 5.09, 'Normal'),
(19, 13, 6, '2026-10-20', 3.72, 'Normal'),
(517, 17, 5, '2026-10-20', 130.82, 'High'),
(115, 15, 5, '2026-10-22', 114.56, 'Normal'),
(47, 47, 3, '2026-10-23', 4.23, 'Normal'),
(314, 12, 1, '2026-10-27', 138.94, 'Normal'),
(333, 33, 7, '2026-10-27', 3.16, 'Low'),
(214, 41, 1, '2026-10-27', 136.41, 'Normal'),
(293, 93, 10, '2026-10-29', 119.39, 'Normal'),
(79, 79, 9, '2026-10-29', 8.38, 'Normal'),
(475, 75, 2, '2026-10-31', 25.02, 'Normal'),
(280, 80, 5, '2026-11-05', 101.37, 'Normal'),
(85, 85, 2, '2026-11-05', 22.6, 'Normal'),
(595, 95, 4, '2026-11-09', 2.75, 'Normal'),
(259, 59, 3, '2026-11-10', 2.6, 'Normal'),
(406, 6, 4, '2026-11-12', 2.17, 'Normal'),
(21, 21, 4, '2026-11-14', 5.47, 'High'),
(230, 30, 6, '2026-11-15', 0.72, 'Normal'),
(277, 77, 1, '2026-11-15', 155.62, 'Normal'),
(299, 99, 10, '2026-11-19', 64.61, 'Normal'),
(76, 76, 4, '2026-11-20', 3.27, 'Normal');


-- ------------------------------------------------------------
-- Quick checks
-- expected: 30 hospitals with a year, 15 diseases,
-- 140 specialisms, 10 test types, 500 lab results
-- ------------------------------------------------------------
SELECT 'Hospitals with accreditation year' AS what, COUNT(*) AS n FROM Hospitals WHERE AccreditationYear IS NOT NULL
UNION ALL SELECT 'diseases', COUNT(*) FROM diseases
UNION ALL SELECT 'disease_medications', COUNT(*) FROM disease_medications
UNION ALL SELECT 'doctor_specialisms', COUNT(*) FROM doctor_specialisms
UNION ALL SELECT 'lab_test_types', COUNT(*) FROM lab_test_types
UNION ALL SELECT 'lab_results', COUNT(*) FROM lab_results;
