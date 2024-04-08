<?php

$connection = mysqli_connect("zkc353.encs.concordia.ca", "zkc353_4", "353boyzz", "zkc353_4");
    
if($connection->connect_error){ 
  die('Connection Failed ' . $connection->connect_error); 
}

$employee_sin = $_POST['employee_sin'];
$start_date = $_POST['start_date'];
$end_date = $_POST['end_date'];

$sql = "SELECT f.name AS Facility_Name, DAYOFYEAR(s.start) AS Day_of_Year, s.start AS Start_Time, s.end AS End_Time
        FROM Shift s
        JOIN Schedule sch ON s.sid = sch.sid
        JOIN Facility f ON sch.fid = f.fid
        WHERE 
        sch.employee_sin = $employee_sin 
        AND s.start >= $start_date
        AND s.end <= $end_date
        ORDER BY f.name ASC, DAYOFYEAR(s.start) ASC, s.start ASC;";

$result = $connection->query($sql);

if ($result->num_rows > 0) {
    echo "<table border='1'>";
    echo "<tr><th>Facility Name</th><th>Day of Year</th><th>Schecule Start</th><th>Schedule End</th></tr>";
    // output data of each row
    while($row = $result->fetch_assoc()) {
        echo "<tr>";
        echo "<td>".$row["Facility_name"]."</td>";
        echo "<td>".$row["Day_of_Year"]."</td>";
        echo "<td>".$row["Start_Time"]."</td>";
        echo "<td>".$row["End_Time"]."</td>";
        echo "</tr>";
    }
    echo "</table>";
} else {
    echo "0 results";
}
$connection->close();

?>