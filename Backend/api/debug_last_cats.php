<?php
header("Content-Type: application/json; charset=UTF-8");
require_once '../APP/config.php';
require_once '../APP/MODELS/CORE/DatabaseConnection.php';

use MODELS\CORE\DatabaseConnection;

try {
    $db = new DatabaseConnection();
    $conn = $db->connect();

    // 1. Get last news
    $sqlNews = "SELECT id, title FROM news ORDER BY id DESC LIMIT 1";
    $res = $conn->query($sqlNews);
    $lastNews = $res->fetch_assoc();

    if (!$lastNews) {
        throw new Exception("No news found");
    }

    $newsId = $lastNews['id'];

    // 2. Get categories
    $sqlCats = "SELECT * FROM news_categories WHERE news_id = $newsId";
    $resCats = $conn->query($sqlCats);
    $cats = [];
    while($row = $resCats->fetch_assoc()) {
        $cats[] = $row;
    }

    echo json_encode([
        "last_news" => $lastNews,
        "categories_count" => count($cats),
        "categories" => $cats
    ]);

} catch (Exception $e) {
    echo json_encode(["status" => "error", "message" => $e->getMessage()]);
}
?>
