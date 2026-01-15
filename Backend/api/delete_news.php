<?php
#region HEADER
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
header("Access-Control-Max-Age: 86400");
#endregion

#region HANDLE PREFLIGHT
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}
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
    $data = json_decode(file_get_contents("php://input"));

    if (!isset($data->news_id) || !isset($data->username)) {
        http_response_code(400);
        echo json_encode(['status' => 'error', 'message' => 'Incomplete data. news_id and username required.']);
        exit();
    }

    $repo = new RepoNews();
    
    // Get news author without loading full news object
    $author = $repo->getNewsAuthor($data->news_id);

    if (!$author) {
        http_response_code(404);
        echo json_encode(['status' => 'error', 'message' => 'News not found.']);
        exit();
    }

    // Verify Ownership
    if ($author !== $data->username) {
        http_response_code(403);
        echo json_encode(['status' => 'error', 'message' => 'Unauthorized. You are not the author of this news.']);
        exit();
    }

    // Delete
    if ($repo->deleteNews($data->news_id)) {
        http_response_code(200);
        echo json_encode(['status' => 'success', 'message' => 'News deleted successfully.']);
    } else {
        throw new Exception("Failed to delete news.");
    }

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
}
#endregion
?>
