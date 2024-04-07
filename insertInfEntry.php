<?php

$connection = mysqli_connect("zkc353.encs.concordia.ca", "zkc353_4", "353boyzz", "zkc353_4");

if ($connection->connect_error) { 
    die('Connection Failed ' . $connection->connect_error); 
}

$person_sin = $_POST['person_sin'];
$variantType = $_POST['variantType'];
$date = $_POST['date'];

$twoWeeksLater = date('Y-m-d', strtotime($date . ' + 2 weeks'));

$sql = "INSERT INTO Infected (person_sin, variantType, date) VALUES ('$person_sin', '$variantType', '$date');";
$sql .= "DELETE FROM Shift WHERE start >= '$date' AND start < '$twoWeeksLater';";

if ($connection->multi_query($sql)) {
    do {
        if ($result = $connection->store_result()) {
            $result->free();
        }
    } while ($connection->more_results() && $connection->next_result());
} else {
    echo "Error executing query: " . $connection->error;
}

$sql1 = "SELECT Facility.name AS sender_name,
                (SELECT GROUP_CONCAT(Person.email SEPARATOR ', ')
                 FROM Person
                 JOIN Schedule ON Person.SIN = Schedule.employee_sin
                 JOIN Facility ON Schedule.fid = Facility.fid
                 WHERE Facility.name = sender_name) AS receiver_emails
         FROM Person
         JOIN Schedule ON Person.SIN = Schedule.employee_sin
         JOIN Facility ON Schedule.fid = Facility.fid
         WHERE Person.SIN = '$person_sin'";

$result = mysqli_query($connection, $sql1);

if ($result) {
    while ($row = mysqli_fetch_assoc($result)) {
        $senderName = $row['sender_name'];
        $receiverEmails = $row['receiver_emails'];
    }
} else {
    echo "Error executing query: " . mysqli_error($connection);
}

mysqli_free_result($result);

$sql2 = "INSERT INTO EmailLog(log_date, sender_fac, receiver_email, subject, body) VALUES ('$date', '$senderName', '$receiverEmails', 'Warning', 'One of your colleagues with whom you worked in the past two weeks has been infected with COVID-19');";

if ($connection->query($sql2) === TRUE) {
    echo "New record created successfully";
} else {
    echo "Error: " . $sql2 . "<br>" . $connection->error;
}

$connection->close();
?>