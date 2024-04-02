<?php

$connection = mysqli_connect("zkc353.encs.concordia.ca", "zkc353_4", "353boyzz", "zkc353_4");
    
if($connection->connect_error){ 
  die('Connection Failed ' . $connection->connect_error); 
}

$employee_sin = $_POST["employee_sin"];
$start_date = $_POST["start_date"];
$end_date = $_POST["end_date"];

$sql = "INSERT INTO Shift(start, end, sid) VALUES ('$start_date', '$end_date', (SELECT sid FROM WorksAt WHERE employee_sin = '$employee_sin'))";

if ($connection->query($sql) === TRUE) {
  echo "New record created successfully";
} else {
  echo "Error: " . $sql . "<br>" . $connection->error;
}

$connection->close();
?>