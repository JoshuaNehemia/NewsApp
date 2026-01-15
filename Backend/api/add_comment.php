<?php
#region HEADER
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
#endregion

#region PREFLIGHT
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit();
}
#endregion

#region REQUIRE
require_once '../APP/config.php';
require_once '../APP/REPOSITORY/RepoComment.php';
require_once '../APP/MODELS/NEWS/Comment.php';
require_once '../APP/MODELS/NEWS/News.php';
require_once '../APP/MODELS/ACCOUNT/User.php';
#endregion

#region USE
use REPOSITORY\RepoComment;
use MODELS\NEWS\Comment;
use MODELS\NEWS\News;
use MODELS\ACCOUNT\User;
#endregion

$data = json_decode(file_get_contents("php://input"));

if (!empty($data->news_id) && !empty($data->username) && !empty($data->content)) {
    try {
        $newsId = (int)$data->news_id;
        $username = trim($data->username);
        $content = trim($data->content);
        $replyToId = isset($data->reply_to_id) ? (int)$data->reply_to_id : null;

        // Create comment object
        $news = new News();
        $news->setId($newsId);

        $user = new User();
        $user->setUsername($username);

        $comment = new Comment();
        $comment->setNews($news);
        $comment->setUser($user);
        $comment->setContent($content);
        $comment->setReplyToId($replyToId); // Support nested replies

        // Save to database
        $repoComment = new RepoComment();
        $result = $repoComment->createComment($comment);

        if ($result) {
            // Get the newly created comment with user details
            $comments = $repoComment->findCommentByNewsId($newsId, 1, 0);
            
            echo json_encode([
                'status' => 'success',
                'message' => 'Comment added successfully',
                'data' => [
                    'comment' => $comments[0] ?? null
                ]
            ]);
        } else {
            http_response_code(500);
            echo json_encode([
                'status' => 'error',
                'message' => 'Failed to add comment'
            ]);
        }
    } catch (Exception $e) {
        http_response_code(500);
        echo json_encode([
            'status' => 'error',
            'message' => $e->getMessage()
        ]);
    }
} else {
    http_response_code(400);
    echo json_encode([
        'status' => 'error',
        'message' => 'Incomplete data. Required: news_id, username, content'
    ]);
}
?>
