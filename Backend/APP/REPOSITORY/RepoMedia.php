<?php
namespace REPOSITORY;

#region REQUIRE
require_once(__DIR__ . "/../MODELS/CORE/DatabaseConnection.php");
#endregion

#region USE
use MODELS\CORE\DatabaseConnection;
use Exception;
#endregion

class RepoMedia
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

    /* =========================================================
     * CREATE
     * ========================================================= */
    #region CREATE

    public function create(array $data): bool
    {
        $sql = "
            INSERT INTO medias (
                name, slug, company_name, media_type,
                picture_ext, logo_ext,
                website, email, description, city_id
            ) VALUES (
                ?, ?, ?, ?, ?, ?, ?, ?, ?, ?
            )
        ";

        $conn = $this->db->connect();
        $stmt = $conn->prepare($sql);

        if (!$stmt) {
            throw new Exception("Failed to prepare media insert statement");
        }

        $stmt->bind_param(
            "sssssssssi",
            $data['name'],
            $data['slug'],
            $data['company_name'],
            $data['media_type'],
            $data['picture_ext'],
            $data['logo_ext'],
            $data['website'],
            $data['email'],
            $data['description'],
            $data['city_id']
        );

        if (!$stmt->execute()) {
            throw new Exception("Failed to create media: " . $stmt->error);
        }

        return true;
    }

    #endregion

    /* =========================================================
     * RETRIEVE
     * ========================================================= */
    #region RETRIEVE

    public function findById(int $id, bool $withDeleted = false): ?array
    {
        $sql = "
            SELECT *
            FROM medias
            WHERE id = ?
            " . ($withDeleted ? "" : "AND deleted_at IS NULL") . "
            LIMIT 1
        ";

        $conn = $this->db->connect();
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("i", $id);
        $stmt->execute();

        return $stmt->get_result()->fetch_assoc() ?: null;
    }

    public function findBySlug(string $slug): ?array
    {
        $sql = "
            SELECT *
            FROM medias
            WHERE slug = ?
              AND deleted_at IS NULL
            LIMIT 1
        ";

        $conn = $this->db->connect();
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("s", $slug);
        $stmt->execute();

        return $stmt->get_result()->fetch_assoc() ?: null;
    }

    public function findAll(bool $onlyActive = true): array
    {
        $sql = "
            SELECT *
            FROM medias
            WHERE deleted_at IS NULL
        ";

        if ($onlyActive) {
            $sql .= " AND is_active = TRUE";
        }

        $sql .= " ORDER BY name ASC";

        $conn = $this->db->connect();
        $stmt = $conn->prepare($sql);
        $stmt->execute();

        return $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
    }

    #endregion

    /* =========================================================
     * UPDATE
     * ========================================================= */
    #region UPDATE

    public function update(int $id, array $data): bool
    {
        $sql = "
            UPDATE medias
            SET
                name = ?,
                company_name = ?,
                media_type = ?,
                picture_ext = ?,
                logo_ext = ?,
                website = ?,
                email = ?,
                description = ?,
                city_id = ?,
                is_active = ?
            WHERE id = ?
              AND deleted_at IS NULL
        ";

        $conn = $this->db->connect();
        $stmt = $conn->prepare($sql);

        $stmt->bind_param(
            "ssssssssiii",
            $data['name'],
            $data['company_name'],
            $data['media_type'],
            $data['picture_ext'],
            $data['logo_ext'],
            $data['website'],
            $data['email'],
            $data['description'],
            $data['city_id'],
            $data['is_active'],
            $id
        );

        if (!$stmt->execute()) {
            throw new Exception("Failed to update media: " . $stmt->error);
        }

        return $stmt->affected_rows > 0;
    }

    public function updateSlug(int $id, string $slug): bool
    {
        $sql = "
            UPDATE medias
            SET slug = ?
            WHERE id = ?
              AND deleted_at IS NULL
        ";

        $conn = $this->db->connect();
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("si", $slug, $id);

        if (!$stmt->execute()) {
            throw new Exception("Failed to update media slug");
        }

        return $stmt->affected_rows > 0;
    }

    #endregion

    /* =========================================================
     * DELETE
     * ========================================================= */
    #region DELETE

    /**
     * Soft delete
     */
    public function softDelete(int $id): bool
    {
        $sql = "
            UPDATE medias
            SET deleted_at = NOW(), is_active = FALSE
            WHERE id = ?
        ";

        $conn = $this->db->connect();
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("i", $id);

        if (!$stmt->execute()) {
            throw new Exception("Failed to soft delete media");
        }

        return $stmt->affected_rows > 0;
    }

    /**
     * Restore soft deleted media
     */
    public function restore(int $id): bool
    {
        $sql = "
            UPDATE medias
            SET deleted_at = NULL, is_active = TRUE
            WHERE id = ?
        ";

        $conn = $this->db->connect();
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("i", $id);

        if (!$stmt->execute()) {
            throw new Exception("Failed to restore media");
        }

        return $stmt->affected_rows > 0;
    }

    /**
     * Hard delete (dangerous)
     */
    public function deleteHard(int $id): bool
    {
        $sql = "
            DELETE FROM medias
            WHERE id = ?
        ";

        $conn = $this->db->connect();
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("i", $id);

        if (!$stmt->execute()) {
            throw new Exception("Failed to permanently delete media");
        }

        return $stmt->affected_rows > 0;
    }

    #endregion
}
