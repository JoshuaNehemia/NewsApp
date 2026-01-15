<?php
header("Content-Type: application/json; charset=UTF-8");
require_once '../APP/config.php';
require_once '../APP/MODELS/CORE/DatabaseConnection.php';

use MODELS\CORE\DatabaseConnection;

try {
    $db = new DatabaseConnection();
    $conn = $db->connect();

    // 1. Get last news
    $sqlNews = "SELECT id, title, category_id FROM news ORDER BY id DESC LIMIT 1";
    $res = $conn->query($sqlNews);
    $lastNews = $res->fetch_assoc();

    if (!$lastNews) {
        throw new Exception("No news found");
    }

    $newsId = $lastNews['id'];

    // 2. Get categories from news_categories
    $sqlCats = "SELECT * FROM news_categories WHERE news_id = $newsId";
    $resCats = $conn->query($sqlCats);
    $cats = [];
    while($row = $resCats->fetch_assoc()) {
        $cats[] = $row;
    }

    // 3. Test aggregate query
    $sqlAgg = "SELECT GROUP_CONCAT(c.name SEPARATOR ',') as names 
               FROM news_categories nc 
               JOIN categories c ON nc.category_id = c.id 
               WHERE nc.news_id = $newsId";
    $resAgg = $conn->query($sqlAgg);
    $agg = $resAgg->fetch_assoc();

    echo json_encode([
        "last_news" => $lastNews,
        "news_categories_rows" => $cats,
        "aggregated_names" => $agg
    ]);

} catch (Exception $e) {
    echo json_encode(["status" => "error", "message" => $e->getMessage()]);
}
?>
