<?php
require "db.con.php";

$User_id = $_POST["UserId"];

if($_SERVER["REQUEST_METHOD"]=="POST"){

 $query = "SELECT * from `ORDER` Where user_id = '$User_id'";

    try{
        $orders = [];
        $res = mysqli_query($con,$query);
        if(!$res){
               echo "not selected";
        }
        else{   
            
             while($row = mysqli_fetch_array($res)){
                $orders[] = [
                "OrderId" => $row['Order_id'],          
                "TotalPrice" => $row['Total_price'],      
                "Finished" => $row['finished'],
                "OrderName"=>$row['Name'],
            ];
           }
           echo json_encode($orders);
        }
    }
    catch(Exception $e){
        echo json_encode(["error" => $e->getMessage()]);
    }
}

?>