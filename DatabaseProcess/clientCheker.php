<?php
require "db.con.php";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $clientComplitation = isset($_POST["cheked"]) ? $_POST["cheked"] : null; 
    $PersonId = isset($_POST["PersonId"]) ? $_POST["PersonId"] : null;

    // Sanitize inputs
    $clientComplitation = $clientComplitation === '1' ? 1 : 0; // Convert to integer
    $PersonId = intval($PersonId); // Convert to integer for safety

    if ($PersonId) {
        $stmt = $con->prepare("UPDATE `clients` SET `paid`=? WHERE `PersonId`=?");
        $stmt->bind_param("ii", $clientComplitation, $PersonId);

        if ($stmt->execute()) {
            echo "$PersonId changed correctly.";
        } else {
            echo "Error: " . $stmt->error;
        }

        $stmt->close();
    } else {
        echo "Invalid PersonId.";
    }
} else {
    echo "Couldn't access the form.";
}
?>
