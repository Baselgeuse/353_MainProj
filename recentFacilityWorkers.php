<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Facilities</title>
  </head>
  <body align="center">
  <h1>Facility's workers in the past 2 weeks</h1>
    <table>
    <tr>
      <th>First name</th>
      <th>last name</th>
      <th>Role</th>
      <th>Number Secondary Residences</th>
    </tr>
    <?php
    $connection = mysqli_connect("zkc353.encs.concordia.ca", "zkc353_4", "353boyzz", "zkc353_4");
    if($connection->connect_error){ 
      die('Connection Failed ' . $connection->connect_error); 
    } 


    $facility_name = ""; // Initialize the variable to hold the facility name

    if ($_SERVER["REQUEST_METHOD"] == "POST") {
      $facility_name = $_POST["entry_id"]; // Retrieve the facility name from the form
    }

    $sql = "SELECT 
    p.fname AS first_name,
    p.lname AS last_name,
    CASE
        WHEN d.doctor_sin IS NOT NULL THEN 'Doctor'
        WHEN ph.pharmacist_sin IS NOT NULL THEN 'Pharmacist'
        WHEN n.nurse_sin IS NOT NULL THEN 'Nurse'
        WHEN r.receptionist_sin IS NOT NULL THEN 'Receptionist'
        WHEN c.cashier_sin IS NOT NULL THEN 'Cashier'
        WHEN a.administrative_sin IS NOT NULL THEN 'Administrative'
        WHEN s.security_sin IS NOT NULL THEN 'Security'
        ELSE 'Unknown'
    END AS role,
    COUNT(DISTINCT sw.rid) AS number_of_secondary_residences
    FROM Person p
    LEFT JOIN Doctor d ON p.SIN = d.doctor_sin
    LEFT JOIN Pharmacist ph ON p.SIN = ph.pharmacist_sin
    LEFT JOIN Nurse n ON p.SIN = n.nurse_sin
    LEFT JOIN Receptionist r ON p.SIN = r.receptionist_sin
    LEFT JOIN Cashier c ON p.SIN = c.cashier_sin
    LEFT JOIN Administrative a ON p.SIN = a.administrative_sin
    LEFT JOIN Security s ON p.SIN = s.security_sin
    Right JOIN Secondary sw ON p.SIN = sw.sin
    JOIN Schedule sch ON p.SIN = sch.employee_sin
    JOIN Shift ON sch.sid = Shift.sid
    WHERE 
      sch.sid IN (SELECT sid FROM Shift WHERE start >= DATE_SUB(CURDATE(), INTERVAL 2 WEEK))
      AND sch.fid = (SELECT fid FROM Facility WHERE Facility.name = '$facility_name') 
    GROUP BY p.SIN
    HAVING COUNT(DISTINCT sw.rid) >= 3
    ORDER BY role ASC, number_of_secondary_residences ASC;";

    $result = $connection -> query($sql);

    if ($result -> num_rows > 0){
      while ($row = $result -> fetch_assoc()){
        echo "<tr><td>" . $row["first_name"] .  "</td><td>" . $row["last_name"] .  "</td><td>" . $row["role"] .  "</td><td>" . $row["number_of_secondary_residences"] .  "</td></tr>";
      }
      echo "</table>";
    }
    else{
      echo "0 result";
    }
    $connection -> close();
    ?>
    <br><br><br>
    <form  method="post">
        Enter the facility name you want to get recent workers for: <input type="text" name="entry_id"><br>
        <input type="submit" value="Get workers">
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