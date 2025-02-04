<?php
require "db.con.php";

$order_id = $_POST["Order_id"];

if($_SERVER["REQUEST_METHOD"]=="POST"){

 $query = "SELECT * from `clients` Where Order_id = '$order_id'";

    try{
        $clients = [];
        $res = mysqli_query($con,$query);
        if(!$res){
               echo "not selected";
        }
        else{   
            
             while($row = mysqli_fetch_array($res)){
                $clients[] = [
                "clientname" => $row['Name'],          
                "personid" => $row['PersonId'],      
                "clientamount" => $row['cost'],
                "cheked"=>$row['paid'],
            ];
           }
           echo json_encode($clients);
        }
    }
    catch(Exception $e){
        echo json_encode(["error" => $e->getMessage()]);
    }
}

?>