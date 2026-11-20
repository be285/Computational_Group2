SELECT *
FROM doctors
WHERE Hospital_name = 'Ashford Children Hospital';

SELECT *
FROM Prescriptions
WHERE PatientID=493
ORDER BY date DESC;

SELECT *
FROM Prescriptions
WHERE DoctorID=91; 

SELECT *
FROM Prescriptions 
JOIN Patients
  ON Prescriptions.PatientID = Patients.PatientID
ORDER BY Patients.patient_firstname, Patients.patient_surname;