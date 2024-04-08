<?php

$connection = mysqli_connect("zkc353.encs.concordia.ca", "zkc353_4", "353boyzz", "zkc353_4");
    
if($connection->connect_error){ 
  die('Connection Failed ' . $connection->connect_error); 
}

$sql = "SELECT p.fname AS First_Name, p.lname AS Last_Name, MIN(sch.start_date) AS First_Day_of_Work, p.DOB AS Date_of_Birth, p.email AS Email_Address,
              (SELECT COUNT(*) FROM Infected WHERE person_sin = n.nurse_sin) AS Total_Times_Infected, COUNT(DISTINCT vac.dose_number) AS Total_Number_of_Vaccines,
              SUM(TIMESTAMPDIFF(HOUR, s.start, s.end)) AS Total_Hours_Scheduled, COUNT(DISTINCT sec.rid) AS Total_Secondary_Residences
        FROM 
          Nurse n
        JOIN Person p ON n.nurse_sin = p.SIN
        JOIN Schedule sch ON n.nurse_sin = sch.employee_sin
        JOIN Infected inf ON n.nurse_sin = inf.person_sin
        LEFT JOIN Vaccinated vac ON n.nurse_sin = vac.person_sin
        LEFT JOIN Shift s ON sch.sid = s.sid
        LEFT JOIN Secondary sec ON p.SIN = sec.sin
        WHERE inf.date BETWEEN DATE_SUB(CURDATE(), INTERVAL 14 DAY) AND CURDATE()
        GROUP BY n.nurse_sin
        HAVING COUNT(DISTINCT sch.fid) >= 2
        ORDER BY First_Day_of_Work ASC, First_Name ASC, Last_Name ASC;";

$result = $connection->query($sql);

if ($result->num_rows > 0) {
  echo "<table border='1'>";
  echo "<tr><th>First Name</th><th>Last Name</th><th>First Day of Work</th><th>Date of Birth</th><th>Email Address</th><th>Total Times Infected</th><th>Total Number of Vaccines</th>
        <th>Total Hours Scheduled</th><th>Total Secondary Residences</th></tr>";
  while ($row = mysqli_fetch_assoc($result)) {
      echo "<tr>";
      echo "<td>" . $row['First_Name'] . "</td>";
      echo "<td>" . $row['Last_Name'] . "</td>";
      echo "<td>" . $row['First_Day_of_Work'] . "</td>";
      echo "<td>" . $row['Date_of_Birth'] . "</td>";
      echo "<td>" . $row['Email_Address'] . "</td>";
      echo "<td>" . $row['Total_Times_Infected'] . "</td>";
      echo "<td>" . $row['Total_Number_of_Vaccines'] . "</td>";
      echo "<td>" . $row['Total_Hours_Scheduled'] . "</td>";
      echo "<td>" . $row['Total_Secondary_Residences'] . "</td>";
      echo "</tr>";
  }
    echo "</table>";
} else {
    echo "0 results";
}
$connection->close();

?>