<?php
namespace REPOSITORY;

#region REQUIRE
require_once(__DIR__ . "/../MODELS/CORE/DatabaseConnection.php");
#endregion

#region USE
use MODELS\CORE\DatabaseConnection;
use Exception;
#endregion

class RepoCategory
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
    public function createCategory(string $name): bool
    {
        $name = trim($name);
        $sql = "
            INSERT IGNORE INTO categories (name)
            VALUES (?)
        ";
        try {
            $conn = $this->db->connect();
            $stmt = $conn->prepare($sql);

            if (!$stmt) {
                throw new Exception("Failed to prepare category insert statement");
            }

            $stmt->bind_param("s", $name);

            if (!$stmt->execute()) {
                throw new Exception("Failed to create category (maybe duplicate): " . $stmt->error);
            }
            return $stmt->affected_rows > 0;
        } catch (Exception $e) {
            throw $e;
        } finally {
            $stmt?->close();
            $conn->close();
        }
    }
    #endregion

    #region RETRIEVE

    /**
     * Get category by id
     */
    public function findById(int $id): ?array
    {
        $sql = "
            SELECT *
            FROM categories
            WHERE id = ?
            LIMIT 1
        ";

        $conn = $this->db->connect();
        $stmt = $conn->prepare($sql);

        $stmt->bind_param("i", $id);
        $stmt->execute();

        $result = $stmt->get_result();
        return $result->fetch_assoc() ?: null;
    }

    /**
     * Get category by name
     */
    public function findByName(string $name): ?array
    {
        $sql = "
            SELECT *
            FROM categories
            WHERE name = ?
            LIMIT 1
        ";

        $conn = $this->db->connect();
        $stmt = $conn->prepare($sql);

        $stmt->bind_param("s", $name);
        $stmt->execute();

        $result = $stmt->get_result();
        return $result->fetch_assoc() ?: null;
    }

    public function findAll(): array
    {
        $sql = "
            SELECT *
            FROM categories
            ORDER BY name ASC
        ";

        $conn = $this->db->connect();
        $stmt = $conn->prepare($sql);
        $stmt->execute();

        return $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
    }

    public function findAllNames(): array
    {
        $sql = "
            SELECT name
            FROM categories
            ORDER BY name ASC
        ";

        $conn = $this->db->connect();
        $stmt = $conn->prepare($sql);
        $stmt->execute();

        return array_column(
            $stmt->get_result()->fetch_all(MYSQLI_ASSOC),
            'name'
        );
    }

    #endregion

    #region UPDATE
    public function updateName(int $id, string $newName): bool
    {
        $newName = trim($newName);

        if ($newName === '') {
            throw new Exception("Category name cannot be empty");
        }

        $sql = "
            UPDATE categories
            SET name = ?
            WHERE id = ?
        ";

        $conn = $this->db->connect();
        $stmt = $conn->prepare($sql);

        $stmt->bind_param("si", $newName, $id);

        if (!$stmt->execute()) {
            throw new Exception("Failed to update category: " . $stmt->error);
        }

        return $stmt->affected_rows > 0;
    }
    public function updateCategoryByOldName(string $oldName, string $newName): bool
    {
        $newName = trim($newName);

        if ($newName === '') {
            throw new Exception("Category name cannot be empty");
        }

        $sql = "
            UPDATE categories
            SET name = ?
            WHERE name = ?
        ";

        $conn = $this->db->connect();
        $stmt = $conn->prepare($sql);

        $stmt->bind_param("ss", $newName, $oldName);

        if (!$stmt->execute()) {
            throw new Exception("Failed to update category: " . $stmt->error);
        }

        return $stmt->affected_rows > 0;
    }

    #endregion

    #region DELETE
    public function deleteById(int $id): bool
    {
        $sql = "
            DELETE FROM categories
            WHERE id = ?
        ";

        $conn = $this->db->connect();
        $stmt = $conn->prepare($sql);

        $stmt->bind_param("i", $id);

        if (!$stmt->execute()) {
            throw new Exception("Failed to delete category: " . $stmt->error);
        }

        return $stmt->affected_rows > 0;
    }

    public function deleteByName(string $name): bool
    {
        $sql = "
            DELETE FROM categories
            WHERE name = ?
        ";

        $conn = $this->db->connect();
        $stmt = $conn->prepare($sql);

        $stmt->bind_param("s", $name);

        if (!$stmt->execute()) {
            throw new Exception("Failed to delete category: " . $stmt->error);
        }

        return $stmt->affected_rows > 0;
    }
    #endregion
}
