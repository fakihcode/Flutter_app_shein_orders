<?php

    require "db.con.php";
    
    if($_SERVER["REQUEST_METHOD"] == "POST"){

        
    $orderComplitation = $_POST["finished"]; 
    $order_id = $_POST["orderId"];
  

        try {
            $query = "UPDATE `order` SET `finished`='$orderComplitation' WHERE `Order_id` = '$order_id'; 
            if (mysqli_query($con, $query)) {
                echo "$order_id changed correctly ";
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