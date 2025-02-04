<?php

require "db.con.php";

if($_SERVER["REQUEST_METHOD"]=="POST"){
    
    $amount = $_POST["amount"];
    $finished = $_POST["finished"];
    $Order_id = $_POST["orderid"];
    $clientname = $_POST["clientname"];

    $query = "INSERT INTO `clients`(`Name`,`Order_id`,`Cost`,`paid`)
     values('$clientname','$Order_id','$amount', '$finished')";
     

     $query1 = "UPDATE `order` SET `Total_price` = `Total_price` + $amount WHERE `Order_id` = $Order_id";
     
    
        try{
        mysqli_query($con , $query);
        mysqli_query($con, $query1);
        
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