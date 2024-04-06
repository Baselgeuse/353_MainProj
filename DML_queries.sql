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
    r.address AS Address,
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
    (SELECT SIN, rid FROM Person
     UNION
     SELECT sin, rid FROM Secondary) er ON e.SIN = er.SIN
JOIN 
    Residence r ON er.rid = r.rid
LEFT JOIN 
    LivesWith lw ON er.SIN = lw.employee_sin OR er.SIN = lw.person_sin
LEFT JOIN 
    Person p ON lw.person_sin = p.SIN OR er.SIN = p.SIN
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
    e.SIN = '123123123' 
    AND p.SIN != '123123123' -- exclude employee’s own record
ORDER BY 
    r.address, p.lname, p.fname;

-- QUESTION 15
SELECT 
    p.fname AS First_Name,
    p.lname AS Last_Name,
    MIN(wa.start_date) AS First_Day_of_Work,
    p.DOB AS Date_of_Birth,
    p.email AS Email_Address,
    (SELECT COUNT(*) FROM Infected WHERE person_sin = n.nurse_sin) AS Total_Times_Infected,
    COUNT(DISTINCT vac.dose_number) AS Total_Number_of_Vaccines,
    SUM(TIMESTAMPDIFF(HOUR, s.start, s.end)) AS Total_Hours_Scheduled,
    COUNT(DISTINCT sec.rid) AS Total_Secondary_Residences
FROM 
    Nurse n
JOIN 
    Person p ON n.nurse_sin = p.SIN
JOIN 
    WorksAt wa ON n.nurse_sin = wa.employee_sin
JOIN 
    Infected inf ON n.nurse_sin = inf.person_sin
LEFT JOIN 
    Vaccinated vac ON n.nurse_sin = vac.person_sin
LEFT JOIN 
    Shift s ON wa.sid = s.sid
LEFT JOIN 
    Secondary sec ON p.SIN = sec.sin
WHERE 
    inf.date BETWEEN DATE_SUB(CURDATE(), INTERVAL 14 DAY) AND CURDATE()
GROUP BY 
    n.nurse_sin
HAVING 
    COUNT(DISTINCT wa.fid) >= 2
ORDER BY 
    First_Day_of_Work ASC, 
    First_Name ASC, 
    Last_Name ASC;

-- QUESTION 16
SELECT 
    roles.EmployeeRole AS Role,
    COUNT(DISTINCT roles.sin) AS Total_Employees,
    SUM(
        CASE 
            WHEN inf.person_sin IS NOT NULL
                 AND inf.date BETWEEN DATE_SUB(CURDATE(), INTERVAL 14 DAY) AND CURDATE()
            THEN 1 
            ELSE 0 
        END
    ) AS Total_Infected_Employees
FROM (
    SELECT pharmacist_sin AS sin, 'Pharmacist' AS EmployeeRole FROM Pharmacist WHERE pharmacist_sin IN (SELECT employee_sin FROM WorksAt WHERE end_date IS NULL)
    UNION ALL
    SELECT nurse_sin, 'Nurse' FROM Nurse WHERE nurse_sin IN (SELECT employee_sin FROM WorksAt WHERE end_date IS NULL)
    UNION ALL
    SELECT doctor_sin, 'Doctor' FROM Doctor WHERE doctor_sin IN (SELECT employee_sin FROM WorksAt WHERE end_date IS NULL)
    UNION ALL
    SELECT receptionist_sin, 'Receptionist' FROM Receptionist WHERE receptionist_sin IN (SELECT employee_sin FROM WorksAt WHERE end_date IS NULL)
    UNION ALL
    SELECT cashier_sin, 'Cashier' FROM Cashier WHERE cashier_sin IN (SELECT employee_sin FROM WorksAt WHERE end_date IS NULL)
    UNION ALL
    SELECT security_sin, 'Security' FROM Security WHERE security_sin IN (SELECT employee_sin FROM WorksAt WHERE end_date IS NULL)
    UNION ALL
    SELECT administrative_sin, 'Administrative' FROM Administrative WHERE administrative_sin IN (SELECT employee_sin FROM WorksAt WHERE end_date IS NULL)
) AS roles
LEFT JOIN Infected inf ON roles.sin = inf.person_sin
GROUP BY roles.EmployeeRole
ORDER BY roles.EmployeeRole;

-- QUESTION 17
SELECT 
    roles.EmployeeRole AS Role,
    COUNT(DISTINCT roles.sin) AS Total_Employees,
    SUM(
        CASE 
            WHEN inf.person_sin IS NULL
            THEN 1 
            ELSE 0 
        END
    ) AS Employees_Never_Infected
