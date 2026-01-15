<?php

namespace REPOSITORY;

#region REQUIRE
require_once(__DIR__ . "/../config.php");
require_once(__DIR__ . "/../MODELS/NEWS/News.php");
require_once(__DIR__ . "/../MODELS/ACCOUNT/Writer.php");
require_once(__DIR__ . "/../MODELS/ACCOUNT/Media.php");
require_once(__DIR__ . "/../MODELS/GEOGRAPHY/City.php");
require_once(__DIR__ . "/../MODELS/GEOGRAPHY/Country.php");
require_once(__DIR__ . "/../MODELS/GEOGRAPHY/CountryDivision.php");
require_once(__DIR__ . "/../MODELS/CORE/DatabaseConnection.php");
require_once(__DIR__ . "/../MODELS/CORE/Geolocation.php");
#endregion

#region USE
use MODELS\NEWS\News;
use MODELS\ACCOUNT\Writer;
use MODELS\ACCOUNT\Media;
use MODELS\GEOGRAPHY\City;
use MODELS\GEOGRAPHY\Country;
use MODELS\GEOGRAPHY\CountryDivision;
use MODELS\CORE\DatabaseConnection;
use MODELS\CORE\Geolocation;
use Exception;
#endregion

class RepoNews extends DatabaseConnection
{
    #region FIELDS
    public DatabaseConnection $db;
    #endregion

    #region CONSTRUCT
    public function __construct()
    {
        $this->db = new DatabaseConnection();
    }
    #endregion

    #region RETRIEVE
    public function findAllNews(int $limit = 10, int $offset = 0): array
    {
        //   is_like = 0 subquery dislike, dan is_like = 1 subquery like
        $sql = "SELECT
                    n.`id` AS 'news_id',
                    n.`title` AS 'news_title',
                    n.`slug` AS 'news_slug',
                    n.`content` AS 'news_content',
                    n.`view_count` AS 'news_views',
                    n.`created_at` AS 'news_created_at', 
                    n.`updated_at` AS 'news_updated_at',
                    
                    -- Subqueries untuk Likes, Rating, dan Tags
                    (SELECT COUNT(*) FROM likes WHERE news_id = n.id AND is_like = 1) AS 'news_like_count',
                    (SELECT COUNT(*) FROM likes WHERE news_id = n.id AND is_like = 0) AS 'news_dislike_count',
                    (SELECT COALESCE(AVG(rate), 0) FROM rates WHERE news_id = n.id) AS 'news_rating',
                    (SELECT COUNT(*) FROM rates WHERE news_id = n.id) AS 'news_rating_count',
                    (SELECT GROUP_CONCAT(t.name SEPARATOR ',') 
                     FROM news_tags nt 
                     JOIN tags t ON nt.tags_id = t.id 
                     WHERE nt.news_id = n.id) AS 'news_tags_string',
                    (SELECT GROUP_CONCAT(c.name SEPARATOR ',') 
                     FROM news_categories nc 
                     JOIN categories c ON nc.category_id = c.id 
                     WHERE nc.news_id = n.id) AS 'news_categories_names',

                    ctg.`id` AS 'category_id',
                    ctg.`name` AS 'category_name',
                    
                    ct.`id` AS 'city_id',
                    ct.`name` AS 'city_name',
                    ct.`latitude` AS 'city_latitude',
                    ct.`longitude` AS 'city_longitude',
                    
                    cd.`id` AS 'country_division_id',
                    cd.`name` AS 'country_division_name',
                    
                    cm.`id` AS 'country_id',
                    cm.`name` AS 'country_name',
                    cm.`code` AS 'country_code',
                    cm.`telephone` AS 'country_telephone',

                    m.`id` AS 'media_id',
                    m.`name` AS 'media_name',
                    m.`slug` AS 'media_slug',
                    m.`company_name` AS 'media_company_name',
                    m.`media_type` AS 'media_type',
                    m.`picture_ext` AS 'media_picture_ext',
                    m.`logo_ext` AS 'media_logo_ext',
                    m.`website` AS 'media_website',
                    m.`email` AS 'media_email',
                    m.`description` AS 'media_description',

                    w.`username` AS 'writer_username',
                    w.`biography` AS 'writer_biography',
                    w.`is_verified` AS 'writer_is_verified',
                    a.`fullname` AS 'writer_fullname',
                    a.`email` AS 'writer_email',
                    a.`role` AS 'writer_role',
                    a.`profile_picture_ext` AS 'writer_profile_picture_ext'
                FROM
                    news n
                    INNER JOIN `categories` ctg ON n.`category_id` = ctg.`id`
                    LEFT JOIN `cities` ct ON n.`city_id` = ct.`id`
                    LEFT JOIN `country_divisions` cd ON ct.`country_division_id` = cd.`id`
                    LEFT JOIN `countries` cm ON cd.`country_id` = cm.`id`
                    LEFT JOIN `medias` m ON n.`media_id` = m.`id`
                    LEFT JOIN `writers` w ON n.`writer_username` = w.`username`
                    INNER JOIN `accounts` a ON w.`username` = a.`username`
                ORDER BY n.created_at DESC
                LIMIT ? OFFSET ?;";

        $connection = null;
        $stmt = null;
        $newsList = [];

        try {
            $connection = $this->db->connect();
            $stmt = $connection->prepare($sql);
            $stmt->bind_param("ii", $limit, $offset);
            $stmt->execute();
            $result = $stmt->get_result();

            while ($row = $result->fetch_assoc()) {
                $newsArray = $this->mapSQLResultToNewsObject($row)->toArray();
                // Manually add rating_count since News model doesn't have this property
                $newsArray['rating_count'] = (int)($row['news_rating_count'] ?? 0);
                $newsList[] = $newsArray;
            }

            return $newsList;
        } catch (Exception $e) {
            throw $e;
        } finally {
            if ($stmt) $stmt->close();
            if ($connection) $connection->close();
        }
    }

