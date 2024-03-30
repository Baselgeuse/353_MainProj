<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Facilities</title>
  </head>
  <body align="center">
    <h1>Facilities</h1>
    <table>
    <tr>
      <th>FID</th>
      <th>Name</th>
      <th>Address</th>
      <th>City</th>
      <th>Province</th>
      <th>Postal Code</th>
      <th>Phone Number</th>
      <th>Web Address</th>
      <th>Facility Type</th>
      <th>Manager SIN</th>
      <th>Capacity</th>
    </tr>
    <?php
    $connection = mysqli_connect("zkc353.encs.concordia.ca", "zkc353_4", "353boyzz", "zkc353_4");
    if($connection->connect_error){ 
      die('Connection Failed ' . $connection->connect_error); 
    } 
    $sql = "SELECT fid, name, address, city, province, postal_code, phone_number, web_address, facility_type, manager_sin, capacity FROM Facility";
    $result = $connection -> query($sql);

    if ($result -> num_rows > 0){
      while ($row = $result -> fetch_assoc()){
        echo "<tr><td>" . $row["fid"] . "</td><td>" . $row["name"] . "</td><td>" . $row["address"] . "</td><td>" . $row["city"] . "</td><td>" . $row["province"] . "</td><td>" 
        . $row["postal_code"] . "</td><td>" . $row["phone_number"] . "</td><td>" . $row["web_address"] . "</td><td>" . $row["facility_type"] . "</td><td>" 
        . $row["manager_sin"] . "</td><td>" . $row["capacity"] . "</td></tr>";
      }
      echo "</table>";
    }
    else{
      echo "0 result";
    }
    $connection -> close();
    ?>
    <br><br><br>
    <form action="delete_entry.php" method="post">
        <input type="hidden" name="table_name" value="Facility">
        <input type="hidden" name="key_name" value="FID">
        Enter FID of the entry to delete: <input type="text" name="entry_id"><br>
        <br>
        <input type="submit" value="Delete Entry">
    </form>
    <style>
      h1 {
        background-color: antiquewhite;
        padding-top: 25px;
        padding-bottom: 25px;
        border: 2px solid black;
      }
      body {
        font-family: sans-serif;
      }
      table {
        border-collapse: collapse;
        width: 100%;
        color: #d66459;
        font-family: monospace;
        font-size: 20px;
        text-align: left;
      }
      th{
        background-color: #d96459;
        color: white;
      }
      a, form{
        background-color: #d66459;
      }
      a,
      a:hover, form, form:hover {
        display:inline-block;
        width: 30%;
        padding-top: 15px;
        padding-bottom: 15px;
        border-radius: 25px;
        border: 2px solid black;
        font-size:large;
        margin-top: 5px;
        margin-bottom: 5px;
        text-decoration: none;
      }
    </style>
  </body>
</html>