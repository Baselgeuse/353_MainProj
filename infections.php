<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Infections</title>
  </head>
  <body align="center">
    <h1>Infections</h1>
    <table>
    <tr>
      <th>Person SIN</th>
      <th>Variant Type</th>
      <th>Date</th>
    </tr>
    <?php
    $connection = mysqli_connect("zkc353.encs.concordia.ca", "zkc353_4", "353boyzz", "zkc353_4");
    if($connection->connect_error){ 
      die('Connection Failed ' . $connection->connect_error); 
    } 
    $sql = "SELECT person_sin, variantType, date FROM Infected";
    $result = $connection -> query($sql);

    if ($result -> num_rows > 0){
      while ($row = $result -> fetch_assoc()){
        echo "<tr><td>" . $row["person_sin"] . "</td><td>" . $row["variantType"] . "</td><td>" . $row["date"] . "</td></tr>";
      }
      echo "</table>";
    }
    else{
      echo "0 result";
    }
    $connection -> close();
    ?>
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
    </style>
  </body>
</html>
