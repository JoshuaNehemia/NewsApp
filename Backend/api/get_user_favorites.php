<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

require_once '../APP/config.php';
require_once '../APP/REPOSITORY/RepoNews.php';

use REPOSITORY\RepoNews;

try {
    $username = isset($_GET['username']) ? $_GET['username'] : '';
    
    if (empty($username)) {
        http_response_code(400);
        echo json_encode([
            'status' => 'error',
            'message' => 'Username is required'
        ]);
        exit;
    }

    $repo = new RepoNews();
    $favorites = $repo->findNewsByUserLikes($username);

    echo json_encode([
        'status' => 'success',
        'data' => $favorites
    ]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'status' => 'error',
        'message' => $e->getMessage()
    ]);
}
?>
