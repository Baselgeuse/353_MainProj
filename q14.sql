SELECT 
    p.fname AS first_name,
    p.lname AS last_name,
    CASE
        WHEN d.doctor_sin IS NOT NULL THEN 'Doctor'
        WHEN ph.pharmacist_sin IS NOT NULL THEN 'Pharmacist'
        WHEN n.nurse_sin IS NOT NULL THEN 'Nurse'
        WHEN r.receptionist_sin IS NOT NULL THEN 'Receptionist'
        WHEN c.cashier_sin IS NOT NULL THEN 'Cashier'
        WHEN a.administrative_sin IS NOT NULL THEN 'Administrative'
        WHEN s.security_sin IS NOT NULL THEN 'Security'
        ELSE 'Unknown'
    END AS role,
    COUNT(DISTINCT sw.rid) AS number_of_secondary_residences
FROM Person p
LEFT JOIN Doctor d ON p.SIN = d.doctor_sin
LEFT JOIN Pharmacist ph ON p.SIN = ph.pharmacist_sin
LEFT JOIN Nurse n ON p.SIN = n.nurse_sin
LEFT JOIN Receptionist r ON p.SIN = r.receptionist_sin
LEFT JOIN Cashier c ON p.SIN = c.cashier_sin
LEFT JOIN Administrative a ON p.SIN = a.administrative_sin
LEFT JOIN Security s ON p.SIN = s.security_sin
Right JOIN Secondary sw ON p.SIN = sw.sin
JOIN Schedule sch ON p.SIN = sch.employee_sin
JOIN Shift ON sch.sid = Shift.sid
WHERE 
	Shift.start >= DATE_SUB(CURDATE(), INTERVAL 2 WEEK) 
	 AND sch.fid = (SELECT fid FROM Facility WHERE Facility.name = 'Pharmacy F') 
GROUP BY p.SIN
HAVING COUNT(DISTINCT sw.rid) >= 3
ORDER BY role ASC, number_of_secondary_residences ASC;