    public function findNewsByCategoryId(int $categoryId, int $limit = 10, int $offset = 0): array
    {
        $sql = "SELECT
                    n.`id` AS 'news_id',
                    n.`title` AS 'news_title',
                    n.`slug` AS 'news_slug',
                    n.`content` AS 'news_content',
                    n.`view_count` AS 'news_views',
                    n.`created_at` AS 'news_created_at',
                    n.`updated_at` AS 'news_updated_at',
                    
                    (SELECT COUNT(*) FROM likes WHERE news_id = n.id AND is_like = 1) AS 'news_like_count',
                    (SELECT COUNT(*) FROM likes WHERE news_id = n.id AND is_like = 0) AS 'news_dislike_count',
                    (SELECT COUNT(*) FROM comments WHERE news_id = n.id) AS 'news_comment_count',
                    (SELECT COALESCE(AVG(rate), 0) FROM rates WHERE news_id = n.id) AS 'news_rating',
                    (SELECT COUNT(*) FROM rates WHERE news_id = n.id) AS 'news_rating_count',
                    (SELECT GROUP_CONCAT(t.name SEPARATOR ',') 
                     FROM news_tags nt 
                     JOIN tags t ON nt.tags_id = t.id 
                     WHERE nt.news_id = n.id) AS 'news_tags_string',
                    (SELECT GROUP_CONCAT(c_sub.name SEPARATOR ',') 
                     FROM news_categories nc_sub 
                     JOIN categories c_sub ON nc_sub.category_id = c_sub.id 
                     WHERE nc_sub.news_id = n.id) AS 'news_categories_names',

                    ctg.`id` AS 'category_id',
                    ctg.`name` AS 'category_name',

                    ct.`id` AS 'city_id',
                    ct.`name` AS 'city_name',
                    ct.`latitude` AS 'city_latitude',
                    ct.`longitude` AS 'city_longitude',
                    
                    cd.`id` AS 'country_division_id',
                    cd.`name` AS 'country_division_name',
                    cm.`id` AS 'country_id',
                    cm.`name` AS 'country_name',
                    cm.`code` AS 'country_code',
                    cm.`telephone` AS 'country_telephone',

                    m.`id` AS 'media_id',
                    m.`name` AS 'media_name',
                    m.`slug` AS 'media_slug',
                    m.`company_name` AS 'media_company_name',
                    m.`media_type` AS 'media_type',
                    m.`picture_ext` AS 'media_picture_ext',
                    m.`logo_ext` AS 'media_logo_ext',
                    m.`website` AS 'media_website',
                    m.`email` AS 'media_email',
                    m.`description` AS 'media_description',

                    w.`username` AS 'writer_username',
                    w.`biography` AS 'writer_biography',
                    w.`is_verified` AS 'writer_is_verified',
                    a.`fullname` AS 'writer_fullname',
                    a.`email` AS 'writer_email',
                    a.`role` AS 'writer_role',
                    a.`profile_picture_ext` AS 'writer_profile_picture_ext'
                FROM
                    news n
                    -- Use news_categories for filtering, but keep n.category_id for primary category display info if needed
                    -- However, usually we want to see the category we filtered by.
                    -- Let's JOIN news_categories to filter, and JOIN categories for display.
                    INNER JOIN news_categories nc ON n.id = nc.news_id
                    INNER JOIN categories ctg ON nc.category_id = ctg.id
                    LEFT JOIN `cities` ct ON n.`city_id` = ct.`id`
                    LEFT JOIN `country_divisions` cd ON ct.`country_division_id` = cd.`id`
                    LEFT JOIN `countries` cm ON cd.`country_id` = cm.`id`
                    LEFT JOIN `medias` m ON n.`media_id` = m.`id`
                    LEFT JOIN `writers` w ON n.`writer_username` = w.`username`
                    INNER JOIN `accounts` a ON w.`username` = a.`username`
                WHERE nc.`category_id` = ?
                ORDER BY n.created_at DESC
                LIMIT ? OFFSET ?;";

        $connection = null;
        $stmt = null;
        $newsList = [];

        try {
            $connection = $this->db->connect();
            $stmt = $connection->prepare($sql);
            
            if (!$stmt) {
                throw new Exception("Failed to prepare findNewsByCategory query: " . $connection->error);
            }

            $stmt->bind_param("iii", $categoryId, $limit, $offset);
            
            $stmt->execute();
            $result = $stmt->get_result();

            while ($row = $result->fetch_assoc()) {
                $newsArray = $this->mapSQLResultToNewsObject($row)->toArray();
                $newsArray['rating_count'] = (int)($row['news_rating_count'] ?? 0);
                $newsList[] = $newsArray;
            }

            return $newsList;
        } catch (Exception $e) {
            throw $e;
        } finally {
            if ($stmt) $stmt->close();
            if ($connection) $connection->close();
        }
    }

