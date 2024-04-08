<?php

$connection = mysqli_connect("zkc353.encs.concordia.ca", "zkc353_4", "353boyzz", "zkc353_4");
    
if($connection->connect_error){ 
  die('Connection Failed ' . $connection->connect_error); 
}

$sql = "SELECT roles.EmployeeRole AS Role, COUNT(DISTINCT roles.sin) AS Total_Employees, SUM(CASE WHEN inf.person_sin IS NOT NULL AND inf.date BETWEEN DATE_SUB(CURDATE(), 
        INTERVAL 14 DAY) AND CURDATE() THEN 1 ELSE 0 END) AS Total_Infected_Employees
FROM (SELECT pharmacist_sin AS sin, 'Pharmacist' AS EmployeeRole FROM Pharmacist WHERE pharmacist_sin IN (SELECT employee_sin FROM Schedule WHERE end_date IS NULL)
UNION ALL
SELECT nurse_sin, 'Nurse' FROM Nurse WHERE nurse_sin IN (SELECT employee_sin FROM Schedule WHERE end_date IS NULL)
UNION ALL
SELECT doctor_sin, 'Doctor' FROM Doctor WHERE doctor_sin IN (SELECT employee_sin FROM Schedule WHERE end_date IS NULL)
UNION ALL
SELECT receptionist_sin, 'Receptionist' FROM Receptionist WHERE receptionist_sin IN (SELECT employee_sin FROM Schedule WHERE end_date IS NULL)
UNION ALL
SELECT cashier_sin, 'Cashier' FROM Cashier WHERE cashier_sin IN (SELECT employee_sin FROM Schedule WHERE end_date IS NULL)
UNION ALL
SELECT security_sin, 'Security' FROM Security WHERE security_sin IN (SELECT employee_sin FROM Schedule WHERE end_date IS NULL)
UNION ALL
SELECT administrative_sin, 'Administrative' FROM Administrative WHERE administrative_sin IN (SELECT employee_sin FROM Schedule WHERE end_date IS NULL)
) AS roles
LEFT JOIN Infected inf ON roles.sin = inf.person_sin
GROUP BY roles.EmployeeRole
ORDER BY roles.EmployeeRole;";

$result = $connection->query($sql);

if ($result->num_rows > 0) {
  echo "<table border='1'>";
  echo "<tr><th>Role</th><th>Total Employees</th><th>Total Infected Employees</th></tr>";
  while ($row = mysqli_fetch_assoc($result)) {
    echo "<tr>";
    echo "<td>" . $row['Role'] . "</td>";
    echo "<td>" . $row['Total_Employees'] . "</td>";
    echo "<td>" . $row['Total_Infected_Employees'] . "</td>";
    echo "</tr>";
}
    echo "</table>";
} else {
    echo "0 results";
}

$connection->close();

?>