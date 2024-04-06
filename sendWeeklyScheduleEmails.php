<?php

// Database connection
$connection = mysqli_connect("zkc353.encs.concordia.ca", "zkc353_4", "353boyzz", "zkc353_4");

if ($connection->connect_error) {
    die("Connection failed: " . $connection->connect_error);
}

// execute the SQL query and return the results
function getWeeklySchedules($connection) {
    $schedules = [];
    // Assuming your query is stored in $sql
    $sql = "YOUR_SQL_QUERY_HERE";
    $result = $connection->query($sql);

    if ($result->num_rows > 0) {
        while($row = $result->fetch_assoc()) {
            $schedules[] = $row;
        }
    }
    return $schedules;
}

// Email sending function
function sendScheduleEmails($schedules) {
    foreach ($schedules as $schedule) {
        $to = $schedule['Employee_Email'];
        $subject = "Schedule for " . $schedule['Facility_Name'] . " " . // Add date range
        $message = "Facility Name: " . $schedule['Facility_Name'] . "\n";
        $message .= "Address: " . $schedule['Facility_Address'] . "\n";
        $message .= "Role: " . $schedule['Employee_Roles'] . "\n";
        $message .= "Name: " . $schedule['Employee_Name'] . "\n";
        // Add schedule details
        $message .= "Schedule: \n";
        foreach ($schedule['days'] as $day) {
            $message .= $day['day'] . ": " . $day['start'] . " to " . $day['end'] . "\n";
        }

        // PHP mail function to send email
        mail($to, $subject, $message);
    }
}

// Get the schedules from the database
$schedules = getWeeklySchedules($connection);

// Send out the emails
sendScheduleEmails($schedules);

?>
