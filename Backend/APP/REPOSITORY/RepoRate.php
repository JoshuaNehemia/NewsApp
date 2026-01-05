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

        $conn = null;
        $stmt = null;

        try {
            $conn = $this->db->connect();
            $stmt = $conn->prepare($sql);

            if (!$stmt) {
                throw new Exception("Failed to prepare rate insert statement");
            }

            $news_id = $newsId;
            $user    = $username;
            $rate    = $rating;

            $stmt->bind_param("isi", $news_id, $user, $rate);

            if (!$stmt->execute()) {
                throw new Exception("Failed to create rate: " . $stmt->error);
            }

            return true;

        } catch (Exception $e) {
            throw $e;
        } finally {
            if ($stmt) {
                $stmt->close();
            }
            if ($conn) {
                $conn->close();
            }
        }
    }
    #endregion

    #region RETRIEVE
    public function findRateByNewsId(int $newsId): float
    {
        $sql = "
            SELECT COALESCE(AVG(rate), 0) AS avg_rating
            FROM rates
            WHERE news_id = ?
        ";

        $conn = null;
        $stmt = null;

        try {
            $conn = $this->db->connect();
            $stmt = $conn->prepare($sql);

            if (!$stmt) {
                throw new Exception("Failed to prepare rate retrieve statement");
            }

            $news_id = $newsId;
            $stmt->bind_param("i", $news_id);

            if (!$stmt->execute()) {
                throw new Exception("Failed to retrieve rate: " . $stmt->error);
            }

            $result = $stmt->get_result()->fetch_assoc();
            return (float)($result['avg_rating'] ?? 0);

        } catch (Exception $e) {
            throw $e;
        } finally {
            if ($stmt) {
                $stmt->close();
            }
            if ($conn) {
                $conn->close();
            }
        }
    }
    #endregion

    #region UPDATE
    public function updateRate(int $newsId, string $username, int $rating): bool
    {
        if ($rating < 1 || $rating > 5) {
            throw new Exception("Rating must be between 1 and 5");
        }

        $sql = "
            UPDATE rates
            SET rating = ?
            WHERE news_id = ? AND username = ?
        ";

        $conn = null;
        $stmt = null;

        try {
            $conn = $this->db->connect();
            $stmt = $conn->prepare($sql);

            if (!$stmt) {
                throw new Exception("Failed to prepare rate update statement");
            }

            $rate    = $rating;
            $news_id = $newsId;
            $user    = $username;

            $stmt->bind_param("iis", $rate, $news_id, $user);

            if (!$stmt->execute()) {
                throw new Exception("Failed to update rate: " . $stmt->error);
            }

            return $stmt->affected_rows > 0;

        } catch (Exception $e) {
            throw $e;
        } finally {
            if ($stmt) {
                $stmt->close();
            }
            if ($conn) {
                $conn->close();
            }
        }
    }
    #endregion

    #region DELETE
    public function deleteRate(int $newsId, string $username): bool
    {
        $sql = "
            DELETE FROM rates
            WHERE news_id = ? AND username = ?
        ";

        $conn = null;
        $stmt = null;

        try {
            $conn = $this->db->connect();
            $stmt = $conn->prepare($sql);

            if (!$stmt) {
                throw new Exception("Failed to prepare rate delete statement");
            }

            $news_id = $newsId;
            $user    = $username;

            $stmt->bind_param("is", $news_id, $user);

            if (!$stmt->execute()) {
                throw new Exception("Failed to delete rate: " . $stmt->error);
            }

            return $stmt->affected_rows > 0;

        } catch (Exception $e) {
            throw $e;
        } finally {
            if ($stmt) {
                $stmt->close();
            }
            if ($conn) {
                $conn->close();
            }
        }
    }
    #endregion
}
