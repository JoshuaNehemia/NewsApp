<?php
header("Content-Type: application/json; charset=UTF-8");
require_once '../APP/config.php';
require_once '../APP/MODELS/CORE/DatabaseConnection.php';

use MODELS\CORE\DatabaseConnection;

try {
    $db = new DatabaseConnection();
    $conn = $db->connect();

    // Check if image_path exists
    $checkSql = "SHOW COLUMNS FROM `news_images` LIKE 'image_path'";
    $result = $conn->query($checkSql);
    
    $messages = [];

    if ($result->num_rows == 0) {
        $sql = "ALTER TABLE `news_images` ADD COLUMN `image_path` VARCHAR(500) NULL AFTER `news_id`";
        if ($conn->query($sql) === TRUE) {
            $messages[] = "Added image_path column.";
        } else {
            throw new Exception("Error adding image_path: " . $conn->error);
        }
    } else {
        $messages[] = "image_path already exists.";
    }

    echo json_encode(["status" => "success", "messages" => $messages]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(["status" => "error", "message" => $e->getMessage()]);
} finally {
    if (isset($conn)) $conn->close();
}
?>