    public function findNewsById(int $id): ?News
    {
        $sql = "SELECT
                    n.`id` AS 'news_id',
                    n.`title` AS 'news_title',
                    n.`slug` AS 'news_slug',
                    n.`content` AS 'news_content',
                    n.`view_count` AS 'news_views',
                    n.`created_at` AS 'news_created_at',
                    n.`updated_at` AS 'news_updated_at',
                    (SELECT COUNT(*) FROM likes WHERE news_id = n.id AND is_like = 1) AS 'news_like_count',
                    (SELECT COUNT(*) FROM likes WHERE news_id = n.id AND is_like = 0) AS 'news_dislike_count',
                    (SELECT COUNT(*) FROM comments WHERE news_id = n.id) AS 'news_comment_count',
                    (SELECT COALESCE(AVG(rate), 0) FROM rates WHERE news_id = n.id) AS 'news_rating',
                    (SELECT GROUP_CONCAT(t.name SEPARATOR ',') 
                     FROM news_tags nt 
                     JOIN tags t ON nt.tags_id = t.id 
                     WHERE nt.news_id = n.id) AS 'news_tags_string',
                    (SELECT GROUP_CONCAT(c.name SEPARATOR ',') 
                     FROM news_categories nc 
                     JOIN categories c ON nc.category_id = c.id 
                     WHERE nc.news_id = n.id) AS 'news_categories_names',

                    ctg.`id` AS 'category_id',
                    ctg.`name` AS 'category_name',
                    
                    ct.`id` AS 'city_id',
                    ct.`name` AS 'city_name',
                    ct.`latitude` AS 'city_latitude',
                    ct.`longitude` AS 'city_longitude',
                    
                    cd.`id` AS 'country_division_id',
                    cd.`name` AS 'country_division_name',
                    
                    cm.`id` AS 'country_id',
                    cm.`name` AS 'country_name',
                    cm.`code` AS 'country_code',
                    cm.`telephone` AS 'country_telephone',

                    m.`id` AS 'media_id',
                    m.`name` AS 'media_name',
                    m.`slug` AS 'media_slug',
                    m.`company_name` AS 'media_company_name',
                    m.`media_type` AS 'media_type',
                    m.`picture_ext` AS 'media_picture_ext',
                    m.`logo_ext` AS 'media_logo_ext',
                    m.`website` AS 'media_website',
                    m.`email` AS 'media_email',
                    m.`description` AS 'media_description',

                    w.`username` AS 'writer_username',
                    w.`biography` AS 'writer_biography',
                    w.`is_verified` AS 'writer_is_verified',
                    a.`fullname` AS 'writer_fullname',
                    a.`role` AS 'writer_role',
                    a.`profile_picture_ext` AS 'writer_profile_picture_ext'
                FROM
                    news n
                    INNER JOIN `categories` ctg ON n.`category_id` = ctg.`id`
                    LEFT JOIN `cities` ct ON n.`city_id` = ct.`id`
                    LEFT JOIN `country_divisions` cd ON ct.`country_division_id` = cd.`id`
                    LEFT JOIN `countries` cm ON cd.`country_id` = cm.`id`
                    LEFT JOIN `medias` m ON n.`media_id` = m.`id`
                    LEFT JOIN `writers` w ON n.`writer_username` = w.`username`
                    INNER JOIN `accounts` a ON w.`username` = a.`username`
                WHERE n.`id` = ?;";
        
        $connection = null;
        $stmt = null;
        try {
            $connection = $this->db->connect();
            $stmt = $connection->prepare($sql);
            if (!$stmt) {
                throw new Exception("Failed to prepare findNewsById query");
            }

            $stmt->bind_param("i", $id);
            $stmt->execute();

            $result = $stmt->get_result();
            $row = $result->fetch_assoc();
            
            if (!$row) return null;
            $news = $this->mapSQLResultToNewsObject($row);
            $comments = $this->getCommentsByNewsId($id, $connection);
            $news->setComments($comments);

            return $news;
        } catch (Exception $e) {
            throw $e;
        } finally {
            if ($stmt) $stmt->close();
            if ($connection) $connection->close();
        }
    }
    #endregion

