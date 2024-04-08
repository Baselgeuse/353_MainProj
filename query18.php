<?php

$connection = mysqli_connect("zkc353.encs.concordia.ca", "zkc353_4", "353boyzz", "zkc353_4");
    
if($connection->connect_error){ 
  die('Connection Failed ' . $connection->connect_error); 
}

$start_date = $_POST['start_date'];
$end_date = $_POST['end_date'];

$sql = "SELECT 
f.province,
COUNT(DISTINCT f.fid) AS Total_Facilities,
COUNT(DISTINCT sch.employee_sin) AS Total_Current_Employees,
COUNT(DISTINCT CASE 
WHEN inf.person_sin IS NOT NULL 
    THEN sch.employee_sin END) AS Total_Infected_Employees,
MAX(f.capacity) AS Maximum_Capacity,
SUM(TIMESTAMPDIFF(HOUR, s.start, s.end)) AS Total_Hours_Scheduled
FROM 
Facility f
LEFT JOIN Schedule sch ON f.fid = sch.fid AND sch.end_date IS NULL
LEFT JOIN (
SELECT person_sin FROM Infected
WHERE date BETWEEN DATE_SUB(CURDATE(), INTERVAL 14 DAY) AND CURDATE()
) AS inf ON sch.employee_sin = inf.person_sin
LEFT JOIN Shift s ON sch.sid = s.sid AND s.start BETWEEN $start_date AND $end_date
GROUP BY f.province
ORDER BY f.province;";

$result = $connection->query($sql);

if ($result->num_rows > 0) {
  echo "<table border='1'>";
  echo "<tr><th>Province</th><th>Total Facilities</th><th>Total Current Employees</th><th>Total Infected Employees</th><th>Maximum Capacity</th><th>Total Hours Scheduled</th></tr>";
  while ($row = mysqli_fetch_assoc($result)) {
    echo "<tr>";
    echo "<td>" . $row['province'] . "</td>";
    echo "<td>" . $row['Total_Facilities'] . "</td>";
    echo "<td>" . $row['Total_Current_Employees'] . "</td>";
    echo "<td>" . $row['Total_Infected_Employees'] . "</td>";
    echo "<td>" . $row['Maximum_Capacity'] . "</td>";
    echo "<td>" . $row['Total_Hours_Scheduled'] . "</td>";
    echo "</tr>";
}
    echo "</table>";
} else {
    echo "0 results";
}

$connection->close();

?>