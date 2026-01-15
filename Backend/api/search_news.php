<?php
#region HEADER
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
#endregion

#region REQUIRE
require_once '../APP/config.php';
require_once '../APP/MODELS/CORE/DatabaseConnection.php';
#endregion

#region USE
use MODELS\CORE\DatabaseConnection;
#endregion

#region LOGIC
try {
    if (!isset($_GET['query']) || empty(trim($_GET['query']))) {
        http_response_code(400);
        echo json_encode([
            'status' => 'error',
            'message' => 'Parameter query required.'
        ]);
        exit();
    }

    $query = trim($_GET['query']);
    $limit = isset($_GET['limit']) ? (int)$_GET['limit'] : 20;
    $offset = isset($_GET['offset']) ? (int)$_GET['offset'] : 0;

    $db = new DatabaseConnection();
    $conn = $db->connect();

    // Search by title using LIKE
    $imageBaseUrl = IMAGE_DATABASE_ADDRESS;
    $sql = "SELECT 
                n.id,
                n.title,
                n.slug,
                LEFT(n.content, 200) as excerpt,
                n.created_at,
                c.name as category,
                a.fullname as author,
                COALESCE(img.image_url, '') as image
            FROM news n
            LEFT JOIN categories c ON n.category_id = c.id
            LEFT JOIN writers w ON n.writer_username = w.username
            LEFT JOIN accounts a ON w.username = a.username
            LEFT JOIN (
                SELECT news_id, CONCAT('{$imageBaseUrl}', id, '.', image_ext) as image_url
                FROM news_images
                WHERE position = 0
            ) img ON n.id = img.news_id
            WHERE n.title LIKE ?
            ORDER BY n.created_at DESC
            LIMIT ? OFFSET ?";

    $stmt = $conn->prepare($sql);
    if (!$stmt) {
        throw new Exception("Failed to prepare search query");
    }

    $searchTerm = "%{$query}%";
    $stmt->bind_param("sii", $searchTerm, $limit, $offset);

    if (!$stmt->execute()) {
        throw new Exception("Failed to execute search: " . $stmt->error);
    }

    $result = $stmt->get_result();
    $news = [];

    while ($row = $result->fetch_assoc()) {
        $news[] = [
            'id' => $row['id'],
            'title' => $row['title'],
            'slug' => $row['slug'],
            'excerpt' => $row['excerpt'] . '...',
            'created_at' => $row['created_at'],
            'category' => $row['category'],
            'author' => $row['author'],
            'image' => $row['image'] ?: 'assets/images/placeholder.jpg'
        ];
    }

    echo json_encode([
        'status' => 'success',
        'data' => $news,
        'count' => count($news),
        'query' => $query
    ]);

    $stmt->close();
    $conn->close();

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'status' => 'error',
        'message' => $e->getMessage()
    ]);
}
#endregion
?>
