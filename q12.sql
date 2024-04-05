SELECT 
    p.fname AS first_name,
    p.lname AS last_name,
    i.date AS date_of_infection,
    f.name AS facility_name,
    COUNT(sw.rid) AS number_of_secondary_residences
FROM Doctor d
JOIN Person p ON p.SIN = d.doctor_sin
JOIN Infected i ON p.SIN = i.person_sin
JOIN Facility f ON p.rid = f.fid
JOIN Schedule s ON d.doctor_sin = s.employee_sin
LEFT JOIN Secondary sw ON p.SIN = sw.sin
 WHERE i.date >= DATE_SUB(CURDATE(), INTERVAL 2 WEEK) 
 GROUP BY p.SIN, i.date
 ORDER BY f.name ASC, number_of_secondary_residences ASC;