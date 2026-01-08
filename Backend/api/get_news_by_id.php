<?php
#region HEADER
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
#endregion

#region REQUIRE
require_once '../APP/config.php';
require_once '../APP/REPOSITORY/RepoNews.php';
#endregion

#region USE
use REPOSITORY\RepoNews;
#endregion

#region LOGIC
try {
    if (!isset($_GET['id']) || empty($_GET['id'])) {
        http_response_code(400);
        echo json_encode([
            'status' => 'error',
            'message' => 'Parameter id diperlukan.'
        ]);
        exit();
    }

    $id = (int)$_GET['id'];
    $repo = new RepoNews();
    $news = $repo->findNewsById($id);

    // 3. Cek hasil
    if ($news) {
        echo json_encode([
            'status' => 'success',
            'data' => $news->toArray()
        ]);
    } else {
        http_response_code(404);
        echo json_encode([
            'status' => 'error',
            'message' => 'Berita dengan ID tersebut tidak ditemukan.'
        ]);
    }

} catch (Exception $e) {
    // Error server internal
    http_response_code(500);
    echo json_encode([
        'status' => 'error',
        'message' => $e->getMessage()
    ]);
}
#endregion
?>