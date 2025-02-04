<?php

    require "db.con.php";
    
    if($_SERVER["REQUEST_METHOD"] == "POST"){

        
    $Emailcontroller = $_POST["email"];
    $PasswordController = $_POST["password"];

        try {
            $query = "INSERT into users(`email`, `password`) Values('$Emailcontroller','$PasswordController')";
            if (mysqli_query($con, $query)) {
                echo "User created successfully.";
            } else {
                echo "Error: " . mysqli_error($con);
            }

        }
        catch(Exception $e){
            echo "Eror WHile creating a new User ". $e->getMessage();
        }
    }
    else{
        echo"coundent acces to form";
    }

?>