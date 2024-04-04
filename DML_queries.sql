-- QUESTION 10
SELECT 
    f.name AS Facility_Name,
    DAYOFYEAR(s.start) AS Day_of_Year, -- DAYOFYEAR function returns an integer representing the day of the year, where 1 is January 1.
    s.start AS Start_Time,
    s.end AS End_Time
FROM 
    Shift s
JOIN 
    Schedule sch ON s.sid = sch.sid
JOIN 
    WorksAt wa ON sch.sid = wa.sid
JOIN 
    Facility f ON wa.fid = f.fid
WHERE 
    wa.employee_sin = '123123123' 
    AND s.start BETWEEN '2021-01-01' AND '2024-05-01'
    AND s.end BETWEEN '2021-01-01' AND '2024-05-01'
ORDER BY 
    f.name ASC, 
    DAYOFYEAR(s.start) ASC, 
    s.start ASC;

-- QUESTION 11
SELECT 
    r.address,
    r.residence_type AS Residence_Type,
    p.fname AS First_Name,
    p.lname AS Last_Name,
    CASE
        WHEN ph.pharmacist_sin IS NOT NULL THEN 'Pharmacist'
        WHEN nu.nurse_sin IS NOT NULL THEN 'Nurse'
        WHEN do.doctor_sin IS NOT NULL THEN 'Doctor'
        WHEN re.receptionist_sin IS NOT NULL THEN 'Receptionist'
        WHEN ca.cashier_sin IS NOT NULL THEN 'Cashier'
        WHEN se.security_sin IS NOT NULL THEN 'Security'
        WHEN ad.administrative_sin IS NOT NULL THEN 'Administrative'
        ELSE 'None'
    END AS Occupation,
    lw.relationship AS Relationship_with_Employee
FROM 
    Person e
JOIN 
    LivesWith lw ON e.SIN = lw.employee_sin
JOIN 
    Person p ON lw.person_sin = p.SIN
JOIN 
    Residence r ON p.rid = r.rid
LEFT JOIN 
    Pharmacist ph ON p.SIN = ph.pharmacist_sin
LEFT JOIN 
    Nurse nu ON p.SIN = nu.nurse_sin
LEFT JOIN 
    Doctor do ON p.SIN = do.doctor_sin
LEFT JOIN 
    Receptionist re ON p.SIN = re.receptionist_sin
LEFT JOIN 
    Cashier ca ON p.SIN = ca.cashier_sin
LEFT JOIN 
    Security se ON p.SIN = se.security_sin
LEFT JOIN 
    Administrative ad ON p.SIN = ad.administrative_sin
WHERE 
    e.SIN = '123123123' -- Replace with the SIN of the employee of interest
    AND p.SIN != '123123123' -- Exclude the employee’s own record
ORDER BY 
    r.address, p.lname, p.fname;

    

SELECT 'Residence' AS TableName, COUNT(*) AS "Count(*)" FROM Residence
UNION ALL
SELECT 'Person', COUNT(*) FROM Person
UNION ALL
SELECT 'Employee', COUNT(*) FROM Employee
UNION ALL
SELECT 'Pharmacist', COUNT(*) FROM Pharmacist
UNION ALL
SELECT 'Nurse', COUNT(*) FROM Nurse
UNION ALL
SELECT 'Doctor', COUNT(*) FROM Doctor
UNION ALL
SELECT 'Receptionist', COUNT(*) FROM Receptionist
UNION ALL
SELECT 'Cashier', COUNT(*) FROM Cashier
UNION ALL
SELECT 'Security', COUNT(*) FROM Security
UNION ALL
SELECT 'Administrative', COUNT(*) FROM Administrative
UNION ALL
SELECT 'Facility', COUNT(*) FROM Facility
UNION ALL
SELECT 'Variant', COUNT(*) FROM Variant
UNION ALL
SELECT 'LivesWith', COUNT(*) FROM LivesWith
UNION ALL
SELECT 'WorksAt', COUNT(*) FROM WorksAt
UNION ALL
SELECT 'Vaccinated', COUNT(*) FROM Vaccinated
UNION ALL
SELECT 'Infected', COUNT(*) FROM Infected;


-- SELECT COUNT(*) FROM R;
-- SELECT COUNT(*) FROM Residence;
-- SELECT COUNT(*) FROM Person;
-- SELECT COUNT(*) FROM Employee;
-- SELECT COUNT(*) FROM Pharmacist;
-- SELECT COUNT(*) FROM Nurse;
-- SELECT COUNT(*) FROM Doctor;
-- SELECT COUNT(*) FROM Receptionist;
-- SELECT COUNT(*) FROM Cashier;
-- SELECT COUNT(*) FROM Security;
-- SELECT COUNT(*) FROM Administrative;
-- SELECT COUNT(*) FROM Facility;
-- SELECT COUNT(*) FROM Variant;
-- SELECT COUNT(*) FROM LivesWith;
-- SELECT COUNT(*) FROM WorksAt;
-- SELECT COUNT(*) FROM Vaccinated;
-- SELECT COUNT(*) FROM Infected;

