<?php
header("Content-Type: application/json; charset=UTF-8");
require_once '../APP/config.php';
require_once '../APP/MODELS/CORE/DatabaseConnection.php';

use MODELS\CORE\DatabaseConnection;

try {
    $db = new DatabaseConnection();
    $conn = $db->connect();

    $sql = "SELECT * FROM categories";
    $result = $conn->query($sql);
    
    $cats = [];
    while($row = $result->fetch_assoc()) {
        $cats[] = $row;
    }

    echo json_encode(["status" => "success", "categories" => $cats]);

} catch (Exception $e) {
    echo json_encode(["status" => "error", "message" => $e->getMessage()]);
}
?>
