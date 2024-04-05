<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Facilities</title>
  </head>
  <body align="center">
  <h1>Recently Infected Doctors</h1>
    <table>
    <tr>
      <th>First name</th>
      <th>last name</th>
      <th>Date of infection</th>
      <th>Facility name</th>
      <th>Number of secondary residences</th>
    </tr>
    <?php
    $connection = mysqli_connect("zkc353.encs.concordia.ca", "zkc353_4", "353boyzz", "zkc353_4");
    if($connection->connect_error){ 
      die('Connection Failed ' . $connection->connect_error); 
    } 

    $sql = "SELECT 
    p.fname AS first_name,
    p.lname AS last_name,
    i.date AS date_of_infection,
    f.name AS facility_name,
    COUNT(sw.rid) AS number_of_secondary_residences
    FROM Doctor d
    JOIN Person p ON p.SIN = d.doctor_sin
    JOIN Infected i ON p.SIN = i.person_sin
    JOIN Facility f ON p.rid = f.fid
    JOIN Schedule s ON d.doctor_sin = s.employee_sin
    LEFT JOIN Secondary sw ON p.SIN = sw.sin
    WHERE i.date >= DATE_SUB(CURDATE(), INTERVAL 2 WEEK) 
    GROUP BY p.SIN, i.date
    ORDER BY f.name ASC, number_of_secondary_residences ASC;";

    $result = $connection -> query($sql);

    if ($result -> num_rows > 0){
      while ($row = $result -> fetch_assoc()){
        echo "<tr><td>" . $row["first_name"] .  "</td><td>" . $row["last_name"] .  "</td><td>" . $row["date_of_infection"] . "</td><td>" . $row["facility_name"] .  "</td><td>" . $row["number_of_secondary_residences"] .  "</td></tr>";
      }
      echo "</table>";
    }
    else{
      echo "0 result";
    }
    $connection -> close();
    ?>
    <br><br><br>
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