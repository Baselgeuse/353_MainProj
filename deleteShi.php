<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Schedule Processing</title>
  </head>
  <body align="center">
  <h1>Schedule Processing</h1>
    <table>
    <tr>
      <th>Schedule ID</th>
      <th>Employee SIN</th>
      <th>FID</th>
      <th>Start Date</th>
      <th>End Date</th>
    </tr>
    <?php
    $connection = mysqli_connect("zkc353.encs.concordia.ca", "zkc353_4", "353boyzz", "zkc353_4");
    if($connection->connect_error){ 
      die('Connection Failed ' . $connection->connect_error); 
    } 
    $sql = "SELECT sid, employee_sin, fid, start_date, end_date FROM WorksAt";
    $result = $connection -> query($sql);

    if ($result -> num_rows > 0){
      while ($row = $result -> fetch_assoc()){
        echo "<tr><td>" . $row["sid"] . "</td><td>" . $row["employee_sin"] . "</td><td>" . $row["fid"] . "</td><td>" . $row["start_date"] . "</td><td>" 
        . $row["end_date"] . "</td></tr>";
      }
      echo "</table>";
    }
    else{
      echo "0 result";
    }
    $connection -> close();
    ?>
    <br><br><br>
    <table>
    <tr>
      <th>Start Time</th>
      <th>End Time</th>
      <th>Schedule ID</th>
      <th>Shift ID</th>
    </tr>
    <?php
    $connection = mysqli_connect("zkc353.encs.concordia.ca", "zkc353_4", "353boyzz", "zkc353_4");
    if($connection->connect_error){ 
      die('Connection Failed ' . $connection->connect_error); 
    } 
    $sql = "SELECT start, end, sid, shift_id FROM Shift";
    $result = $connection -> query($sql);

    if ($result -> num_rows > 0){
      while ($row = $result -> fetch_assoc()){
        echo "<tr><td>" . $row["start"] . "</td><td>" . $row["end"] . "</td><td>" . $row["sid"] . "</td><td>" . $row["shift_id"] . "</td></tr>";
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
        <input type="hidden" name="table_name" value="Shift">
        <input type="hidden" name="key_name" value="sid">
        Enter Schedule ID of the entry to delete: <input type="text" name="entry_id"><br>
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