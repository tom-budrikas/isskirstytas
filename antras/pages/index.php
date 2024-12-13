<?php
    require_once '/php/vendor/autoload.php';
    $client = new MongoDB\Client("mongodb://root:root@mongo:27017/");
    $collection = $client->mano_db->mano_duomenys;
    $mongo_res = $collection->findOne(['id' => 1]);

    $conn = new PDO("mysql:host=mysql;dbname=mysql_db", "root", "root");
    $query = $conn->prepare("SELECT * FROM `test` WHERE `id` = 1");
    $query->execute();
    $mysql_res = $query->fetchObject()
?>  
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <?php 
        echo $mongo_res->data;
        echo "<br>";
        echo $mysql_res->data;
     ?>
</body>
</html>