<?php

require "db.con.php";

    $Email = $_POST["email"];
    $Password =$_POST["password"];
    $user_id;

    if ($_SERVER["REQUEST_METHOD"]=="POST") {
    try{
        $query = "SELECT * FROM users WHERE email = '$Email' AND password = '$Password'";
        $result = mysqli_query($con, $query);
        if ($result) {
            $row = mysqli_fetch_assoc($result); 
            if ($row) {
               $user_id = $row["user_id"];
            } else {
                echo "Invalid email or password.";
            }
            echo json_encode($user_id);
        }
       }
       catch(Exception $e){
        echo "error". $e->getMessage();
       }
    }
    
?>