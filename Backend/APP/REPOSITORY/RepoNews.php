<?php

namespace REPOSITORY;

#region REQUIRE
require_once(__DIR__ . "/../MODELS/NEWS/News.php");
require_once(__DIR__ . "/../MODELS/ACCOUNT/Writer.php");
require_once(__DIR__ . "/../MODELS/CORE/Geolocation.php");
require_once(__DIR__ . "/../MODELS/CORE/DatabaseConnection.php");
#endregion

#region USE
use MODELS\NEWS\News;
use MODELS\ACCOUNT\Writer;
use MODELS\CORE\Geolocation;
use MODELS\CORE\DatabaseConnection;
use Exception;
#endregion

class RepoNews extends DatabaseConnection
{
    #region RETRIEVE

    public function findById(int $id): ?News
    {
        $sql = "
            SELECT *
            FROM news
            WHERE id = ?
            LIMIT 1
        ";

        $stmt = $this->getConnection()->prepare($sql);
        if (!$stmt) {
            throw new Exception("Failed to prepare findById query");
        }

        $stmt->bind_param("i", $id);
        $stmt->execute();

        $result = $stmt->get_result();
        $row = $result->fetch_assoc();

        return $row ? $this->mapRowToNews($row) : null;
    }

    public function findAll(int $limit = 10, int $offset = 0): array
    {
        $sql = "
            SELECT *
            FROM news
            ORDER BY created_at DESC
            LIMIT ? OFFSET ?
        ";

        $stmt = $this->getConnection()->prepare($sql);
        if (!$stmt) {
            throw new Exception("Failed to prepare findAll query");
        }

        $stmt->bind_param("ii", $limit, $offset);
        $stmt->execute();

        $result = $stmt->get_result();
        $newsList = [];

        while ($row = $result->fetch_assoc()) {
            $newsList[] = $this->mapRowToNews($row);
        }

        return $newsList;
    }

    #endregion

    #region CREATE

    public function create(News $news): int
    {
        $sql = "
            INSERT INTO news
            (
                writer_username,
                category_id,
                city_id,
                title,
                slug,
                content,
                view_count,
                latitude,
                longitude
            )
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
        ";

        $geo = $news->getLocation();

        $stmt = $this->getConnection()->prepare($sql);
        if (!$stmt) {
            throw new Exception("Failed to prepare create news query");
        }

        $stmt->bind_param(
            "siisssidd",
            $news->getAuthor()->getUsername(),
            $news->getCategoryId(),
            $news->getCityId(),
            $news->getTitle(),
            $news->getSlug(),
            $news->getContent(),
            $news->getViewCount(),
            $geo?->getLatitude(),
            $geo?->getLongitude()
        );

        if (!$stmt->execute()) {
            throw new Exception("Failed to create news: " . $stmt->error);
        }

        return $stmt->insert_id;
    }

    #endregion

    #region UPDATE

    public function update(News $news): bool
    {
        $sql = "
            UPDATE news SET
                category_id = ?,
                city_id = ?,
                title = ?,
                slug = ?,
                content = ?,
                latitude = ?,
                longitude = ?
            WHERE id = ?
        ";

        $geo = $news->getLocation();

        $stmt = $this->getConnection()->prepare($sql);
        if (!$stmt) {
            throw new Exception("Failed to prepare update query");
        }

        $stmt->bind_param(
            "iissdddi",
            $news->getCategoryId(),
            $news->getCityId(),
            $news->getTitle(),
            $news->getSlug(),
            $news->getContent(),
            $geo?->getLatitude(),
            $geo?->getLongitude(),
            $news->getId()
        );

        return $stmt->execute();
    }

    public function incrementViewCount(int $newsId): bool
    {
        $sql = "UPDATE news SET view_count = view_count + 1 WHERE id = ?";

        $stmt = $this->getConnection()->prepare($sql);
        $stmt->bind_param("i", $newsId);

        return $stmt->execute();
    }

    #endregion

    #region DELETE

    public function delete(int $id): bool
    {
        $sql = "DELETE FROM news WHERE id = ?";

        $stmt = $this->getConnection()->prepare($sql);
        $stmt->bind_param("i", $id);

        return $stmt->execute();
    }

    #endregion

    #region MAPPER

    private function mapRowToNews(array $row): News
    {
        $news = new News();

        $news
            ->setId((int) $row['id'])
            ->setTitle($row['title'])
            ->setSlug($row['slug'])
            ->setContent($row['content'])
            ->setViewCount((int) $row['view_count'])
            ->setCategoryId((int) $row['category_id'])
            ->setCityId((int) $row['city_id'])
            ->setCreatedAt($row['created_at'])
            ->setUpdatedAt($row['updated_at']);

        if ($row['latitude'] !== null && $row['longitude'] !== null) {
            $news->setLocation(
                new Geolocation(
                    (float) $row['latitude'],
                    (float) $row['longitude']
                )
            );
        }

        $writer = new Writer();
        $writer->setUsername($row['writer_username']);
        $news->setAuthor($writer);

        return $news;
    }

    #endregion
}
