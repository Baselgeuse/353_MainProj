<?php

$connection = mysqli_connect("zkc353.encs.concordia.ca", "zkc353_4", "353boyzz", "zkc353_4");
    
if($connection->connect_error){ 
  die('Connection Failed ' . $connection->connect_error); 
}

$RID = $_POST['RID'];
$address = $_POST['address'];
$city = $_POST['city'];
$province  = $_POST['province'];
$postal_code = $_POST['postal_code'];
$phone_number = $_POST['phone_number'];
$room_count = $_POST['room_count'];
$residence_type = $_POST['residence_type'];

$sql = "INSERT INTO Residence (rid, address, city, province, postal_code, phone_number, room_count, residence_type) 
        VALUES ('$RID', '$address', '$city', '$province', '$postal_code', '$phone_number', '$room_count', '$residence_type')";

if ($connection->query($sql) === TRUE) {
  echo "New record created successfully";
} else {
  echo "Error: " . $sql . "<br>" . $connection->error;
}

$connection->close();
?>