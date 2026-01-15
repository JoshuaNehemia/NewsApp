<?php
#region HEADER
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
#endregion

#region REQUIRE
require_once '../APP/config.php';
require_once '../APP/REPOSITORY/RepoComment.php';
#endregion

#region USE
use REPOSITORY\RepoComment;
#endregion

#region LOGIC
try {
    if (!isset($_GET['news_id']) || empty($_GET['news_id'])) {
        http_response_code(400);
        echo json_encode([
            'status' => 'error',
            'message' => 'Parameter news_id required.'
        ]);
        exit();
    }

    $newsId = (int)$_GET['news_id'];
    $limit = isset($_GET['limit']) ? (int)$_GET['limit'] : 100;
    $offset = isset($_GET['offset']) ? (int)$_GET['offset'] : 0;

    $repoComment = new RepoComment();
    
    // Get ALL comments (including replies) for this news
    $comments = $repoComment->getAllComments($newsId, $limit, $offset);

    // Convert Comment objects to arrays
    $commentsArray = [];
    foreach ($comments as $comment) {
        $commentsArray[] = [
            'id' => $comment->getId(),
            'username' => $comment->getUser()->getUsername(),
            'fullname' => $comment->getUser()->getFullname(),
            'content' => $comment->getContent(),
            'created_at' => $comment->getCreatedAt(),
            'reply_to_id' => $comment->getReplyToId() // Include for hierarchy
        ];
    }

    echo json_encode([
        'status' => 'success',
        'data' => $commentsArray,
        'count' => count($commentsArray)
    ]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'status' => 'error',
        'message' => $e->getMessage()
    ]);
}
#endregion
?>
