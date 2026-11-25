# Query results

HPDM172 Group 2 - Xuening Chang (CX branch)

These are the results of every query in `query.sql`, run on MySQL 8.0 on the module Ubuntu VM.
The database was built in this order: `Coursework.sql` (patientsanddoctors branch), `medications.sql`, `prescriptions_table.sql`, `extra_tables_partB.sql`, then `query.sql`.
The results were saved by running `show_results.sql` with `tee`.

Part B 1 and 2 change the data, so they were run first on a fresh database (new patient = 601).

## Contents

| # | Query | Rows |
|---|---|---|
| A1 | [Doctors based at a particular hospital](#a1-doctors-based-at-a-particular-hospital) | 3 rows |
| A2 | [Prescriptions for a particular patient, ordered by date](#a2-prescriptions-for-a-particular-patient-ordered-by-date) | 3 rows |
| A3 | [Prescriptions made by a particular doctor](#a3-prescriptions-made-by-a-particular-doctor) | 6 rows |
| A4 | [All prescriptions ordered by patient name](#a4-all-prescriptions-ordered-by-patient-name) | 500 rows |
| B1 | [Add a new patient registered with a doctor](#b1-add-a-new-patient-registered-with-a-doctor) | 1 row |
| B2 | [Modify an existing patient's address](#b2-modify-an-existing-patients-address) | 1 row |
| B3 | [Mailing list: patients registered to doctors at one hospital](#b3-mailing-list-patients-registered-to-doctors-at-one-hospital) | 18 rows |
| B4 | [Doctors at Teaching hospitals accredited 2015-2024](#b4-doctors-at-teaching-hospitals-accredited-2015-2024) | 14 rows |
| B5 | [Patients who may have a disease, based on their medication](#b5-patients-who-may-have-a-disease-based-on-their-medication) | 45 rows |
| B6 | [Doctors who specialise in a particular disease](#b6-doctors-who-specialise-in-a-particular-disease) | 9 rows |
| B7 | [Lab results for patients over 60](#b7-lab-results-for-patients-over-60) | 200 rows |
| B8 | [Appointments for a given patient](#b8-appointments-for-a-given-patient) | 1 row |
| B9 | [Appointments for a given doctor](#b9-appointments-for-a-given-doctor) | 6 rows |
| B10 | [Prescriptions from one hospital, A-Z by medication (4 columns)](#b10-prescriptions-from-one-hospital-a-z-by-medication-4-columns) | 25 rows |
| B11 | [Lab results from hospitals accredited 2013-2020](#b11-lab-results-from-hospitals-accredited-2013-2020) | 162 rows |
| B12 | [Doctor with the most prescriptions](#b12-doctor-with-the-most-prescriptions) | 3 rows |
| B13 | [Doctors at the hospital with the most beds](#b13-doctors-at-the-hospital-with-the-most-beds) | 3 rows |
| B14 | [Hospitals accredited before 2015 with Emergency Service](#b14-hospitals-accredited-before-2015-with-emergency-service) | 6 rows |
| B15 | [Patients at hospitals with fewer than 400 beds](#b15-patients-at-hospitals-with-fewer-than-400-beds) | 426 rows |

---

## Part A

### A1 Doctors based at a particular hospital

```sql
SELECT *
FROM doctors
WHERE hospital_name = 'Ashford Children Hospital';
```

```
+-----------+------------------+----------------+---------------+------------------------------------------+---------------------------+
| doctor_id | doctor_firstname | doctor_surname | date_of_birth | doctor_address                           | hospital_name             |
+-----------+------------------+----------------+---------------+------------------------------------------+---------------------------+
|         1 | Sana             | Qureshi        | 1988-04-27    | 85, Meadow Crescent, Portsmouth, PO6 2GR | Ashford Children Hospital |
|        41 | Lucia            | Fernandez      | 1995-10-08    | 76, Rowan Close, Cardiff, CF23 5WT       | Ashford Children Hospital |
|        81 | Reza             | Farhadi        | 1961-04-06    | 134, Hazel Drive, Coventry, CV2 1XQ      | Ashford Children Hospital |
+-----------+------------------+----------------+---------------+------------------------------------------+---------------------------+
```

*3 rows in set*

### A2 Prescriptions for a particular patient, ordered by date

```sql
SELECT *
FROM Prescriptions
WHERE PatientID = 493
ORDER BY PrescriptionDate DESC;
```

```
+----------------+-----------+----------+--------------+------------------+
| PrescriptionID | PatientID | DoctorID | MedicationID | PrescriptionDate |
+----------------+-----------+----------+--------------+------------------+
|              1 |       493 |       91 |           17 | 2026-08-05       |
|             28 |       493 |       40 |           19 | 2026-08-02       |
|             47 |       493 |       79 |           20 | 2026-07-02       |
+----------------+-----------+----------+--------------+------------------+
```

*3 rows in set*

### A3 Prescriptions made by a particular doctor

```sql
SELECT *
FROM Prescriptions
WHERE DoctorID = 91;
```

```
+----------------+-----------+----------+--------------+------------------+
| PrescriptionID | PatientID | DoctorID | MedicationID | PrescriptionDate |
+----------------+-----------+----------+--------------+------------------+
|              1 |       493 |       91 |           17 | 2026-08-05       |
|            209 |        79 |       91 |            9 | 2026-09-06       |
|            271 |       342 |       91 |            3 | 2025-03-20       |
|            332 |       270 |       91 |           17 | 2025-04-07       |
|            406 |       531 |       91 |           20 | 2026-05-05       |
|            480 |       332 |       91 |            7 | 2026-02-16       |
+----------------+-----------+----------+--------------+------------------+
```

*6 rows in set*

### A4 All prescriptions ordered by patient name

```sql
SELECT *
FROM Prescriptions
JOIN patients
  ON Prescriptions.PatientID = patients.patient_id
ORDER BY patients.patient_firstname, patients.patient_surname;
```

```
+----------------+-----------+----------+--------------+------------------+------------+-------------------+-----------------+---------------+-----------------------------------------------------+-----------+
| PrescriptionID | PatientID | DoctorID | MedicationID | PrescriptionDate | patient_id | patient_firstname | patient_surname | date_of_birth | patient_address                                     | doctor_id |
+----------------+-----------+----------+--------------+------------------+------------+-------------------+-----------------+---------------+-----------------------------------------------------+-----------+
|            474 |        51 |       94 |            1 | 2025-12-26       |         51 | Aaron             | Turner          | 1954-10-04    | 101, Heather Close, Lisburn, BT28 1HN               |        51 |
|            336 |        51 |       35 |           12 | 2025-07-13       |         51 | Aaron             | Turner          | 1954-10-04    | 101, Heather Close, Lisburn, BT28 1HN               |        51 |
|            438 |       316 |       50 |            4 | 2026-01-08       |        316 | Adam              | Bennett         | 2006-12-21    | 63, Devonshire Close, Southampton, SO16 3GJ         |        16 |
|            150 |       353 |        4 |            5 | 2025-12-12       |        353 | Adam              | Rojas           | 1962-06-01    | 144, Clifton Road, Newcastle upon Tyne, NE4 5QS     |        53 |
|            211 |       353 |       16 |           19 | 2025-05-20       |        353 | Adam              | Rojas           | 1962-06-01    | 144, Clifton Road, Newcastle upon Tyne, NE4 5QS     |        53 |
|            396 |       315 |       71 |            5 | 2026-02-10       |        315 | Adan              | Medrano         | 1968-06-17    | 111, Pine Close, Derry, BT47 4RA                    |        15 |
|            387 |       370 |       38 |           23 | 2026-09-08       |        370 | Adebayo           | Mensah          | 1971-02-15    | 56, Hazel Lane, Hull, HU8 6WB                       |        70 |
|            167 |       275 |       63 |           12 | 2025-05-31       |        275 | Adelaide          | Georges         | 1982-05-08    | 45, Holly Close, Bath, BA2 6UA                      |        75 |
|            318 |       395 |       52 |            8 | 2025-10-07       |        395 | Aimee             | Peron           | 2013-09-25    | 132, Linden Grove, Nottingham, NG8 3YD              |        95 |
|            366 |       395 |        3 |           10 | 2025-07-01       |        395 | Aimee             | Peron           | 2013-09-25    | 132, Linden Grove, Nottingham, NG8 3YD              |        95 |
|            273 |       395 |       85 |           10 | 2025-04-23       |        395 | Aimee             | Peron           | 2013-09-25    | 132, Linden Grove, Nottingham, NG8 3YD              |        95 |
|            424 |       267 |       59 |            1 | 2025-12-04       |        267 | Aisha             | Ahmed           | 1944-01-13    | 91, Moorland Avenue, York, YO24 3PS                 |        67 |
|            304 |       194 |       83 |            3 | 2025-12-19       |        194 | Akcabay           | Inonu           | 1986-06-27    | 39, Mill Close, Southampton, SO15 8RB               |        94 |
|            208 |       574 |       33 |            2 | 2026-01-08       |        574 | Alan              | Paneta          | 1992-10-19    | 179, Oak Road, Southampton, SO15 9BW                |        74 |
|            191 |        74 |       46 |           14 | 2026-03-26       |         74 | Alcides           | Rocamora        | 1963-01-29    | 62, Riverside Place, Exeter, EX1 9ZY                |        74 |
|            249 |        74 |       38 |            7 | 2026-02-20       |         74 | Alcides           | Rocamora        | 1963-01-29    | 62, Riverside Place, Exeter, EX1 9ZY                |        74 |
|             39 |        74 |       59 |            3 | 2026-06-30       |         74 | Alcides           | Rocamora        | 1963-01-29    | 62, Riverside Place, Exeter, EX1 9ZY                |        74 |
|            219 |       178 |       96 |           10 | 2025-05-10       |        178 | Alexis            | Williams        | 1997-03-16    | 60, Willow Gardens, Swansea, SA1 9PJ                |        78 |
|            417 |       279 |       94 |            4 | 2025-02-20       |        279 | Alicia            | Herman          | 1963-01-13    | 23, Rowan Close, Aberdeen, AB10 2SG                 |        79 |
|             18 |       279 |       10 |           19 | 2025-07-27       |        279 | Alicia            | Herman          | 1963-01-13    | 23, Rowan Close, Aberdeen, AB10 2SG                 |        79 |
|            382 |       279 |        7 |            3 | 2026-08-15       |        279 | Alicia            | Herman          | 1963-01-13    | 23, Rowan Close, Aberdeen, AB10 2SG                 |        79 |
|            355 |       599 |       55 |           21 | 2026-10-26       |        599 | Alison            | Parkinson       | 2022-07-29    | 110, Kings Lane, Nottingham, NG5 4GN                |        99 |
|            481 |        71 |       74 |           10 | 2024-12-21       |         71 | Ama               | Mensah          | 1937-05-09    | 92, Church Grove, Derry, BT48 7XL                   |        71 |
|            193 |       428 |       36 |           12 | 2025-06-13       |        428 | Ama               | Okafor          | 1985-11-22    | 58, Mayfield Crescent, Wrexham, LL11 1ZH            |        28 |
|            139 |       350 |       26 |           12 | 2026-02-18       |        350 | Ama               | Osei            | 1943-11-14    | 70, Bramble Road, Exeter, EX1 1NS                   |        50 |
|            260 |       108 |       45 |           24 | 2026-07-28       |        108 | Ama               | Owusu           | 2009-12-14    | 149, Bluebell Court, Cardiff, CF5 5AT               |         8 |
|            230 |       254 |       54 |           20 | 2025-02-19       |        254 | Amador            | Duran           | 1971-03-20    | 134, Maple Close, Sheffield, S6 7HH                 |        54 |
|            145 |       166 |       32 |            9 | 2026-02-13       |        166 | Amara             | Okafor          | 2016-09-12    | 63, Foxglove Gardens, Coventry, CV3 3ZS             |        66 |
|            171 |         1 |       81 |            2 | 2026-06-28       |          1 | Amber             | Weber           | 1990-02-19    | 91, Kings Street, Birmingham, B28 6GG               |         1 |
|            467 |         1 |        7 |           12 | 2025-02-17       |          1 | Amber             | Weber           | 1990-02-19    | 91, Kings Street, Birmingham, B28 6GG               |         1 |
|             85 |       271 |       31 |           24 | 2025-11-14       |        271 | Amy               | Cole            | 2014-03-04    | 51, Queens Place, Belfast, BT15 4XX                 |        71 |
|            278 |       271 |        5 |           23 | 2026-10-01       |        271 | Amy               | Cole            | 2014-03-04    | 51, Queens Place, Belfast, BT15 4XX                 |        71 |
|            379 |       249 |       80 |           27 | 2025-03-25       |        249 | Ana Sophia        | Novaes          | 2007-05-10    | 135, Hawthorn Gardens, Swansea, SA5 5FA             |        49 |
|            405 |       393 |      100 |            9 | 2025-05-09       |        393 | Ananya            | Gupta           | 1935-10-11    | 73, Rose Place, Liverpool, L15 3DU                  |        93 |
|            129 |       393 |       54 |           11 | 2026-01-22       |        393 | Ananya            | Gupta           | 1935-10-11    | 73, Rose Place, Liverpool, L15 3DU                  |        93 |
|            235 |        59 |       63 |           11 | 2025-10-12       |         59 | Ananya            | Nair            | 1972-04-01    | 20, Cherry Lane, Bangor, BT20 4RZ                   |        59 |
|            395 |        59 |       12 |           17 | 2025-12-08       |         59 | Ananya            | Nair            | 1972-04-01    | 20, Cherry Lane, Bangor, BT20 4RZ                   |        59 |
|            461 |       248 |       92 |            2 | 2025-03-15       |        248 | Ananya            | Shah            | 1954-02-17    | 157, Elm Street, Bath, BA2 1FY                      |        48 |
|            299 |       464 |       89 |           15 | 2026-08-03       |        464 | Andriy            | Koval           | 1979-08-25    | 149, Bramble Place, Derry, BT47 4SF                 |        64 |
|            288 |       464 |       58 |           28 | 2026-03-09       |        464 | Andriy            | Koval           | 1979-08-25    | 149, Bramble Place, Derry, BT47 4SF                 |        64 |
|            220 |       382 |       82 |           30 | 2025-08-13       |        382 | Aniela            | Paw             | 1995-04-06    | 103, Church Gardens, Belfast, BT9 4SF               |        82 |
|            338 |       382 |       32 |           18 | 2026-10-26       |        382 | Aniela            | Paw             | 1995-04-06    | 103, Church Gardens, Belfast, BT9 4SF               |        82 |
|            161 |       106 |       10 |           19 | 2024-12-13       |        106 | Ann               | Graham          | 1930-07-07    | 171, Chestnut Crescent, Exeter, EX4 9EJ             |         6 |
|            165 |       106 |       97 |           14 | 2025-01-21       |        106 | Ann               | Graham          | 1930-07-07    | 171, Chestnut Crescent, Exeter, EX4 9EJ             |         6 |
|            441 |       487 |       83 |           26 | 2026-05-31       |        487 | Annette           | Shaw            | 1976-12-23    | 74, Station Avenue, York, YO24 3BY                  |        87 |
|            455 |       487 |       76 |           24 | 2025-09-05       |        487 | Annette           | Shaw            | 1976-12-23    | 74, Station Avenue, York, YO24 3BY                  |        87 |
|            209 |        79 |       91 |            9 | 2026-09-06       |         79 | Annunziata        | Germano         | 1940-01-10    | 96, Queens Place, Bangor, BT19 2HR                  |        79 |
|            118 |        79 |       23 |            1 | 2025-05-16       |         79 | Annunziata        | Germano         | 1940-01-10    | 96, Queens Place, Bangor, BT19 2HR                  |        79 |
|            258 |       422 |       98 |           17 | 2026-03-16       |        422 | Antonello         | Renzi           | 1981-09-11    | 94, Maple Close, Hull, HU6 5LD                      |        22 |
|            186 |       422 |       38 |           12 | 2026-10-06       |        422 | Antonello         | Renzi           | 1981-09-11    | 94, Maple Close, Hull, HU6 5LD                      |        22 |
|            389 |       333 |       98 |           11 | 2025-04-08       |        333 | Antoni            | Cieciura        | 1946-07-25    | 101, Belmont Terrace, Belfast, BT5 1GU              |        33 |
|            307 |       562 |       12 |           20 | 2026-08-21       |        562 | Antoni            | Koscik          | 1991-06-24    | 125, Linden Place, Leeds, LS12 4NR                  |        62 |
|            198 |       366 |       61 |           15 | 2025-06-23       |        366 | Antonia           | Loera           | 1948-04-01    | 64, Devonshire Place, Portsmouth, PO2 3ER           |        66 |
|            283 |       225 |       92 |           18 | 2025-04-10       |        225 | Antonina          | Gaiatto         | 1939-01-26    | 62, Heather Drive, Exeter, EX4 5PY                  |        25 |
|            280 |       424 |       54 |            2 | 2025-09-01       |        424 | Aoibheann         | Callan          | 1943-05-13    | 92, Hillcrest Road, Reading, RG1 2LA                |        24 |
|            125 |       446 |       29 |            6 | 2025-10-26       |        446 | Aoibheann         | Conneely        | 2026-10-25    | 176, Belmont Terrace, Cambridge, CB2 9RP            |        46 |
|            364 |       446 |       19 |           15 | 2025-05-30       |        446 | Aoibheann         | Conneely        | 2026-10-25    | 176, Belmont Terrace, Cambridge, CB2 9RP            |        46 |
|            399 |       539 |       11 |           23 | 2025-10-08       |        539 | April             | Davis           | 1941-10-14    | 128, Sycamore Close, Wrexham, LL11 4LJ              |        39 |
|            359 |       406 |       15 |           28 | 2025-01-27       |        406 | Ariadna           | Florez          | 1979-03-22    | 13, Birch Close, Edinburgh, EH11 6JR                |         6 |
|             71 |       411 |       63 |           17 | 2026-10-21       |        411 | Arif              | Hossain         | 2026-03-08    | 125, Westfield Lane, Truro, TR1 5TU                 |        11 |
|            470 |       472 |        2 |            8 | 2026-01-12       |        472 | Arjun             | Sharma          | 1947-04-17    | 1, Birch Way, Lisburn, BT28 2NB                     |        72 |
|            446 |       500 |       96 |           20 | 2025-07-15       |        500 | Arjun             | Singh           | 1936-09-16    | 19, Clifton Grove, Southampton, SO16 7PU            |       100 |
|            460 |       500 |       42 |           12 | 2025-08-28       |        500 | Arjun             | Singh           | 1936-09-16    | 19, Clifton Grove, Southampton, SO16 7PU            |       100 |
|            245 |       521 |       60 |           22 | 2025-04-14       |        521 | Arthur            | Paris           | 2004-04-13    | 31, Station Crescent, Plymouth, PL3 4LW             |        21 |
|            247 |       521 |        4 |           16 | 2025-09-18       |        521 | Arthur            | Paris           | 2004-04-13    | 31, Station Crescent, Plymouth, PL3 4LW             |        21 |
|            239 |        19 |        2 |            4 | 2026-04-07       |         19 | Ashling           | Tierney         | 1967-02-23    | 17, Maple Avenue, Swansea, SA2 1AP                  |        19 |
|            391 |        75 |       29 |           10 | 2026-07-26       |         75 | Aura              | Izquierdo       | 2017-03-10    | 115, Westfield Close, Norwich, NR7 2RN              |        75 |
|            176 |       567 |       50 |           24 | 2024-11-21       |        567 | Aysuna            | Ergul           | 2010-06-12    | 29, Orchard Way, Newcastle upon Tyne, NE4 6BH       |        67 |
|            352 |       567 |        5 |            5 | 2025-04-27       |        567 | Aysuna            | Ergul           | 2010-06-12    | 29, Orchard Way, Newcastle upon Tyne, NE4 6BH       |        67 |
|            325 |       518 |        9 |           27 | 2026-06-13       |        518 | Azahar            | Canete          | 1971-10-16    | 139, Westfield Lane, Leicester, LE2 1FY             |        18 |
|             83 |       518 |       95 |           15 | 2026-07-05       |        518 | Azahar            | Canete          | 1971-10-16    | 139, Westfield Lane, Leicester, LE2 1FY             |        18 |
|            311 |       508 |       42 |           10 | 2026-01-18       |        508 | Azeneth           | Vega            | 2013-03-15    | 21, Sandringham Drive, Newcastle upon Tyne, NE6 4JY |         8 |
|             88 |        22 |       26 |            3 | 2026-01-07       |         22 | Bakhshi           | Sagar           | 1975-07-25    | 22, Woodlands Way, London, E11 7RQ                  |        22 |
|            267 |       208 |        7 |            4 | 2026-01-24       |        208 | Barry             | Renehan         | 2014-09-22    | 98, Brook Gardens, Inverness, IV3 1HX               |         8 |
|            404 |       307 |       86 |           22 | 2024-12-14       |        307 | Bazej             | Sakwa           | 1976-04-25    | 2, Station Grove, Wrexham, LL12 5EH                 |         7 |
|            416 |       116 |       46 |           29 | 2026-10-08       |        116 | Bazej             | Smutek          | 2024-05-18    | 119, Sandringham Way, Bangor, BT19 7UW              |        16 |
|            100 |       295 |       19 |           11 | 2025-09-19       |        295 | Beate             | Juncken         | 1968-05-02    | 61, Albert Street, Bristol, BS5 8ZP                 |        95 |
|            487 |       181 |       35 |            7 | 2026-08-30       |        181 | Benjamim          | Mendes          | 1951-04-19    | 96, Poplar Place, Wrexham, LL12 7ZR                 |        81 |
|            143 |       559 |       57 |           11 | 2026-07-29       |        559 | Benjamin          | Morel           | 2016-09-20    | 36, Queens Road, Oxford, OX3 1RF                    |        59 |
|            477 |       569 |       64 |           27 | 2026-04-20       |        569 | Bernard           | Ramos           | 1971-04-05    | 30, Maple Place, Aberdeen, AB15 8RT                 |        69 |
|             35 |       569 |       58 |           29 | 2025-04-30       |        569 | Bernard           | Ramos           | 1971-04-05    | 30, Maple Place, Aberdeen, AB15 8RT                 |        69 |
|             75 |       454 |       49 |           12 | 2026-04-12       |        454 | Bethan            | O'Gowan         | 1947-08-30    | 145, Oak Road, Aberdeen, AB15 2JD                   |        54 |
|            221 |       299 |       76 |            1 | 2025-07-15       |        299 | Bethany           | Holden          | 2006-08-27    | 5, Maple Place, Truro, TR1 9DN                      |        99 |
|            390 |       306 |       54 |            4 | 2026-04-10       |        306 | Bethany           | Moore           | 1967-06-21    | 102, Kingston Drive, Southampton, SO16 7EZ          |         6 |
|            223 |       305 |       12 |            2 | 2025-04-26       |        305 | Beverley          | Kirk            | 1930-07-07    | 139, Lakeside Terrace, Reading, RG1 4YE             |         5 |
|            388 |       339 |       29 |            8 | 2025-05-05       |        339 | Bhanumati         | Maharaj         | 1997-09-12    | 64, Pine Crescent, Belfast, BT9 2LW                 |        39 |
|            107 |       362 |       58 |           26 | 2026-10-25       |        362 | Bimala            | Rajagopal       | 1974-09-20    | 95, Laurel Street, Manchester, M14 7SZ              |        62 |
|            272 |       290 |       39 |           13 | 2025-09-07       |        290 | Birthe            | Knappe          | 1982-09-27    | 43, Bramble Court, Oxford, OX4 9PR                  |        90 |
|             58 |       290 |       75 |           19 | 2025-06-08       |        290 | Birthe            | Knappe          | 1982-09-27    | 43, Bramble Court, Oxford, OX4 9PR                  |        90 |
|            491 |       532 |        5 |            2 | 2026-10-27       |        532 | Bohdan            | Tkachenko       | 1992-08-27    | 153, Sandringham Way, Dundee, DD3 5JF               |        32 |
|             25 |       532 |       77 |           14 | 2026-09-30       |        532 | Bohdan            | Tkachenko       | 1992-08-27    | 153, Sandringham Way, Dundee, DD3 5JF               |        32 |
|            426 |       331 |       20 |           30 | 2025-06-15       |        331 | Borys             | Mrozowicz       | 1996-05-19    | 72, Fairview Road, Bath, BA1 6ZF                    |        31 |
|            393 |       156 |       31 |           21 | 2025-11-09       |        156 | Brenda            | McDonald        | 1973-03-12    | 26, Heather Gardens, Oxford, OX2 6ZB                |        56 |
|            420 |        13 |       48 |            2 | 2026-01-28       |         13 | Calvin            | Hogan           | 1980-08-17    | 62, Willow Lane, Plymouth, PL3 1HD                  |        13 |
|            313 |        13 |       13 |           15 | 2026-02-11       |         13 | Calvin            | Hogan           | 1980-08-17    | 62, Willow Lane, Plymouth, PL3 1HD                  |        13 |
|            380 |        13 |        4 |           21 | 2026-03-27       |         13 | Calvin            | Hogan           | 1980-08-17    | 62, Willow Lane, Plymouth, PL3 1HD                  |        13 |
|            385 |       473 |       53 |            5 | 2025-02-17       |        473 | Caoimhin          | Meenaghan       | 1977-06-08    | 75, Mill Grove, Exeter, EX4 2HW                     |        73 |
|             93 |       455 |       44 |            1 | 2026-09-03       |        455 | Capucine          | Huet            | 2019-01-20    | 57, Ashfield Gardens, Bath, BA2 9TN                 |        55 |
|            361 |       455 |       66 |           16 | 2026-03-30       |        455 | Capucine          | Huet            | 2019-01-20    | 57, Ashfield Gardens, Bath, BA2 9TN                 |        55 |
|              3 |       455 |       47 |           28 | 2025-01-14       |        455 | Capucine          | Huet            | 2019-01-20    | 57, Ashfield Gardens, Bath, BA2 9TN                 |        55 |
|            284 |       146 |       92 |           18 | 2025-05-19       |        146 | Carl              | Holmes          | 2010-12-21    | 85, Greenfield Road, Bristol, BS5 8SZ               |        46 |
|            345 |        64 |        1 |           13 | 2025-07-28       |         64 | Carlos            | Meyer           | 1983-11-25    | 114, Maple Close, Inverness, IV3 1GJ                |        64 |
|            134 |        64 |       19 |            5 | 2025-06-09       |         64 | Carlos            | Meyer           | 1983-11-25    | 114, Maple Close, Inverness, IV3 1GJ                |        64 |
|            108 |       258 |       38 |           25 | 2025-12-05       |        258 | Carolina          | Giron           | 1927-04-03    | 105, Foxglove Court, Manchester, M20 8QG            |        58 |
|            353 |       530 |       32 |           13 | 2026-08-22       |        530 | Carolina          | Morpurgo        | 1940-02-21    | 65, Willow Place, Bristol, BS9 4HE                  |        30 |
|             67 |       530 |       58 |           16 | 2026-07-10       |        530 | Carolina          | Morpurgo        | 1940-02-21    | 65, Willow Place, Bristol, BS9 4HE                  |        30 |
|            456 |       530 |       71 |           10 | 2025-09-18       |        530 | Carolina          | Morpurgo        | 1940-02-21    | 65, Willow Place, Bristol, BS9 4HE                  |        30 |
|            182 |       118 |       47 |           14 | 2025-01-26       |        118 | Catalina          | Segovia         | 1954-05-17    | 37, Devonshire Grove, Southampton, SO18 4GA         |        18 |
|            421 |       274 |       64 |           12 | 2024-12-14       |        274 | Caua              | Nascimento      | 1991-01-03    | 23, Bramble Street, Lisburn, BT28 6GE               |        74 |
|            231 |       103 |       35 |           16 | 2024-11-22       |        103 | Cebrian           | Sanjuan         | 1993-02-03    | 164, Juniper Lane, Glasgow, G12 7QQ                 |         3 |
|            111 |       103 |       98 |            5 | 2025-03-12       |        103 | Cebrian           | Sanjuan         | 1993-02-03    | 164, Juniper Lane, Glasgow, G12 7QQ                 |         3 |
|             73 |       368 |        9 |            6 | 2024-12-08       |        368 | Cecile            | Becker          | 1991-09-20    | 135, Rowan Court, Wrexham, LL12 7QU                 |        68 |
|             54 |       435 |       64 |            5 | 2025-07-29       |        435 | Cecilia           | Rubio           | 2005-08-08    | 11, Birch Street, Aberdeen, AB24 4YU                |        35 |
|            341 |       435 |       87 |           16 | 2026-05-16       |        435 | Cecilia           | Rubio           | 2005-08-08    | 11, Birch Street, Aberdeen, AB24 4YU                |        35 |
|              4 |       282 |       78 |            2 | 2026-10-14       |        282 | Celina            | Muller          | 1946-01-26    | 132, Heather Lane, Edinburgh, EH6 9AQ               |        82 |
|             44 |       101 |       93 |           11 | 2026-09-16       |        101 | Centa             | Nette           | 2010-10-27    | 58, Cherry Close, Sheffield, S10 5YU                |         1 |
|            163 |       273 |       61 |           19 | 2025-02-15       |        273 | Cerci             | Soylu           | 1997-01-12    | 139, Poplar Avenue, Brighton, BN2 4ZG               |        73 |
|             81 |       436 |       50 |           18 | 2025-06-10       |        436 | Cevale            | Tevetoglu       | 1938-01-02    | 81, Rowan Drive, Cardiff, CF14 9WB                  |        36 |
|            214 |       352 |       32 |           25 | 2025-04-20       |        352 | Charles           | Mitchell        | 1948-12-09    | 46, Redgate Road, Leeds, LS12 1UX                   |        52 |
|            430 |       269 |       98 |           16 | 2026-10-07       |        269 | Charles           | Weber           | 1974-11-27    | 68, Springfield Gardens, York, YO31 2EP             |        69 |
|            320 |       234 |       94 |           19 | 2025-08-18       |        234 | Christopher       | Lee             | 2001-10-25    | 17, Hawthorn Place, Birmingham, B13 4GY             |        34 |
|            326 |        39 |       42 |            9 | 2025-03-13       |         39 | Cindoruk          | Bilir           | 1998-06-06    | 49, Bramble Crescent, Belfast, BT15 2LE             |        39 |
|             63 |        39 |       31 |           15 | 2026-03-06       |         39 | Cindoruk          | Bilir           | 1998-06-06    | 49, Bramble Crescent, Belfast, BT15 2LE             |        39 |
|            181 |       405 |       85 |           14 | 2026-03-04       |        405 | Ciriaco           | Duran           | 1956-01-25    | 177, Hillcrest Court, Cambridge, CB4 6PA            |         5 |
|             31 |       405 |       43 |           19 | 2026-08-03       |        405 | Ciriaco           | Duran           | 1956-01-25    | 177, Hillcrest Court, Cambridge, CB4 6PA            |         5 |
|            419 |       348 |       62 |           30 | 2025-02-23       |        348 | Clara             | Caldeira        | 1954-03-14    | 156, Starlight Court, Cambridge, CB1 2TT            |        48 |
|            316 |        41 |       50 |            6 | 2026-04-17       |         41 | Clifford          | Baker           | 2009-12-03    | 145, Hillcrest Drive, Cardiff, CF23 2RL             |        41 |
|            480 |       332 |       91 |            7 | 2026-02-16       |        332 | Colleen           | McGilly         | 2011-10-11    | 1, Sunnyside Close, Brighton, BN2 9NG               |        32 |
|             42 |       332 |       16 |            7 | 2026-02-20       |        332 | Colleen           | McGilly         | 2011-10-11    | 1, Sunnyside Close, Brighton, BN2 9NG               |        32 |
|            462 |       584 |       32 |           10 | 2026-10-15       |        584 | Constance         | Leclercq        | 1973-01-16    | 164, Laurel Gardens, Brighton, BN2 9EX              |        84 |
|             48 |       243 |       85 |           23 | 2024-11-29       |        243 | Corey             | Hughes          | 2002-03-12    | 55, Church Avenue, Wrexham, LL11 7JH                |        43 |
|            374 |       278 |       69 |            5 | 2026-08-27       |        278 | Courtney          | Walker          | 1990-09-19    | 5, Rowan Gardens, Bangor, BT19 5XD                  |        78 |
|            102 |       278 |       11 |           15 | 2025-06-18       |        278 | Courtney          | Walker          | 1990-09-19    | 5, Rowan Gardens, Bangor, BT19 5XD                  |        78 |
|            212 |       200 |       61 |           24 | 2026-03-18       |        200 | Dadi              | Saefullah       | 1978-07-08    | 13, Woodlands Street, Newcastle upon Tyne, NE4 3JZ  |       100 |
|            255 |       200 |       18 |           14 | 2025-05-27       |        200 | Dadi              | Saefullah       | 1978-07-08    | 13, Woodlands Street, Newcastle upon Tyne, NE4 3JZ  |       100 |
|            428 |       419 |        9 |           13 | 2026-08-23       |        419 | Darmanto          | Maryadi         | 1983-02-28    | 94, Juniper Drive, Truro, TR1 1RS                   |        19 |
|            436 |       461 |       19 |           30 | 2026-05-22       |        461 | Davi              | Teixeira        | 1986-04-24    | 170, Juniper Lane, Southampton, SO16 4HY            |        61 |
|            376 |       351 |       72 |           22 | 2026-09-23       |        351 | Davi              | Araujo          | 1995-11-27    | 15, Clifton Grove, Inverness, IV2 7SQ               |        51 |
|            375 |       588 |       12 |            5 | 2024-12-31       |        588 | Dawn              | Andrews         | 1986-10-05    | 179, Station Terrace, Truro, TR1 6GL                |        88 |
|            157 |       343 |       94 |           25 | 2024-11-22       |        343 | Dean              | Preston         | 1994-02-07    | 179, Mill Place, Lisburn, BT27 9AF                  |        43 |
|            226 |       484 |       35 |            1 | 2025-02-20       |        484 | Delil             | Manco           | 2001-04-30    | 166, Park Terrace, Swansea, SA1 4AH                 |        84 |
|            266 |       513 |       23 |           16 | 2026-02-28       |        513 | Denise            | Vallee          | 1947-02-26    | 169, Queens Court, Dundee, DD3 2ZH                  |        13 |
|            250 |       325 |       65 |           19 | 2025-05-15       |        325 | Diane             | Foucher         | 1986-05-01    | 7, Springfield Close, Belfast, BT5 4GR              |        25 |
|            263 |       325 |       79 |           14 | 2025-07-05       |        325 | Diane             | Foucher         | 1986-05-01    | 7, Springfield Close, Belfast, BT5 4GR              |        25 |
|            472 |       396 |       26 |           19 | 2025-04-15       |        396 | Dominique         | Morvan          | 1940-11-13    | 175, Richmond Road, York, YO24 7SL                  |        96 |
|            222 |       396 |       14 |            5 | 2025-08-18       |        396 | Dominique         | Morvan          | 1940-11-13    | 175, Richmond Road, York, YO24 7SL                  |        96 |
|            122 |       396 |       50 |            9 | 2026-04-17       |        396 | Dominique         | Morvan          | 1940-11-13    | 175, Richmond Road, York, YO24 7SL                  |        96 |
|            138 |       396 |       48 |            6 | 2025-07-30       |        396 | Dominique         | Morvan          | 1940-11-13    | 175, Richmond Road, York, YO24 7SL                  |        96 |
|            114 |       514 |       34 |           14 | 2025-08-05       |        514 | Donald            | Rios            | 1929-06-03    | 143, Primrose Place, Truro, TR1 4WG                 |        14 |
|            216 |       597 |       90 |           15 | 2026-02-07       |        597 | Dorota            | Waloch          | 1928-12-01    | 131, Maple Gardens, Newcastle upon Tyne, NE6 9LR    |        97 |
|            180 |       100 |       12 |           23 | 2024-11-20       |        100 | Drajat            | Nashiruddin     | 1989-02-20    | 75, Heather Lane, Edinburgh, EH6 2QP                |       100 |
|             16 |       100 |       60 |            6 | 2026-01-15       |        100 | Drajat            | Nashiruddin     | 1989-02-20    | 75, Heather Lane, Edinburgh, EH6 2QP                |       100 |
|            323 |       100 |       71 |            4 | 2026-09-27       |        100 | Drajat            | Nashiruddin     | 1989-02-20    | 75, Heather Lane, Edinburgh, EH6 2QP                |       100 |
|            410 |        91 |       23 |           24 | 2025-01-07       |         91 | Dustin            | Bush            | 2001-09-22    | 116, Bramble Drive, Southampton, SO16 9DR           |        91 |
|            492 |        91 |       68 |           10 | 2025-10-16       |         91 | Dustin            | Bush            | 2001-09-22    | 116, Bramble Drive, Southampton, SO16 9DR           |        91 |
|             13 |        91 |       55 |           26 | 2026-02-12       |         91 | Dustin            | Bush            | 2001-09-22    | 116, Bramble Drive, Southampton, SO16 9DR           |        91 |
|            340 |       149 |       25 |           23 | 2026-02-01       |        149 | Eckehard          | Albers          | 1960-02-29    | 51, Riverside Grove, Coventry, CV3 7UQ              |        49 |
|            409 |       179 |        2 |           29 | 2026-04-14       |        179 | Edi               | Yulianti        | 1983-08-01    | 113, Meadow Court, Southampton, SO15 3UY            |        79 |
|            408 |       179 |       49 |           12 | 2025-12-23       |        179 | Edi               | Yulianti        | 1983-08-01    | 113, Meadow Court, Southampton, SO15 3UY            |        79 |
|            244 |       160 |       33 |            1 | 2024-11-25       |        160 | Ekaja             | Mammen          | 1959-08-22    | 28, Starlight Grove, Edinburgh, EH4 6GJ             |        60 |
|            494 |       160 |       55 |           15 | 2026-10-13       |        160 | Ekaja             | Mammen          | 1959-08-22    | 28, Starlight Grove, Edinburgh, EH4 6GJ             |        60 |
|             78 |       160 |       65 |           16 | 2025-08-14       |        160 | Ekaja             | Mammen          | 1959-08-22    | 28, Starlight Grove, Edinburgh, EH4 6GJ             |        60 |
|            378 |       160 |       75 |            3 | 2025-12-08       |        160 | Ekaja             | Mammen          | 1959-08-22    | 28, Starlight Grove, Edinburgh, EH4 6GJ             |        60 |
|             24 |       160 |       38 |           20 | 2025-01-14       |        160 | Ekaja             | Mammen          | 1959-08-22    | 28, Starlight Grove, Edinburgh, EH4 6GJ             |        60 |
|            418 |       488 |        2 |            1 | 2026-01-10       |        488 | Eloy              | Castaneda       | 1946-02-21    | 23, Rowan Place, Brighton, BN2 6AD                  |        88 |
|             98 |       488 |       18 |            1 | 2025-12-03       |        488 | Eloy              | Castaneda       | 1946-02-21    | 23, Rowan Place, Brighton, BN2 6AD                  |        88 |
|              7 |       575 |       71 |            7 | 2025-01-17       |        575 | Emil              | Czuj            | 2017-11-28    | 148, Holly Avenue, York, YO10 3AR                   |        75 |
|            207 |       483 |       74 |            4 | 2026-03-25       |        483 | Emilio            | Raya            | 2023-07-19    | 18, Riverside Way, Lisburn, BT28 4BR                |        83 |
|             33 |       512 |       40 |           10 | 2025-09-10       |        512 | Emily             | Gardner         | 2015-10-05    | 55, Silverdale Terrace, Aberdeen, AB10 7TE          |        12 |
|             74 |       150 |       59 |           29 | 2025-10-19       |        150 | Ermes             | Ricolfi         | 1951-10-24    | 120, Church Place, Reading, RG2 1RN                 |        50 |
|            431 |       190 |       14 |           17 | 2026-06-19       |        190 | Estrella          | Sales           | 1979-07-13    | 105, Mayfield Terrace, Southampton, SO15 9ED        |        90 |
|            381 |        29 |       60 |           16 | 2025-08-27       |         29 | Ewa               | Junck           | 2012-12-14    | 72, Cedar Grove, Oxford, OX4 9EA                    |        29 |
|            295 |        29 |       42 |           12 | 2024-12-01       |         29 | Ewa               | Junck           | 2012-12-14    | 72, Cedar Grove, Oxford, OX4 9EA                    |        29 |
|            254 |       261 |       63 |           28 | 2025-07-09       |        261 | Ewa               | Mzyk            | 1955-07-13    | 140, Lavender Avenue, Manchester, M14 8YE           |        61 |
|             84 |       354 |       95 |           20 | 2026-06-03       |        354 | Fabian            | Ladeck          | 2025-05-12    | 32, Church Drive, Hull, HU5 5RQ                     |        54 |
|            140 |       517 |       80 |           12 | 2026-03-01       |        517 | Fabian            | Malon           | 1946-07-06    | 69, Westfield Terrace, Manchester, M21 9NY          |        17 |
|            252 |       576 |        5 |            8 | 2025-12-13       |        576 | Fabiola           | Melendez        | 1961-05-31    | 48, Foxglove Grove, Hull, HU5 9XJ                   |        76 |
|            317 |       390 |       26 |           12 | 2025-10-14       |        390 | Farhana           | Islam           | 1980-07-15    | 113, Lavender Drive, Portsmouth, PO6 6QT            |        90 |
|            271 |       342 |       91 |            3 | 2025-03-20       |        342 | Farhunnisa        | Dongoran        | 1964-12-14    | 118, Greenfield Avenue, Brighton, BN1 2YX           |        42 |
|            442 |       342 |       46 |            5 | 2026-10-18       |        342 | Farhunnisa        | Dongoran        | 1964-12-14    | 118, Greenfield Avenue, Brighton, BN1 2YX           |        42 |
|            112 |       408 |      100 |            4 | 2026-02-09       |        408 | Fatinur           | Duran           | 2006-07-13    | 122, Fairview Street, Newcastle upon Tyne, NE4 1QA  |         8 |
|            435 |       104 |       51 |            5 | 2025-01-03       |        104 | Felipe            | Moura           | 2020-08-31    | 86, Heather Place, Reading, RG30 4JJ                |         4 |
|            287 |       423 |       23 |            9 | 2025-09-06       |        423 | Feraye            | Ertas           | 1972-05-24    | 55, Highfield Terrace, Newcastle upon Tyne, NE2 7ND |        23 |
|            155 |       423 |       69 |           14 | 2025-10-04       |        423 | Feraye            | Ertas           | 1972-05-24    | 55, Highfield Terrace, Newcastle upon Tyne, NE2 7ND |        23 |
|            251 |       444 |       51 |            5 | 2026-10-11       |        444 | Filomena          | Herranz         | 1954-07-09    | 22, Queens Gardens, Truro, TR1 3WA                  |        44 |
|             49 |       444 |       82 |            8 | 2025-01-09       |        444 | Filomena          | Herranz         | 1954-07-09    | 22, Queens Gardens, Truro, TR1 3WA                  |        44 |
|            333 |       215 |       40 |            1 | 2025-08-25       |        215 | Finn              | Dass            | 1957-01-19    | 25, Redgate Drive, Belfast, BT5 7SN                 |        15 |
|            447 |       189 |       38 |           18 | 2026-08-27       |        189 | Gael              | Barbosa         | 1985-04-26    | 5, Brookfield Avenue, Reading, RG30 3XU             |        89 |
|             99 |       189 |        5 |            9 | 2025-04-15       |        189 | Gael              | Barbosa         | 1985-04-26    | 5, Brookfield Avenue, Reading, RG30 3XU             |        89 |
|            269 |       189 |       52 |            2 | 2025-03-28       |        189 | Gael              | Barbosa         | 1985-04-26    | 5, Brookfield Avenue, Reading, RG30 3XU             |        89 |
|            201 |       414 |       83 |           23 | 2026-09-24       |        414 | Gambira           | Pratiwi         | 1943-03-15    | 91, Sunnyside Close, London, SW4 5YU                |        14 |
|            274 |       399 |       38 |           29 | 2025-02-04       |        399 | Ganga             | Rajan           | 1939-05-27    | 14, Clifton Gardens, Southampton, SO18 2FB          |        99 |
|            448 |        60 |       53 |            1 | 2025-09-23       |         60 | Gaurangi          | Kata            | 1948-10-22    | 91, Meadow Drive, Newcastle upon Tyne, NE6 8WR      |        60 |
|            162 |        60 |        8 |            7 | 2026-05-14       |         60 | Gaurangi          | Kata            | 1948-10-22    | 91, Meadow Drive, Newcastle upon Tyne, NE6 8WR      |        60 |
|            194 |       582 |       43 |           29 | 2025-08-10       |        582 | Giampiero         | Tarantino       | 1974-07-31    | 122, Heather Street, Glasgow, G41 4UF               |        82 |
|            464 |       420 |       16 |           20 | 2026-05-07       |        420 | Gian              | Montalcini      | 1964-06-06    | 144, Redgate Court, Birmingham, B17 4HL             |        20 |
|            449 |       451 |        7 |            2 | 2026-03-01       |        451 | Gozem             | Ertas           | 2007-10-25    | 146, Moorland Court, Belfast, BT5 7QB               |        51 |
|            196 |       335 |       79 |           23 | 2024-11-28       |        335 | Graciela          | Peralta         | 1970-11-29    | 151, Heather Close, Bristol, BS9 1EL                |        35 |
|            488 |       519 |       16 |           11 | 2025-10-30       |        519 | Griselda          | Offredi         | 1963-01-03    | 65, Birch Court, Inverness, IV3 5AS                 |        19 |
|            367 |       338 |        6 |            2 | 2026-11-13       |        338 | Grzegorz          | Liss            | 2025-02-05    | 132, Heather Grove, Truro, TR1 8WB                  |        38 |
|            195 |       300 |       99 |            8 | 2025-08-29       |        300 | Gursal            | Ergul           | 1939-07-03    | 112, Greenfield Terrace, Hull, HU6 8PX              |       100 |
|             69 |       300 |       93 |           30 | 2025-12-09       |        300 | Gursal            | Ergul           | 1939-07-03    | 112, Greenfield Terrace, Hull, HU6 8PX              |       100 |
|            170 |       321 |       12 |           26 | 2025-11-07       |        321 | Hamza             | Farouk          | 1933-12-17    | 112, Cedar Grove, Bangor, BT20 4PD                  |        21 |
|            103 |       511 |        6 |           25 | 2025-03-05       |        511 | Hamza             | Nasser          | 1998-10-26    | 73, Kings Grove, Birmingham, B28 8QD                |        11 |
|            473 |       511 |       33 |           15 | 2025-12-01       |        511 | Hamza             | Nasser          | 1998-10-26    | 73, Kings Grove, Birmingham, B28 8QD                |        11 |
|            227 |        17 |       58 |            7 | 2024-12-23       |         17 | Hardana           | Mardhiyah       | 2021-11-13    | 17, Starlight Way, Exeter, EX1 3PZ                  |        17 |
|            465 |       592 |       80 |           29 | 2026-08-09       |        592 | Harry             | Smith           | 1999-10-30    | 157, Brookfield Avenue, Derry, BT47 8UQ             |        92 |
|            451 |       367 |       61 |           12 | 2026-07-12       |        367 | Heather           | Jones           | 1952-06-20    | 100, Chestnut Terrace, Birmingham, B17 3DU          |        67 |
|            277 |       280 |       77 |           25 | 2026-04-18       |        280 | Helena            | Rendon          | 2023-05-23    | 137, Belmont Road, Derby, DE21 2FY                  |        80 |
|            454 |       280 |       52 |           18 | 2025-10-09       |        280 | Helena            | Rendon          | 2023-05-23    | 137, Belmont Road, Derby, DE21 2FY                  |        80 |
|            185 |       245 |       98 |           20 | 2026-06-28       |        245 | Henriette         | Lagarde         | 1997-04-19    | 27, Bramble Grove, Belfast, BT9 8FU                 |        45 |
|            242 |       345 |       43 |           29 | 2025-02-05       |        345 | Hortensia         | Lloret          | 1959-05-05    | 170, Cedar Gardens, Liverpool, L25 2XZ              |        45 |
|            495 |       418 |        7 |           17 | 2026-08-27       |        418 | Hredhaan          | Sarkar          | 2004-01-31    | 71, Rowan Street, Nottingham, NG3 2FZ               |        18 |
|            411 |       418 |       53 |           18 | 2026-11-11       |        418 | Hredhaan          | Sarkar          | 2004-01-31    | 71, Rowan Street, Nottingham, NG3 2FZ               |        18 |
|            233 |       228 |       42 |           22 | 2025-12-15       |        228 | Hyunwoo           | Park            | 1971-09-02    | 17, Kings Close, Truro, TR1 9YD                     |        28 |
|            372 |       228 |       89 |           24 | 2026-08-06       |        228 | Hyunwoo           | Park            | 1971-09-02    | 17, Kings Close, Truro, TR1 9YD                     |        28 |
|             15 |       228 |       46 |            1 | 2025-02-14       |        228 | Hyunwoo           | Park            | 1971-09-02    | 17, Kings Close, Truro, TR1 9YD                     |        28 |
|            253 |       431 |       71 |           14 | 2025-07-02       |        431 | Iain              | Russell         | 1927-03-09    | 167, Lakeside Gardens, Newcastle upon Tyne, NE2 2DA |        31 |
|            127 |       304 |       45 |            5 | 2026-01-26       |        304 | Ibrahim           | Saleh           | 1962-06-27    | 40, Oak Avenue, Newport, NP19 5TF                   |         4 |
|             47 |       493 |       79 |           20 | 2026-07-02       |        493 | Ignacy            | Kostek          | 1968-06-11    | 26, Ashfield Lane, Coventry, CV5 8YD                |        93 |
|             28 |       493 |       40 |           19 | 2026-08-02       |        493 | Ignacy            | Kostek          | 1968-06-11    | 26, Ashfield Lane, Coventry, CV5 8YD                |        93 |
|              1 |       493 |       91 |           17 | 2026-08-05       |        493 | Ignacy            | Kostek          | 1968-06-11    | 26, Ashfield Lane, Coventry, CV5 8YD                |        93 |
|             94 |       413 |       98 |           29 | 2026-08-11       |        413 | Imran             | Akter           | 1984-03-11    | 120, Juniper Avenue, Sheffield, S11 3WP             |        13 |
|             17 |       413 |        7 |           16 | 2026-06-28       |        413 | Imran             | Akter           | 1984-03-11    | 120, Juniper Avenue, Sheffield, S11 3WP             |        13 |
|             65 |       204 |       31 |           22 | 2025-02-02       |        204 | Iryna             | Bondarenko      | 1969-10-24    | 137, Cedar Way, Coventry, CV5 4PY                   |         4 |
|            116 |       397 |       48 |           18 | 2025-12-18       |        397 | Iryna             | Melnyk          | 1937-06-09    | 156, Hillcrest Road, Wrexham, LL12 8SH              |        97 |
|            303 |       397 |        1 |            8 | 2026-03-12       |        397 | Iryna             | Melnyk          | 1937-06-09    | 156, Hillcrest Road, Wrexham, LL12 8SH              |        97 |
|            115 |        14 |       88 |            2 | 2026-08-26       |         14 | Isaac             | Thomas          | 1943-12-04    | 109, Redgate Terrace, Inverness, IV3 2LN            |        14 |
|            475 |        14 |       72 |           30 | 2024-12-19       |         14 | Isaac             | Thomas          | 1943-12-04    | 109, Redgate Terrace, Inverness, IV3 2LN            |        14 |
|             22 |        14 |       44 |            3 | 2026-03-28       |         14 | Isaac             | Thomas          | 1943-12-04    | 109, Redgate Terrace, Inverness, IV3 2LN            |        14 |
|            413 |       533 |       80 |           16 | 2025-01-29       |        533 | Isabela           | Miranda         | 1932-03-31    | 63, Greenfield Lane, Newcastle upon Tyne, NE6 4AA   |        33 |
|            169 |       504 |       11 |           15 | 2026-01-17       |        504 | Jaiman            | Iswahyudi       | 1943-12-21    | 119, Lavender Drive, Truro, TR1 9WJ                 |         4 |
|             92 |       462 |       51 |            6 | 2026-06-06       |        462 | James             | Nevin           | 1942-07-23    | 49, Juniper Place, Sheffield, S10 1RE               |        62 |
|              6 |       499 |       65 |           11 | 2025-09-21       |        499 | James             | Richards        | 1995-12-05    | 100, Heather Close, Newport, NP20 2GP               |        99 |
|            152 |        34 |       78 |            1 | 2025-01-06       |         34 | Janusz            | Dippel          | 1984-10-04    | 105, Kings Close, Liverpool, L18 9ZQ                |        34 |
|            172 |       400 |       24 |           17 | 2025-10-09       |        400 | Jay               | O'Connor        | 1951-06-09    | 21, Cherry Lane, Sheffield, S10 7WL                 |       100 |
|            104 |       400 |       12 |           10 | 2026-04-02       |        400 | Jay               | O'Connor        | 1951-06-09    | 21, Cherry Lane, Sheffield, S10 7WL                 |       100 |
|            265 |       359 |       85 |           21 | 2025-12-06       |        359 | Jeevika           | Arya            | 1954-10-01    | 166, Hazel Avenue, Hull, HU6 1JJ                    |        59 |
|             90 |       359 |       24 |           17 | 2026-02-02       |        359 | Jeevika           | Arya            | 1954-10-01    | 166, Hazel Avenue, Hull, HU6 1JJ                    |        59 |
|            308 |       359 |        2 |           30 | 2025-11-02       |        359 | Jeevika           | Arya            | 1954-10-01    | 166, Hazel Avenue, Hull, HU6 1JJ                    |        59 |
|            142 |       571 |       32 |           20 | 2026-05-16       |        571 | Jeffrey           | Roth            | 2012-12-06    | 2, Poplar Avenue, Bangor, BT20 1WP                  |        71 |
|            328 |       571 |       90 |           20 | 2025-06-02       |        571 | Jeffrey           | Roth            | 2012-12-06    | 2, Poplar Avenue, Bangor, BT20 1WP                  |        71 |
|            149 |        42 |       72 |            1 | 2025-09-07       |         42 | Jennifer          | Bailey          | 2001-04-21    | 18, Lakeside Gardens, Manchester, M20 4WW           |        42 |
|            407 |       227 |       92 |           26 | 2025-08-24       |        227 | Jennifer          | Castillo        | 1988-08-12    | 40, Birch Street, Southampton, SO15 6UZ             |        27 |
|            369 |       594 |       64 |           30 | 2026-08-17       |        594 | Jennifer          | Green           | 1933-10-30    | 69, Meadow Terrace, Derby, DE22 2NL                 |        94 |
|            218 |       109 |       45 |            8 | 2026-01-31       |        109 | Jerzy             | Jedruch         | 1957-11-18    | 104, Sunnyside Close, Plymouth, PL3 1DX             |         9 |
|            110 |       109 |       82 |            3 | 2026-11-16       |        109 | Jerzy             | Jedruch         | 1957-11-18    | 104, Sunnyside Close, Plymouth, PL3 1DX             |         9 |
|            469 |       109 |       75 |           13 | 2025-04-03       |        109 | Jerzy             | Jedruch         | 1957-11-18    | 104, Sunnyside Close, Plymouth, PL3 1DX             |         9 |
|            457 |       226 |       18 |           22 | 2026-01-04       |        226 | Jessica           | Velez           | 1931-09-10    | 23, Bramble Gardens, Cardiff, CF14 5JW              |        26 |
|            229 |        82 |       80 |           26 | 2026-03-07       |         82 | Jia               | Wang            | 2008-06-29    | 74, Station Lane, Hull, HU8 1XE                     |        82 |
|            275 |        21 |       92 |           19 | 2026-02-10       |         21 | Jiho              | Choi            | 2006-04-07    | 133, Springfield Gardens, Brighton, BN1 4XG         |        21 |
|            109 |       466 |       89 |           23 | 2026-02-19       |        466 | Jing              | Li              | 1963-03-30    | 105, Sandringham Way, Edinburgh, EH6 4LQ            |        66 |
|            489 |       309 |       50 |           16 | 2025-02-14       |        309 | Jing              | Wang            | 1978-12-07    | 95, Primrose Way, Aberdeen, AB15 1LD                |         9 |
|            256 |       309 |       88 |           19 | 2025-07-05       |        309 | Jing              | Wang            | 1978-12-07    | 95, Primrose Way, Aberdeen, AB15 1LD                |         9 |
|            301 |       318 |       57 |           21 | 2024-11-20       |        318 | Joao Pedro        | Porto           | 1990-04-01    | 28, Bluebell Way, Lisburn, BT28 4XG                 |        18 |
|            458 |       365 |       58 |            1 | 2025-01-08       |        365 | Jorge             | Montes          | 1996-01-02    | 146, Station Street, Swansea, SA5 2XG               |        65 |
|            377 |       417 |       98 |           21 | 2026-09-24       |        417 | Jose Miguel       | Farias          | 1936-08-01    | 79, Brook Lane, Glasgow, G12 6UH                    |        17 |
|            337 |       139 |       53 |           13 | 2026-02-23       |        139 | Joseph            | Frazier         | 1951-04-12    | 23, Park Gardens, Birmingham, B13 6QR               |        39 |
|            402 |       363 |      100 |           29 | 2025-12-26       |        363 | Josette           | Arnaud          | 1969-02-21    | 81, Kingston Drive, Hull, HU6 4QB                   |        63 |
|            264 |       363 |       69 |           13 | 2025-06-16       |        363 | Josette           | Arnaud          | 1969-02-21    | 81, Kingston Drive, Hull, HU6 4QB                   |        63 |
|             97 |       577 |       23 |            8 | 2025-11-12       |        577 | Joshua            | Glover          | 1957-11-16    | 116, Pine Close, Bath, BA1 4XS                      |        77 |
|            386 |       568 |       67 |           24 | 2025-11-05       |        568 | Josue             | Moura           | 1972-05-23    | 118, Park Court, Liverpool, L15 6ZU                 |        68 |
|             95 |       568 |       40 |           30 | 2024-12-22       |        568 | Josue             | Moura           | 1972-05-23    | 118, Park Court, Liverpool, L15 6ZU                 |        68 |
|            479 |        45 |      100 |           15 | 2026-08-29       |         45 | Jozef             | Jop             | 1986-09-27    | 167, Hawthorn Street, Leeds, LS12 6UB               |        45 |
|             34 |        45 |       88 |            2 | 2025-05-25       |         45 | Jozef             | Jop             | 1986-09-27    | 167, Hawthorn Street, Leeds, LS12 6UB               |        45 |
|            439 |       476 |        3 |           25 | 2025-10-28       |        476 | Juan              | Llanos          | 2020-05-22    | 171, Westfield Court, Newport, NP19 4HN             |        76 |
|            343 |        78 |       19 |           24 | 2026-09-05       |         78 | Julie             | Goodman         | 2012-09-29    | 101, Chestnut Close, Manchester, M21 8ES            |        78 |
|            432 |       544 |       75 |           28 | 2025-11-01       |        544 | Kacper            | Elert           | 1942-04-25    | 104, Ash Close, Belfast, BT15 5DT                   |        44 |
|            146 |        96 |       72 |           14 | 2026-06-30       |         96 | Karina            | Styrna          | 1996-12-11    | 43, Moorland Drive, Liverpool, L18 7NY              |        96 |
|             36 |        96 |       49 |           17 | 2024-12-17       |         96 | Karina            | Styrna          | 1996-12-11    | 43, Moorland Drive, Liverpool, L18 7NY              |        96 |
|             43 |        56 |       14 |           30 | 2025-05-18       |         56 | Karta             | Fujiati         | 1979-05-21    | 143, Cherry Terrace, London, E11 7WX                |        56 |
|            476 |       439 |       73 |            5 | 2026-08-03       |        439 | Kateryna          | Bondarenko      | 1938-12-07    | 70, Kingston Street, Sheffield, S6 3NY              |        39 |
|            189 |       223 |       30 |           22 | 2025-08-14       |        223 | Kateryna          | Shevchenko      | 1997-01-22    | 85, Highfield Drive, Bath, BA1 1DE                  |        23 |
|            136 |       223 |       22 |            6 | 2025-08-10       |        223 | Kateryna          | Shevchenko      | 1997-01-22    | 85, Highfield Drive, Bath, BA1 1DE                  |        23 |
|            236 |       223 |       56 |           22 | 2025-03-10       |        223 | Kateryna          | Shevchenko      | 1997-01-22    | 85, Highfield Drive, Bath, BA1 1DE                  |        23 |
|            423 |       534 |       40 |           17 | 2025-05-02       |        534 | Kateryna          | Tkachenko       | 2008-07-31    | 118, Linden Lane, Bangor, BT20 8JX                  |        34 |
|            368 |       534 |       12 |           13 | 2025-04-12       |        534 | Kateryna          | Tkachenko       | 2008-07-31    | 118, Linden Lane, Bangor, BT20 8JX                  |        34 |
|            329 |       177 |       15 |            8 | 2026-01-12       |        177 | Katherine         | Cervantes       | 1997-01-03    | 163, Hillcrest Road, Norwich, NR7 3DP               |        77 |
|            459 |       263 |       64 |            4 | 2024-12-05       |        263 | Katie             | Monagle         | 1929-11-06    | 45, Hazel Road, Truro, TR1 6FU                      |        63 |
|            206 |       263 |       98 |            1 | 2025-04-18       |        263 | Katie             | Monagle         | 1929-11-06    | 45, Hazel Road, Truro, TR1 6FU                      |        63 |
|            327 |       392 |       74 |           21 | 2024-12-02       |        392 | Kavya             | Rao             | 1953-12-15    | 174, Sandringham Gardens, Bath, BA1 1JS             |        92 |
|            144 |       373 |       75 |           20 | 2025-07-17       |        373 | Kayleigh          | Jones           | 1964-07-05    | 82, Springfield Avenue, Norwich, NR3 7WR            |        73 |
|            261 |       373 |       10 |            5 | 2025-10-17       |        373 | Kayleigh          | Jones           | 1964-07-05    | 82, Springfield Avenue, Norwich, NR3 7WR            |        73 |
|             53 |       373 |       99 |           11 | 2025-12-22       |        373 | Kayleigh          | Jones           | 1964-07-05    | 82, Springfield Avenue, Norwich, NR3 7WR            |        73 |
|            348 |       554 |       11 |            7 | 2024-12-07       |        554 | Kelly             | Molina          | 1958-11-27    | 165, Hawthorn Lane, Southampton, SO15 6HZ           |        54 |
|            466 |       554 |       67 |           11 | 2026-03-27       |        554 | Kelly             | Molina          | 1958-11-27    | 165, Hawthorn Lane, Southampton, SO15 6HZ           |        54 |
|            141 |       239 |        9 |           25 | 2025-04-28       |        239 | Kenji             | Ito             | 1991-01-07    | 14, Sunnyside Terrace, Wrexham, LL12 9ZE            |        39 |
|            496 |        72 |       62 |           16 | 2025-07-02       |         72 | Kenneth           | Lawson          | 1927-07-21    | 59, Cherry Drive, Belfast, BT5 9NZ                  |        72 |
|            147 |       537 |       53 |           15 | 2025-04-03       |        537 | Kerry             | Richard         | 2000-10-06    | 102, Sunnyside Street, Newport, NP19 6UH            |        37 |
|            401 |       155 |       66 |           16 | 2025-01-07       |        155 | Kimberly          | Ball            | 1959-02-17    | 178, Linden Street, Bangor, BT19 1QJ                |        55 |
|            234 |         3 |       62 |           14 | 2026-08-16       |          3 | Kirk              | Ramirez         | 1965-04-12    | 77, Station Lane, Belfast, BT9 3YQ                  |         3 |
|            310 |       127 |       92 |            4 | 2025-11-01       |        127 | Kofi              | Okafor          | 1972-11-06    | 76, Brookfield Gardens, Glasgow, G41 5ZN            |        27 |
|            199 |       127 |       68 |           16 | 2026-10-12       |        127 | Kofi              | Okafor          | 1972-11-06    | 76, Brookfield Gardens, Glasgow, G41 5ZN            |        27 |
|            485 |       113 |       16 |           21 | 2025-07-07       |        113 | Kojo              | Okafor          | 1972-10-04    | 6, Laurel Court, Brighton, BN1 8XT                  |        13 |
|            262 |       113 |       20 |            8 | 2025-06-10       |        113 | Kojo              | Okafor          | 1972-10-04    | 6, Laurel Court, Brighton, BN1 8XT                  |        13 |
|            415 |       449 |       66 |           14 | 2026-09-12       |        449 | Kosemen           | Guclu           | 2007-03-08    | 134, Juniper Gardens, Cambridge, CB1 1XZ            |        49 |
|            164 |       120 |       36 |           13 | 2024-12-12       |        120 | Kristiane         | Hauffer         | 1944-03-31    | 129, Cedar Grove, Norwich, NR1 5NF                  |        20 |
|            179 |       546 |       50 |            9 | 2026-03-20       |        546 | Kwame             | Owusu           | 2018-05-26    | 2, Sandringham Avenue, Oxford, OX4 2GX              |        46 |
|             68 |       546 |       21 |           25 | 2025-01-20       |        546 | Kwame             | Owusu           | 2018-05-26    | 2, Sandringham Avenue, Oxford, OX4 2GX              |        46 |
|            314 |       162 |       77 |           17 | 2025-12-23       |        162 | Lala              | Permadi         | 1992-05-15    | 28, Fairview Gardens, Nottingham, NG5 7EL           |        62 |
|            344 |       162 |       67 |           16 | 2024-12-02       |        162 | Lala              | Permadi         | 1992-05-15    | 28, Fairview Gardens, Nottingham, NG5 7EL           |        62 |
|            362 |       551 |       23 |           29 | 2025-05-12       |        551 | Lana              | MacVeigh        | 1966-05-13    | 148, Starlight Court, Exeter, EX4 9FP               |        51 |
|             30 |       528 |       30 |           25 | 2025-07-11       |        528 | Lazaro            | Exposito        | 1931-04-10    | 37, Beech Road, Cambridge, CB2 3GY                  |        28 |
|              8 |         7 |       30 |            8 | 2026-03-23       |          7 | Linus             | Schmiedecke     | 1997-01-09    | 60, Sunnyside Gardens, Coventry, CV2 2HS            |         7 |
|            276 |         7 |        7 |           17 | 2026-10-26       |          7 | Linus             | Schmiedecke     | 1997-01-09    | 60, Sunnyside Gardens, Coventry, CV2 2HS            |         7 |
|             23 |       131 |       89 |           18 | 2026-02-25       |        131 | Loreto            | Esteve          | 1960-03-31    | 129, Westfield Court, Bath, BA2 9JB                 |        31 |
|            290 |        50 |       46 |            5 | 2025-04-21       |         50 | Luan              | Peixoto         | 1959-01-17    | 116, Sunnyside Place, Cambridge, CB2 6DE            |        50 |
|            453 |        50 |       30 |           18 | 2026-01-29       |         50 | Luan              | Peixoto         | 1959-01-17    | 116, Sunnyside Place, Cambridge, CB2 6DE            |        50 |
|            354 |        50 |       30 |            9 | 2026-06-02       |         50 | Luan              | Peixoto         | 1959-01-17    | 116, Sunnyside Place, Cambridge, CB2 6DE            |        50 |
|            120 |        50 |       37 |           19 | 2026-11-11       |         50 | Luan              | Peixoto         | 1959-01-17    | 116, Sunnyside Place, Cambridge, CB2 6DE            |        50 |
|            187 |       161 |       41 |           23 | 2025-12-03       |        161 | Lucy              | Johnson         | 1934-12-19    | 92, Juniper Avenue, Exeter, EX2 2UH                 |        61 |
|             79 |       136 |       58 |           15 | 2025-06-23       |        136 | Luisa             | Villegas        | 1975-12-24    | 172, Cherry Close, Southampton, SO15 5GN            |        36 |
|            204 |         9 |       69 |           30 | 2025-03-09       |          9 | Luiz              | Correia         | 2006-06-03    | 26, Pine Gardens, Southampton, SO18 3LH             |         9 |
|            334 |       470 |       16 |           11 | 2026-06-05       |        470 | Luiz              | Guerra          | 1998-09-01    | 72, Woodlands Gardens, Nottingham, NG5 2GW          |        70 |
|            351 |       233 |       20 |           10 | 2025-01-16       |        233 | Mahin             | Ahmed           | 2022-06-01    | 110, Redgate Court, Aberdeen, AB24 9FQ              |        33 |
|            384 |       111 |       17 |           28 | 2026-06-08       |        111 | Maida             | Laksita         | 1940-03-07    | 160, Moorland Place, Bath, BA1 7DA                  |        11 |
|             82 |       111 |       41 |           12 | 2026-08-20       |        111 | Maida             | Laksita         | 1940-03-07    | 160, Moorland Place, Bath, BA1 7DA                  |        11 |
|             32 |       548 |       41 |            2 | 2024-12-31       |        548 | Maksymilian       | Matulewicz      | 1962-11-23    | 150, Westfield Way, Bristol, BS9 8ED                |        48 |
|            315 |       165 |       24 |            4 | 2025-04-10       |        165 | Mandy             | Chadwick        | 1958-12-12    | 46, Acacia Court, Truro, TR1 4JN                    |        65 |
|            117 |       165 |       84 |           21 | 2025-06-28       |        165 | Mandy             | Chadwick        | 1958-12-12    | 46, Acacia Court, Truro, TR1 4JN                    |        65 |
|             20 |       477 |       53 |            8 | 2026-02-02       |        477 | Manuela           | Nunes           | 2018-10-02    | 158, Poplar Terrace, Cardiff, CF14 6ET              |        77 |
|            347 |        54 |       74 |           18 | 2024-12-16       |         54 | Mar               | Carranza        | 1968-04-24    | 73, Mayfield Court, Belfast, BT5 8QS                |        54 |
|            159 |        27 |       21 |            2 | 2025-11-13       |         27 | Marc              | Turpin          | 2000-12-31    | 60, Acacia Terrace, Truro, TR1 8WX                  |        27 |
|             10 |         4 |       89 |           26 | 2025-01-15       |          4 | Margaret          | Fuller          | 1980-08-23    | 114, Willow Way, Oxford, OX4 2NH                    |         4 |
|            433 |       142 |       58 |           12 | 2026-01-31       |        142 | Maria             | Sa              | 2018-05-07    | 16, Riverside Gardens, Newcastle upon Tyne, NE6 1AG |        42 |
|            360 |       142 |       85 |            2 | 2026-06-18       |        142 | Maria             | Sa              | 2018-05-07    | 16, Riverside Gardens, Newcastle upon Tyne, NE6 1AG |        42 |
|             37 |       142 |       67 |           16 | 2025-11-04       |        142 | Maria             | Sa              | 2018-05-07    | 16, Riverside Gardens, Newcastle upon Tyne, NE6 1AG |        42 |
|            322 |        92 |       81 |            7 | 2024-11-30       |         92 | Marianna          | Son             | 1955-12-08    | 83, Park Avenue, Reading, RG2 5GE                   |        92 |
|             59 |       253 |       63 |           24 | 2025-06-16       |        253 | Mario             | Barnett         | 1981-06-23    | 130, Primrose Place, York, YO10 4NQ                 |        53 |
|            241 |       357 |       50 |           28 | 2026-07-10       |        357 | Marisol           | Navarrete       | 1931-03-20    | 123, Starlight Close, Southampton, SO18 2DP         |        57 |
|            238 |       264 |       97 |            6 | 2024-12-26       |        264 | Marjan            | Krause          | 1966-11-26    | 166, Belmont Place, Norwich, NR7 2RF                |        64 |
|            183 |       134 |       13 |           11 | 2025-03-23       |        134 | Mark              | Howley          | 1953-01-30    | 27, Sandringham Drive, Portsmouth, PO2 3BB          |        34 |
|            246 |       134 |       92 |           10 | 2024-11-23       |        134 | Mark              | Howley          | 1953-01-30    | 27, Sandringham Drive, Portsmouth, PO2 3BB          |        34 |
|            177 |       124 |       13 |           23 | 2026-03-16       |        124 | Mark              | Skinner         | 1955-02-18    | 83, Clifton Way, Oxford, OX2 9ZU                    |        24 |
|            490 |       124 |       35 |           24 | 2025-08-02       |        124 | Mark              | Skinner         | 1955-02-18    | 83, Clifton Way, Oxford, OX2 9ZU                    |        24 |
|            500 |       188 |       67 |           16 | 2026-06-08       |        188 | Marta             | Segebahn        | 1927-07-04    | 64, Fern Way, Leeds, LS6 5SP                        |        88 |
|            400 |       188 |       37 |           26 | 2026-06-07       |        188 | Marta             | Segebahn        | 1927-07-04    | 64, Fern Way, Leeds, LS6 5SP                        |        88 |
|            168 |       188 |       10 |           10 | 2024-12-24       |        188 | Marta             | Segebahn        | 1927-07-04    | 64, Fern Way, Leeds, LS6 5SP                        |        88 |
|            132 |       188 |       62 |           26 | 2025-12-12       |        188 | Marta             | Segebahn        | 1927-07-04    | 64, Fern Way, Leeds, LS6 5SP                        |        88 |
|             89 |       580 |       10 |            3 | 2025-11-25       |        580 | Martino           | Agazzi          | 1962-06-15    | 151, Queens Crescent, Southampton, SO16 3GD         |        80 |
|            298 |       580 |       21 |            4 | 2025-07-06       |        580 | Martino           | Agazzi          | 1962-06-15    | 151, Queens Crescent, Southampton, SO16 3GD         |        80 |
|             50 |       497 |        8 |           10 | 2024-12-28       |        497 | Mathew            | Ward            | 2013-11-28    | 161, Bramble Road, Southampton, SO16 8HJ            |        97 |
|             14 |       229 |       68 |           10 | 2025-01-02       |        229 | Matthew           | Taylor          | 1973-01-18    | 161, Ivy Drive, Bristol, BS7 6QW                    |        29 |
|             91 |       229 |       70 |            5 | 2025-11-22       |        229 | Matthew           | Taylor          | 1973-01-18    | 161, Ivy Drive, Bristol, BS7 6QW                    |        29 |
|            403 |       270 |       46 |           12 | 2025-02-26       |        270 | Maurice           | He              | 1984-10-19    | 141, Lavender Road, Portsmouth, PO6 1RW             |        70 |
|            332 |       270 |       91 |           17 | 2025-04-07       |        270 | Maurice           | He              | 1984-10-19    | 141, Lavender Road, Portsmouth, PO6 1RW             |        70 |
|            443 |       573 |        5 |            1 | 2025-02-07       |        573 | Maurice           | Thornton        | 1978-07-22    | 125, Brook Drive, Oxford, OX4 6PQ                   |        73 |
|             76 |        24 |       82 |           30 | 2026-05-03       |         24 | Maurilio          | Murri           | 1987-09-30    | 151, Ashfield Court, Cambridge, CB1 6TN             |        24 |
|            128 |       186 |       22 |            8 | 2026-08-08       |        186 | Maya              | Majumdar        | 1958-05-30    | 16, Ivy Lane, Liverpool, L18 2GL                    |        86 |
|            437 |       224 |       66 |           22 | 2026-05-05       |        224 | Mazlum            | Camurcuoglu     | 1932-08-28    | 37, Cherry Road, Aberdeen, AB15 1JA                 |        24 |
|            133 |       591 |       90 |           24 | 2026-03-25       |        591 | Meera             | Nair            | 1980-10-17    | 33, Cherry Gardens, Aberdeen, AB15 3YQ              |        91 |
|            294 |       379 |        7 |           11 | 2026-08-31       |        379 | Meera             | Sharma          | 1959-07-25    | 179, Queens Grove, Glasgow, G31 5FD                 |        79 |
|            445 |       285 |       66 |           23 | 2025-06-27       |        285 | Meera             | Singh           | 1967-06-18    | 114, Ivy Grove, Bath, BA2 4DL                       |        85 |
|            130 |       285 |       25 |            8 | 2025-10-09       |        285 | Meera             | Singh           | 1967-06-18    | 114, Ivy Grove, Bath, BA2 4DL                       |        85 |
|            203 |        99 |       84 |            6 | 2025-08-07       |         99 | Mei               | Li              | 2025-11-24    | 105, Devonshire Grove, Bath, BA2 9LB                |        99 |
|             70 |       238 |       87 |           28 | 2026-08-10       |        238 | Melania           | Pometta         | 2001-04-07    | 118, Bramble Grove, Cambridge, CB4 7LR              |        38 |
|            197 |       457 |       46 |           17 | 2025-11-04       |        457 | Melanie           | Macdonald       | 2000-01-19    | 85, Meadow Terrace, Oxford, OX2 7GB                 |        57 |
|            312 |       457 |       14 |           16 | 2025-05-07       |        457 | Melanie           | Macdonald       | 2000-01-19    | 85, Meadow Terrace, Oxford, OX2 7GB                 |        57 |
|            123 |       457 |       38 |           15 | 2026-01-05       |        457 | Melanie           | Macdonald       | 2000-01-19    | 85, Meadow Terrace, Oxford, OX2 7GB                 |        57 |
|            101 |       210 |       43 |           24 | 2026-05-21       |        210 | Melissa           | Borsiere        | 2020-09-12    | 17, Lakeside Gardens, Leeds, LS17 3RP               |        10 |
|            184 |       510 |       94 |           13 | 2026-04-04       |        510 | Michael           | Berg            | 1960-01-19    | 29, Pine Lane, Newport, NP20 4FA                    |        10 |
|            452 |        30 |       95 |           26 | 2026-09-15       |         30 | Miguel            | Campos          | 2003-04-14    | 14, Hazel Lane, Cambridge, CB2 4ZH                  |        30 |
|            151 |        30 |       62 |            1 | 2025-05-14       |         30 | Miguel            | Campos          | 2003-04-14    | 14, Hazel Lane, Cambridge, CB2 4ZH                  |        30 |
|            434 |       434 |       79 |           30 | 2025-08-22       |        434 | Minji             | Kim             | 1980-09-08    | 14, Belmont Place, Sheffield, S6 1YQ                |        34 |
|            282 |       434 |       19 |           22 | 2025-08-11       |        434 | Minji             | Kim             | 1980-09-08    | 14, Belmont Place, Sheffield, S6 1YQ                |        34 |
|            228 |       220 |       70 |           13 | 2025-04-10       |        220 | Minji             | Park            | 2021-07-24    | 97, Albert Terrace, Bangor, BT20 5XT                |        20 |
|            119 |       220 |       89 |            3 | 2025-10-13       |        220 | Minji             | Park            | 2021-07-24    | 97, Albert Terrace, Bangor, BT20 5XT                |        20 |
|            358 |       220 |       89 |            7 | 2026-06-15       |        220 | Minji             | Park            | 2021-07-24    | 97, Albert Terrace, Bangor, BT20 5XT                |        20 |
|            224 |        93 |        6 |           15 | 2026-03-28       |         93 | Monica            | Matos           | 1976-05-12    | 60, Brook Lane, Cardiff, CF5 1JP                    |        93 |
|            371 |        93 |       93 |            4 | 2024-12-20       |         93 | Monica            | Matos           | 1976-05-12    | 60, Brook Lane, Cardiff, CF5 1JP                    |        93 |
|            175 |       167 |       53 |            5 | 2026-07-12       |        167 | Napoleone         | Vespucci        | 1956-06-25    | 90, Park Crescent, Oxford, OX3 5TJ                  |        67 |
|            259 |       176 |       77 |            6 | 2026-06-12       |        176 | Nataniel          | Seta            | 1948-05-25    | 154, Lavender Terrace, Coventry, CV5 7QE            |        76 |
|            357 |       212 |       51 |           12 | 2026-03-27       |        212 | Neha              | Singh           | 1937-03-30    | 130, Cherry Close, Oxford, OX3 1SR                  |        12 |
|             12 |       212 |       74 |           28 | 2025-08-16       |        212 | Neha              | Singh           | 1937-03-30    | 130, Cherry Close, Oxford, OX3 1SR                  |        12 |
|            471 |       246 |       62 |           21 | 2025-01-14       |        246 | Nikki             | O'Crowley       | 1991-09-26    | 89, Primrose Gardens, York, YO24 7PE                |        46 |
|            289 |        38 |       52 |            2 | 2025-01-01       |         38 | Nina              | Sa              | 1931-12-12    | 150, Hazel Avenue, Coventry, CV2 2LR                |        38 |
|            302 |        38 |       58 |           25 | 2025-03-10       |         38 | Nina              | Sa              | 1931-12-12    | 150, Hazel Avenue, Coventry, CV2 2LR                |        38 |
|            422 |       598 |       58 |           27 | 2026-04-10       |        598 | Oksana            | Melnyk          | 2012-07-23    | 92, Foxglove Court, Sheffield, S6 1XG               |        98 |
|            373 |        48 |        6 |           16 | 2025-07-31       |         48 | Olga              | Junken          | 1994-05-10    | 172, Meadow Gardens, Edinburgh, EH4 2DA             |        48 |
|            350 |       277 |       99 |           22 | 2025-10-26       |        277 | Olgierd           | Wojtiuk         | 1946-02-17    | 121, Greenfield Court, Oxford, OX4 9GH              |        77 |
|            486 |       277 |       52 |            3 | 2026-05-21       |        277 | Olgierd           | Wojtiuk         | 1946-02-17    | 121, Greenfield Court, Oxford, OX4 9GH              |        77 |
|             46 |        15 |       89 |           22 | 2024-12-15       |         15 | Omaja             | Madan           | 2003-06-27    | 48, Willow Avenue, Plymouth, PL6 4EB                |        15 |
|             52 |       492 |       47 |           10 | 2024-12-30       |        492 | Pablo             | Anguiano        | 2006-05-12    | 109, Birch Terrace, Southampton, SO18 8PF           |        92 |
|            178 |       482 |       78 |           15 | 2025-01-24       |        482 | Patrick           | Kramer          | 1956-02-24    | 140, Ivy Crescent, Reading, RG30 8RD                |        82 |
|            356 |       506 |       11 |            4 | 2026-07-16       |        506 | Paula             | Scott           | 2002-05-02    | 141, Hazel Avenue, Belfast, BT5 9WL                 |         6 |
|             60 |       506 |       80 |            8 | 2025-10-11       |        506 | Paula             | Scott           | 2002-05-02    | 141, Hazel Avenue, Belfast, BT5 9WL                 |         6 |
|            463 |        62 |       64 |            3 | 2025-07-31       |         62 | Peter             | Garde           | 1931-06-28    | 6, Pine Avenue, Sheffield, S10 8NQ                  |        62 |
|            493 |        62 |       74 |           24 | 2025-03-27       |         62 | Peter             | Garde           | 1931-06-28    | 6, Pine Avenue, Sheffield, S10 8NQ                  |        62 |
|            113 |       522 |       25 |            4 | 2026-10-23       |        522 | Pierpaolo         | Ferragamo       | 2014-04-26    | 60, Riverside Road, Truro, TR1 4SR                  |        22 |
|            270 |       522 |       12 |           23 | 2025-01-16       |        522 | Pierpaolo         | Ferragamo       | 2014-04-26    | 60, Riverside Road, Truro, TR1 4SR                  |        22 |
|             61 |       298 |       49 |            5 | 2026-06-01       |        298 | Pietra            | da Rosa         | 1944-06-13    | 172, Sandringham Way, Leeds, LS12 2RS               |        98 |
|             41 |       389 |       51 |           17 | 2026-07-21       |        389 | Prabowo           | Rajata          | 1976-12-17    | 180, Clifton Gardens, Wrexham, LL11 2DN             |        89 |
|             51 |       583 |       96 |           22 | 2025-01-09       |        583 | Priscila          | Pardo           | 1944-03-22    | 27, Ash Terrace, Liverpool, L25 3QA                 |        83 |
|            190 |        43 |       36 |            5 | 2025-09-18       |         43 | Priya             | Nair            | 1929-08-06    | 153, Belmont Road, Aberdeen, AB10 9JQ               |        43 |
|            188 |       447 |       32 |           22 | 2026-04-19       |        447 | Priya             | Shah            | 2025-10-31    | 99, Silverdale Way, Belfast, BT5 6ES                |        47 |
|            306 |       105 |       48 |           24 | 2025-09-21       |        105 | Priya             | Sharma          | 1975-10-27    | 99, Queens Court, Newcastle upon Tyne, NE4 4AF      |         5 |
|            215 |       105 |       72 |           28 | 2025-05-01       |        105 | Priya             | Sharma          | 1975-10-27    | 99, Queens Court, Newcastle upon Tyne, NE4 4AF      |         5 |
|            497 |       465 |       11 |           29 | 2025-01-30       |        465 | Priya             | Singh           | 1987-07-08    | 125, Oak Avenue, Lisburn, BT27 7FN                  |        65 |
|            279 |       465 |        5 |            3 | 2025-12-25       |        465 | Priya             | Singh           | 1987-07-08    | 125, Oak Avenue, Lisburn, BT27 7FN                  |        65 |
|            121 |       465 |        6 |            8 | 2025-06-19       |        465 | Priya             | Singh           | 1987-07-08    | 125, Oak Avenue, Lisburn, BT27 7FN                  |        65 |
|            200 |       308 |        7 |           11 | 2025-02-20       |        308 | Raina             | Pranowo         | 1984-10-11    | 123, Lakeside Street, Reading, RG1 3GT              |         8 |
|            243 |       308 |       93 |            3 | 2025-05-22       |        308 | Raina             | Pranowo         | 1984-10-11    | 123, Lakeside Street, Reading, RG1 3GT              |         8 |
|            281 |       520 |       69 |            6 | 2024-12-22       |        520 | Raphaela          | Bachmann        | 1950-10-26    | 116, Kings Way, Portsmouth, PO2 5SL                 |        20 |
|            268 |       520 |       96 |            7 | 2025-03-18       |        520 | Raphaela          | Bachmann        | 1950-10-26    | 116, Kings Way, Portsmouth, PO2 5SL                 |        20 |
|             29 |       330 |       41 |           14 | 2026-08-19       |        330 | Rehaan            | Mukhopadhyay    | 1938-05-26    | 35, Bramble Place, Derby, DE22 8HQ                  |        30 |
|            217 |       478 |       26 |           22 | 2026-02-24       |        478 | Ren               | Sato            | 1976-10-09    | 109, Belmont Avenue, Liverpool, L18 8LQ             |        78 |
|            232 |       478 |        1 |            8 | 2025-07-13       |        478 | Ren               | Sato            | 1976-10-09    | 109, Belmont Avenue, Liverpool, L18 8LQ             |        78 |
|            156 |       141 |       55 |            6 | 2026-07-07       |        141 | Ren               | Watanabe        | 1986-05-15    | 175, Oak Lane, Dundee, DD4 5PQ                      |        41 |
|            296 |       403 |       89 |           30 | 2026-09-29       |        403 | Ren               | Yamamoto        | 1958-05-27    | 24, Foxglove Place, Aberdeen, AB10 9FZ              |         3 |
|            124 |       403 |       33 |           19 | 2026-10-14       |        403 | Ren               | Yamamoto        | 1958-05-27    | 24, Foxglove Place, Aberdeen, AB10 9FZ              |         3 |
|            482 |       154 |        6 |            4 | 2025-07-06       |        154 | Rene              | Llano           | 2010-09-15    | 6, Poplar Avenue, Portsmouth, PO6 2TA               |        54 |
|            309 |       498 |       34 |           20 | 2026-02-27       |        498 | Renee             | Bailly          | 1980-12-13    | 13, Willow Grove, Dundee, DD2 9RD                   |        98 |
|             77 |       192 |       96 |           11 | 2026-06-25       |        192 | Richard           | Stokes          | 1972-04-06    | 58, Poplar Way, Southampton, SO15 1SD               |        92 |
|            257 |       192 |       21 |            4 | 2025-10-05       |        192 | Richard           | Stokes          | 1972-04-06    | 58, Poplar Way, Southampton, SO15 1SD               |        92 |
|             40 |       503 |       72 |           22 | 2025-05-15       |        503 | Robert            | Jones           | 1994-07-28    | 114, Devonshire Terrace, Wrexham, LL12 3ZR          |         3 |
|            135 |       377 |       49 |            7 | 2026-10-21       |        377 | Rocio             | Aguilera        | 1967-08-02    | 39, Highfield Court, Edinburgh, EH4 3WQ             |        77 |
|            305 |       317 |       55 |           19 | 2026-05-15       |        317 | Roman             | Pininfarina     | 1934-10-09    | 95, Clifton Drive, Leeds, LS6 2NY                   |        17 |
|             56 |       394 |       26 |           15 | 2025-01-17       |        394 | Roseanna          | Ferguson        | 1952-07-05    | 128, Poplar Gardens, Hull, HU6 5HU                  |        94 |
|            398 |       394 |       34 |           23 | 2025-02-02       |        394 | Roseanna          | Ferguson        | 1952-07-05    | 128, Poplar Gardens, Hull, HU6 5HU                  |        94 |
|             21 |       509 |       21 |           26 | 2026-03-26       |        509 | Rudra             | Banik           | 2003-04-23    | 6, Rowan Close, Birmingham, B28 3GN                 |         9 |
|            174 |       560 |       60 |           13 | 2025-08-24       |        560 | Rupert            | Koch            | 1990-08-06    | 114, Woodlands Close, Newport, NP20 5TT             |        60 |
|            370 |       560 |       74 |           17 | 2025-09-25       |        560 | Rupert            | Koch            | 1990-08-06    | 114, Woodlands Close, Newport, NP20 5TT             |        60 |
|              2 |       222 |        3 |            9 | 2026-06-21       |        222 | Russell           | Skinner         | 1936-12-21    | 64, Meadow Grove, Sheffield, S10 4NA                |        22 |
|            293 |       222 |       83 |            2 | 2024-12-26       |        222 | Russell           | Skinner         | 1936-12-21    | 64, Meadow Grove, Sheffield, S10 4NA                |        22 |
|            248 |        81 |       73 |           22 | 2025-11-05       |         81 | Sadman            | Gul             | 1955-05-29    | 154, Brookfield Close, Bath, BA2 5UW                |        81 |
|            414 |        81 |       52 |            4 | 2026-01-09       |         81 | Sadman            | Gul             | 1955-05-29    | 154, Brookfield Close, Bath, BA2 5UW                |        81 |
|            160 |       198 |        9 |           15 | 2026-11-10       |        198 | Samir             | Farouk          | 1953-11-13    | 129, Heather Gardens, Glasgow, G31 9LP              |        98 |
|            335 |       386 |       52 |            8 | 2026-09-05       |        386 | Savak             | Corlu           | 1941-03-18    | 157, Elm Drive, Brighton, BN1 5LF                   |        86 |
|            468 |       485 |       10 |           13 | 2026-06-22       |        485 | Seojun            | Choi            | 2004-01-20    | 110, Springfield Place, Glasgow, G31 3FE            |        85 |
|            240 |       485 |       75 |           30 | 2025-11-07       |        485 | Seojun            | Choi            | 2004-01-20    | 110, Springfield Place, Glasgow, G31 3FE            |        85 |
|            363 |        35 |       36 |           11 | 2025-04-11       |         35 | Sheila            | Stanley         | 1980-09-20    | 24, Orchard Way, Portsmouth, PO2 1SG                |        35 |
|            394 |       479 |       14 |           13 | 2024-12-20       |        479 | Shivani           | Shan            | 1989-11-07    | 47, Richmond Court, Cambridge, CB1 6FY              |        79 |
|            498 |        85 |       14 |           30 | 2026-08-28       |         85 | Silva             | Heintze         | 2020-04-12    | 147, Maple Street, Inverness, IV3 8DE               |        85 |
|            237 |       336 |       12 |           18 | 2025-01-26       |        336 | Silvia            | Canales         | 2018-10-09    | 164, Silverdale Lane, Bath, BA1 8QB                 |        36 |
|            213 |       312 |       27 |           18 | 2026-06-07       |        312 | Simber            | Karadeniz       | 1956-03-27    | 41, Sycamore Way, Aberdeen, AB24 4LG                |        12 |
|              5 |       187 |       93 |           10 | 2024-12-17       |        187 | Simonetta         | Calbo           | 1941-07-09    | 105, Sunnyside Avenue, Bath, BA1 7BN                |        87 |
|             26 |       515 |       63 |           14 | 2025-08-15       |        515 | Sonia             | Loffler         | 1993-10-13    | 164, Laurel Crescent, Reading, RG30 9ZS             |        15 |
|            392 |       322 |       17 |           22 | 2026-05-16       |        322 | Soobin            | Kim             | 1940-09-16    | 165, Victoria Lane, Edinburgh, EH11 2EQ             |        22 |
|            425 |        25 |       41 |           13 | 2025-03-27       |         25 | Sora              | Nakamura        | 1948-12-24    | 33, Poplar Way, Bath, BA1 5AD                       |        25 |
|            137 |       272 |       94 |           11 | 2026-07-01       |        272 | Sora              | Tanaka          | 2007-10-08    | 12, Bramble Terrace, Manchester, M20 4TP            |        72 |
|             86 |       341 |       87 |           16 | 2026-09-04       |        341 | Sultana           | Das             | 1999-08-21    | 133, Chestnut Avenue, Swansea, SA2 1PL              |        41 |
|            105 |       152 |       34 |           18 | 2026-01-18       |        152 | Sylwia            | Prazmo          | 1961-07-27    | 159, Richmond Court, Cardiff, CF23 5BN              |        52 |
|            365 |       266 |       96 |           19 | 2026-10-04       |        266 | Tammy             | Gibson          | 1976-07-02    | 124, Fern Way, Bangor, BT20 5YT                     |        66 |
|            383 |        52 |       86 |           17 | 2026-10-11       |         52 | Tanvir            | Islam           | 1981-07-31    | 16, Lavender Lane, Birmingham, B17 4RN              |        52 |
|            192 |       250 |       24 |           17 | 2026-03-15       |        250 | Tanya             | Edwards         | 2019-01-24    | 14, Oak Terrace, Truro, TR1 1RR                     |        50 |
|            131 |       250 |       62 |            1 | 2025-10-20       |        250 | Tanya             | Edwards         | 2019-01-24    | 14, Oak Terrace, Truro, TR1 1RR                     |        50 |
|            412 |       250 |        9 |           14 | 2025-01-03       |        250 | Tanya             | Edwards         | 2019-01-24    | 14, Oak Terrace, Truro, TR1 1RR                     |        50 |
|             55 |       250 |       65 |           15 | 2026-08-12       |        250 | Tanya             | Edwards         | 2019-01-24    | 14, Oak Terrace, Truro, TR1 1RR                     |        50 |
|            483 |       250 |        4 |           10 | 2024-11-23       |        250 | Tanya             | Edwards         | 2019-01-24    | 14, Oak Terrace, Truro, TR1 1RR                     |        50 |
|            205 |       340 |       11 |           27 | 2026-01-02       |        340 | Tasvir            | Yaman           | 1958-02-10    | 46, Orchard Street, Manchester, M20 3DF             |        40 |
|            292 |       115 |       88 |            1 | 2026-09-29       |        115 | Tezol             | Ergul           | 1966-06-01    | 86, Ashfield Close, York, YO10 6EW                  |        15 |
|            285 |       218 |      100 |           24 | 2025-03-06       |        218 | Theobald          | Kohl            | 1965-07-13    | 171, Mayfield Road, Dundee, DD3 1DQ                 |        18 |
|            429 |       240 |       97 |            8 | 2025-04-17       |        240 | Theodore          | Dara            | 1963-11-21    | 85, Hillcrest Street, Southampton, SO15 6NB         |        40 |
|            478 |       240 |       52 |           24 | 2025-11-26       |        240 | Theodore          | Dara            | 1963-11-21    | 85, Hillcrest Street, Southampton, SO15 6NB         |        40 |
|             57 |       240 |       33 |            6 | 2026-06-14       |        240 | Theodore          | Dara            | 1963-11-21    | 85, Hillcrest Street, Southampton, SO15 6NB         |        40 |
|            349 |       240 |       49 |           19 | 2025-06-20       |        240 | Theodore          | Dara            | 1963-11-21    | 85, Hillcrest Street, Southampton, SO15 6NB         |        40 |
|            300 |       191 |       51 |           27 | 2026-02-21       |        191 | Theresa           | Valdez          | 1938-01-26    | 24, Windsor Way, Bath, BA1 6SR                      |        91 |
|            291 |       380 |       16 |            8 | 2025-01-09       |        380 | Thomas            | Garcia          | 1956-11-20    | 97, Devonshire Gardens, Dundee, DD4 7JJ             |        80 |
|             27 |       459 |       62 |           25 | 2026-11-15       |        459 | Timothee          | Lenoir          | 1963-10-15    | 33, Redgate Avenue, Norwich, NR1 1GJ                |        59 |
|             72 |        63 |       70 |           15 | 2025-09-25       |         63 | Tina              | Nibali          | 2023-09-27    | 12, Mill Drive, Southampton, SO15 4TS               |        63 |
|              9 |        63 |       22 |           11 | 2025-12-20       |         63 | Tina              | Nibali          | 2023-09-27    | 12, Mill Drive, Southampton, SO15 4TS               |        63 |
|             62 |       126 |       98 |           16 | 2026-08-24       |        126 | Tola              | Majsterek       | 1966-06-09    | 150, Devonshire Court, Derry, BT47 8XG              |        26 |
|            158 |        23 |        5 |           20 | 2025-08-24       |         23 | Tri               | Wahyudin        | 1989-02-09    | 159, Church Gardens, Liverpool, L18 4XP             |        23 |
|             96 |       529 |       59 |           17 | 2025-06-13       |        529 | Triveni           | Purohit         | 1971-12-24    | 26, Meadow Street, Liverpool, L25 4AF               |        29 |
|            202 |       287 |       97 |            6 | 2025-07-05       |        287 | Tyler             | Dunny           | 1991-10-12    | 31, Brookfield Avenue, Newcastle upon Tyne, NE2 2XQ |        87 |
|            225 |       600 |       43 |            6 | 2025-07-30       |        600 | Upkaar            | Bajwa           | 1949-04-20    | 54, Ivy Close, Aberdeen, AB10 3UT                   |       100 |
|            440 |       600 |       11 |           21 | 2025-03-23       |        600 | Upkaar            | Bajwa           | 1949-04-20    | 54, Ivy Close, Aberdeen, AB10 3UT                   |       100 |
|            450 |       430 |       70 |            4 | 2026-06-01       |        430 | Upkaar            | Kakar           | 2019-06-28    | 37, Station Grove, Norwich, NR7 1WR                 |        30 |
|            331 |       507 |       57 |           25 | 2025-05-14       |        507 | Urs               | Warmer          | 1976-05-25    | 32, Station Close, Oxford, OX3 7RN                  |         7 |
|            153 |       507 |        9 |           29 | 2025-09-28       |        507 | Urs               | Warmer          | 1976-05-25    | 32, Station Close, Oxford, OX3 7RN                  |         7 |
|            126 |       507 |       79 |           25 | 2025-07-04       |        507 | Urs               | Warmer          | 1976-05-25    | 32, Station Close, Oxford, OX3 7RN                  |         7 |
|            321 |       507 |       65 |           29 | 2025-05-05       |        507 | Urs               | Warmer          | 1976-05-25    | 32, Station Close, Oxford, OX3 7RN                  |         7 |
|            346 |       495 |       50 |            8 | 2026-09-25       |        495 | Vicente           | Cavalcante      | 1980-02-20    | 80, Church Close, Dundee, DD3 5DJ                   |        95 |
|             45 |       495 |       49 |           21 | 2026-05-10       |        495 | Vicente           | Cavalcante      | 1980-02-20    | 80, Church Close, Dundee, DD3 5DJ                   |        95 |
|            330 |       252 |       62 |           28 | 2025-05-16       |        252 | Victor            | Verduzco        | 1999-11-29    | 92, Ash Lane, Norwich, NR1 4NE                      |        52 |
|            148 |        98 |       42 |            4 | 2026-01-03       |         98 | Victoria          | Geany           | 2021-05-13    | 28, Elm Road, Cardiff, CF5 8NB                      |        98 |
|            499 |       237 |       96 |           12 | 2025-11-16       |        237 | Virginia          | Granado         | 2007-12-12    | 22, Laurel Avenue, Inverness, IV2 4XU               |        37 |
|            427 |       494 |       31 |           17 | 2025-10-25       |        494 | Vittoria          | Borromini       | 1966-09-10    | 103, Devonshire Crescent, Belfast, BT9 5XE          |        94 |
|            324 |       531 |       77 |           12 | 2024-11-21       |        531 | Watika            | Ravel           | 1986-12-25    | 11, Cherry Drive, Edinburgh, EH11 3GB               |        31 |
|            406 |       531 |       91 |           20 | 2026-05-05       |        531 | Watika            | Ravel           | 1986-12-25    | 11, Cherry Drive, Edinburgh, EH11 3GB               |        31 |
|             38 |       391 |        1 |            8 | 2025-03-01       |        391 | Wawan             | Thamrin         | 2012-04-02    | 95, Foxglove Crescent, Belfast, BT9 9YA             |        91 |
|             87 |       391 |       78 |            6 | 2026-08-06       |        391 | Wawan             | Thamrin         | 2012-04-02    | 95, Foxglove Crescent, Belfast, BT9 9YA             |        91 |
|            397 |       391 |       35 |            2 | 2025-04-22       |        391 | Wawan             | Thamrin         | 2012-04-02    | 95, Foxglove Crescent, Belfast, BT9 9YA             |        91 |
|            106 |       289 |       30 |           16 | 2026-08-26       |        289 | William           | Diaz            | 1941-01-17    | 41, Rowan Crescent, Newport, NP19 7NL               |        89 |
|            342 |       289 |       46 |           21 | 2026-07-31       |        289 | William           | Diaz            | 1941-01-17    | 41, Rowan Crescent, Newport, NP19 7NL               |        89 |
|            286 |       314 |       47 |           27 | 2025-05-19       |        314 | Yatin             | Bir             | 1990-01-15    | 143, Mill Terrace, Inverness, IV2 1TJ               |        14 |
|            484 |       536 |        2 |            8 | 2025-03-21       |        536 | Yejin             | Yoon            | 1946-08-31    | 90, Riverside Court, Coventry, CV3 2XG              |        36 |
|            173 |       247 |       54 |           17 | 2026-07-16       |        247 | Yifan             | Zhao            | 1929-06-30    | 152, Richmond Grove, London, E11 5YX                |        47 |
|            210 |       378 |       87 |            5 | 2025-11-28       |        378 | Ylma              | Inonu           | 1978-06-25    | 17, Devonshire Crescent, Aberdeen, AB10 6GR         |        78 |
|            154 |       387 |       66 |            1 | 2025-10-14       |        387 | Yuki              | Nakamura        | 1978-09-15    | 132, Station Grove, Cambridge, CB2 2LZ              |        87 |
|            444 |       561 |       80 |           10 | 2025-05-15       |        561 | Yuki              | Suzuki          | 1997-06-09    | 12, Belmont Way, Derby, DE22 4UJ                    |        61 |
|            297 |        36 |       10 |           23 | 2025-11-24       |         36 | Yuki              | Watanabe        | 1927-03-22    | 168, Fern Drive, Portsmouth, PO4 5AN                |        36 |
|             66 |       301 |       33 |            1 | 2026-02-11       |        301 | Yuna              | Ito             | 1980-09-28    | 99, Westfield Lane, London, SW4 8ZL                 |         1 |
|             19 |       185 |       87 |           27 | 2026-03-26       |        185 | Yuna              | Tanaka          | 1971-08-22    | 22, Richmond Lane, Bristol, BS7 8HE                 |        85 |
|             80 |       185 |       21 |            5 | 2025-05-18       |        185 | Yuna              | Tanaka          | 1971-08-22    | 22, Richmond Lane, Bristol, BS7 8HE                 |        85 |
|            339 |       185 |        7 |           11 | 2026-06-01       |        185 | Yuna              | Tanaka          | 1971-08-22    | 22, Richmond Lane, Bristol, BS7 8HE                 |        85 |
|            319 |       132 |       22 |            9 | 2025-12-22       |        132 | Yurdaser          | Ihsanoglu       | 1978-09-02    | 14, Lakeside Avenue, Newcastle upon Tyne, NE2 3WJ   |        32 |
|             64 |       132 |       21 |           19 | 2025-10-22       |        132 | Yurdaser          | Ihsanoglu       | 1978-09-02    | 14, Lakeside Avenue, Newcastle upon Tyne, NE2 3WJ   |        32 |
|            166 |       132 |       41 |           19 | 2026-04-09       |        132 | Yurdaser          | Ihsanoglu       | 1978-09-02    | 14, Lakeside Avenue, Newcastle upon Tyne, NE2 3WJ   |        32 |
|             11 |       143 |       69 |           11 | 2025-06-23       |        143 | Zalindra          | Habibi          | 1986-07-17    | 122, Cherry Street, Belfast, BT5 8ZA                |        43 |
+----------------+-----------+----------+--------------+------------------+------------+-------------------+-----------------+---------------+-----------------------------------------------------+-----------+
```

*500 rows in set*

---

## Part B

Each Part B query is a stored procedure in `query.sql`. The procedure is shown, then the `CALL` used and its result.

### B1 Add a new patient registered with a doctor

Procedure `add_new_patient` (inputs: `IN p_firstname VARCHAR(150), IN p_surname VARCHAR(150), IN p_dob DATE, IN p_address VARCHAR(255), IN p_doctor_id INT UNSIGNED`):

```sql
INSERT INTO patients (patient_firstname, patient_surname, date_of_birth, patient_address, doctor_id)
VALUES (p_firstname, p_surname, p_dob, p_address, p_doctor_id);

SELECT *
FROM patients
WHERE patient_id = LAST_INSERT_ID();
```

Run with:

```sql
CALL add_new_patient('Ryan', 'Morgan', '1988-04-12', '12 Queen Street, Exeter, EX4 3SR', 25);
```

```
+------------+-------------------+-----------------+---------------+----------------------------------+-----------+
| patient_id | patient_firstname | patient_surname | date_of_birth | patient_address                  | doctor_id |
+------------+-------------------+-----------------+---------------+----------------------------------+-----------+
|        601 | Ryan              | Morgan          | 1988-04-12    | 12 Queen Street, Exeter, EX4 3SR |        25 |
+------------+-------------------+-----------------+---------------+----------------------------------+-----------+
```

*1 row in set*

### B2 Modify an existing patient's address

Procedure `update_patient_address` (inputs: `IN p_patient_id INT UNSIGNED, IN p_new_address VARCHAR(255)`):

```sql
UPDATE patients
SET patient_address = p_new_address
WHERE patient_id = p_patient_id;

SELECT patient_id, patient_firstname, patient_surname, patient_address
FROM patients
WHERE patient_id = p_patient_id;
```

Run with:

```sql
CALL update_patient_address(17, '5 Pennsylvania Road, Exeter, EX4 6BH');
```

**Before:**

```sql
SELECT patient_id, patient_firstname, patient_surname, patient_address
FROM patients
WHERE patient_id = 17;
```

```
+------------+-------------------+-----------------+------------------------------------+
| patient_id | patient_firstname | patient_surname | patient_address                    |
+------------+-------------------+-----------------+------------------------------------+
|         17 | Hardana           | Mardhiyah       | 17, Starlight Way, Exeter, EX1 3PZ |
+------------+-------------------+-----------------+------------------------------------+
```

*1 row in set*

**After:**

```
+------------+-------------------+-----------------+--------------------------------------+
| patient_id | patient_firstname | patient_surname | patient_address                      |
+------------+-------------------+-----------------+--------------------------------------+
|         17 | Hardana           | Mardhiyah       | 5 Pennsylvania Road, Exeter, EX4 6BH |
+------------+-------------------+-----------------+--------------------------------------+
```

*1 row in set*

### B3 Mailing list: patients registered to doctors at one hospital

Procedure `mailing_list_for_hospital` (inputs: `IN p_hospital VARCHAR(150)`):

```sql
SELECT p.patient_firstname, p.patient_surname, p.patient_address
FROM patients p
JOIN doctors d ON p.doctor_id = d.doctor_id
WHERE d.hospital_name = p_hospital
ORDER BY p.patient_surname, p.patient_firstname;
```

Run with:

```sql
CALL mailing_list_for_hospital('Ashford Children Hospital');
```

```
+-------------------+-----------------+-----------------------------------------+
| patient_firstname | patient_surname | patient_address                         |
+-------------------+-----------------+-----------------------------------------+
| Bilkay            | Arsoy           | 105, Linden Street, Exeter, EX4 8XZ     |
| Clifford          | Baker           | 145, Hillcrest Drive, Cardiff, CF23 2RL |
| Kwame             | Balogun         | 12, Silverdale Drive, Swansea, SA5 2QD  |
| Yvette            | Becker          | 65, Hazel Drive, Bangor, BT20 9PP       |
| Olivie            | Bernier         | 90, Fern Street, York, YO31 8ZU         |
| Sultana           | Das             | 133, Chestnut Avenue, Swansea, SA2 1PL  |
| Sadman            | Gul             | 154, Brookfield Close, Bath, BA2 5UW    |
| Yuna              | Ito             | 99, Westfield Lane, London, SW4 8ZL     |
| Ibrahim           | Lailasari       | 119, Willow Close, Inverness, IV2 1NZ   |
| Adele             | Marion          | 19, Westfield Way, Leicester, LE5 2ZJ   |
| Benjamim          | Mendes          | 96, Poplar Place, Wrexham, LL12 7ZR     |
| Aidan             | Needham         | 148, Station Lane, Liverpool, L25 8TB   |
| Centa             | Nette           | 58, Cherry Close, Sheffield, S10 5YU    |
| Brigitta          | Schweitzer      | 74, Riverside Terrace, Swansea, SA1 2LH |
| Prabowo           | Situmorang      | 148, Kingston Way, Glasgow, G12 7BU     |
| Capucine          | Thierry         | 34, Willow Close, Wrexham, LL12 9DT     |
| Ren               | Watanabe        | 175, Oak Lane, Dundee, DD4 5PQ          |
| Amber             | Weber           | 91, Kings Street, Birmingham, B28 6GG   |
+-------------------+-----------------+-----------------------------------------+
```

*18 rows in set*

### B4 Doctors at Teaching hospitals accredited 2015-2024

Procedure `doctors_at_teaching_hospitals_2015_2024`:

```sql
SELECT d.doctor_id, d.doctor_firstname, d.doctor_surname,
       h.Name AS hospital, h.AccreditationYear
FROM doctors d
JOIN Hospitals h ON d.hospital_name = h.Name
WHERE h.Type = 'Teaching'
  AND h.AccreditationYear BETWEEN 2015 AND 2024
ORDER BY h.Name, d.doctor_surname;
```

Run with:

```sql
CALL doctors_at_teaching_hospitals_2015_2024();
```

```
+-----------+------------------+----------------+--------------------------------+-------------------+
| doctor_id | doctor_firstname | doctor_surname | hospital                       | AccreditationYear |
+-----------+------------------+----------------+--------------------------------+-------------------+
|         5 | Siti             | Abdullah       | Central City Teaching Hospital |              2020 |
|        45 | Nadia            | Ahmed          | Central City Teaching Hospital |              2020 |
|        85 | Anders           | Nielsen        | Central City Teaching Hospital |              2020 |
|        50 | Hassan           | Ali            | Grand Central Hospital         |              2017 |
|        90 | Ingrid           | Larsen         | Grand Central Hospital         |              2017 |
|        10 | Nikhil           | Menon          | Grand Central Hospital         |              2017 |
|        23 | Alexander        | Novak          | Northgate Teaching Hospital    |              2021 |
|        63 | Sofia            | Rossi          | Northgate Teaching Hospital    |              2021 |
|        65 | Amina            | Abdi           | Parkview Teaching Hospital     |              2023 |
|        25 | Beatriz          | Oliveira       | Parkview Teaching Hospital     |              2023 |
|        70 | Ananya           | Iyer           | Royal Meadow Hospital          |              2020 |
|        30 | Chloe            | Williams       | Royal Meadow Hospital          |              2020 |
|        77 | William          | Hughes         | Valley View Teaching Hospital  |              2022 |
|        37 | Ruth             | MacDonald      | Valley View Teaching Hospital  |              2022 |
+-----------+------------------+----------------+--------------------------------+-------------------+
```

*14 rows in set*

### B5 Patients who may have a disease, based on their medication

Procedure `patients_who_may_have_disease` (inputs: `IN p_disease VARCHAR(150)`):

```sql
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
```

Run with:

```sql
CALL patients_who_may_have_disease('Asthma');
```

```
+------------+-------------------+-----------------+--------------+
| patient_id | patient_firstname | patient_surname | medications  |
+------------+-------------------+-----------------+--------------+
|        363 | Josette           | Arnaud          | Prednisolone |
|        520 | Raphaela          | Bachmann        | Salbutamol   |
|        600 | Upkaar            | Bajwa           | Salbutamol   |
|         41 | Clifford          | Baker           | Salbutamol   |
|        189 | Gael              | Barbosa         | Montelukast  |
|        368 | Cecile            | Becker          | Salbutamol   |
|        510 | Michael           | Berg            | Prednisolone |
|        336 | Silvia            | Canales         | Montelukast  |
|         54 | Mar               | Carranza        | Montelukast  |
|        485 | Seojun            | Choi            | Prednisolone |
|        446 | Aoibheann         | Conneely        | Salbutamol   |
|        240 | Theodore          | Dara            | Salbutamol   |
|        287 | Tyler             | Dunny           | Salbutamol   |
|        131 | Loreto            | Esteve          | Montelukast  |
|        139 | Joseph            | Frazier         | Prednisolone |
|        225 | Antonina          | Gaiatto         | Montelukast  |
|        120 | Kristiane         | Hauffer         | Prednisolone |
|        146 | Carl              | Holmes          | Montelukast  |
|        109 | Jerzy             | Jedruch         | Prednisolone |
|        312 | Simber            | Karadeniz       | Montelukast  |
|        290 | Birthe            | Knappe          | Prednisolone |
|        560 | Rupert            | Koch            | Prednisolone |
|        264 | Marjan            | Krause          | Salbutamol   |
|         99 | Mei               | Li              | Salbutamol   |
|        419 | Darmanto          | Maryadi         | Prednisolone |
|        397 | Iryna             | Melnyk          | Montelukast  |
|         64 | Carlos            | Meyer           | Prednisolone |
|        530 | Carolina          | Morpurgo        | Prednisolone |
|        396 | Dominique         | Morvan          | Salbutamol   |
|         25 | Sora              | Nakamura        | Prednisolone |
|        100 | Drajat            | Nashiruddin     | Salbutamol   |
|        462 | James             | Nevin           | Salbutamol   |
|        220 | Minji             | Park            | Prednisolone |
|        382 | Aniela            | Paw             | Montelukast  |
|         50 | Luan              | Peixoto         | Montelukast  |
|        152 | Sylwia            | Prazmo          | Montelukast  |
|        280 | Helena            | Rendon          | Montelukast  |
|        418 | Hredhaan          | Sarkar          | Montelukast  |
|        176 | Nataniel          | Seta            | Salbutamol   |
|        479 | Shivani           | Shan            | Prednisolone |
|        223 | Kateryna          | Shevchenko      | Salbutamol   |
|        436 | Cevale            | Tevetoglu       | Montelukast  |
|        391 | Wawan             | Thamrin         | Salbutamol   |
|        534 | Kateryna          | Tkachenko       | Prednisolone |
|        141 | Ren               | Watanabe        | Salbutamol   |
+------------+-------------------+-----------------+--------------+
```

*45 rows in set*

### B6 Doctors who specialise in a particular disease

Procedure `doctors_specialising_in_disease` (inputs: `IN p_disease VARCHAR(150)`):

```sql
SELECT d.doctor_id, d.doctor_firstname, d.doctor_surname, d.hospital_name
FROM doctors d
JOIN doctor_specialisms ds ON ds.doctor_id = d.doctor_id
JOIN diseases dis          ON dis.disease_id = ds.disease_id
WHERE dis.disease_name = p_disease
ORDER BY d.hospital_name, d.doctor_surname;
```

Run with:

```sql
CALL doctors_specialising_in_disease('Type 2 diabetes');
```

```
+-----------+------------------+----------------+----------------------------------+
| doctor_id | doctor_firstname | doctor_surname | hospital_name                    |
+-----------+------------------+----------------+----------------------------------+
|        42 | David            | Cohen          | Bluebell Children Hospital       |
|         4 | Hiroshi          | Tanaka         | Cedar Grove Psychiatric Hospital |
|        49 | James            | Walker         | Fairview Psychiatric Hospital    |
|        93 | Mateusz          | Kowalski       | Hawthorn General Hospital        |
|        94 | Rafael           | Santos         | Highland Specialist Hospital     |
|        19 | Karim            | Mansour        | Maple Leaf Specialist Hospital   |
|        64 | Aoife            | Murphy         | Oakwood Mental Health Hospital   |
|        34 | Charlotte        | Green          | Springfield General Hospital     |
|        79 | Katherine        | Wood           | Westfield Teaching Hospital      |
+-----------+------------------+----------------+----------------------------------+
```

*9 rows in set*

### B7 Lab results for patients over 60

Procedure `lab_results_patients_over_60`:

```sql
SELECT p.patient_id, p.patient_firstname, p.patient_surname,
       TIMESTAMPDIFF(YEAR, p.date_of_birth, CURDATE()) AS age,
       t.test_name, lr.test_date, lr.result_value, t.unit, lr.result_flag
FROM lab_results lr
JOIN patients p       ON p.patient_id = lr.patient_id
JOIN lab_test_types t ON t.test_type_id = lr.test_type_id
WHERE TIMESTAMPDIFF(YEAR, p.date_of_birth, CURDATE()) > 60
ORDER BY age DESC, p.patient_id, lr.test_date;
```

Run with:

```sql
CALL lab_results_patients_over_60();
```

```
+------------+-------------------+-----------------+------+--------------------+------------+--------------+----------+-------------+
| patient_id | patient_firstname | patient_surname | age  | test_name          | test_date  | result_value | unit     | result_flag |
+------------+-------------------+-----------------+------+--------------------+------------+--------------+----------+-------------+
|         16 | Andic             | Sener           |   99 | Total cholesterol  | 2025-07-16 |         5.63 | mmol/L   | High        |
|         16 | Andic             | Sener           |   99 | Potassium          | 2025-07-19 |         4.59 | mmol/L   | Normal      |
|         16 | Andic             | Sener           |   99 | C-reactive protein | 2025-11-07 |         1.74 | mg/L     | Normal      |
|         16 | Andic             | Sener           |   99 | Potassium          | 2026-07-04 |         4.77 | mmol/L   | Normal      |
|        197 | Kalina            | Piaseczna       |   99 | Potassium          | 2025-11-10 |         4.78 | mmol/L   | Normal      |
|        197 | Kalina            | Piaseczna       |   99 | Vitamin D          | 2026-07-23 |       149.79 | nmol/L   | High        |
|        258 | Carolina          | Giron           |   99 | HbA1c              | 2025-03-17 |        24.43 | mmol/mol | Normal      |
|        596 | Christopher       | Kealty          |   98 | Vitamin D          | 2025-03-19 |        43.58 | nmol/L   | Low         |
|         43 | Priya             | Nair            |   97 | Potassium          | 2025-10-28 |         4.41 | mmol/L   | Normal      |
|        219 | Maanav            | Bassi           |   97 | TSH                | 2026-09-25 |         1.64 | mU/L     | Normal      |
|        381 | Olivie            | Bernier         |   97 | Haemoglobin        | 2025-06-03 |       101.02 | g/L      | Low         |
|        425 | Lufen             | Camurcuoglu     |   97 | Vitamin D          | 2025-03-27 |       112.07 | nmol/L   | Normal      |
|        453 | Jerzy             | Przybys         |   97 | ALT                | 2025-07-26 |        15.83 | U/L      | Normal      |
|        514 | Donald            | Rios            |   97 | Vitamin D          | 2025-02-23 |       116.64 | nmol/L   | Normal      |
|        514 | Donald            | Rios            |   97 | Sodium             | 2026-07-26 |       145.55 | mmol/L   | Normal      |
|        597 | Dorota            | Waloch          |   97 | TSH                | 2025-06-30 |         4.29 | mU/L     | High        |
|        597 | Dorota            | Waloch          |   97 | TSH                | 2026-09-09 |         3.37 | mU/L     | Normal      |
|        106 | Ann               | Graham          |   96 | Sodium             | 2026-10-01 |       140.66 | mmol/L   | Normal      |
|        305 | Beverley          | Kirk            |   96 | ALT                | 2025-10-18 |        22.36 | U/L      | Normal      |
|         62 | Peter             | Garde           |   95 | Vitamin D          | 2025-01-28 |        39.04 | nmol/L   | Low         |
|         62 | Peter             | Garde           |   95 | eGFR               | 2025-02-19 |        93.60 | mL/min   | Normal      |
|        344 | Pietra            | Cassiano        |   95 | TSH                | 2026-01-02 |         1.11 | mU/L     | Normal      |
|        344 | Pietra            | Cassiano        |   95 | ALT                | 2026-07-26 |        33.86 | U/L      | Normal      |
|         38 | Nina              | Sa              |   94 | Sodium             | 2026-09-24 |       134.73 | mmol/L   | Normal      |
|        217 | Christy           | Mallon          |   94 | C-reactive protein | 2024-12-13 |         0.47 | mg/L     | Normal      |
|        217 | Christy           | Mallon          |   94 | C-reactive protein | 2025-03-06 |         4.85 | mg/L     | Normal      |
|        217 | Christy           | Mallon          |   94 | C-reactive protein | 2026-08-27 |         0.15 | mg/L     | Normal      |
|        480 | Tomurcuk          | Zorlu           |   94 | Sodium             | 2025-01-07 |       145.76 | mmol/L   | Normal      |
|        594 | Jennifer          | Green           |   93 | HbA1c              | 2025-08-30 |        29.46 | mmol/mol | Normal      |
|        201 | Kwame             | Balogun         |   92 | Potassium          | 2026-06-30 |         3.74 | mmol/L   | Normal      |
|        310 | Piotr             | Nabiaek         |   92 | Sodium             | 2025-11-18 |       133.68 | mmol/L   | Normal      |
|        310 | Piotr             | Nabiaek         |   92 | Potassium          | 2026-05-29 |         4.77 | mmol/L   | Normal      |
|        317 | Roman             | Pininfarina     |   92 | Potassium          | 2025-03-12 |         6.37 | mmol/L   | High        |
|        321 | Hamza             | Farouk          |   92 | HbA1c              | 2025-03-11 |        13.92 | mmol/mol | Low         |
|        456 | Stefani           | Zichichi        |   92 | Total cholesterol  | 2025-04-15 |         3.40 | mmol/L   | Normal      |
|        161 | Lucy              | Johnson         |   91 | Potassium          | 2026-10-17 |         4.26 | mmol/L   | Normal      |
|        293 | Cesar             | Orta            |   91 | Haemoglobin        | 2024-12-23 |       153.16 | g/L      | Normal      |
|        293 | Cesar             | Orta            |   91 | Haemoglobin        | 2025-06-04 |       124.21 | g/L      | Normal      |
|        293 | Cesar             | Orta            |   91 | Vitamin D          | 2026-10-29 |       119.39 | nmol/L   | Normal      |
|        393 | Ananya            | Gupta           |   91 | TSH                | 2026-09-21 |         2.98 | mU/L     | Normal      |
|        393 | Ananya            | Gupta           |   91 | Potassium          | 2026-09-22 |         5.13 | mmol/L   | Normal      |
|        505 | Hana              | Sato            |   91 | TSH                | 2026-08-26 |         3.22 | mU/L     | Normal      |
|        505 | Hana              | Sato            |   91 | TSH                | 2026-08-30 |         2.14 | mU/L     | Normal      |
|        500 | Arjun             | Singh           |   90 | Vitamin D          | 2024-12-19 |        35.76 | nmol/L   | Low         |
|         76 | Rahul             | Nair            |   89 | Total cholesterol  | 2026-03-05 |         2.42 | mmol/L   | Normal      |
|         76 | Rahul             | Nair            |   89 | TSH                | 2026-11-20 |         3.27 | mU/L     | Normal      |
|        212 | Neha              | Singh           |   89 | C-reactive protein | 2026-03-05 |         0.41 | mg/L     | Normal      |
|        222 | Russell           | Skinner         |   89 | TSH                | 2025-01-29 |         0.22 | mU/L     | Low         |
|        151 | Anselm            | Blumel          |   88 | TSH                | 2025-08-26 |         0.54 | mU/L     | Normal      |
|        151 | Anselm            | Blumel          |   88 | C-reactive protein | 2026-08-07 |         1.54 | mg/L     | Normal      |
|        191 | Theresa           | Valdez          |   88 | Haemoglobin        | 2026-01-03 |       103.22 | g/L      | Low         |
|        191 | Theresa           | Valdez          |   88 | TSH                | 2026-01-09 |         0.31 | mU/L     | Low         |
|        255 | Sora              | Ito             |   88 | Potassium          | 2025-10-14 |         3.76 | mmol/L   | Normal      |
|        255 | Sora              | Ito             |   88 | Vitamin D          | 2025-12-19 |        27.63 | nmol/L   | Low         |
|        330 | Rehaan            | Mukhopadhyay    |   88 | HbA1c              | 2025-04-24 |        22.30 | mmol/mol | Normal      |
|        330 | Rehaan            | Mukhopadhyay    |   88 | C-reactive protein | 2026-08-14 |         4.60 | mg/L     | Normal      |
|        330 | Rehaan            | Mukhopadhyay    |   88 | ALT                | 2026-09-04 |        22.35 | U/L      | Normal      |
|        388 | Nicholas          | Smith           |   88 | Haemoglobin        | 2026-03-05 |       158.71 | g/L      | Normal      |
|        388 | Nicholas          | Smith           |   88 | ALT                | 2026-07-17 |        53.88 | U/L      | Normal      |
|        225 | Antonina          | Gaiatto         |   87 | HbA1c              | 2026-02-07 |        40.55 | mmol/mol | Normal      |
|        399 | Ganga             | Rajan           |   87 | ALT                | 2025-09-20 |        54.32 | U/L      | Normal      |
|         79 | Annunziata        | Germano         |   86 | eGFR               | 2025-07-02 |       115.21 | mL/min   | Normal      |
|         79 | Annunziata        | Germano         |   86 | ALT                | 2026-10-29 |         8.38 | U/L      | Normal      |
|        111 | Maida             | Laksita         |   86 | Sodium             | 2026-01-13 |       135.97 | mmol/L   | Normal      |
|        322 | Soobin            | Kim             |   86 | TSH                | 2025-08-23 |         1.51 | mU/L     | Normal      |
|        322 | Soobin            | Kim             |   86 | ALT                | 2025-10-08 |        26.76 | U/L      | Normal      |
|        187 | Simonetta         | Calbo           |   85 | C-reactive protein | 2025-09-12 |         7.48 | mg/L     | High        |
|        187 | Simonetta         | Calbo           |   85 | Vitamin D          | 2026-01-27 |        42.45 | nmol/L   | Low         |
|        187 | Simonetta         | Calbo           |   85 | TSH                | 2026-07-07 |         3.38 | mU/L     | Normal      |
|        236 | Fatima            | Nasser          |   85 | TSH                | 2025-08-09 |         1.67 | mU/L     | Normal      |
|        289 | William           | Diaz            |   85 | Sodium             | 2026-03-19 |       149.87 | mmol/L   | High        |
|        475 | Renata            | Mannoia         |   85 | HbA1c              | 2026-10-31 |        25.02 | mmol/mol | Normal      |
|        350 | Ama               | Osei            |   83 | eGFR               | 2026-05-22 |       113.63 | mL/min   | Normal      |
|        414 | Gambira           | Pratiwi         |   83 | HbA1c              | 2025-02-23 |        47.19 | mmol/mol | High        |
|        414 | Gambira           | Pratiwi         |   83 | Potassium          | 2025-03-07 |         5.77 | mmol/L   | High        |
|        414 | Gambira           | Pratiwi         |   83 | Potassium          | 2026-03-07 |         4.43 | mmol/L   | Normal      |
|         14 | Isaac             | Thomas          |   82 | eGFR               | 2025-01-01 |        95.83 | mL/min   | Normal      |
|        120 | Kristiane         | Hauffer         |   82 | Vitamin D          | 2025-08-23 |        56.78 | nmol/L   | Normal      |
|        120 | Kristiane         | Hauffer         |   82 | Total cholesterol  | 2025-12-28 |         0.89 | mmol/L   | Normal      |
|        267 | Aisha             | Ahmed           |   82 | ALT                | 2025-03-15 |        10.73 | U/L      | Normal      |
|        298 | Pietra            | da Rosa         |   82 | C-reactive protein | 2025-12-13 |         3.20 | mg/L     | Normal      |
|        504 | Jaiman            | Iswahyudi       |   82 | TSH                | 2026-02-02 |         0.45 | mU/L     | Normal      |
|        504 | Jaiman            | Iswahyudi       |   82 | C-reactive protein | 2026-07-20 |         0.16 | mg/L     | Normal      |
|        583 | Priscila          | Pardo           |   82 | eGFR               | 2025-10-18 |       136.10 | mL/min   | High        |
|         94 | Gabriele          | Cerutti         |   81 | Haemoglobin        | 2025-10-11 |       139.03 | g/L      | Normal      |
|         94 | Gabriele          | Cerutti         |   81 | Total cholesterol  | 2026-01-20 |         5.65 | mmol/L   | High        |
|        426 | Kateryna          | Koval           |   81 | Haemoglobin        | 2025-08-17 |       131.01 | g/L      | Normal      |
|        540 | Jia               | Huang           |   81 | Haemoglobin        | 2025-07-25 |       160.32 | g/L      | Normal      |
|         69 | Leonid            | Hettner         |   80 | Haemoglobin        | 2025-06-16 |       163.35 | g/L      | Normal      |
|        277 | Olgierd           | Wojtiuk         |   80 | C-reactive protein | 2025-12-06 |         6.37 | mg/L     | High        |
|        277 | Olgierd           | Wojtiuk         |   80 | Haemoglobin        | 2026-11-15 |       155.62 | g/L      | Normal      |
|        333 | Antoni            | Cieciura        |   80 | Potassium          | 2026-10-27 |         3.16 | mmol/L   | Low         |
|        517 | Fabian            | Malon           |   80 | eGFR               | 2025-02-24 |        95.45 | mL/min   | Normal      |
|        517 | Fabian            | Malon           |   80 | eGFR               | 2026-10-20 |       130.82 | mL/min   | High        |
|        536 | Yejin             | Yoon            |   80 | C-reactive protein | 2025-03-17 |         0.72 | mg/L     | Normal      |
|        536 | Yejin             | Yoon            |   80 | Total cholesterol  | 2025-07-29 |         0.45 | mmol/L   | Normal      |
|        175 | Kavya             | Gupta           |   79 | C-reactive protein | 2026-01-06 |         3.53 | mg/L     | Normal      |
|        454 | Bethan            | O'Gowan         |   79 | Potassium          | 2024-12-28 |         3.63 | mmol/L   | Normal      |
|        454 | Bethan            | O'Gowan         |   79 | Sodium             | 2026-01-12 |       144.22 | mmol/L   | Normal      |
|        454 | Bethan            | O'Gowan         |   79 | Sodium             | 2026-05-12 |       137.04 | mmol/L   | Normal      |
|        472 | Arjun             | Sharma          |   79 | Sodium             | 2025-01-27 |       130.39 | mmol/L   | Low         |
|        176 | Nataniel          | Seta            |   78 | Potassium          | 2025-09-25 |         4.71 | mmol/L   | Normal      |
|        324 | Ruairi            | Earle           |   78 | Potassium          | 2025-02-11 |         4.61 | mmol/L   | Normal      |
|        360 | Miriam            | Valdes          |   78 | eGFR               | 2026-09-28 |       101.37 | mL/min   | Normal      |
|        549 | Julian            | Kwinta          |   78 | Haemoglobin        | 2026-04-15 |       192.04 | g/L      | High        |
|        570 | Wei               | Zhang           |   78 | Potassium          | 2026-01-23 |         4.55 | mmol/L   | Normal      |
|         25 | Sora              | Nakamura        |   77 | Vitamin D          | 2026-08-16 |        77.99 | nmol/L   | Normal      |
|        352 | Charles           | Mitchell        |   77 | Potassium          | 2026-01-18 |         5.62 | mmol/L   | High        |
|        256 | Raffaella         | Castellitto     |   76 | eGFR               | 2026-06-19 |       113.87 | mL/min   | Normal      |
|        371 | Arno              | Kostolzin       |   76 | Haemoglobin        | 2026-04-27 |       136.36 | g/L      | Normal      |
|        371 | Arno              | Kostolzin       |   76 | eGFR               | 2026-06-02 |       135.15 | mL/min   | High        |
|        468 | Therese           | Nicolas         |   76 | ALT                | 2025-08-28 |        64.23 | U/L      | High        |
|        468 | Therese           | Nicolas         |   76 | TSH                | 2026-06-07 |         3.30 | mU/L     | Normal      |
|         18 | Jordan            | Diez            |   75 | eGFR               | 2025-10-01 |        92.64 | mL/min   | Normal      |
|        139 | Joseph            | Frazier         |   75 | Haemoglobin        | 2025-04-03 |       149.50 | g/L      | Normal      |
|        139 | Joseph            | Frazier         |   75 | eGFR               | 2025-05-08 |       115.67 | mL/min   | Normal      |
|        139 | Joseph            | Frazier         |   75 | ALT                | 2026-07-31 |        29.55 | U/L      | Normal      |
|        181 | Benjamim          | Mendes          |   75 | Haemoglobin        | 2024-12-22 |       133.37 | g/L      | Normal      |
|        181 | Benjamim          | Mendes          |   75 | Haemoglobin        | 2026-06-26 |       134.74 | g/L      | Normal      |
|        450 | Serafina          | Bulzoni         |   75 | TSH                | 2024-12-06 |         1.20 | mU/L     | Normal      |
|        450 | Serafina          | Bulzoni         |   75 | ALT                | 2025-06-23 |        17.29 | U/L      | Normal      |
|        394 | Roseanna          | Ferguson        |   74 | Vitamin D          | 2025-01-07 |        35.09 | nmol/L   | Low         |
|        394 | Roseanna          | Ferguson        |   74 | C-reactive protein | 2025-10-26 |         0.68 | mg/L     | Normal      |
|        586 | Gael              | Pereira         |   74 | ALT                | 2025-01-31 |         5.60 | U/L      | Low         |
|        586 | Gael              | Pereira         |   74 | Haemoglobin        | 2025-09-10 |       188.07 | g/L      | High        |
|        134 | Mark              | Howley          |   73 | HbA1c              | 2026-08-15 |        16.91 | mmol/mol | Low         |
|        198 | Samir             | Farouk          |   73 | Vitamin D          | 2025-10-16 |       159.37 | nmol/L   | High        |
|         51 | Aaron             | Turner          |   72 | TSH                | 2025-02-12 |         0.28 | mU/L     | Low         |
|         88 | Isabel            | Sousa           |   72 | ALT                | 2026-01-14 |        33.51 | U/L      | Normal      |
|        248 | Ananya            | Shah            |   72 | Haemoglobin        | 2025-07-20 |       132.17 | g/L      | Normal      |
|        248 | Ananya            | Shah            |   72 | C-reactive protein | 2026-01-01 |         7.42 | mg/L     | High        |
|        348 | Clara             | Caldeira        |   72 | Total cholesterol  | 2026-04-18 |         4.70 | mmol/L   | Normal      |
|        124 | Mark              | Skinner         |   71 | Total cholesterol  | 2025-06-06 |         4.85 | mmol/L   | Normal      |
|        125 | Hana              | Suzuki          |   71 | HbA1c              | 2025-10-11 |        20.13 | mmol/mol | Normal      |
|        123 | Daniel            | Burgess         |   70 | eGFR               | 2025-01-28 |       117.68 | mL/min   | Normal      |
|        123 | Daniel            | Burgess         |   70 | ALT                | 2025-07-10 |         7.42 | U/L      | Normal      |
|        123 | Daniel            | Burgess         |   70 | ALT                | 2025-11-23 |        44.23 | U/L      | Normal      |
|        158 | Gambira           | Zulaika         |   70 | Haemoglobin        | 2026-01-24 |       127.61 | g/L      | Normal      |
|        158 | Gambira           | Zulaika         |   70 | C-reactive protein | 2026-01-28 |         2.33 | mg/L     | Normal      |
|        221 | Mary              | Baxter          |   70 | Potassium          | 2026-08-29 |         4.66 | mmol/L   | Normal      |
|        296 | Janya             | Mand            |   70 | ALT                | 2025-10-27 |         6.67 | U/L      | Low         |
|        380 | Thomas            | Garcia          |   70 | ALT                | 2025-01-16 |        41.25 | U/L      | Normal      |
|        380 | Thomas            | Garcia          |   70 | Vitamin D          | 2025-03-07 |        72.88 | nmol/L   | Normal      |
|        380 | Thomas            | Garcia          |   70 | eGFR               | 2025-05-15 |        88.30 | mL/min   | Low         |
|        405 | Ciriaco           | Duran           |   70 | Sodium             | 2025-06-16 |       140.22 | mmol/L   | Normal      |
|        482 | Patrick           | Kramer          |   70 | HbA1c              | 2025-11-30 |        41.34 | mmol/mol | Normal      |
|        109 | Jerzy             | Jedruch         |   69 | ALT                | 2025-03-24 |         1.87 | U/L      | Low         |
|        442 | Melissa           | Perez           |   69 | Total cholesterol  | 2025-02-02 |         0.53 | mmol/L   | Normal      |
|        442 | Melissa           | Perez           |   69 | C-reactive protein | 2026-07-01 |         2.62 | mg/L     | Normal      |
|        577 | Joshua            | Glover          |   69 | Potassium          | 2026-02-15 |         4.38 | mmol/L   | Normal      |
|        577 | Joshua            | Glover          |   69 | Potassium          | 2026-09-06 |         4.17 | mmol/L   | Normal      |
|        186 | Maya              | Majumdar        |   68 | Vitamin D          | 2025-12-11 |       118.12 | nmol/L   | Normal      |
|        340 | Tasvir            | Yaman           |   68 | Total cholesterol  | 2025-06-30 |         4.00 | mmol/L   | Normal      |
|        340 | Tasvir            | Yaman           |   68 | Potassium          | 2025-10-06 |         4.52 | mmol/L   | Normal      |
|         50 | Luan              | Peixoto         |   67 | eGFR               | 2026-07-26 |        93.56 | mL/min   | Normal      |
|         89 | Bella             | da Conceicao    |   67 | Total cholesterol  | 2026-02-28 |         5.53 | mmol/L   | High        |
|        155 | Kimberly          | Ball            |   67 | Total cholesterol  | 2025-05-15 |         2.31 | mmol/L   | Normal      |
|        160 | Ekaja             | Mammen          |   67 | eGFR               | 2026-06-25 |        93.56 | mL/min   | Normal      |
|        165 | Mandy             | Chadwick        |   67 | ALT                | 2026-09-24 |        63.72 | U/L      | High        |
|        379 | Meera             | Sharma          |   67 | ALT                | 2025-03-13 |        23.67 | U/L      | Normal      |
|        379 | Meera             | Sharma          |   67 | Sodium             | 2025-04-15 |       143.52 | mmol/L   | Normal      |
|        440 | Noor              | Ali             |   67 | Haemoglobin        | 2025-04-07 |       133.11 | g/L      | Normal      |
|        554 | Kelly             | Molina          |   67 | Haemoglobin        | 2025-04-16 |       127.35 | g/L      | Normal      |
|        554 | Kelly             | Molina          |   67 | Potassium          | 2026-05-29 |         5.88 | mmol/L   | High        |
|         58 | Jia               | Liu             |   66 | eGFR               | 2025-02-23 |        92.69 | mL/min   | Normal      |
|         58 | Jia               | Liu             |   66 | HbA1c              | 2026-05-23 |        24.49 | mmol/mol | Normal      |
|        110 | Yejin             | Kim             |   66 | eGFR               | 2025-01-04 |       117.76 | mL/min   | Normal      |
|        110 | Yejin             | Kim             |   66 | Potassium          | 2025-04-08 |         5.16 | mmol/L   | Normal      |
|        131 | Loreto            | Esteve          |   66 | Haemoglobin        | 2025-10-05 |       109.18 | g/L      | Low         |
|        131 | Loreto            | Esteve          |   66 | eGFR               | 2025-12-11 |       116.59 | mL/min   | Normal      |
|        149 | Eckehard          | Albers          |   66 | HbA1c              | 2025-07-08 |        53.19 | mmol/mol | High        |
|        510 | Michael           | Berg            |   66 | Vitamin D          | 2025-11-16 |       118.66 | nmol/L   | Normal      |
|        585 | Ignacy            | Masiak          |   66 | C-reactive protein | 2025-04-02 |         4.54 | mg/L     | Normal      |
|        585 | Ignacy            | Masiak          |   66 | Vitamin D          | 2025-06-06 |       115.27 | nmol/L   | Normal      |
|          2 | Nas               | Bilgin          |   65 | Haemoglobin        | 2026-05-27 |       179.79 | g/L      | High        |
|        152 | Sylwia            | Prazmo          |   65 | ALT                | 2026-04-18 |        24.34 | U/L      | Normal      |
|        152 | Sylwia            | Prazmo          |   65 | HbA1c              | 2026-05-04 |        54.81 | mmol/mol | High        |
|        576 | Fabiola           | Melendez        |   65 | eGFR               | 2025-09-27 |       118.67 | mL/min   | Normal      |
|        260 | Gokten            | Safak           |   64 | ALT                | 2026-05-16 |        76.59 | U/L      | High        |
|        304 | Ibrahim           | Saleh           |   64 | Vitamin D          | 2026-04-11 |        93.13 | nmol/L   | Normal      |
|        353 | Adam              | Rojas           |   64 | Sodium             | 2026-09-06 |       139.24 | mmol/L   | Normal      |
|        471 | Manuel            | Meyers          |   64 | ALT                | 2025-04-16 |        71.91 | U/L      | High        |
|        548 | Maksymilian       | Matulewicz      |   64 | Potassium          | 2025-08-14 |         4.05 | mmol/L   | Normal      |
|        580 | Martino           | Agazzi          |   64 | Sodium             | 2026-05-29 |       137.96 | mmol/L   | Normal      |
|        595 | Geraldine         | Blake           |   64 | Potassium          | 2026-06-29 |         3.82 | mmol/L   | Normal      |
|        595 | Geraldine         | Blake           |   64 | TSH                | 2026-11-09 |         2.75 | mU/L     | Normal      |
|         57 | Lihua             | Li              |   63 | C-reactive protein | 2026-08-14 |         6.81 | mg/L     | High        |
|         74 | Alcides           | Rocamora        |   63 | Vitamin D          | 2025-08-29 |        52.62 | nmol/L   | Normal      |
|         74 | Alcides           | Rocamora        |   63 | Sodium             | 2025-11-26 |       150.48 | mmol/L   | High        |
|         74 | Alcides           | Rocamora        |   63 | TSH                | 2026-03-01 |         1.85 | mU/L     | Normal      |
|        140 | Toktug            | Sensoy          |   63 | Sodium             | 2025-09-16 |       132.19 | mmol/L   | Low         |
|        240 | Theodore          | Dara            |   63 | C-reactive protein | 2025-03-08 |         1.89 | mg/L     | Normal      |
|        459 | Timothee          | Lenoir          |   63 | Sodium             | 2025-01-09 |       135.61 | mmol/L   | Normal      |
|        459 | Timothee          | Lenoir          |   63 | HbA1c              | 2025-06-29 |        28.55 | mmol/mol | Normal      |
|        519 | Griselda          | Offredi         |   63 | Total cholesterol  | 2025-04-13 |         0.88 | mmol/L   | Normal      |
|         10 | Khalid            | Ali             |   62 | HbA1c              | 2025-07-09 |        16.99 | mmol/mol | Low         |
|        420 | Gian              | Montalcini      |   62 | HbA1c              | 2025-11-30 |        14.75 | mmol/mol | Low         |
|        218 | Theobald          | Kohl            |   61 | Haemoglobin        | 2025-10-18 |       151.86 | g/L      | Normal      |
|        218 | Theobald          | Kohl            |   61 | C-reactive protein | 2026-03-25 |         5.98 | mg/L     | High        |
|        438 | Gunaydin          | Durmus          |   61 | Vitamin D          | 2026-04-02 |       107.28 | nmol/L   | Normal      |
+------------+-------------------+-----------------+------+--------------------+------------+--------------+----------+-------------+
```

*200 rows in set*

### B8 Appointments for a given patient

Procedure `appointments_for_patient` (inputs: `IN p_patient_id INT UNSIGNED`):

```sql
SELECT a.appointment_id, a.appointment_datetime,
       CONCAT(d.doctor_firstname, ' ', d.doctor_surname) AS doctor,
       d.hospital_name
FROM appointments a
JOIN doctors d ON d.doctor_id = a.doctor_id
WHERE a.patient_id = p_patient_id
ORDER BY a.appointment_datetime;
```

Run with:

```sql
CALL appointments_for_patient(1);
```

```
+----------------+----------------------+--------------+---------------------------+
| appointment_id | appointment_datetime | doctor       | hospital_name             |
+----------------+----------------------+--------------+---------------------------+
|              1 | 2027-03-20 14:40:00  | Sana Qureshi | Ashford Children Hospital |
+----------------+----------------------+--------------+---------------------------+
```

*1 row in set*

### B9 Appointments for a given doctor

Procedure `appointments_for_doctor` (inputs: `IN p_doctor_id INT UNSIGNED`):

```sql
SELECT a.appointment_id, a.appointment_datetime,
       p.patient_id,
       CONCAT(p.patient_firstname, ' ', p.patient_surname) AS patient
FROM appointments a
JOIN patients p ON p.patient_id = a.patient_id
WHERE a.doctor_id = p_doctor_id
ORDER BY a.appointment_datetime;
```

Run with:

```sql
CALL appointments_for_doctor(1);
```

```
+----------------+----------------------+------------+--------------------+
| appointment_id | appointment_datetime | patient_id | patient            |
+----------------+----------------------+------------+--------------------+
|            301 | 2026-12-30 12:40:00  |        301 | Yuna Ito           |
|            401 | 2027-01-27 10:40:00  |        401 | Ibrahim Lailasari  |
|              1 | 2027-03-20 14:40:00  |          1 | Amber Weber        |
|            201 | 2027-06-11 09:00:00  |        201 | Kwame Balogun      |
|            101 | 2027-06-21 09:10:00  |        101 | Centa Nette        |
|            501 | 2027-07-25 11:50:00  |        501 | Prabowo Situmorang |
+----------------+----------------------+------------+--------------------+
```

*6 rows in set*

### B10 Prescriptions from one hospital, A-Z by medication (4 columns)

Procedure `prescriptions_from_hospital_by_medication` (inputs: `IN p_hospital VARCHAR(150)`):

```sql
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
```

Run with:

```sql
CALL prescriptions_from_hospital_by_medication('Harbourview General Hospital');
```

```
+---------------------+-----------------+---------------------+------------------------------+
| medication          | doctor          | patient             | hospital                     |
+---------------------+-----------------+---------------------+------------------------------+
| Bisoprolol          | Isabella Garcia | Jay O'Connor        | Harbourview General Hospital |
| Bisoprolol          | Lukas Schneider | Mark Howley         | Harbourview General Hospital |
| Cetirizine          | Isabella Garcia | Ananya Nair         | Harbourview General Hospital |
| Citalopram          | Tariq Mahmoud   | Theodore Dara       | Harbourview General Hospital |
| Diclofenac          | Lukas Schneider | Ananya Shah         | Harbourview General Hospital |
| Diclofenac          | Isabella Garcia | Beverley Kirk       | Harbourview General Hospital |
| Diclofenac          | Tariq Mahmoud   | Gael Barbosa        | Harbourview General Hospital |
| Diclofenac          | Tariq Mahmoud   | Nina Sa             | Harbourview General Hospital |
| Doxycycline         | Lukas Schneider | Kofi Okafor         | Harbourview General Hospital |
| Doxycycline         | Tariq Mahmoud   | Sadman Gul          | Harbourview General Hospital |
| Ezetimibe           | Tariq Mahmoud   | Olgierd Wojtiuk     | Harbourview General Hospital |
| Furosemide          | Isabella Garcia | Dawn Andrews        | Harbourview General Hospital |
| Hydrochlorothiazide | Lukas Schneider | Jiho Choi           | Harbourview General Hospital |
| Montelukast         | Lukas Schneider | Antonina Gaiatto    | Harbourview General Hospital |
| Montelukast         | Lukas Schneider | Carl Holmes         | Harbourview General Hospital |
| Montelukast         | Tariq Mahmoud   | Helena Rendon       | Harbourview General Hospital |
| Montelukast         | Isabella Garcia | Silvia Canales      | Harbourview General Hospital |
| Prednisolone        | Isabella Garcia | Kateryna Tkachenko  | Harbourview General Hospital |
| Ramipril            | Isabella Garcia | Antoni Koscik       | Harbourview General Hospital |
| Tamsulosin          | Tariq Mahmoud   | Aimee Peron         | Harbourview General Hospital |
| Tamsulosin          | Tariq Mahmoud   | Savak Corlu         | Harbourview General Hospital |
| Tramadol            | Isabella Garcia | Hamza Farouk        | Harbourview General Hospital |
| Tramadol            | Lukas Schneider | Jennifer Castillo   | Harbourview General Hospital |
| Warfarin            | Isabella Garcia | Drajat Nashiruddin  | Harbourview General Hospital |
| Warfarin            | Isabella Garcia | Pierpaolo Ferragamo | Harbourview General Hospital |
+---------------------+-----------------+---------------------+------------------------------+
```

*25 rows in set*

### B11 Lab results from hospitals accredited 2013-2020

Procedure `lab_results_hospitals_accredited_2013_2020`:

```sql
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
```

Run with:

```sql
CALL lab_results_hospitals_accredited_2013_2020();
```

```
+----------------------------------+-------------------+---------------+---------------------+--------------------+------------+--------------+----------+-------------+
| hospital                         | AccreditationYear | lab_result_id | patient             | test_name          | test_date  | result_value | unit     | result_flag |
+----------------------------------+-------------------+---------------+---------------------+--------------------+------------+--------------+----------+-------------+
| Ashford Children Hospital        |              2019 |            13 | Benjamim Mendes     | Haemoglobin        | 2024-12-22 |       133.37 | g/L      | Normal      |
| Ashford Children Hospital        |              2019 |            66 | Ren Watanabe        | Vitamin D          | 2025-03-08 |        69.27 | nmol/L   | Normal      |
| Ashford Children Hospital        |              2019 |            75 | Sultana Das         | Potassium          | 2025-03-19 |         4.30 | mmol/L   | Normal      |
| Ashford Children Hospital        |              2019 |           145 | Sultana Das         | eGFR               | 2025-07-03 |        94.69 | mL/min   | Normal      |
| Ashford Children Hospital        |              2019 |           208 | Prabowo Situmorang  | Haemoglobin        | 2025-09-24 |       111.14 | g/L      | Low         |
| Ashford Children Hospital        |              2019 |           265 | Bilkay Arsoy        | HbA1c              | 2025-12-11 |        17.05 | mmol/mol | Low         |
| Ashford Children Hospital        |              2019 |           297 | Simonetta Calbo     | Vitamin D          | 2026-01-27 |        42.45 | nmol/L   | Low         |
| Ashford Children Hospital        |              2019 |           339 | Julien Marin        | C-reactive protein | 2026-04-08 |         7.02 | mg/L     | High        |
| Ashford Children Hospital        |              2019 |           393 | Benjamim Mendes     | Haemoglobin        | 2026-06-26 |       134.74 | g/L      | Normal      |
| Ashford Children Hospital        |              2019 |           395 | Ren Watanabe        | Potassium          | 2026-06-29 |         5.26 | mmol/L   | Normal      |
| Ashford Children Hospital        |              2019 |           399 | Aidan Needham       | eGFR               | 2026-07-01 |       114.75 | mL/min   | Normal      |
| Ashford Children Hospital        |              2019 |           452 | Ren Watanabe        | eGFR               | 2026-09-12 |        90.64 | mL/min   | Normal      |
| Ashford Children Hospital        |              2019 |           455 | Adele Marion        | C-reactive protein | 2026-09-14 |         2.55 | mg/L     | Normal      |
| Ashford Children Hospital        |              2019 |           487 | Serafin Tejada      | Haemoglobin        | 2026-10-27 |       136.41 | g/L      | Normal      |
| Cedar Grove Psychiatric Hospital |              2019 |             4 | Holly Oconnell      | Haemoglobin        | 2024-12-12 |       152.57 | g/L      | Normal      |
| Cedar Grove Psychiatric Hospital |              2019 |           146 | Holly Oconnell      | C-reactive protein | 2025-07-08 |         0.57 | mg/L     | Normal      |
| Cedar Grove Psychiatric Hospital |              2019 |           153 | Pierre Valentin     | HbA1c              | 2025-07-11 |        29.63 | mmol/mol | Normal      |
| Cedar Grove Psychiatric Hospital |              2019 |           194 | Iryna Bondarenko    | Total cholesterol  | 2025-09-01 |         4.35 | mmol/L   | Normal      |
| Cedar Grove Psychiatric Hospital |              2019 |           251 | Piotr Nabiaek       | Sodium             | 2025-11-18 |       133.68 | mmol/L   | Normal      |
| Cedar Grove Psychiatric Hospital |              2019 |           268 | Aimee Peron         | Haemoglobin        | 2025-12-14 |       139.59 | g/L      | Normal      |
| Cedar Grove Psychiatric Hospital |              2019 |           270 | Christina Bryant    | Sodium             | 2025-12-15 |       136.72 | mmol/L   | Normal      |
| Cedar Grove Psychiatric Hospital |              2019 |           279 | Pietra Cassiano     | TSH                | 2026-01-02 |         1.11 | mU/L     | Normal      |
| Cedar Grove Psychiatric Hospital |              2019 |           299 | Jaiman Iswahyudi    | TSH                | 2026-02-02 |         0.45 | mU/L     | Normal      |
| Cedar Grove Psychiatric Hospital |              2019 |           300 | Holly Oconnell      | ALT                | 2026-02-03 |        72.07 | U/L      | High        |
| Cedar Grove Psychiatric Hospital |              2019 |           323 | Mahin Ahmed         | ALT                | 2026-03-06 |         4.63 | U/L      | Low         |
| Cedar Grove Psychiatric Hospital |              2019 |           341 | Ibrahim Saleh       | Vitamin D          | 2026-04-11 |        93.13 | nmol/L   | Normal      |
| Cedar Grove Psychiatric Hospital |              2019 |           358 | Felipe Moura        | eGFR               | 2026-05-11 |       104.02 | mL/min   | Normal      |
| Cedar Grove Psychiatric Hospital |              2019 |           361 | Holly Oconnell      | TSH                | 2026-05-16 |         3.19 | mU/L     | Normal      |
| Cedar Grove Psychiatric Hospital |              2019 |           363 | Delil Manco         | Potassium          | 2026-05-20 |         4.18 | mmol/L   | Normal      |
| Cedar Grove Psychiatric Hospital |              2019 |           365 | Saoirse Collinder   | TSH                | 2026-05-22 |         0.02 | mU/L     | Low         |
| Cedar Grove Psychiatric Hospital |              2019 |           380 | Priya Shah          | Haemoglobin        | 2026-06-04 |       162.31 | g/L      | Normal      |
| Cedar Grove Psychiatric Hospital |              2019 |           402 | Christina Bryant    | Sodium             | 2026-07-02 |       136.48 | mmol/L   | Normal      |
| Cedar Grove Psychiatric Hospital |              2019 |           411 | Jaiman Iswahyudi    | C-reactive protein | 2026-07-20 |         0.16 | mg/L     | Normal      |
| Cedar Grove Psychiatric Hospital |              2019 |           419 | Pietra Cassiano     | ALT                | 2026-07-26 |        33.86 | U/L      | Normal      |
| Cedar Grove Psychiatric Hospital |              2019 |           476 | Karsana Kuswandari  | C-reactive protein | 2026-10-13 |         2.50 | mg/L     | Normal      |
| Central City Teaching Hospital   |              2020 |             6 | Gail Payne          | eGFR               | 2024-12-13 |        92.32 | mL/min   | Normal      |
| Central City Teaching Hospital   |              2020 |            42 | Gaurika Nori        | TSH                | 2025-02-07 |         4.22 | mU/L     | High        |
| Central City Teaching Hospital   |              2020 |            45 | Seojun Choi         | ALT                | 2025-02-11 |        13.49 | U/L      | Normal      |
| Central City Teaching Hospital   |              2020 |            80 | Amy Horne           | eGFR               | 2025-03-27 |       102.96 | mL/min   | Normal      |
| Central City Teaching Hospital   |              2020 |            82 | Ignacy Masiak       | C-reactive protein | 2025-04-02 |         4.54 | mg/L     | Normal      |
| Central City Teaching Hospital   |              2020 |           118 | Gail Payne          | Haemoglobin        | 2025-05-30 |       158.74 | g/L      | Normal      |
| Central City Teaching Hospital   |              2020 |           126 | Ignacy Masiak       | Vitamin D          | 2025-06-06 |       115.27 | nmol/L   | Normal      |
| Central City Teaching Hospital   |              2020 |           134 | Ciriaco Duran       | Sodium             | 2025-06-16 |       140.22 | mmol/L   | Normal      |
| Central City Teaching Hospital   |              2020 |           143 | Henriette Lagarde   | HbA1c              | 2025-07-01 |        37.95 | mmol/mol | Normal      |
| Central City Teaching Hospital   |              2020 |           148 | Yuna Tanaka         | Total cholesterol  | 2025-07-09 |         1.20 | mmol/L   | Normal      |
| Central City Teaching Hospital   |              2020 |           181 | Rafi Khan           | Sodium             | 2025-08-15 |       143.86 | mmol/L   | Normal      |
| Central City Teaching Hospital   |              2020 |           196 | Sheila Stanley      | ALT                | 2025-09-06 |        49.04 | U/L      | Normal      |
| Central City Teaching Hospital   |              2020 |           229 | Beverley Kirk       | ALT                | 2025-10-18 |        22.36 | U/L      | Normal      |
| Central City Teaching Hospital   |              2020 |           315 | Yuna Tanaka         | Total cholesterol  | 2026-03-01 |         1.80 | mmol/L   | Normal      |
| Central City Teaching Hospital   |              2020 |           322 | Rania Ali           | Total cholesterol  | 2026-03-06 |         4.29 | mmol/L   | Normal      |
| Central City Teaching Hospital   |              2020 |           357 | Meera Singh         | Potassium          | 2026-05-09 |         4.27 | mmol/L   | Normal      |
| Central City Teaching Hospital   |              2020 |           426 | Silva Heintze       | Potassium          | 2026-08-05 |         3.26 | mmol/L   | Low         |
| Central City Teaching Hospital   |              2020 |           435 | Soobin Jung         | Sodium             | 2026-08-23 |       150.20 | mmol/L   | High        |
| Central City Teaching Hospital   |              2020 |           439 | Hana Sato           | TSH                | 2026-08-26 |         3.22 | mU/L     | Normal      |
| Central City Teaching Hospital   |              2020 |           443 | Hana Sato           | TSH                | 2026-08-30 |         2.14 | mU/L     | Normal      |
| Central City Teaching Hospital   |              2020 |           492 | Silva Heintze       | HbA1c              | 2026-11-05 |        22.60 | mmol/mol | Normal      |
| Eastgate Specialist Hospital     |              2014 |            52 | Alex Berger         | Sodium             | 2025-02-21 |       142.65 | mmol/L   | Normal      |
| Eastgate Specialist Hospital     |              2014 |            70 | Cianan Rodden       | TSH                | 2025-03-15 |         3.01 | mU/L     | Normal      |
| Eastgate Specialist Hospital     |              2014 |           111 | Rohan Sharma        | Total cholesterol  | 2025-05-16 |         0.67 | mmol/L   | Normal      |
| Eastgate Specialist Hospital     |              2014 |           121 | Alex Berger         | ALT                | 2025-06-02 |        72.13 | U/L      | High        |
| Eastgate Specialist Hospital     |              2014 |           151 | Emmett Troy         | ALT                | 2025-07-10 |        16.09 | U/L      | Normal      |
| Eastgate Specialist Hospital     |              2014 |           163 | Margaret Leclercq   | Sodium             | 2025-07-19 |       144.86 | mmol/L   | Normal      |
| Eastgate Specialist Hospital     |              2014 |           201 | Simonetta Calbo     | C-reactive protein | 2025-09-12 |         7.48 | mg/L     | High        |
| Eastgate Specialist Hospital     |              2014 |           224 | Bazej Sakwa         | HbA1c              | 2025-10-14 |        19.82 | mmol/mol | Low         |
| Eastgate Specialist Hospital     |              2014 |           235 | Priya Nair          | Potassium          | 2025-10-28 |         4.41 | mmol/L   | Normal      |
| Eastgate Specialist Hospital     |              2014 |           246 | Tyler Dunny         | Haemoglobin        | 2025-11-12 |       146.78 | g/L      | Normal      |
| Eastgate Specialist Hospital     |              2014 |           302 | Polly MacNabb       | Total cholesterol  | 2026-02-09 |         0.61 | mmol/L   | Normal      |
| Eastgate Specialist Hospital     |              2014 |           350 | Rohan Sharma        | Potassium          | 2026-04-29 |         3.63 | mmol/L   | Normal      |
| Eastgate Specialist Hospital     |              2014 |           377 | Melina Siqueira     | Haemoglobin        | 2026-06-01 |       114.23 | g/L      | Low         |
| Eastgate Specialist Hospital     |              2014 |           404 | Simonetta Calbo     | TSH                | 2026-07-07 |         3.38 | mU/L     | Normal      |
| Eastgate Specialist Hospital     |              2014 |           407 | Bazej Sakwa         | Sodium             | 2026-07-11 |       135.21 | mmol/L   | Normal      |
| Eastgate Specialist Hospital     |              2014 |           434 | Rohan Sharma        | ALT                | 2026-08-19 |        40.89 | U/L      | Normal      |
| Eastgate Specialist Hospital     |              2014 |           484 | Melina Siqueira     | Total cholesterol  | 2026-10-23 |         4.23 | mmol/L   | Normal      |
| Grand Central Hospital           |              2017 |             2 | Serafina Bulzoni    | TSH                | 2024-12-06 |         1.20 | mU/L     | Normal      |
| Grand Central Hospital           |              2017 |             7 | Farhana Islam       | eGFR               | 2024-12-15 |       111.31 | mL/min   | Normal      |
| Grand Central Hospital           |              2017 |            22 | Yejin Kim           | eGFR               | 2025-01-04 |       117.76 | mL/min   | Normal      |
| Grand Central Hospital           |              2017 |            87 | Yejin Kim           | Potassium          | 2025-04-08 |         5.16 | mmol/L   | Normal      |
| Grand Central Hospital           |              2017 |           102 | Wawan Wacana        | HbA1c              | 2025-04-30 |        17.86 | mmol/mol | Low         |
| Grand Central Hospital           |              2017 |           138 | Serafina Bulzoni    | ALT                | 2025-06-23 |        17.29 | U/L      | Normal      |
| Grand Central Hospital           |              2017 |           149 | Khalid Ali          | HbA1c              | 2025-07-09 |        16.99 | mmol/mol | Low         |
| Grand Central Hospital           |              2017 |           249 | Michael Berg        | Vitamin D          | 2025-11-16 |       118.66 | nmol/L   | Normal      |
| Grand Central Hospital           |              2017 |           366 | Ama Osei            | eGFR               | 2026-05-22 |       113.63 | mL/min   | Normal      |
| Grand Central Hospital           |              2017 |           372 | Piotr Nabiaek       | Potassium          | 2026-05-29 |         4.77 | mmol/L   | Normal      |
| Grand Central Hospital           |              2017 |           417 | Luan Peixoto        | eGFR               | 2026-07-26 |        93.56 | mL/min   | Normal      |
| Little Oaks Children Hospital    |              2016 |            73 | Carolina Giron      | HbA1c              | 2025-03-17 |        24.43 | mmol/mol | Normal      |
| Little Oaks Children Hospital    |              2016 |           154 | Hredhaan Sarkar     | ALT                | 2025-07-11 |        36.19 | U/L      | Normal      |
| Little Oaks Children Hospital    |              2016 |           213 | Jordan Diez         | eGFR               | 2025-10-01 |        92.64 | mL/min   | Normal      |
| Little Oaks Children Hospital    |              2016 |           226 | Samir Farouk        | Vitamin D          | 2025-10-16 |       159.37 | nmol/L   | High        |
| Little Oaks Children Hospital    |              2016 |           228 | Theobald Kohl       | Haemoglobin        | 2025-10-18 |       151.86 | g/L      | Normal      |
| Little Oaks Children Hospital    |              2016 |           232 | Antoni Koscik       | ALT                | 2025-10-23 |        25.06 | U/L      | Normal      |
| Little Oaks Children Hospital    |              2016 |           242 | Magnus Mulichen     | Sodium             | 2025-11-08 |       139.57 | mmol/L   | Normal      |
| Little Oaks Children Hospital    |              2016 |           255 | Renee Bailly        | Vitamin D          | 2025-11-27 |        73.58 | nmol/L   | Normal      |
| Little Oaks Children Hospital    |              2016 |           267 | Pietra da Rosa      | C-reactive protein | 2025-12-13 |         3.20 | mg/L     | Normal      |
| Little Oaks Children Hospital    |              2016 |           293 | Gambira Zulaika     | Haemoglobin        | 2026-01-24 |       127.61 | g/L      | Normal      |
| Little Oaks Children Hospital    |              2016 |           294 | Victoria Geany      | C-reactive protein | 2026-01-26 |         0.38 | mg/L     | Normal      |
| Little Oaks Children Hospital    |              2016 |           298 | Gambira Zulaika     | C-reactive protein | 2026-01-28 |         2.33 | mg/L     | Normal      |
| Little Oaks Children Hospital    |              2016 |           318 | Mario Barnett       | Total cholesterol  | 2026-03-04 |         4.04 | mmol/L   | Normal      |
| Little Oaks Children Hospital    |              2016 |           333 | Theobald Kohl       | C-reactive protein | 2026-03-25 |         5.98 | mg/L     | High        |
| Little Oaks Children Hospital    |              2016 |           368 | Jia Liu             | HbA1c              | 2026-05-23 |        24.49 | mmol/mol | Normal      |
| Little Oaks Children Hospital    |              2016 |           392 | Yusuf Nasser        | Sodium             | 2026-06-25 |       136.30 | mmol/L   | Normal      |
| Little Oaks Children Hospital    |              2016 |           448 | Victoria Geany      | Sodium             | 2026-09-07 |       133.91 | mmol/L   | Normal      |
| Riverside General Hospital       |              2020 |            44 | Ama Okafor          | eGFR               | 2025-02-10 |       135.30 | mL/min   | High        |
| Riverside General Hospital       |              2020 |           132 | Amber Weber         | Haemoglobin        | 2025-06-16 |       123.07 | g/L      | Normal      |
| Riverside General Hospital       |              2020 |           190 | Therese Nicolas     | ALT                | 2025-08-28 |        64.23 | U/L      | High        |
| Riverside General Hospital       |              2020 |           239 | Cecile Becker       | C-reactive protein | 2025-11-03 |         7.44 | mg/L     | High        |
| Riverside General Hospital       |              2020 |           247 | Zainab Mansour      | eGFR               | 2025-11-12 |        94.14 | mL/min   | Normal      |
| Riverside General Hospital       |              2020 |           273 | Sora Ito            | Vitamin D          | 2025-12-19 |        27.63 | nmol/L   | Low         |
| Riverside General Hospital       |              2020 |           317 | Josue Moura         | Haemoglobin        | 2026-03-01 |       109.82 | g/L      | Low         |
| Riverside General Hospital       |              2020 |           346 | Delil Manco         | Sodium             | 2026-04-21 |       130.49 | mmol/L   | Low         |
| Riverside General Hospital       |              2020 |           381 | Therese Nicolas     | TSH                | 2026-06-07 |         3.30 | mU/L     | Normal      |
| Riverside General Hospital       |              2020 |           382 | Zainab Mansour      | Sodium             | 2026-06-08 |       135.73 | mmol/L   | Normal      |
| Royal Meadow Hospital            |              2020 |            99 | Rehaan Mukhopadhyay | HbA1c              | 2025-04-24 |        22.30 | mmol/mol | Normal      |
| Royal Meadow Hospital            |              2020 |           131 | Samir Hassan        | Total cholesterol  | 2025-06-14 |         5.46 | mmol/L   | High        |
| Royal Meadow Hospital            |              2020 |           136 | Luiz  Guerra        | Total cholesterol  | 2025-06-22 |         5.31 | mmol/L   | High        |
| Royal Meadow Hospital            |              2020 |           172 | Samir Hassan        | Vitamin D          | 2025-08-06 |       121.97 | nmol/L   | Normal      |
| Royal Meadow Hospital            |              2020 |           187 | Samir Hassan        | HbA1c              | 2025-08-24 |        46.74 | mmol/mol | High        |
| Royal Meadow Hospital            |              2020 |           262 | Olgierd Wojtiuk     | C-reactive protein | 2025-12-06 |         6.37 | mg/L     | High        |
| Royal Meadow Hospital            |              2020 |           338 | Luiz  Guerra        | Total cholesterol  | 2026-04-06 |         2.71 | mmol/L   | Normal      |
| Royal Meadow Hospital            |              2020 |           353 | Eduardo Camargo     | TSH                | 2026-04-30 |         2.31 | mU/L     | Normal      |
| Royal Meadow Hospital            |              2020 |           430 | Rehaan Mukhopadhyay | C-reactive protein | 2026-08-14 |         4.60 | mg/L     | Normal      |
| Royal Meadow Hospital            |              2020 |           445 | Rehaan Mukhopadhyay | ALT                | 2026-09-04 |        22.35 | U/L      | Normal      |
| Royal Meadow Hospital            |              2020 |           497 | Soledad Mejia       | C-reactive protein | 2026-11-15 |         0.72 | mg/L     | Normal      |
| Sunrise Maternity Hospital       |              2018 |            17 | Luisa Villegas      | TSH                | 2024-12-25 |         3.24 | mU/L     | Normal      |
| Sunrise Maternity Hospital       |              2018 |            72 | Yejin Yoon          | C-reactive protein | 2025-03-17 |         0.72 | mg/L     | Normal      |
| Sunrise Maternity Hospital       |              2018 |           169 | Yejin Yoon          | Total cholesterol  | 2025-07-29 |         0.45 | mmol/L   | Normal      |
| Sunrise Maternity Hospital       |              2018 |           173 | Fatima Nasser       | TSH                | 2025-08-09 |         1.67 | mU/L     | Normal      |
| Sunrise Maternity Hospital       |              2018 |           210 | Nataniel Seta       | Potassium          | 2025-09-25 |         4.71 | mmol/L   | Normal      |
| Sunrise Maternity Hospital       |              2018 |           211 | Fabiola Melendez    | eGFR               | 2025-09-27 |       118.67 | mL/min   | Normal      |
| Sunrise Maternity Hospital       |              2018 |           257 | Patrick Kramer      | HbA1c              | 2025-11-30 |        41.34 | mmol/mol | Normal      |
| Sunrise Maternity Hospital       |              2018 |           321 | Rahul Nair          | Total cholesterol  | 2026-03-05 |         2.42 | mmol/L   | Normal      |
| Sunrise Maternity Hospital       |              2018 |           325 | Cianan Rodden       | Vitamin D          | 2026-03-09 |        88.26 | nmol/L   | Normal      |
| Sunrise Maternity Hospital       |              2018 |           354 | Kosemen Guclu       | ALT                | 2026-05-01 |        34.14 | U/L      | Normal      |
| Sunrise Maternity Hospital       |              2018 |           396 | Lisa Lawson         | Sodium             | 2026-06-29 |       141.69 | mmol/L   | Normal      |
| Sunrise Maternity Hospital       |              2018 |           500 | Rahul Nair          | TSH                | 2026-11-20 |         3.27 | mU/L     | Normal      |
| Westbrook Children Hospital      |              2020 |             8 | Ylma Inonu          | Sodium             | 2024-12-16 |       150.59 | mmol/L   | High        |
| Westbrook Children Hospital      |              2020 |            37 | Gael Pereira        | ALT                | 2025-01-31 |         5.60 | U/L      | Low         |
| Westbrook Children Hospital      |              2020 |           168 | Ozpetek Aslan       | Potassium          | 2025-07-28 |         4.48 | mmol/L   | Normal      |
| Westbrook Children Hospital      |              2020 |           197 | Gilberto Pabon      | C-reactive protein | 2025-09-08 |         0.02 | mg/L     | Normal      |
| Westbrook Children Hospital      |              2020 |           296 | Alexis Williams     | Sodium             | 2026-01-27 |       146.79 | mmol/L   | High        |
| Westbrook Children Hospital      |              2020 |           310 | Grzegorz Liss       | Haemoglobin        | 2026-02-20 |       139.96 | g/L      | Normal      |
| Westbrook Children Hospital      |              2020 |           337 | Gunaydin Durmus     | Vitamin D          | 2026-04-02 |       107.28 | nmol/L   | Normal      |
| Westbrook Children Hospital      |              2020 |           389 | Alexis Williams     | eGFR               | 2026-06-21 |       109.20 | mL/min   | Normal      |
| Westbrook Children Hospital      |              2020 |           453 | Julie Goodman       | HbA1c              | 2026-09-13 |        36.11 | mmol/mol | Normal      |
| Westbrook Children Hospital      |              2020 |           461 | Nina Sa             | Sodium             | 2026-09-24 |       134.73 | mmol/L   | Normal      |
| Westbrook Children Hospital      |              2020 |           471 | Gilberto Pabon      | Haemoglobin        | 2026-10-07 |       125.64 | g/L      | Normal      |
| Westfield Teaching Hospital      |              2013 |            16 | Brayan Martins      | ALT                | 2024-12-25 |         5.78 | U/L      | Low         |
| Westfield Teaching Hospital      |              2013 |            69 | Meera Sharma        | ALT                | 2025-03-13 |        23.67 | U/L      | Normal      |
| Westfield Teaching Hospital      |              2013 |            83 | Joseph Frazier      | Haemoglobin        | 2025-04-03 |       149.50 | g/L      | Normal      |
| Westfield Teaching Hospital      |              2013 |            96 | Edi Yulianti        | C-reactive protein | 2025-04-16 |         1.90 | mg/L     | Normal      |
| Westfield Teaching Hospital      |              2013 |           107 | Joseph Frazier      | eGFR               | 2025-05-08 |       115.67 | mL/min   | Normal      |
| Westfield Teaching Hospital      |              2013 |           123 | Olivie Bernier      | Haemoglobin        | 2025-06-03 |       101.02 | g/L      | Low         |
| Westfield Teaching Hospital      |              2013 |           144 | Annunziata Germano  | eGFR               | 2025-07-02 |       115.21 | mL/min   | Normal      |
| Westfield Teaching Hospital      |              2013 |           158 | Maria  Caldeira     | Vitamin D          | 2025-07-16 |        76.17 | nmol/L   | Normal      |
| Westfield Teaching Hospital      |              2013 |           214 | Bhanumati Maharaj   | Vitamin D          | 2025-10-02 |        56.28 | nmol/L   | Normal      |
| Westfield Teaching Hospital      |              2013 |           304 | Maurilio Murri      | Sodium             | 2026-02-12 |       141.52 | mmol/L   | Normal      |
| Westfield Teaching Hospital      |              2013 |           335 | Shivani Shan        | Vitamin D          | 2026-03-29 |        33.60 | nmol/L   | Low         |
| Westfield Teaching Hospital      |              2013 |           384 | Kenji Ito           | TSH                | 2026-06-16 |         2.47 | mU/L     | Normal      |
| Westfield Teaching Hospital      |              2013 |           423 | Bhanumati Maharaj   | C-reactive protein | 2026-08-03 |         7.13 | mg/L     | High        |
| Westfield Teaching Hospital      |              2013 |           436 | Shivani Shan        | TSH                | 2026-08-25 |         3.26 | mU/L     | Normal      |
| Westfield Teaching Hospital      |              2013 |           464 | Bhanumati Maharaj   | Sodium             | 2026-09-27 |       139.15 | mmol/L   | Normal      |
| Westfield Teaching Hospital      |              2013 |           470 | Charles Weber       | Sodium             | 2026-10-04 |       151.04 | mmol/L   | High        |
| Westfield Teaching Hospital      |              2013 |           489 | Annunziata Germano  | ALT                | 2026-10-29 |         8.38 | U/L      | Normal      |
+----------------------------------+-------------------+---------------+---------------------+--------------------+------------+--------------+----------+-------------+
```

*162 rows in set*

### B12 Doctor with the most prescriptions

Procedure `doctor_with_most_prescriptions`:

```sql
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
```

Run with:

```sql
CALL doctor_with_most_prescriptions();
```

```
+-----------+------------------+----------------+-------------------------------+-------------------------+
| doctor_id | doctor_firstname | doctor_surname | hospital_name                 | number_of_prescriptions |
+-----------+------------------+----------------+-------------------------------+-------------------------+
|         7 | Oliver           | Bennett        | Eastgate Specialist Hospital  |                      10 |
|        12 | Isabella         | Garcia         | Harbourview General Hospital  |                      10 |
|        58 | Bilal            | Khan           | Little Oaks Children Hospital |                      10 |
+-----------+------------------+----------------+-------------------------------+-------------------------+
```

*3 rows in set*

### B13 Doctors at the hospital with the most beds

Procedure `doctors_at_biggest_hospital`:

```sql
SELECT d.doctor_id, d.doctor_firstname, d.doctor_surname,
       h.Name AS hospital, h.Size AS beds
FROM doctors d
JOIN Hospitals h ON h.Name = d.hospital_name
WHERE h.Size = (SELECT MAX(Size) FROM Hospitals)
ORDER BY d.doctor_surname;
```

Run with:

```sql
CALL doctors_at_biggest_hospital();
```

```
+-----------+------------------+----------------+------------------------+------+
| doctor_id | doctor_firstname | doctor_surname | hospital               | beds |
+-----------+------------------+----------------+------------------------+------+
|        50 | Hassan           | Ali            | Grand Central Hospital |  900 |
|        90 | Ingrid           | Larsen         | Grand Central Hospital |  900 |
|        10 | Nikhil           | Menon          | Grand Central Hospital |  900 |
+-----------+------------------+----------------+------------------------+------+
```

*3 rows in set*

### B14 Hospitals accredited before 2015 with Emergency Service

Procedure `hospitals_accredited_before_2015_with_emergency`:

```sql
SELECT Name, Type, AccreditationYear
FROM Hospitals
WHERE AccreditationYear < 2015
  AND EmergencyService = TRUE
ORDER BY Name;
```

Run with:

```sql
CALL hospitals_accredited_before_2015_with_emergency();
```

```
+--------------------------------+------------+-------------------+
| Name                           | Type       | AccreditationYear |
+--------------------------------+------------+-------------------+
| Greenfield General Hospital    | General    |              2011 |
| Hawthorn General Hospital      | General    |              2008 |
| Maple Leaf Specialist Hospital | Specialist |              2011 |
| Millbrook General Hospital     | General    |              2009 |
| Redwood Teaching Hospital      | Teaching   |              2008 |
| Westfield Teaching Hospital    | Teaching   |              2013 |
+--------------------------------+------------+-------------------+
```

*6 rows in set*

### B15 Patients at hospitals with fewer than 400 beds

Procedure `patients_at_hospitals_under_400_beds`:

```sql
SELECT p.patient_id, p.patient_firstname, p.patient_surname,
       d.hospital_name, h.Size AS beds
FROM patients p
JOIN doctors d   ON d.doctor_id = p.doctor_id
JOIN Hospitals h ON h.Name = d.hospital_name
WHERE h.Size < 400
ORDER BY h.Size, d.hospital_name, p.patient_surname;
```

Run with:

```sql
CALL patients_at_hospitals_under_400_beds();
```

```
+------------+-------------------+-----------------+----------------------------------+------+
| patient_id | patient_firstname | patient_surname | hospital_name                    | beds |
+------------+-------------------+-----------------+----------------------------------+------+
|         42 | Jennifer          | Bailey          | Bluebell Children Hospital       |   95 |
|          2 | Nas               | Bilgin          | Bluebell Children Hospital       |   95 |
|        502 | Adelaide          | Brunel          | Bluebell Children Hospital       |   95 |
|        302 | Lynsey            | Callaghan       | Bluebell Children Hospital       |   95 |
|        542 | Blanca            | Collazo         | Bluebell Children Hospital       |   95 |
|        342 | Farhunnisa        | Dongoran        | Bluebell Children Hospital       |   95 |
|        482 | Patrick           | Kramer          | Bluebell Children Hospital       |   95 |
|        102 | Marianna          | Mays            | Bluebell Children Hospital       |   95 |
|        282 | Celina            | Muller          | Bluebell Children Hospital       |   95 |
|        382 | Aniela            | Paw             | Bluebell Children Hospital       |   95 |
|        442 | Melissa           | Perez           | Bluebell Children Hospital       |   95 |
|        202 | Qabil             | Roy             | Bluebell Children Hospital       |   95 |
|        142 | Maria             | Sa              | Bluebell Children Hospital       |   95 |
|        582 | Giampiero         | Tarantino       | Bluebell Children Hospital       |   95 |
|        402 | Pierre            | Valentin        | Bluebell Children Hospital       |   95 |
|         82 | Jia               | Wang            | Bluebell Children Hospital       |   95 |
|        242 | Samantha          | Werner          | Bluebell Children Hospital       |   95 |
|        182 | Rafia             | Yuksel          | Bluebell Children Hospital       |   95 |
|        580 | Martino           | Agazzi          | Willowbrook Maternity Hospital   |  100 |
|        440 | Noor              | Ali             | Willowbrook Maternity Hospital   |  100 |
|        240 | Theodore          | Dara            | Willowbrook Maternity Hospital   |  100 |
|        380 | Thomas            | Garcia          | Willowbrook Maternity Hospital   |  100 |
|         80 | Imran             | Hossain         | Willowbrook Maternity Hospital   |  100 |
|        540 | Jia               | Huang           | Willowbrook Maternity Hospital   |  100 |
|         40 | Thomas            | Knox            | Willowbrook Maternity Hospital   |  100 |
|        180 | Lintang           | Mustofa         | Willowbrook Maternity Hospital   |  100 |
|        280 | Helena            | Rendon          | Willowbrook Maternity Hospital   |  100 |
|        140 | Toktug            | Sensoy          | Willowbrook Maternity Hospital   |  100 |
|        340 | Tasvir            | Yaman           | Willowbrook Maternity Hospital   |  100 |
|        480 | Tomurcuk          | Zorlu           | Willowbrook Maternity Hospital   |  100 |
|         26 | Frederique        | Bigot           | Pinewood Children Hospital       |  110 |
|        266 | Tammy             | Gibson          | Pinewood Children Hospital       |  110 |
|        526 | Abbie             | Hunter          | Pinewood Children Hospital       |  110 |
|        426 | Kateryna          | Koval           | Pinewood Children Hospital       |  110 |
|        466 | Jing              | Li              | Pinewood Children Hospital       |  110 |
|        566 | Jing              | Liu             | Pinewood Children Hospital       |  110 |
|        366 | Antonia           | Loera           | Pinewood Children Hospital       |  110 |
|        126 | Tola              | Majsterek       | Pinewood Children Hospital       |  110 |
|         66 | Gilberto          | Meza            | Pinewood Children Hospital       |  110 |
|        166 | Amara             | Okafor          | Pinewood Children Hospital       |  110 |
|        226 | Jessica           | Velez           | Pinewood Children Hospital       |  110 |
|        326 | David             | Wong            | Pinewood Children Hospital       |  110 |
|        336 | Silvia            | Canales         | Sunrise Maternity Hospital       |  120 |
|        476 | Juan              | Llanos          | Sunrise Maternity Hospital       |  120 |
|        576 | Fabiola           | Melendez        | Sunrise Maternity Hospital       |  120 |
|         76 | Rahul             | Nair            | Sunrise Maternity Hospital       |  120 |
|        236 | Fatima            | Nasser          | Sunrise Maternity Hospital       |  120 |
|        376 | Emilio            | Pontecorvo      | Sunrise Maternity Hospital       |  120 |
|        176 | Nataniel          | Seta            | Sunrise Maternity Hospital       |  120 |
|        276 | Jessica           | Smith           | Sunrise Maternity Hospital       |  120 |
|        436 | Cevale            | Tevetoglu       | Sunrise Maternity Hospital       |  120 |
|        136 | Luisa             | Villegas        | Sunrise Maternity Hospital       |  120 |
|         36 | Yuki              | Watanabe        | Sunrise Maternity Hospital       |  120 |
|        536 | Yejin             | Yoon            | Sunrise Maternity Hospital       |  120 |
|        359 | Jeevika           | Arya            | Maple Leaf Specialist Hospital   |  125 |
|        219 | Maanav            | Bassi           | Maple Leaf Specialist Hospital   |  125 |
|        319 | Michel            | Da Silva        | Maple Leaf Specialist Hospital   |  125 |
|        299 | Bethany           | Holden          | Maple Leaf Specialist Hospital   |  125 |
|        199 | Nusrat            | Hossain         | Maple Leaf Specialist Hospital   |  125 |
|        459 | Timothee          | Lenoir          | Maple Leaf Specialist Hospital   |  125 |
|        119 | Loretta           | Leonardi        | Maple Leaf Specialist Hospital   |  125 |
|         99 | Mei               | Li              | Maple Leaf Specialist Hospital   |  125 |
|        419 | Darmanto          | Maryadi         | Maple Leaf Specialist Hospital   |  125 |
|        559 | Benjamin          | Morel           | Maple Leaf Specialist Hospital   |  125 |
|         59 | Ananya            | Nair            | Maple Leaf Specialist Hospital   |  125 |
|        519 | Griselda          | Offredi         | Maple Leaf Specialist Hospital   |  125 |
|        599 | Alison            | Parkinson       | Maple Leaf Specialist Hospital   |  125 |
|        399 | Ganga             | Rajan           | Maple Leaf Specialist Hospital   |  125 |
|        499 | James             | Richards        | Maple Leaf Specialist Hospital   |  125 |
|        259 | Erika             | Siering         | Maple Leaf Specialist Hospital   |  125 |
|        159 | Antoin            | Swords          | Maple Leaf Specialist Hospital   |  125 |
|         19 | Ashling           | Tierney         | Maple Leaf Specialist Hospital   |  125 |
|        355 | Mateusz           | akota           | Hillcrest Specialist Hospital    |  130 |
|        155 | Kimberly          | Ball            | Hillcrest Specialist Hospital    |  130 |
|         95 | Sandalio          | Bermudez        | Hillcrest Specialist Hospital    |  130 |
|        595 | Geraldine         | Blake           | Hillcrest Specialist Hospital    |  130 |
|        495 | Vicente           | Cavalcante      | Hillcrest Specialist Hospital    |  130 |
|        215 | Finn              | Dass            | Hillcrest Specialist Hospital    |  130 |
|        115 | Tezol             | Ergul           | Hillcrest Specialist Hospital    |  130 |
|        415 | Stephen           | Fletcher        | Hillcrest Specialist Hospital    |  130 |
|        455 | Capucine          | Huet            | Hillcrest Specialist Hospital    |  130 |
|        255 | Sora              | Ito             | Hillcrest Specialist Hospital    |  130 |
|        295 | Beate             | Juncken         | Hillcrest Specialist Hospital    |  130 |
|         55 | Kajen             | Kuswandari      | Hillcrest Specialist Hospital    |  130 |
|        515 | Sonia             | Loffler         | Hillcrest Specialist Hospital    |  130 |
|         15 | Omaja             | Madan           | Hillcrest Specialist Hospital    |  130 |
|        195 | Julien            | Marin           | Hillcrest Specialist Hospital    |  130 |
|        315 | Adan              | Medrano         | Hillcrest Specialist Hospital    |  130 |
|        395 | Aimee             | Peron           | Hillcrest Specialist Hospital    |  130 |
|        555 | Daniel            | Solis           | Hillcrest Specialist Hospital    |  130 |
|          8 | Rhys              | Allen           | Elmwood Rehabilitation Hospital  |  140 |
|        588 | Dawn              | Andrews         | Elmwood Rehabilitation Hospital  |  140 |
|        348 | Clara             | Caldeira        | Elmwood Rehabilitation Hospital  |  140 |
|        488 | Eloy              | Castaneda       | Elmwood Rehabilitation Hospital  |  140 |
|        408 | Fatinur           | Duran           | Elmwood Rehabilitation Hospital  |  140 |
|        288 | Albert            | Garbaciak       | Elmwood Rehabilitation Hospital  |  140 |
|        148 | Jing              | Huang           | Elmwood Rehabilitation Hospital  |  140 |
|         48 | Olga              | Junken          | Elmwood Rehabilitation Hospital  |  140 |
|        548 | Maksymilian       | Matulewicz      | Elmwood Rehabilitation Hospital  |  140 |
|        108 | Ama               | Owusu           | Elmwood Rehabilitation Hospital  |  140 |
|        308 | Raina             | Pranowo         | Elmwood Rehabilitation Hospital  |  140 |
|        208 | Barry             | Renehan         | Elmwood Rehabilitation Hospital  |  140 |
|        188 | Marta             | Segebahn        | Elmwood Rehabilitation Hospital  |  140 |
|        248 | Ananya            | Shah            | Elmwood Rehabilitation Hospital  |  140 |
|        388 | Nicholas          | Smith           | Elmwood Rehabilitation Hospital  |  140 |
|         88 | Isabel            | Sousa           | Elmwood Rehabilitation Hospital  |  140 |
|        448 | Okturk            | Soylu           | Elmwood Rehabilitation Hospital  |  140 |
|        508 | Azeneth           | Vega            | Elmwood Rehabilitation Hospital  |  140 |
|        281 | Bilkay            | Arsoy           | Ashford Children Hospital        |  145 |
|         41 | Clifford          | Baker           | Ashford Children Hospital        |  145 |
|        201 | Kwame             | Balogun         | Ashford Children Hospital        |  145 |
|        441 | Yvette            | Becker          | Ashford Children Hospital        |  145 |
|        381 | Olivie            | Bernier         | Ashford Children Hospital        |  145 |
|        341 | Sultana           | Das             | Ashford Children Hospital        |  145 |
|         81 | Sadman            | Gul             | Ashford Children Hospital        |  145 |
|        301 | Yuna              | Ito             | Ashford Children Hospital        |  145 |
|        401 | Ibrahim           | Lailasari       | Ashford Children Hospital        |  145 |
|        581 | Adele             | Marion          | Ashford Children Hospital        |  145 |
|        181 | Benjamim          | Mendes          | Ashford Children Hospital        |  145 |
|        241 | Aidan             | Needham         | Ashford Children Hospital        |  145 |
|        101 | Centa             | Nette           | Ashford Children Hospital        |  145 |
|        541 | Brigitta          | Schweitzer      | Ashford Children Hospital        |  145 |
|        501 | Prabowo           | Situmorang      | Ashford Children Hospital        |  145 |
|        481 | Capucine          | Thierry         | Ashford Children Hospital        |  145 |
|        141 | Ren               | Watanabe        | Ashford Children Hospital        |  145 |
|          1 | Amber             | Weber           | Ashford Children Hospital        |  145 |
|        375 | Samir             | Ali             | St Andrews Specialist Hospital   |  150 |
|        575 | Emil              | Czuj            | St Andrews Specialist Hospital   |  150 |
|        275 | Adelaide          | Georges         | St Andrews Specialist Hospital   |  150 |
|        175 | Kavya             | Gupta           | St Andrews Specialist Hospital   |  150 |
|         75 | Aura              | Izquierdo       | St Andrews Specialist Hospital   |  150 |
|        235 | Reina             | Lopez           | St Andrews Specialist Hospital   |  150 |
|        475 | Renata            | Mannoia         | St Andrews Specialist Hospital   |  150 |
|        335 | Graciela          | Peralta         | St Andrews Specialist Hospital   |  150 |
|        435 | Cecilia           | Rubio           | St Andrews Specialist Hospital   |  150 |
|        135 | Allegra           | Scarponi        | St Andrews Specialist Hospital   |  150 |
|         35 | Sheila            | Stanley         | St Andrews Specialist Hospital   |  150 |
|        535 | Lourdes           | Villegas        | St Andrews Specialist Hospital   |  150 |
|        314 | Yatin             | Bir             | Highland Specialist Hospital     |  155 |
|        494 | Vittoria          | Borromini       | Highland Specialist Hospital     |  155 |
|         54 | Mar               | Carranza        | Highland Specialist Hospital     |  155 |
|         94 | Gabriele          | Cerutti         | Highland Specialist Hospital     |  155 |
|        114 | Yochana           | Dua             | Highland Specialist Hospital     |  155 |
|        254 | Amador            | Duran           | Highland Specialist Hospital     |  155 |
|        394 | Roseanna          | Ferguson        | Highland Specialist Hospital     |  155 |
|        594 | Jennifer          | Green           | Highland Specialist Hospital     |  155 |
|        294 | Rebeca            | Heredia         | Highland Specialist Hospital     |  155 |
|        194 | Akcabay           | Inonu           | Highland Specialist Hospital     |  155 |
|        354 | Fabian            | Ladeck          | Highland Specialist Hospital     |  155 |
|        154 | Rene              | Llano           | Highland Specialist Hospital     |  155 |
|        554 | Kelly             | Molina          | Highland Specialist Hospital     |  155 |
|        454 | Bethan            | O'Gowan         | Highland Specialist Hospital     |  155 |
|        414 | Gambira           | Pratiwi         | Highland Specialist Hospital     |  155 |
|        514 | Donald            | Rios            | Highland Specialist Hospital     |  155 |
|        214 | Serafin           | Tejada          | Highland Specialist Hospital     |  155 |
|         14 | Isaac             | Thomas          | Highland Specialist Hospital     |  155 |
|        498 | Renee             | Bailly          | Little Oaks Children Hospital    |  160 |
|        518 | Azahar            | Canete          | Little Oaks Children Hospital    |  160 |
|        298 | Pietra            | da Rosa         | Little Oaks Children Hospital    |  160 |
|         18 | Jordan            | Diez            | Little Oaks Children Hospital    |  160 |
|        198 | Samir             | Farouk          | Little Oaks Children Hospital    |  160 |
|         98 | Victoria          | Geany           | Little Oaks Children Hospital    |  160 |
|        258 | Carolina          | Giron           | Little Oaks Children Hospital    |  160 |
|        218 | Theobald          | Kohl            | Little Oaks Children Hospital    |  160 |
|         58 | Jia               | Liu             | Little Oaks Children Hospital    |  160 |
|        358 | Brayan            | Martins         | Little Oaks Children Hospital    |  160 |
|        598 | Oksana            | Melnyk          | Little Oaks Children Hospital    |  160 |
|        458 | Magnus            | Mulichen        | Little Oaks Children Hospital    |  160 |
|        398 | Yusuf             | Nasser          | Little Oaks Children Hospital    |  160 |
|        558 | Arnaldo           | Polizzi         | Little Oaks Children Hospital    |  160 |
|        318 | Joao Pedro        | Porto           | Little Oaks Children Hospital    |  160 |
|        418 | Hredhaan          | Sarkar          | Little Oaks Children Hospital    |  160 |
|        118 | Catalina          | Segovia         | Little Oaks Children Hospital    |  160 |
|        158 | Gambira           | Zulaika         | Little Oaks Children Hospital    |  160 |
|         87 | Livia             | Aragao          | Eastgate Specialist Hospital     |  170 |
|        407 | Alex              | Berger          | Eastgate Specialist Hospital     |  170 |
|        187 | Simonetta         | Calbo           | Eastgate Specialist Hospital     |  170 |
|        287 | Tyler             | Dunny           | Eastgate Specialist Hospital     |  170 |
|        207 | Muktedir          | Duran           | Eastgate Specialist Hospital     |  170 |
|        587 | Margaret          | Leclercq        | Eastgate Specialist Hospital     |  170 |
|        547 | Polly             | MacNabb         | Eastgate Specialist Hospital     |  170 |
|        387 | Yuki              | Nakamura        | Eastgate Specialist Hospital     |  170 |
|        347 | Cianan            | Rodden          | Eastgate Specialist Hospital     |  170 |
|        307 | Bazej             | Sakwa           | Eastgate Specialist Hospital     |  170 |
|          7 | Linus             | Schmiedecke     | Eastgate Specialist Hospital     |  170 |
|        447 | Priya             | Shah            | Eastgate Specialist Hospital     |  170 |
|        107 | Rohan             | Sharma          | Eastgate Specialist Hospital     |  170 |
|        487 | Annette           | Shaw            | Eastgate Specialist Hospital     |  170 |
|         47 | Melina            | Siqueira        | Eastgate Specialist Hospital     |  170 |
|        147 | Emmett            | Troy            | Eastgate Specialist Hospital     |  170 |
|        507 | Urs               | Warmer          | Eastgate Specialist Hospital     |  170 |
|        247 | Yifan             | Zhao            | Eastgate Specialist Hospital     |  170 |
|        538 | Ozpetek           | Aslan           | Westbrook Children Hospital      |  180 |
|        438 | Gunaydin          | Durmus          | Westbrook Children Hospital      |  180 |
|         78 | Julie             | Goodman         | Westbrook Children Hospital      |  180 |
|        378 | Ylma              | Inonu           | Westbrook Children Hospital      |  180 |
|        338 | Grzegorz          | Liss            | Westbrook Children Hospital      |  180 |
|        578 | Hans              | Mende           | Westbrook Children Hospital      |  180 |
|        138 | Gilberto          | Pabon           | Westbrook Children Hospital      |  180 |
|        238 | Melania           | Pometta         | Westbrook Children Hospital      |  180 |
|         38 | Nina              | Sa              | Westbrook Children Hospital      |  180 |
|        478 | Ren               | Sato            | Westbrook Children Hospital      |  180 |
|        278 | Courtney          | Walker          | Westbrook Children Hospital      |  180 |
|        178 | Alexis            | Williams        | Westbrook Children Hospital      |  180 |
|        169 | Trinidad          | Angulo          | Rosewood Psychiatric Hospital    |  190 |
|        129 | Paola             | Beltran         | Rosewood Psychiatric Hospital    |  190 |
|         69 | Leonid            | Hettner         | Rosewood Psychiatric Hospital    |  190 |
|         29 | Ewa               | Junck           | Rosewood Psychiatric Hospital    |  190 |
|        329 | Rosemary          | Magan           | Rosewood Psychiatric Hospital    |  190 |
|        429 | Shaun             | Neill           | Rosewood Psychiatric Hospital    |  190 |
|        369 | Madhavi           | Patil           | Rosewood Psychiatric Hospital    |  190 |
|        529 | Triveni           | Purohit         | Rosewood Psychiatric Hospital    |  190 |
|        569 | Bernard           | Ramos           | Rosewood Psychiatric Hospital    |  190 |
|        469 | David             | Summers         | Rosewood Psychiatric Hospital    |  190 |
|        229 | Matthew           | Taylor          | Rosewood Psychiatric Hospital    |  190 |
|        269 | Charles           | Weber           | Rosewood Psychiatric Hospital    |  190 |
|        424 | Aoibheann         | Callan          | Oakwood Mental Health Hospital   |  200 |
|        224 | Mazlum            | Camurcuoglu     | Oakwood Mental Health Hospital   |  200 |
|        164 | Ryan              | da Rosa         | Oakwood Mental Health Hospital   |  200 |
|        324 | Ruairi            | Earle           | Oakwood Mental Health Hospital   |  200 |
|        464 | Andriy            | Koval           | Oakwood Mental Health Hospital   |  200 |
|        264 | Marjan            | Krause          | Oakwood Mental Health Hospital   |  200 |
|         64 | Carlos            | Meyer           | Oakwood Mental Health Hospital   |  200 |
|         24 | Maurilio          | Murri           | Oakwood Mental Health Hospital   |  200 |
|        524 | Socorro           | Osorio          | Oakwood Mental Health Hospital   |  200 |
|        564 | Rohan             | Shah            | Oakwood Mental Health Hospital   |  200 |
|        364 | Prayogo           | Siregar         | Oakwood Mental Health Hospital   |  200 |
|        124 | Mark              | Skinner         | Oakwood Mental Health Hospital   |  200 |
|          6 | Eloisa            | Arregui         | Crescent Mental Health Hospital  |  210 |
|         46 | Suzanne           | Blot            | Crescent Mental Health Hospital  |  210 |
|        446 | Aoibheann         | Conneely        | Crescent Mental Health Hospital  |  210 |
|        386 | Savak             | Corlu           | Crescent Mental Health Hospital  |  210 |
|        406 | Ariadna           | Florez          | Crescent Mental Health Hospital  |  210 |
|        106 | Ann               | Graham          | Crescent Mental Health Hospital  |  210 |
|        146 | Carl              | Holmes          | Crescent Mental Health Hospital  |  210 |
|         86 | Soobin            | Jung            | Crescent Mental Health Hospital  |  210 |
|        206 | Debbie            | Kline           | Crescent Mental Health Hospital  |  210 |
|        186 | Maya              | Majumdar        | Crescent Mental Health Hospital  |  210 |
|        306 | Bethany           | Moore           | Crescent Mental Health Hospital  |  210 |
|        246 | Nikki             | O'Crowley       | Crescent Mental Health Hospital  |  210 |
|        546 | Kwame             | Owusu           | Crescent Mental Health Hospital  |  210 |
|        586 | Gael              | Pereira         | Crescent Mental Health Hospital  |  210 |
|        486 | Lindsey           | Pickering       | Crescent Mental Health Hospital  |  210 |
|        346 | Arsipatra         | Rajata          | Crescent Mental Health Hospital  |  210 |
|        506 | Paula             | Scott           | Crescent Mental Health Hospital  |  210 |
|        286 | Tony              | Wilson          | Crescent Mental Health Hospital  |  210 |
|        520 | Raphaela          | Bachmann        | Meadowlands Psychiatric Hospital |  220 |
|        600 | Upkaar            | Bajwa           | Meadowlands Psychiatric Hospital |  220 |
|        320 | Thomas            | Camara          | Meadowlands Psychiatric Hospital |  220 |
|        300 | Gursal            | Ergul           | Meadowlands Psychiatric Hospital |  220 |
|        120 | Kristiane         | Hauffer         | Meadowlands Psychiatric Hospital |  220 |
|         60 | Gaurangi          | Kata            | Meadowlands Psychiatric Hospital |  220 |
|        560 | Rupert            | Koch            | Meadowlands Psychiatric Hospital |  220 |
|        460 | Lisa              | Lawson          | Meadowlands Psychiatric Hospital |  220 |
|        160 | Ekaja             | Mammen          | Meadowlands Psychiatric Hospital |  220 |
|        420 | Gian              | Montalcini      | Meadowlands Psychiatric Hospital |  220 |
|        100 | Drajat            | Nashiruddin     | Meadowlands Psychiatric Hospital |  220 |
|        400 | Jay               | O'Connor        | Meadowlands Psychiatric Hospital |  220 |
|        220 | Minji             | Park            | Meadowlands Psychiatric Hospital |  220 |
|        200 | Dadi              | Saefullah       | Meadowlands Psychiatric Hospital |  220 |
|        260 | Gokten            | Safak           | Meadowlands Psychiatric Hospital |  220 |
|         20 | Rachel            | Savage          | Meadowlands Psychiatric Hospital |  220 |
|        500 | Arjun             | Singh           | Meadowlands Psychiatric Hospital |  220 |
|        360 | Miriam            | Valdes          | Meadowlands Psychiatric Hospital |  220 |
|        149 | Eckehard          | Albers          | Fairview Psychiatric Hospital    |  230 |
|        589 | Chloe             | Ball            | Fairview Psychiatric Hospital    |  230 |
|        509 | Rudra             | Banik           | Fairview Psychiatric Hospital    |  230 |
|        189 | Gael              | Barbosa         | Fairview Psychiatric Hospital    |  230 |
|        489 | Holly             | Carter          | Fairview Psychiatric Hospital    |  230 |
|        209 | Jing              | Chen            | Fairview Psychiatric Hospital    |  230 |
|          9 | Luiz              | Correia         | Fairview Psychiatric Hospital    |  230 |
|         89 | Bella             | da Conceicao    | Fairview Psychiatric Hospital    |  230 |
|        289 | William           | Diaz            | Fairview Psychiatric Hospital    |  230 |
|        449 | Kosemen           | Guclu           | Fairview Psychiatric Hospital    |  230 |
|        109 | Jerzy             | Jedruch         | Fairview Psychiatric Hospital    |  230 |
|        549 | Julian            | Kwinta          | Fairview Psychiatric Hospital    |  230 |
|        349 | Heike             | Loffler         | Fairview Psychiatric Hospital    |  230 |
|        249 | Ana Sophia        | Novaes          | Fairview Psychiatric Hospital    |  230 |
|        409 | Jolanda           | Pininfarina     | Fairview Psychiatric Hospital    |  230 |
|        389 | Prabowo           | Rajata          | Fairview Psychiatric Hospital    |  230 |
|         49 | Misty             | Russell         | Fairview Psychiatric Hospital    |  230 |
|        309 | Jing              | Wang            | Fairview Psychiatric Hospital    |  230 |
|        204 | Iryna             | Bondarenko      | Cedar Grove Psychiatric Hospital |  250 |
|         44 | Christina         | Bryant          | Cedar Grove Psychiatric Hospital |  250 |
|        344 | Pietra            | Cassiano        | Cedar Grove Psychiatric Hospital |  250 |
|        284 | Saoirse           | Collinder       | Cedar Grove Psychiatric Hospital |  250 |
|        544 | Kacper            | Elert           | Cedar Grove Psychiatric Hospital |  250 |
|        404 | Renato            | Escolano        | Cedar Grove Psychiatric Hospital |  250 |
|          4 | Margaret          | Fuller          | Cedar Grove Psychiatric Hospital |  250 |
|        244 | Alpsu             | Gul             | Cedar Grove Psychiatric Hospital |  250 |
|        444 | Filomena          | Herranz         | Cedar Grove Psychiatric Hospital |  250 |
|        504 | Jaiman            | Iswahyudi       | Cedar Grove Psychiatric Hospital |  250 |
|        584 | Constance         | Leclercq        | Cedar Grove Psychiatric Hospital |  250 |
|        144 | Ming              | Liu             | Cedar Grove Psychiatric Hospital |  250 |
|        484 | Delil             | Manco           | Cedar Grove Psychiatric Hospital |  250 |
|        104 | Felipe            | Moura           | Cedar Grove Psychiatric Hospital |  250 |
|        184 | Louis             | O'Hickey        | Cedar Grove Psychiatric Hospital |  250 |
|        384 | Holly             | Oconnell        | Cedar Grove Psychiatric Hospital |  250 |
|         84 | Sabine            | Perez           | Cedar Grove Psychiatric Hospital |  250 |
|        304 | Ibrahim           | Saleh           | Cedar Grove Psychiatric Hospital |  250 |
|        271 | Amy               | Cole            | Seaview General Hospital         |  275 |
|        131 | Loreto            | Esteve          | Seaview General Hospital         |  275 |
|        231 | Mei               | Huang           | Seaview General Hospital         |  275 |
|        371 | Arno              | Kostolzin       | Seaview General Hospital         |  275 |
|         71 | Ama               | Mensah          | Seaview General Hospital         |  275 |
|        471 | Manuel            | Meyers          | Seaview General Hospital         |  275 |
|        331 | Borys             | Mrozowicz       | Seaview General Hospital         |  275 |
|         31 | Marianna          | Omiotek         | Seaview General Hospital         |  275 |
|        531 | Watika            | Ravel           | Seaview General Hospital         |  275 |
|        571 | Jeffrey           | Roth            | Seaview General Hospital         |  275 |
|        431 | Iain              | Russell         | Seaview General Hospital         |  275 |
|        171 | Baktianto         | Yulianti        | Seaview General Hospital         |  275 |
|        417 | Jose Miguel       | Farias          | Lakeside General Hospital        |  290 |
|        157 | Beth              | Gray            | Lakeside General Hospital        |  290 |
|        117 | Guadalupe         | Guitart         | Lakeside General Hospital        |  290 |
|        557 | Nabila            | Khan            | Lakeside General Hospital        |  290 |
|         57 | Lihua             | Li              | Lakeside General Hospital        |  290 |
|        457 | Melanie           | Macdonald       | Lakeside General Hospital        |  290 |
|        217 | Christy           | Mallon          | Lakeside General Hospital        |  290 |
|        517 | Fabian            | Malon           | Lakeside General Hospital        |  290 |
|         17 | Hardana           | Mardhiyah       | Lakeside General Hospital        |  290 |
|        397 | Iryna             | Melnyk          | Lakeside General Hospital        |  290 |
|         97 | Dakshesh          | Mody            | Lakeside General Hospital        |  290 |
|        357 | Marisol           | Navarrete       | Lakeside General Hospital        |  290 |
|        197 | Kalina            | Piaseczna       | Lakeside General Hospital        |  290 |
|        317 | Roman             | Pininfarina     | Lakeside General Hospital        |  290 |
|        297 | Rosaria           | Pizziol         | Lakeside General Hospital        |  290 |
|        257 | Heidi             | Snyder          | Lakeside General Hospital        |  290 |
|        597 | Dorota            | Waloch          | Lakeside General Hospital        |  290 |
|        497 | Mathew            | Ward            | Lakeside General Hospital        |  290 |
|        522 | Pierpaolo         | Ferragamo       | Mountain View General Hospital   |  310 |
|         62 | Peter             | Garde           | Mountain View General Hospital   |  310 |
|        322 | Soobin            | Kim             | Mountain View General Hospital   |  310 |
|        562 | Antoni            | Koscik          | Mountain View General Hospital   |  310 |
|        122 | Elliott           | Murray          | Mountain View General Hospital   |  310 |
|        462 | James             | Nevin           | Mountain View General Hospital   |  310 |
|        162 | Lala              | Permadi         | Mountain View General Hospital   |  310 |
|        362 | Bimala            | Rajagopal       | Mountain View General Hospital   |  310 |
|        422 | Antonello         | Renzi           | Mountain View General Hospital   |  310 |
|         22 | Bakhshi           | Sagar           | Mountain View General Hospital   |  310 |
|        222 | Russell           | Skinner         | Mountain View General Hospital   |  310 |
|        262 | Susan             | Zuniga          | Mountain View General Hospital   |  310 |
|        492 | Pablo             | Anguiano        | Harbourview General Hospital     |  320 |
|        552 | Eryk              | Bereda          | Harbourview General Hospital     |  320 |
|        112 | Telemaco          | Galeati         | Harbourview General Hospital     |  320 |
|        512 | Emily             | Gardner         | Harbourview General Hospital     |  320 |
|         52 | Tanvir            | Islam           | Harbourview General Hospital     |  320 |
|        312 | Simber            | Karadeniz       | Harbourview General Hospital     |  320 |
|        352 | Charles           | Mitchell        | Harbourview General Hospital     |  320 |
|        292 | Holly             | Nelson          | Harbourview General Hospital     |  320 |
|        452 | Yuridia           | Paez            | Harbourview General Hospital     |  320 |
|        152 | Sylwia            | Prazmo          | Harbourview General Hospital     |  320 |
|        392 | Kavya             | Rao             | Harbourview General Hospital     |  320 |
|        412 | Lidia             | Rompa           | Harbourview General Hospital     |  320 |
|        212 | Neha              | Singh           | Harbourview General Hospital     |  320 |
|        592 | Harry             | Smith           | Harbourview General Hospital     |  320 |
|         92 | Marianna          | Son             | Harbourview General Hospital     |  320 |
|        192 | Richard           | Stokes          | Harbourview General Hospital     |  320 |
|         12 | Arthur            | Vasconcelos     | Harbourview General Hospital     |  320 |
|        252 | Victor            | Verduzco        | Harbourview General Hospital     |  320 |
|        221 | Mary              | Baxter          | Millbrook General Hospital       |  330 |
|        121 | Adelia            | Carballo        | Millbrook General Hospital       |  330 |
|         21 | Jiho              | Choi            | Millbrook General Hospital       |  330 |
|        361 | Sencar            | Erdogan         | Millbrook General Hospital       |  330 |
|        321 | Hamza             | Farouk          | Millbrook General Hospital       |  330 |
|        161 | Lucy              | Johnson         | Millbrook General Hospital       |  330 |
|        261 | Ewa               | Mzyk            | Millbrook General Hospital       |  330 |
|        521 | Arthur            | Paris           | Millbrook General Hospital       |  330 |
|         61 | Michelle          | Russell         | Millbrook General Hospital       |  330 |
|        561 | Yuki              | Suzuki          | Millbrook General Hospital       |  330 |
|        461 | Davi              | Teixeira        | Millbrook General Hospital       |  330 |
|        421 | Zaira             | Tome            | Millbrook General Hospital       |  330 |
|        543 | Kojo              | Adeyemi         | Brookside General Hospital       |  350 |
|        143 | Zalindra          | Habibi          | Brookside General Hospital       |  350 |
|        243 | Corey             | Hughes          | Brookside General Hospital       |  350 |
|        503 | Robert            | Jones           | Brookside General Hospital       |  350 |
|         83 | Veronique         | Klemm           | Brookside General Hospital       |  350 |
|        303 | Domhnall          | McAndrew        | Brookside General Hospital       |  350 |
|         43 | Priya             | Nair            | Brookside General Hospital       |  350 |
|        583 | Priscila          | Pardo           | Brookside General Hospital       |  350 |
|        283 | Seojun            | Park            | Brookside General Hospital       |  350 |
|        383 | Valentine         | Pelletier       | Brookside General Hospital       |  350 |
|        343 | Dean              | Preston         | Brookside General Hospital       |  350 |
|          3 | Kirk              | Ramirez         | Brookside General Hospital       |  350 |
|        483 | Emilio            | Raya            | Brookside General Hospital       |  350 |
|        103 | Cebrian           | Sanjuan         | Brookside General Hospital       |  350 |
|        443 | Beverley          | Shaw            | Brookside General Hospital       |  350 |
|        203 | Coluccio          | Viola           | Brookside General Hospital       |  350 |
|        183 | Yuna              | Watanabe        | Brookside General Hospital       |  350 |
|        403 | Ren               | Yamamoto        | Brookside General Hospital       |  350 |
|        413 | Imran             | Akter           | Hawthorn General Hospital        |  360 |
|        253 | Mario             | Barnett         | Hawthorn General Hospital        |  360 |
|        593 | Henry             | Bhandari        | Hawthorn General Hospital        |  360 |
|        153 | Donatella         | Camiscione      | Hawthorn General Hospital        |  360 |
|        553 | Samuel            | Daniels         | Hawthorn General Hospital        |  360 |
|        393 | Ananya            | Gupta           | Hawthorn General Hospital        |  360 |
|         13 | Calvin            | Hogan           | Hawthorn General Hospital        |  360 |
|        493 | Ignacy            | Kostek          | Hawthorn General Hospital        |  360 |
|        193 | Karlfried         | Kostolzin       | Hawthorn General Hospital        |  360 |
|        213 | Ming              | Li              | Hawthorn General Hospital        |  360 |
|         93 | Monica            | Matos           | Hawthorn General Hospital        |  360 |
|        113 | Kojo              | Okafor          | Hawthorn General Hospital        |  360 |
|        293 | Cesar             | Orta            | Hawthorn General Hospital        |  360 |
|        453 | Jerzy             | Przybys         | Hawthorn General Hospital        |  360 |
|        353 | Adam              | Rojas           | Hawthorn General Hospital        |  360 |
|        313 | Jeremiah          | Seshadri        | Hawthorn General Hospital        |  360 |
|         53 | Leoncio           | Teruel          | Hawthorn General Hospital        |  360 |
|        513 | Denise            | Vallee          | Hawthorn General Hospital        |  360 |
|        491 | Carla             | Anggraini       | Greenfield General Hospital      |  380 |
|        351 | Davi              | Araujo          | Greenfield General Hospital      |  380 |
|        151 | Anselm            | Blumel          | Greenfield General Hospital      |  380 |
|         91 | Dustin            | Bush            | Greenfield General Hospital      |  380 |
|        251 | Isaias            | Calvet          | Greenfield General Hospital      |  380 |
|        451 | Gozem             | Ertas           | Greenfield General Hospital      |  380 |
|        411 | Arif              | Hossain         | Greenfield General Hospital      |  380 |
|        111 | Maida             | Laksita         | Greenfield General Hospital      |  380 |
|        211 | Felicia           | Lewis           | Greenfield General Hospital      |  380 |
|        551 | Lana              | MacVeigh        | Greenfield General Hospital      |  380 |
|        591 | Meera             | Nair            | Greenfield General Hospital      |  380 |
|        511 | Hamza             | Nasser          | Greenfield General Hospital      |  380 |
|        311 | Vedhika           | Pant            | Greenfield General Hospital      |  380 |
|         11 | Yuki              | Sato            | Greenfield General Hospital      |  380 |
|        391 | Wawan             | Thamrin         | Greenfield General Hospital      |  380 |
|         51 | Aaron             | Turner          | Greenfield General Hospital      |  380 |
|        191 | Theresa           | Valdez          | Greenfield General Hospital      |  380 |
|        291 | Sakura            | Yamamoto        | Greenfield General Hospital      |  380 |
+------------+-------------------+-----------------+----------------------------------+------+
```

*426 rows in set*