    #region CREATE
    public function checkTitleExists(string $title): bool
    {
        $sql = "SELECT id FROM news WHERE title = ?";
        $connection = null;
        $stmt = null;
        try {
            $connection = $this->db->connect();
            $stmt = $connection->prepare($sql);
            $stmt->bind_param("s", $title);
            $stmt->execute();
            $stmt->store_result();
            return $stmt->num_rows > 0;
        } catch (Exception $e) {
            return false;
        } finally {
            if ($stmt) $stmt->close();
            if ($connection) $connection->close();
        }
    }

    public function CreateNews(News $news, array $additionalCategoryIds = []): int
    {
        $sql = "INSERT INTO `news` (
                    `writer_username`,
                    `media_id`,
                    `category_id`,
                    `city_id`,
                    `title`,
                    `slug`,
                    `content`
                )
                VALUES (?, ?, ?, ?, ?, ?, ?)
            ";
        $connection = null;
        $stmt = null;

        try {
            $connection = $this->db->connect();
            // Start transaction
            $connection->begin_transaction();

            $stmt = $connection->prepare($sql);
            if (!$stmt) {
                throw new Exception("Failed to prepare createNews query: " . $connection->error);
            }
            $writerUsername = $news->getAuthor()->getUsername();
            $mediaId        = $news->getMedia()->getId();
            $cityId         = $news->getCity()->getId();
            $title          = $news->getTitle();
            $slug           = $news->getSlug();
            $content        = $news->getContent();
            $catRaw = $news->getCategory();
            // Primary category (first one)
            $catId  = is_array($catRaw) ? $catRaw['id'] : (is_object($catRaw) ? $catRaw->getId() : $catRaw);

            $stmt->bind_param(
                "siiisss",
                $writerUsername,
                $mediaId,
                $catId,
                $cityId,
                $title,
                $slug,
                $content
            );

            if ($stmt->execute()) {
                $newsId = $stmt->insert_id;

                // Insert into news_categories
                // Merge primary category with additional ones to ensure all are in the Many-to-Many table
                $allCategories = array_unique(array_merge([$catId], $additionalCategoryIds));
                
                $sqlCat = "INSERT INTO news_categories (news_id, category_id) VALUES (?, ?)";
                $stmtCat = $connection->prepare($sqlCat);
                
                // Bind once
                $cIdInt = 0;
                $stmtCat->bind_param("ii", $newsId, $cIdInt);
                
                foreach ($allCategories as $cId) {
                    $cIdInt = (int)$cId;
                    if ($cIdInt > 0) {
                        $stmtCat->execute();
                    }
                }
                $stmtCat->close();

                $connection->commit();
                return $newsId;
            } else {
                $connection->rollback();
                return 0;
            }

        } catch (Exception $e) {
            if ($connection) $connection->rollback();
            throw $e;
        } finally {
            if ($stmt) $stmt->close();
            if ($connection) $connection->close();
        }
    }
    #endregion

    #region UPDATE
    public function updateNews(News $news): bool
    {
        $sql = "UPDATE `news`
                SET
                    `writer_username` = ?,
                    `media_id` = ?,
                    `category_id` = ?,
                    `city_id` = ?,
                    `title` = ?,
                    `slug` = ?,
                    `content` = ?
                WHERE `id` = ?
            ";
        $connection = null;
        $stmt = null;

        try {
            $connection = $this->db->connect();

            $stmt = $connection->prepare($sql);
            if (!$stmt) {
                throw new Exception("Failed to prepare updateNews query: " . $connection->error);
            }

            $arr_news = $news->toArray();
            $mediaId = $arr_news['media']['id'] ?? null;

            $stmt->bind_param(
                "siiisssi",
                $arr_news['author']['username'],
                $mediaId,
                $arr_news['category']['id'],
                $arr_news['city']['id'],
                $arr_news['title'],
                $arr_news['slug'],
                $arr_news['content'],
                $arr_news['id']
            );

            $stmt->execute();
            return $stmt->affected_rows === 1;

        } catch (Exception $e) {
            throw $e;
        } finally {
            if ($stmt) $stmt->close();
            if ($connection) $connection->close();
        }
    }
    public function incrementViewCount(int $newsId): bool
    {
        $sql = "UPDATE news SET view_count = view_count + 1 WHERE id = ?";
        
        $connection = null;
        $stmt = null;

        try {
            $connection = $this->db->connect();
            $stmt = $connection->prepare($sql);
            
            if (!$stmt) {
                throw new Exception("Failed to prepare increment view statement: " . $connection->error);
            }

            $stmt->bind_param("i", $newsId);
            $stmt->execute();
            return $stmt->affected_rows > 0;

        } catch (Exception $e) {
            throw $e;
        } finally {
            if ($stmt) $stmt->close();
            if ($connection) $connection->close();
        }
    }
    #endregion

    #region DELETE
    public function deleteNews(int $news_id): bool
    {
        $sql = "DELETE FROM `news` WHERE `id` = ?";
        $stmt = null;

        try {
            $connection = $this->db->connect();
            $stmt = $connection->prepare($sql);
            if (!$stmt) {
                throw new Exception("Failed to prepare deleteNews query: " . $connection->error);
            }
            $stmt->bind_param("i", $news_id);
            $stmt->execute();
            $result = $stmt->affected_rows === 1;
            $stmt->close();
            return $result;

        } catch (Exception $e) {
            throw $e;
        }
    }

    public function getNewsAuthor(int $news_id): ?string
    {
        $sql = "SELECT w.username FROM news n
                INNER JOIN writers w ON n.writer_username = w.username
                WHERE n.id = ?";
        $stmt = null;

        try {
            $connection = $this->db->connect();
            $stmt = $connection->prepare($sql);
            if (!$stmt) {
                throw new Exception("Failed to prepare getNewsAuthor query: " . $connection->error);
            }
            $stmt->bind_param("i", $news_id);
            $stmt->execute();
            $result = $stmt->get_result();
            $row = $result->fetch_assoc();
            $stmt->close();
            
            return $row ? $row['username'] : null;

        } catch (Exception $e) {
            throw $e;
        }
    }
    #endregion
    
    #region HELPER
    private function getCommentsByNewsId(int $newsId, $connection = null): array
    {
        $sql = "SELECT 
                    c.id, 
                    c.content, 
                    c.created_at, 
                    c.username,
                    a.fullname AS user_fullname,
                    a.profile_picture_ext AS user_pic_ext
                FROM comments c
                JOIN accounts a ON c.username = a.username
                WHERE c.news_id = ?
                ORDER BY c.created_at DESC";

        $localConnection = false;
        if ($connection === null) {
            $connection = $this->db->connect();
            $localConnection = true;
        }
        $stmt = null;
        $comments = [];

        try {
            $connection = $this->db->connect();
            $stmt = $connection->prepare($sql);
            $stmt->bind_param("i", $newsId);
            $stmt->execute();
            $result = $stmt->get_result();

            while ($row = $result->fetch_assoc()) {
                // Jika null gunakan default
                $picExt = $row['user_pic_ext'] ?? 'png'; 
                $picPath = IMAGE_DATABASE_ADDRESS . "USERS/" . $row['username'] . "." . $picExt;

                $comments[] = [
                    'id' => $row['id'],
                    'user' => [
                        'username' => $row['username'],
                        'name' => $row['user_fullname'],
                        'avatar' => $picPath
                    ],
                    'text' => $row['content'],
                    'date' => $row['created_at']
                ];
            }
            return $comments;

        } catch (Exception $e) {
            return [];
        } finally {
            if ($stmt) $stmt->close();
            if ($localConnection && $connection) {
                $connection->close();
            }
        }
    }
    #endregion

    #region MAPPER
    private function mapSQLResultToNewsObject(array $row): News
    {
        $news = new News();
        $city = new City();
        $country = new Country();
        $country_division = new CountryDivision();
        $media = new Media();
        $writer = new Writer();

        $country->setId((int)$row['country_id']); 
        $country->setName($row['country_name']);
        $country->setCode($row['country_code']);
        $country->setTelephone($row['country_telephone']);
        
        $country_division->setId((int)$row['country_division_id']);
        $country_division->setName($row['country_division_name']);
        $country_division->setCountry($country);
        
        $city->setId((int)$row["city_id"]);
        $city->setName($row["city_name"]);
        $city->setGeolocation(new Geolocation((float)$row['city_latitude'], (float)$row['city_longitude']));
        $city->setCountryDivision($country_division);

        $media->setId((int)$row['media_id']);
        $media->setName($row['media_name']);
        $media->setSlug($row['media_slug']);
        $media->setCompanyName($row['media_company_name']);
        $media->setType($row['media_type'] ?? 'NEWS');
        $picExt = isset($row['media_picture_ext']) && !empty($row['media_picture_ext']) ? $row['media_picture_ext'] : 'jpg'; 
        $media->createPictureAddressFromExt($picExt);
        $logoExt = isset($row['media_logo_ext']) && !empty($row['media_logo_ext']) ? $row['media_logo_ext'] : 'png'; 
        $media->createLogoAddressFromExt($logoExt);
        $media->setEmail($row['media_email']);
        $media->setDescription($row['media_description']);
        $website = $row['media_website'];
        $media->setWebsite($website);
        $media->setCity($city);
        
        $writer->setUsername($row['writer_username']);
        $writer->setFullname($row['writer_fullname']);
        $writer->setRole(strtoupper($row['writer_role'] ?? 'WRITER'));
        $writer->setEmail($row['writer_email'] ?? "writer@newsapp.com");
        $fullPath = IMAGE_DATABASE_ADDRESS . "WRITER/" . $row['writer_username'] . "." . $row['writer_profile_picture_ext'];
        $writer->setProfilePictureAddress($fullPath);
        $writer->setMedia($media); 
        $writer->setBiography($row['writer_biography'] ?? "-");
        $writer->setIsVerified((bool)($row['writer_is_verified'] ?? false));

        $news->setId((int)$row['news_id']);
        $news->setTitle($row['news_title']);
        $news->setSlug($row['news_slug']);
        $news->setContent($row['news_content']);
        $news->setViewCount((int)$row['news_views']);
        $news->setLikeCount((int)($row['news_like_count'] ?? 0));
        $news->setDislikeCount((int)($row['news_dislike_count'] ?? 0));
        $news->setCommentCount((int)($row['news_comment_count'] ?? 0));
        $news->setRating((float)($row['news_rating'] ?? 0.0));
        // Store rating_count for later use in toArray (News model doesn't have this property)
        $ratingCount = (int)($row['news_rating_count'] ?? 0);
        $tagsArray = explode(',', $row['news_tags_string']);
        $news->setTags($tagsArray);
        
        $catsArray = isset($row['news_categories_names']) && !empty($row['news_categories_names']) ? explode(',', $row['news_categories_names']) : [];
        $news->setCategories($catsArray);

        $news->setCategory($row['category_name']);
        $news->setCreatedAt($row['news_created_at']);
        $news->setUpdatedAt($row['news_updated_at'] ?? $row['news_created_at'] ?? date('Y-m-d H:i:s'));
        

        $imgSql = "SELECT image_path, image_ext FROM news_images WHERE news_id = ? ORDER BY position ASC";
        $conn = $this->db->connect();
        $stmtImg = $conn->prepare($imgSql);
        if ($stmtImg) {
            $newsId = (int)$row['news_id'];
            $stmtImg->bind_param("i", $newsId);
            $stmtImg->execute();
            $resImg = $stmtImg->get_result();
            while ($imgRow = $resImg->fetch_assoc()) {
                if (!empty($imgRow['image_path'])) {
                    $fullPath = API_ADDRESS . $imgRow['image_path'];
                } else {
                    $fullPath = IMAGE_DATABASE_ADDRESS . "NEWS/" . $newsId . "." . $imgRow['image_ext'];
                }
                $news->addImage($fullPath);
            }
            $stmtImg->close();
        }

        $news->setCity($city);
        $news->setAuthor($writer);
        $news->setMedia($media);

        return $news;
    }

    private function mapSQLResultToNewsThumbnail(array $row): News
    {
        return new News();
    }

    #endregion

    #region GET USER FAVORITES
    public function findNewsByUserLikes(string $username): array
    {
        $sql = "SELECT
                    n.`id` AS 'news_id',
                    n.`title` AS 'news_title',
                    n.`slug` AS 'news_slug',
                    n.`content` AS 'news_content',
                    n.`view_count` AS 'news_views',
                    n.`created_at` AS 'news_created_at', 
                    n.`updated_at` AS 'news_updated_at',
                    
                    (SELECT COUNT(*) FROM likes WHERE news_id = n.id AND is_like = 1) AS 'news_like_count',
                    (SELECT COUNT(*) FROM likes WHERE news_id = n.id AND is_like = 0) AS 'news_dislike_count',
                    (SELECT COALESCE(AVG(rate), 0) FROM rates WHERE news_id = n.id) AS 'news_rating',
                    (SELECT GROUP_CONCAT(t.name SEPARATOR ',') 
                     FROM news_tags nt 
                     JOIN tags t ON nt.tags_id = t.id 
                     WHERE nt.news_id = n.id) AS 'news_tags_string',
                    (SELECT GROUP_CONCAT(c.name SEPARATOR ',') 
                     FROM news_categories nc 
                     JOIN categories c ON nc.category_id = c.id 
                     WHERE nc.news_id = n.id) AS 'news_categories_names',

                    ctg.`id` AS 'category_id',
                    ctg.`name` AS 'category_name',
                    
                    ct.`id` AS 'city_id',
                    ct.`name` AS 'city_name',
                    ct.`latitude` AS 'city_latitude',
                    ct.`longitude` AS 'city_longitude',
                    
                    cd.`id` AS 'country_division_id',
                    cd.`name` AS 'country_division_name',
                    
                    cm.`id` AS 'country_id',
                    cm.`name` AS 'country_name',
                    cm.`code` AS 'country_code',
                    cm.`telephone` AS 'country_telephone',

                    m.`id` AS 'media_id',
                    m.`name` AS 'media_name',
                    m.`slug` AS 'media_slug',
                    m.`company_name` AS 'media_company_name',
                    m.`media_type` AS 'media_type',
                    m.`picture_ext` AS 'media_picture_ext',
                    m.`logo_ext` AS 'media_logo_ext',
                    m.`website` AS 'media_website',
                    m.`email` AS 'media_email',
                    m.`description` AS 'media_description',

                    w.`username` AS 'writer_username',
                    w.`biography` AS 'writer_biography',
                    w.`is_verified` AS 'writer_is_verified',
                    a.`fullname` AS 'writer_fullname',
                    a.`email` AS 'writer_email',
                    a.`role` AS 'writer_role',
                    a.`profile_picture_ext` AS 'writer_profile_picture_ext'
                FROM
                    news n
                    INNER JOIN `categories` ctg ON n.`category_id` = ctg.`id`
                    LEFT JOIN `cities` ct ON n.`city_id` = ct.`id`
                    LEFT JOIN `country_divisions` cd ON ct.`country_division_id` = cd.`id`
                    LEFT JOIN `countries` cm ON cd.`country_id` = cm.`id`
                    LEFT JOIN `medias` m ON n.`media_id` = m.`id`
                    LEFT JOIN `writers` w ON n.`writer_username` = w.`username`
                    INNER JOIN `accounts` a ON w.`username` = a.`username`
                    INNER JOIN `likes` l ON n.`id` = l.`news_id` AND l.`username` = ?
                WHERE l.`is_like` = 1
                ORDER BY l.`created_at` DESC;";

        $connection = null;
        $stmt = null;
        $newsList = [];

        try {
            $connection = $this->db->connect();
            $stmt = $connection->prepare($sql);
            $stmt->bind_param("s", $username);
            $stmt->execute();
            $result = $stmt->get_result();

            while ($row = $result->fetch_assoc()) {
                $newsList[] = $this->mapSQLResultToNewsObject($row)->toArray();
            }

            return $newsList;
        } catch (Exception $e) {
            throw $e;
        } finally {
            if ($stmt) $stmt->close();
        }
    }
    #endregion
}
?>