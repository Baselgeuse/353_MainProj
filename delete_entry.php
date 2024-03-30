<?php

$connection = mysqli_connect("zkc353.encs.concordia.ca", "zkc353_4", "353boyzz", "zkc353_4");
    if($connection->connect_error){ 
      die('Connection Failed ' . $connection->connect_error); 
}

$connection->query("SET FOREIGN_KEY_CHECKS = 0");

$entry_ID = $_POST['entry_id'];
$table_name = $_POST['table_name'];
$key_name = $_POST['key_name'];

$sql = "DELETE FROM $table_name WHERE $key_name = $entry_ID";

if ($connection->query($sql) === TRUE) {
  echo "Entry deleted successfully";
} else {
  echo "Error deleting entry: " . $connection->error;
}

$connection->query("SET FOREIGN_KEY_CHECKS = 1");

$connection->close();
?>