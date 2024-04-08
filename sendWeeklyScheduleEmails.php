<?php

$connection = mysqli_connect("zkc353.encs.concordia.ca", "zkc353_4", "353boyzz", "zkc353_4");

// Check connection
if ($connection->connect_error) {
    die("Connection failed: " . $connection->connect_error);
}

// SQL to fetch the schedules for the next week
$sql = "
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
     SELECT administrative_sin, 'Administrative' FROM Administrative) r ON p.SIN = r.sin
WHERE
    s.start BETWEEN CURRENT_DATE AND CURRENT_DATE + INTERVAL 7 DAY
GROUP BY
    Facility_Name, Facility_Address, Employee_Name, Employee_Email, Schedule_Day
ORDER BY
    MIN(s.start);
";

if ($result = $connection->query($sql)) {
    while ($row = $result->fetch_assoc()) {
        // Assuming you have a function to send emails
        $subject = "Weekly Schedule for " . $row['Facility_Name'];
        $body = "Facility Name: " . $row['Facility_Name'] . "\n"
              . "Address: " . $row['Facility_Address'] . "\n"
              . "Role: " . $row['Employee_Roles'] . "\n"
              . "Name: " . $row['Employee_Name'] . "\n"
              . "Schedule: " . $row['Schedule_Day'] . ", " . $row['Schedule_Start'] . " to " . $row['Schedule_End'];

        // Simulate email sending and logging
        // mail($row['Employee_Email'], $subject, $body); // Uncomment to send email

        // Log email
        $logSql = "INSERT INTO EmailLog (log_date, sender_fac, receiver_email, subject, body) VALUES 
                   (NOW(), '" . $connection->real_escape_string($row['Facility_Name']) . "', 
                   '" . $connection->real_escape_string($row['Employee_Email']) . "', 
                   '" . $connection->real_escape_string($subject) . "', 
                   '" . $connection->real_escape_string(substr($body, 0, 100)) . "')";
        if (!$connection->query($logSql)) {
            echo "Error logging email: " . $connection->error;
        }
    }
} else {
    echo "Error fetching schedules: " . $connection->error;
}

$connection->close();
?>
