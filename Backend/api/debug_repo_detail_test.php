<?php
header("Content-Type: application/json; charset=UTF-8");
require_once '../APP/config.php';
require_once '../APP/REPOSITORY/RepoNews.php';

use REPOSITORY\RepoNews;

try {
    $repo = new RepoNews();
    $news = $repo->findNewsById(9); // ID 9 is "d" which has 3 cats
    
    if ($news) {
        echo json_encode([
            "id" => $news->getId(),
            "title" => $news->getTitle(),
            "categories" => $news->getCategories()
        ]);
    } else {
        echo json_encode(["status" => "noth found"]);
    }

} catch (Exception $e) {
    echo json_encode(["error" => $e->getMessage()]);
}
?>
