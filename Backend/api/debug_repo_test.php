<?php
header("Content-Type: application/json; charset=UTF-8");
require_once '../APP/config.php';
require_once '../APP/REPOSITORY/RepoNews.php';

use REPOSITORY\RepoNews;

try {
    $repo = new RepoNews();
    // Assuming '3' is Entertainment and user has news there.
    // We check the first result (which should be the latest news created)
    $newsList = $repo->findNewsByCategoryId(3, 10, 0);
    
    // We only care about the latest news
    $latest = $newsList[0] ?? null;
    
    if ($latest) {
        echo json_encode([
            "id" => $latest['id'],
            "title" => $latest['title'],
            "categories" => $latest['categories']
        ]);
    } else {
        echo json_encode(["status" => "empty"]);
    }

} catch (Exception $e) {
    echo json_encode(["error" => $e->getMessage()]);
}
?>
