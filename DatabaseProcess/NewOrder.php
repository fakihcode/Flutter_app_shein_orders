<?php

require "db.con.php";

if($_SERVER["REQUEST_METHOD"]=="POST"){
    
    $TotalPrice = $_POST["TotalPrice"];
    $finished = $_POST["finished"];
    $User_id = $_POST["Userid"];
    $nameOrder = $_POST["ordername"];

    $query = "INSERT INTO `Order`(`Total_price`,`finished`,`Name`,`user_id`)
     values('$TotalPrice','$finished','$nameOrder', '$User_id')";
     
    
        try{
        mysqli_query($con , $query);
        
        exit();
        
        }
        catch(Exception $e)
        {
            echo "Failed".$e->getMessage();
        }
    
    
    }
    else{
        echo"coundnt access to the method ";
    }
    
?>