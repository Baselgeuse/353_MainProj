<?php

$connection = mysqli_connect("zkc353.encs.concordia.ca", "zkc353_4", "353boyzz", "zkc353_4");
    
if($connection->connect_error){ 
  die('Connection Failed ' . $connection->connect_error); 
}

$facility_id = $_POST['facility_id'];

$sql = "SELECT Person.fname, Person.lname, WorksAt.start_date, Person.DOB, Person.SIN, Person.phone_number, Residence.address, Residence.city, Residence.province, Residence.postal_code, Person.citizenship, Person.email, COUNT(Secondary.rid) AS num_secondary_residences
        FROM WorksAt
        INNER JOIN Person ON WorksAt.employee_sin = Person.SIN
        INNER JOIN Facility ON WorksAt.fid = Facility.fid
        INNER JOIN Residence ON Person.rid = Residence.rid
        LEFT JOIN Secondary ON Person.SIN = Secondary.sin
        WHERE Facility.name = $facility_id
        GROUP BY Person.SIN
        HAVING num_secondary_residences >= 1
        ORDER BY WorksAt.start_date DESC, Person.fname, Person.lname";

$result = $connection->query($sql);

if ($result->num_rows > 0) {
    echo "<table>";
    echo "<tr><th>First Name</th><th>Last Name</th><th>Start Date</th><th>Date of Birth</th><th>Medicare Card Number</th><th>Telephone Number</th><th>Primary Address</th><th>City</th><th>Province</th><th>Postal Code</th><th>Citizenship</th><th>Email Address</th><th>Number of Secondary Residences</th></tr>";
    // output data of each row
    while($row = $result->fetch_assoc()) {
        echo "<tr>";
        echo "<td>".$row["fname"]."</td>";
        echo "<td>".$row["lname"]."</td>";
        echo "<td>".$row["start_date"]."</td>";
        echo "<td>".$row["DOB"]."</td>";
        echo "<td>".$row["SIN"]."</td>";
        echo "<td>".$row["phone_number"]."</td>";
        echo "<td>".$row["address"]."</td>";
        echo "<td>".$row["city"]."</td>";
        echo "<td>".$row["province"]."</td>";
        echo "<td>".$row["postal_code"]."</td>";
        echo "<td>".$row["citizenship"]."</td>";
        echo "<td>".$row["email"]."</td>";
        echo "<td>".$row["num_secondary_residences"]."</td>";
        echo "</tr>";
    }
    echo "</table>";
} else {
    echo "0 results";
}
$connection->close();

?>