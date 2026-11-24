-- =========================================
-- Medication Database
-- Group Coursework: Computational Group 2
-- 30 fictional dataset medication records
-- =========================================

-- Create the Medications table

CREATE TABLE IF NOT EXISTS Medications (
    MedicationID INT NOT NULL,
    MedicationName VARCHAR(100) NOT NULL,
    PRIMARY KEY (MedicationID),
    UNIQUE (MedicationName)
);

-- Insert 30 medications

INSERT IGNORE INTO Medications
(MedicationID, MedicationName)
VALUES
(1, 'Atorvastatin'),
(2, 'Diclofenac'),
(3, 'Ezetimibe'),
(4, 'Doxycycline'),
(5, 'Furosemide'),
(6, 'Salbutamol'),
(7, 'Spironolactone'),
(8, 'Tamsulosin'),
(9, 'Amoxicillin'),
(10, 'Bisoprolol'),
(11, 'Insulin'),
(12, 'Simvastatin'),
(13, 'Prednisolone'),
(14, 'Ibuprofen'),
(15, 'Amlodipine'),
(16, 'Fluoxetine'),
(17, 'Cetirizine'),
(18, 'Montelukast'),
(19, 'Hydrochlorothiazide'),
(20, 'Ramipril'),
(21, 'Losartan'),
(22, 'Gliclazide'),
(23, 'Warfarin'),
(24, 'Citalopram'),
(25, 'Levothyroxine'),
(26, 'Tramadol'),
(27, 'Loratadine'),
(28, 'Sertraline'),
(29, 'Lansoprazole'),
(30, 'Paracetamol');

-- Check the inserted medications

SELECT * FROM Medications;

-- Check the total number of medications

SELECT COUNT(*) AS TotalMedications
FROM Medications;
