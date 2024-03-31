<?php

$connection = mysqli_connect("zkc353.encs.concordia.ca", "zkc353_4", "353boyzz", "zkc353_4");
    
if($connection->connect_error){ 
  die('Connection Failed ' . $connection->connect_error); 
}

$person_sin = $_POST['person_sin'];
$dose_number = $_POST['dose_number'];
$vaccine_type = $_POST['vaccine_type'];
$date  = $_POST['date'];
$fid = $_POST['fid'];

$sql = "INSERT INTO Vaccinated (person_sin, dose_number, vaccine_type, date, fid) 
        VALUES ('$person_sin', '$dose_number', '$vaccine_type', '$date', '$fid')";

if ($connection->query($sql) === TRUE) {
  echo "New record created successfully";
} else {
  echo "Error: " . $sql . "<br>" . $connection->error;
}

$connection->close();
?>