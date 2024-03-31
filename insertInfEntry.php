<?php

$connection = mysqli_connect("zkc353.encs.concordia.ca", "zkc353_4", "353boyzz", "zkc353_4");
    
if($connection->connect_error){ 
  die('Connection Failed ' . $connection->connect_error); 
}

$person_sin = $_POST['person_sin'];
$variantType = $_POST['variantType'];
$date = $_POST['date'];


$sql = "INSERT INTO Infected (person_sin, variantType, date) 
        VALUES  ('$person_sin', '$variantType', '$date')";

if ($connection->query($sql) === TRUE) {
  echo "New record created successfully";
} else {
  echo "Error: " . $sql . "<br>" . $connection->error;
}

$connection->close();
?>