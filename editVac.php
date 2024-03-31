<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Facilities</title>
  </head>
  <body align="center">
  <h1>Vaccinations</h1>
    <table>
    <tr>
      <th>Person SIN</th>
      <th>Dose Number</th>
      <th>Vaccine Type</th>
      <th>Date</th>
      <th>FID</th>
    </tr>
    <?php
    $connection = mysqli_connect("zkc353.encs.concordia.ca", "zkc353_4", "353boyzz", "zkc353_4");
    if($connection->connect_error){ 
      die('Connection Failed ' . $connection->connect_error); 
    } 
    $sql = "SELECT person_sin, dose_number, vaccine_type, date, fid FROM Vaccinated";
    $result = $connection -> query($sql);

    if ($result -> num_rows > 0){
      while ($row = $result -> fetch_assoc()){
        echo "<tr><td>" . $row["person_sin"] . "</td><td>" . $row["dose_number"] . "</td><td>" . $row["vaccine_type"] . "</td><td>" . $row["date"] . "</td><td>" 
        . $row["fid"] . "</td></tr>";
      }
      echo "</table>";
    }
    else{
      echo "0 result";
    }
    $connection -> close();
    ?>
    <br><br><br>
    <form action="edit_entry.php" method="post">
        <input type="hidden" name="table_name" value="Vaccinated">
        <input type="hidden" name="key_name" value="person_sin">
        Enter SIN of the entry to edit: <input type="text" name="entry_id"><br>
        Enter the attribute you would like to edit: <input type="text" name="column_name"><br>
        New value: <input type="text" name="new_value"><br>
        <input type="submit" value="Edit Entry">
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