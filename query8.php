<?php

$connection = mysqli_connect("zkc353.encs.concordia.ca", "zkc353_4", "353boyzz", "zkc353_4");
    
if($connection->connect_error){ 
  die('Connection Failed ' . $connection->connect_error); 
}

$sql = "SELECT Facility.name, Facility.address, Facility.city, Facility.province, Facility.postal_code, Facility.phone_number, Facility.web_address, Facility.facility_type, 
               Facility.capacity, Person.fname AS manager_name, COUNT(WorksAt.employee_sin) AS num_employees, COUNT(Doctor.doctor_sin) AS num_doctors, COUNT(Nurse.nurse_sin) AS num_nurses 
        FROM Facility
        Left JOIN Person ON Facility.manager_sin = Person.SIN
        LEFT JOIN WorksAt ON Facility.fid = WorksAt.fid 
        LEFT JOIN Doctor ON WorksAt.employee_sin = Doctor.doctor_sin
        LEFT JOIN Nurse ON WorksAt.employee_sin = Nurse.nurse_sin
        GROUP BY Facility.fid
        ORDER BY Facility.province ASC, Facility.city ASC, Facility.facility_type ASC, COUNT(Doctor.doctor_sin) ASC";

$result = $connection->query($sql);

if ($result->num_rows > 0) {
  // Output data of each row
  echo "<table border='1'>";
  echo "<tr><th>Facility Name</th><th>Address</th><th>City</th><th>Province</th><th>Postal Code</th><th>Phone Number</th><th>Web Address</th><th>Type</th><th>Capacity</th><th>Manager Name</th><th>Num Employees</th><th>Num Doctors</th><th>Num Nurses</th></tr>";
  while($row = $result->fetch_assoc()) {
    echo "<tr>";
    echo "<td>".$row["name"]."</td>";
    echo "<td>".$row["address"]."</td>";
    echo "<td>".$row["city"]."</td>";
    echo "<td>".$row["province"]."</td>";
    echo "<td>".$row["postal_code"]."</td>";
    echo "<td>".$row["phone_number"]."</td>";
    echo "<td>".$row["web_address"]."</td>";
    echo "<td>".$row["facility_type"]."</td>";
    echo "<td>".$row["capacity"]."</td>";
    echo "<td>".$row["manager_name"]."</td>";
    echo "<td>".$row["num_employees"]."</td>";
    echo "<td>".$row["num_doctors"]."</td>";
    echo "<td>".$row["num_nurses"]."</td>";
    echo "</tr>";
  }
  echo "</table>";
} else {
  echo "0 results";
}


$connection->close();
?>