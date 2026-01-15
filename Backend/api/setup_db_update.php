<?php
header("Content-Type: application/json; charset=UTF-8");
require_once '../APP/config.php';
require_once '../APP/MODELS/CORE/DatabaseConnection.php';

use MODELS\CORE\DatabaseConnection;

try {
    $db = new DatabaseConnection();
    $conn = $db->connect();

    // 1. Create news_categories table
    $sql = "CREATE TABLE IF NOT EXISTS `news_categories` (
        `id` INT(11) NOT NULL AUTO_INCREMENT,
        `news_id` INT(11) NOT NULL,
        `category_id` INT(11) NOT NULL,
        PRIMARY KEY (`id`),
        KEY `news_id` (`news_id`),
        KEY `category_id` (`category_id`),
        CONSTRAINT `fk_nc_news` FOREIGN KEY (`news_id`) REFERENCES `news` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
        CONSTRAINT `fk_nc_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;";

    if ($conn->query($sql) === TRUE) {
        $msg1 = "Table news_categories created/exists successfully.";
    } else {
        throw new Exception("Error creating table: " . $conn->error);
    }

    // 2. Migrate existing data: Copy category_id from news table to news_categories
    // Only insert if not exists to avoid duplicates on re-run
    $sqlMigrate = "INSERT INTO news_categories (news_id, category_id)
                   SELECT id, category_id FROM news
                   WHERE id NOT IN (SELECT news_id FROM news_categories)";

    if ($conn->query($sqlMigrate) === TRUE) {
        $msg2 = "Data migrated successfully.";
    } else {
        throw new Exception("Error migrating data: " . $conn->error);
    }

    echo json_encode([
        "status" => "success", 
        "messages" => [$msg1, $msg2]
    ]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(["status" => "error", "message" => $e->getMessage()]);
} finally {
    if (isset($conn)) $conn->close();
}
?>
