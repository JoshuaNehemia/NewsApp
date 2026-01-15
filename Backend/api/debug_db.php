<?php
header("Content-Type: application/json; charset=UTF-8");
require_once '../APP/config.php';
require_once '../APP/MODELS/CORE/DatabaseConnection.php';

use MODELS\CORE\DatabaseConnection;

try {
    $db = new DatabaseConnection();
    $conn = $db->connect();

    $sql = "DESCRIBE news_images";
    $result = $conn->query($sql);
    
    $columns = [];
    while($row = $result->fetch_assoc()) {
        $columns[] = $row;
    }

    echo json_encode(["status" => "success", "columns" => $columns]);

} catch (Exception $e) {
    echo json_encode(["status" => "error", "message" => $e->getMessage()]);
}
?>
