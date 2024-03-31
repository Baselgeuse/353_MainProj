<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Facilities</title>
  </head>
  <body align="center">
  <h1>Residences</h1>
    <table>
    <tr>
      <th>RID</th>
      <th>Address</th>
      <th>City</th>
      <th>Province</th>
      <th>Postal Code</th>
      <th>Phone Number</th>
      <th>Room Count</th>
      <th>Residence Type</th>
    </tr>
    <?php
    $connection = mysqli_connect("zkc353.encs.concordia.ca", "zkc353_4", "353boyzz", "zkc353_4");
    if($connection->connect_error){ 
      die('Connection Failed ' . $connection->connect_error); 
    } 
    $sql = "SELECT rid, address, city, province, postal_code, phone_number, room_count, residence_type FROM Residence";
    $result = $connection -> query($sql);

    if ($result -> num_rows > 0){
      while ($row = $result -> fetch_assoc()){
        echo "<tr><td>" . $row["rid"] . "</td><td>" . $row["address"] . "</td><td>" . $row["city"] . "</td><td>" . $row["province"] . "</td><td>" 
        . $row["postal_code"] . "</td><td>" . $row["phone_number"] . "</td><td>" . $row["room_count"] . "</td><td>" . $row["residence_type"] . "</td></tr>";
      }
      echo "</table>";
    }
    else{
      echo "0 result";
    }
    $connection -> close();
    ?>
    <br><br><br>
    <form action="insertResEntry.php" method="post">
        RID: <input type="text" name="RID"><br>
        Address: <input type="text" name="address"><br>
        City: <input type="text" name="city"><br>
        Province: <input type="text" name="province"><br>
        Postal Code: <input type="text" name="postal_code"><br>
        Phone Number: <input type="text" name="phone_number"><br>
        Room Count: <input type="text" name="room_count"><br>
        Residence Type: <input type="text" name="residence_type"><br>
        <input type="submit" value="Submit">
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