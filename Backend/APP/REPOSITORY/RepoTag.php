<?php
namespace REPOSITORY;

#region REQUIRE
require_once(__DIR__ . "/../MODELS/CORE/DatabaseConnection.php");
#endregion

#region USE
use MODELS\CORE\DatabaseConnection;
use Exception;
#endregion

class RepoTag
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

    #region RETRIEVE
    public function searchTagByCategoryId(int $categoryId): array
    {
        $sql = "
            SELECT name
            FROM tags
            WHERE category_id = ?
            ORDER BY name ASC
        ";

        $conn = $this->db->connect();
        $stmt = $conn->prepare($sql);

        if (!$stmt) {
            throw new Exception("Failed to prepare tag retrieval statement");
        }

        $stmt->bind_param("i", $categoryId);
        $stmt->execute();

        $result = $stmt->get_result();

        $tags = [];
        while ($row = $result->fetch_assoc()) {
            $tags[] = $row['name'];
        }

        return $tags;
    }

    public function searchTagsByCategory(int $categoryId, string $keyword): array
    {
        $sql = "
            SELECT name
            FROM tags
            WHERE category_id = ?
              AND name LIKE ?
            ORDER BY name ASC
        ";

        $conn = $this->db->connect();
        $stmt = $conn->prepare($sql);

        $like = '%' . $keyword . '%';
        $stmt->bind_param("is", $categoryId, $like);
        $stmt->execute();

        $result = $stmt->get_result();

        $tags = [];
        while ($row = $result->fetch_assoc()) {
            $tags[] = $row['name'];
        }

        return $tags;
    }
    #endregion

    #region CREATE
    public function createTagIfNotExists(int $categoryId, string $name): bool
    {
        $sql = "
            INSERT IGNORE INTO tags (category_id, name)
            VALUES (?, ?);
        ";

        $conn = $this->db->connect();
        $stmt = $conn->prepare($sql);

        $stmt->bind_param("is", $categoryId, $name);
        $stmt->execute();

        return $stmt->affected_rows > 0;
    }

    #endregion

    #region UPDATE
    public function updateTag(int $tagId, string $newName): bool
    {
        $newName = trim($newName);

        if ($newName === '') {
            throw new Exception("Tag name cannot be empty");
        }

        $sql = "
            UPDATE tags
            SET name = ?
            WHERE id = ?
        ";

        $conn = $this->db->connect();
        $stmt = $conn->prepare($sql);

        $stmt->bind_param("si", $newName, $tagId);

        if (!$stmt->execute()) {
            throw new Exception("Failed to update tag: " . $stmt->error);
        }

        return $stmt->affected_rows > 0;
    }

    #endregion

    #region DELETE
    public function deleteById(int $tagId): bool
    {
        $sql = "
            DELETE FROM tags
            WHERE id = ?
        ";

        $conn = $this->db->connect();
        $stmt = $conn->prepare($sql);

        $stmt->bind_param("i", $tagId);

        if (!$stmt->execute()) {
            throw new Exception("Failed to delete tag: " . $stmt->error);
        }

        return $stmt->affected_rows > 0;
    }
    #endregion
}
