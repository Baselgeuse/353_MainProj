<?php

$connection = mysqli_connect("zkc353.encs.concordia.ca", "zkc353_4", "353boyzz", "zkc353_4");
    
if($connection->connect_error){ 
  die('Connection Failed ' . $connection->connect_error); 
}

$SIN = $_POST['SIN'];
$MID = $_POST['MID'];
$fname = $_POST['fname'];
$lname  = $_POST['lname'];
$email = $_POST['email'];
$DOB = $_POST['DOB'];
$phone_number = $_POST['phone_number'];
$citizenship = $_POST['citizenship'];
$RID = $_POST['RID'];

$sql = "INSERT INTO Person (SIN, MID, fname, lname, email, DOB, phone_number, citizenship, rid) 
        VALUES ('$SIN', '$MID', '$fname', '$lname', '$email', '$DOB', '$phone_number', '$citizenship', '$RID')";

if ($connection->query($sql) === TRUE) {
  echo "New record created successfully";
} else {
  echo "Error: " . $sql . "<br>" . $connection->error;
}

$connection->close();
?>