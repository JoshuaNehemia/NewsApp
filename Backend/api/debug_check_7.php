<?php
header("Content-Type: application/json; charset=UTF-8");
require_once '../APP/config.php';
require_once '../APP/MODELS/CORE/DatabaseConnection.php';

use MODELS\CORE\DatabaseConnection;

try {
    $db = new DatabaseConnection();
    $conn = $db->connect();

    // Get ID 7 (or latest)
    $sql = "SELECT * FROM news_categories WHERE news_id = 7";
    $res = $conn->query($sql);
    
    echo "News 7 Categories:\n";
    while($row = $res->fetch_assoc()) {
        echo " - Cat ID: " . $row['category_id'] . "\n";
    }

} catch (Exception $e) {
    echo "Error: " . $e->getMessage();
}
?>
