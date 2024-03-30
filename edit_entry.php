<?php

$connection = mysqli_connect("zkc353.encs.concordia.ca", "zkc353_4", "353boyzz", "zkc353_4");
    if($connection->connect_error){ 
      die('Connection Failed ' . $connection->connect_error); 
}

$entry_ID = $_POST['entry_id'];
$column_name = $_POST['column_name'];
$table_name = $_POST['table_name'];
$new_value = $_POST['new_value'];
$key_name = $_POST['key_name'];

$sql = "UPDATE $table_name SET $column_name = '$new_value' WHERE $key_name = $entry_ID";

if ($connection->query($sql) === TRUE) {
  echo "Entry updated successfully";
} else {
  echo "Error updating entry: " . $connection->error;
}

$connection->close();
?>