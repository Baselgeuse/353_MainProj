<?php

$connection = mysqli_connect("zkc353.encs.concordia.ca", "zkc353_4", "353boyzz", "zkc353_4");
    
if($connection->connect_error){ 
  die('Connection Failed ' . $connection->connect_error); 
}

$FID = $_POST['FID'];
$name = $_POST['name'];
$address = $_POST['address'];
$city = $_POST['city'];
$province  = $_POST['province'];
$postal_code = $_POST['postal_code'];
$phone_number = $_POST['phone_number'];
$web_address = $_POST['web_address'];
$facility_type = $_POST['facility_type'];
$manager_sin = $_POST['manager_sin'];
$capacity = $_POST['capacity'];

$sql = "INSERT INTO Facility (fid, name, address, city, province, postal_code, phone_number, web_address, facility_type, manager_sin, capacity) 
        VALUES ('$FID', '$name', '$address', '$city', '$province', '$postal_code', '$phone_number', '$web_address', '$facility_type', '$manager_sin', '$capacity')";

if ($connection->query($sql) === TRUE) {
  echo "New record created successfully";
} else {
  echo "Error: " . $sql . "<br>" . $connection->error;
}

$connection->close();
?>