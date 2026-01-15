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
require_once '../APP/REPOSITORY/RepoRate.php';
#endregion

#region USE
use REPOSITORY\RepoRate;
#endregion

$data = json_decode(file_get_contents("php://input"));

if (!empty($data->news_id) && !empty($data->username) && isset($data->rate)) {
    try {
        $newsId = (int)$data->news_id;
        $username = trim($data->username);
        $rate = (int)$data->rate;

        // Validate rating range
        if ($rate < 1 || $rate > 5) {
            http_response_code(400);
            echo json_encode([
                'status' => 'error',
                'message' => 'Rating must be between 1 and 5'
            ]);
            exit();
        }

        $repoRate = new RepoRate();
        
        // Check if user already rated this news
        $existingRate = $repoRate->getUserRate($newsId, $username);
        
        if ($existingRate !== null) {
            // Update existing rating
            $repoRate->updateRate($newsId, $username, $rate);
        } else {
            // Create new rating
            $repoRate->create($newsId, $username, $rate);
        }

        // Get updated average rating
        $avgRating = $repoRate->findRateByNewsId($newsId);

        echo json_encode([
            'status' => 'success',
            'message' => 'Rating saved successfully',
            'data' => [
                'user_rate' => (float)$rate,
                'avg_rating' => $avgRating
            ]
        ]);

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
        'message' => 'Incomplete data. Required: news_id, username, rate'
    ]);
}
?>
