<?php

$con = mysqli_connect("localhost", "root", "") or die("Couldn't connect to server");
try{

    mysqli_select_db($con, "flutter_app_orders") or die("Couldn't find database.");
    
   }
catch(Exception $e){
    echo "Connection Failed".$e->getMessage();
    echo "<br>";
}


?>