FROM (
    SELECT pharmacist_sin AS sin, 'Pharmacist' AS EmployeeRole FROM Pharmacist WHERE pharmacist_sin IN (SELECT employee_sin FROM WorksAt WHERE end_date IS NULL)
    UNION ALL
    SELECT nurse_sin, 'Nurse' FROM Nurse WHERE nurse_sin IN (SELECT employee_sin FROM WorksAt WHERE end_date IS NULL)
    UNION ALL
    SELECT doctor_sin, 'Doctor' FROM Doctor WHERE doctor_sin IN (SELECT employee_sin FROM WorksAt WHERE end_date IS NULL)
    UNION ALL
    SELECT receptionist_sin, 'Receptionist' FROM Receptionist WHERE receptionist_sin IN (SELECT employee_sin FROM WorksAt WHERE end_date IS NULL)
    UNION ALL
    SELECT cashier_sin, 'Cashier' FROM Cashier WHERE cashier_sin IN (SELECT employee_sin FROM WorksAt WHERE end_date IS NULL)
    UNION ALL
    SELECT security_sin, 'Security' FROM Security WHERE security_sin IN (SELECT employee_sin FROM WorksAt WHERE end_date IS NULL)
    UNION ALL
    SELECT administrative_sin, 'Administrative' FROM Administrative WHERE administrative_sin IN (SELECT employee_sin FROM WorksAt WHERE end_date IS NULL)
) AS roles
LEFT JOIN Infected inf ON roles.sin = inf.person_sin
GROUP BY roles.EmployeeRole
ORDER BY roles.EmployeeRole;

-- QUESTION 18
SELECT 
    f.province,
    COUNT(DISTINCT f.fid) AS Total_Facilities,
    COUNT(DISTINCT wa.employee_sin) AS Total_Current_Employees,
    COUNT(DISTINCT CASE 
		WHEN inf.person_sin IS NOT NULL 
        THEN wa.employee_sin END) AS Total_Infected_Employees,
    MAX(f.capacity) AS Maximum_Capacity,
    SUM(TIMESTAMPDIFF(HOUR, s.start, s.end)) AS Total_Hours_Scheduled
FROM 
    Facility f
LEFT JOIN WorksAt wa ON f.fid = wa.fid AND wa.end_date IS NULL
LEFT JOIN (
    SELECT person_sin FROM Infected
    WHERE date BETWEEN DATE_SUB(CURDATE(), INTERVAL 14 DAY) AND CURDATE()
) AS inf ON wa.employee_sin = inf.person_sin
LEFT JOIN Schedule sch ON wa.sid = sch.sid
LEFT JOIN Shift s ON sch.sid = s.sid AND s.start BETWEEN '2024-04-01' AND '2024-12-31'
GROUP BY f.province
ORDER BY f.province;

-- Generate emails for every employee, indicating their schedule for the upcoming week
SELECT
    f.name AS Facility_Name,
    f.address AS Facility_Address,
    CONCAT(p.fname, ' ', p.lname) AS Employee_Name,
    p.email AS Employee_Email,
    GROUP_CONCAT(DISTINCT r.Role ORDER BY r.Role) AS Employee_Roles,
    CASE
        WHEN DAYOFWEEK(s.start) = 2 THEN 'Monday'
        WHEN DAYOFWEEK(s.start) = 3 THEN 'Tuesday'
        WHEN DAYOFWEEK(s.start) = 4 THEN 'Wednesday'
        WHEN DAYOFWEEK(s.start) = 5 THEN 'Thursday'
        WHEN DAYOFWEEK(s.start) = 6 THEN 'Friday'
        WHEN DAYOFWEEK(s.start) = 7 THEN 'Saturday'
        WHEN DAYOFWEEK(s.start) = 1 THEN 'Sunday'
    END AS Schedule_Day,
    MIN(s.start) AS Schedule_Start,
    MAX(s.end) AS Schedule_End
FROM
    Person p
JOIN
    WorksAt wa ON p.SIN = wa.employee_sin
JOIN
    Facility f ON wa.fid = f.fid
JOIN
    Shift s ON wa.sid = s.sid
JOIN
    (SELECT pharmacist_sin AS sin, 'Pharmacist' AS Role FROM Pharmacist
     UNION ALL
     SELECT nurse_sin, 'Nurse' FROM Nurse
     UNION ALL
     SELECT doctor_sin, 'Doctor' FROM Doctor
     UNION ALL
     SELECT receptionist_sin, 'Receptionist' FROM Receptionist
     UNION ALL
     SELECT cashier_sin, 'Cashier' FROM Cashier
     UNION ALL
     SELECT security_sin, 'Security' FROM Security
     UNION ALL
     SELECT administrative_sin, 'Administrative' FROM Administrative
    ) r ON p.SIN = r.sin
WHERE
    s.start BETWEEN CURRENT_DATE AND CURRENT_DATE + INTERVAL 7 DAY
GROUP BY
    Facility_Name, Facility_Address, Employee_Name, Employee_Email, Schedule_Day
ORDER BY
    MIN(s.start);






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

