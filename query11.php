<?php

$connection = mysqli_connect("zkc353.encs.concordia.ca", "zkc353_4", "353boyzz", "zkc353_4");
    
if($connection->connect_error){ 
  die('Connection Failed ' . $connection->connect_error); 
}

$employee_sin = $_POST['employee_sin'];

$sql = "SELECT r.address AS Address, r.residence_type AS Residence_Type, p.fname AS First_Name, p.lname AS Last_Name,
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
        JOIN (SELECT SIN, rid FROM Person UNION SELECT sin, rid FROM Secondary) er ON e.SIN = er.SIN
        JOIN Residence r ON er.rid = r.rid
        LEFT JOIN LivesWith lw ON er.SIN = lw.employee_sin OR er.SIN = lw.person_sin
        LEFT JOIN Person p ON lw.person_sin = p.SIN OR er.SIN = p.SIN
        LEFT JOIN Pharmacist ph ON p.SIN = ph.pharmacist_sin
        LEFT JOIN Nurse nu ON p.SIN = nu.nurse_sin
        LEFT JOIN Doctor do ON p.SIN = do.doctor_sin
        LEFT JOIN Receptionist re ON p.SIN = re.receptionist_sin
        LEFT JOIN Cashier ca ON p.SIN = ca.cashier_sin
        LEFT JOIN Security se ON p.SIN = se.security_sin
        LEFT JOIN Administrative ad ON p.SIN = ad.administrative_sin
        WHERE e.SIN = $employee_sin AND p.SIN != $employee_sin -- exclude employee’s own record
        ORDER BY r.address, p.lname, p.fname;";

$result = $connection->query($sql);

if ($result->num_rows > 0) {
    echo "<table border='1'>";
    echo "<tr><th>Residence Type</th><th>First Name</th><th>Last Name</th><th>Occupiation</th><th>Relationship with Employee</th></tr>";
    // output data of each row
    while($row = $result->fetch_assoc()) {
        echo "<tr>";
        echo "<td>".$row["Residence_Type"]."</td>";
        echo "<td>".$row["First_Name"]."</td>";
        echo "<td>".$row["Last_Name"]."</td>";
        echo "<td>".$row["Occupation"]."</td>";
        echo "<td>".$row["Relationship_with_Employee"]."</td>";
        echo "</tr>";
    }
    echo "</table>";
} else {
    echo "0 results";
}
$connection->close();

?>