<?php
namespace REPOSITORY;

#region REQUIRE
require_once(__DIR__ . "/../MODELS/CORE/DatabaseConnection.php");
#endregion

#region USE
use MODELS\CORE\DatabaseConnection;
use Exception;
#endregion

class RepoRate
{
    #region FIELDS
    private DatabaseConnection $db;
    #endregion

    #region CONSTRUCTOR
    public function __construct()
    {
        $this->db = new DatabaseConnection();
    }
    #endregion

    #region CREATE
    public function create(int $newsId, string $username, int $rating): bool
    {
        if ($rating < 1 || $rating > 5) {
            throw new Exception("Rating must be between 1 and 5");
        }

        $sql = "
            INSERT INTO rates (news_id, username, rating)
            VALUES (?, ?, ?)
        ";

        $conn = $this->db->connect();
        $stmt = $conn->prepare($sql);

        if (!$stmt) {
            throw new Exception("Failed to prepare rate insert statement");
        }

        $stmt->bind_param("isi", $newsId, $username, $rating);

        if (!$stmt->execute()) {
            throw new Exception("Failed to create rate: " . $stmt->error);
        }

        return true;
    }
    #endregion

    #region RETRIEVE

    public function getAverageRatingByNews(int $newsId): float
    {
        $sql = "
            SELECT COALESCE(AVG(rate), 0) AS avg_rating
            FROM rates
            WHERE news_id = ?
        ";

        $conn = $this->db->connect();
        $stmt = $conn->prepare($sql);

        $stmt->bind_param("i", $newsId);
        $stmt->execute();

        $result = $stmt->get_result()->fetch_assoc();
        return (float)$result['avg_rating'];
    }
    #endregion

    /* =========================================================
     * UPDATE
     * ========================================================= */
    #region UPDATE
    public function update(int $newsId, string $username, int $rating): bool
    {
        if ($rating < 1 || $rating > 5) {
            throw new Exception("Rating must be between 1 and 5");
        }

        $sql = "
            UPDATE rates
            SET rating = ?
            WHERE news_id = ? AND username = ?
        ";

        $conn = $this->db->connect();
        $stmt = $conn->prepare($sql);

        $stmt->bind_param("iis", $rating, $newsId, $username);

        if (!$stmt->execute()) {
            throw new Exception("Failed to update rate: " . $stmt->error);
        }

        return $stmt->affected_rows > 0;
    }
    #endregion

    /* =========================================================
     * DELETE
     * ========================================================= */
    #region DELETE
    public function delete(int $newsId, string $username): bool
    {
        $sql = "
            DELETE FROM rates
            WHERE news_id = ? AND username = ?
        ";

        $conn = $this->db->connect();
        $stmt = $conn->prepare($sql);

        $stmt->bind_param("is", $newsId, $username);

        if (!$stmt->execute()) {
            throw new Exception("Failed to delete rate: " . $stmt->error);
        }

        return $stmt->affected_rows > 0;
    }
    #endregion
}
?>
