<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Facilities</title>
  </head>
  <body align="center">
  <h1>People</h1>
    <table>
    <tr>
      <th>SIN</th>
      <th>MID</th>
      <th>First Name</th>
      <th>Last Name</th>
      <th>Email</th>
      <th>Date of Birth</th>
      <th>Phone Number</th>
      <th>Citizenship</th>
      <th>RID</th>
    </tr>
    <?php
    $connection = mysqli_connect("zkc353.encs.concordia.ca", "zkc353_4", "353boyzz", "zkc353_4");
    if($connection->connect_error){ 
      die('Connection Failed ' . $connection->connect_error); 
    } 
    $sql = "SELECT SIN, MID, fname, lname, email, DOB, phone_number, citizenship, rid FROM Person";
    $result = $connection -> query($sql);

    if ($result -> num_rows > 0){
      while ($row = $result -> fetch_assoc()){
        echo "<tr><td>" . $row["SIN"] . "</td><td>" . $row["MID"] . "</td><td>" . $row["fname"] . "</td><td>" . $row["lname"] . "</td><td>" 
        . $row["email"] . "</td><td>" . $row["DOB"] . "</td><td>" . $row["phone_number"] . "</td><td>" . $row["citizenship"] . "</td><td>" 
        . $row["rid"] . "</td></tr>";
      }
      echo "</table>";
    }
    else{
      echo "0 result";
    }
    $connection -> close();
    ?>
    <br><br><br>
    <form action="insertPerEntry.php" method="post">
        SIN: <input type="text" name="SIN"><br>
        MID: <input type="text" name="MID"><br>
        First Name: <input type="text" name="fname"><br>
        Last Name: <input type="text" name="lname"><br>
        Email: <input type="text" name="email"><br>
        Date of Birth: <input type="text" name="DOB"><br>
        Phone Number: <input type="text" name="phone_number"><br>
        Citizenship: <input type="text" name="citizenship"><br>
        RID: <input type="text" name="RID"><br>
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