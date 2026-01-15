<?php

namespace REPOSITORY;

#region REQUIRE
require_once(__DIR__ . "/../MODELS/CORE/DatabaseConnection.php");
require_once(__DIR__ . "/../MODELS/NEWS/Comment.php");
require_once(__DIR__ . "/../MODELS/NEWS/News.php");
require_once(__DIR__ . "/../MODELS/ACCOUNT/User.php");
#endregion

#region USE
use MODELS\ACCOUNT\User;
use MODELS\NEWS\Comment;
use MODELS\NEWS\News;
use MODELS\CORE\DatabaseConnection;
use Exception;
#endregion

class RepoComment
{
    #region CONSTRUCTOR
    public function __construct()
    {
        // No longer storing DatabaseConnection as field
        // Each method will create its own connection
    }
    #endregion

    #region RETRIEVE
    public function findCommentByNewsId(int $news_id, int $limit = 10, int $offset = 0): array
    {
        $sql = "WITH RECURSIVE reply_tree AS (
                SELECT
                    c.id AS root_comment_id,
                    c.id AS comment_id
                FROM comments c
                WHERE c.news_id = ?

                UNION ALL

                SELECT
                    rt.root_comment_id,
                    c.id AS comment_id
                FROM comments c
                INNER JOIN reply_tree rt
                    ON c.reply_to_id = rt.comment_id
            )
            SELECT
                c.id,
                c.news_id,
                c.username,
                a.fullname,
                c.reply_to_id,
                c.content,
                c.created_at,
                c.updated_at,
                COUNT(rt.comment_id) - 1 AS reply_count
            FROM comments c
            LEFT JOIN reply_tree rt
                ON c.id = rt.root_comment_id
            LEFT JOIN accounts a 
                ON c.username = a.username
            WHERE c.news_id = ? AND c.reply_to_id IS NULL
            GROUP BY c.id
            ORDER BY c.created_at ASC
            LIMIT ? OFFSET ?;
        ";

        $comments = [];

        try {
            $db = new DatabaseConnection();
            $conn = $db->connect();
            $stmt = $conn->prepare($sql);

            if (!$stmt) {
                throw new Exception("Failed to prepare findCommentByNewsId query.");
            }

            $stmt->bind_param("iiii", $news_id, $news_id, $limit, $offset);

            if (!$stmt->execute()) {
                throw new Exception("Failed to find comment:" . $stmt->error);
            }

            $result = $stmt->get_result();

            while ($row = $result->fetch_assoc()) {
                $comments[] = $this->mapSQLResultToCommentObject($row);
            }

            return $comments;

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

    /**
     * Get all comments (including replies) for a news article
     * Used for building hierarchical structure on frontend
     */
    public function getAllComments(int $news_id, int $limit = 100, int $offset = 0): array
    {
        $sql = "SELECT
                c.id,
                c.news_id,
                c.username,
                a.fullname,
                c.reply_to_id,
                c.content,
                c.created_at,
                c.updated_at
            FROM comments c
            LEFT JOIN accounts a 
                ON c.username = a.username
            WHERE c.news_id = ?
            ORDER BY c.created_at ASC
            LIMIT ? OFFSET ?;
        ";

        $comments = [];

        try {
            $db = new DatabaseConnection();
            $conn = $db->connect();
            $stmt = $conn->prepare($sql);

            if (!$stmt) {
                throw new Exception("Failed to prepare getAllComments query.");
            }

            $stmt->bind_param("iii", $news_id, $limit, $offset);

            if (!$stmt->execute()) {
                throw new Exception("Failed to get all comments:" . $stmt->error);
            }

            $result = $stmt->get_result();

            while ($row = $result->fetch_assoc()) {
                $comments[] = $this->mapSQLResultToCommentObject($row);
            }

            return $comments;

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


    public function findReplyCommentByReplyToId(int $replyToId, int $limit = 10, int $offset = 0): array
    {
        $sql = "WITH RECURSIVE reply_tree AS (
                SELECT
                    c.id AS root_comment_id,
                    c.id AS comment_id
                FROM comments c
                WHERE c.news_id = ?

                UNION ALL

                SELECT
                    rt.root_comment_id,
                    c.id AS comment_id
                FROM comments c
                INNER JOIN reply_tree rt
                    ON c.reply_to_id = rt.comment_id
            )
            SELECT
                c.id,
                c.news_id,
                c.username,
                a.fullname,
                c.reply_to_id,
                c.content,
                c.created_at,
                c.updated_at,
                COUNT(rt.comment_id) - 1 AS reply_count
            FROM comments c
            LEFT JOIN reply_tree rt
                ON c.id = rt.root_comment_id
            LEFT JOIN accounts a 
                ON c.username = a.username
            WHERE c.reply_to_id = ?
            GROUP BY c.id
            ORDER BY c.created_at ASC
            LIMIT ? OFFSET ?;
        ";

        $comments = [];

        try {
            $db = new DatabaseConnection();
            $conn = $db->connect();
            $stmt = $conn->prepare($sql);

            if (!$stmt) {
                throw new Exception("Failed to prepare findCommentByNewsId query.");
            }

            $stmt->bind_param("iiii", $news_id, $news_id, $limit, $offset);

            if (!$stmt->execute()) {
                throw new Exception("Failed to find comment:" . $stmt->error);
            }

            $result = $stmt->get_result();

            while ($row = $result->fetch_assoc()) {
                $comments[] = $this->mapSQLResultToCommentObject($row);
            }
            return $comments;

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

    #region CREATE
    public function createComment(Comment $comment): bool
    {
        $sql = "INSERT INTO comments (
                news_id,
                username,
                reply_to_id,
                content
            ) VALUES (?, ?, ?, ?);";

        try {
            $db = new DatabaseConnection();
            $conn = $db->connect();
            $stmt = $conn->prepare($sql);

            if (!$stmt) {
                throw new Exception("Failed to prepare createComment query.");
            }

            $newsId = $comment->getNews()->getId();
            $username = $comment->getUser()->getUsername();
            $replyToId = $comment->getReplyToId();
            $content = $comment->getContent();

            $stmt->bind_param(
                "isis",
                $newsId,
                $username,
                $replyToId,
                $content
            );

            if (!$stmt->execute()) {
                throw new Exception("Failed to create comment:" . $stmt->error);
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

    #region UPDATE
    public function updateComment(Comment $comment): bool
    {
        $sql = "UPDATE comments
            SET content = ?
            WHERE id = ?
              AND username = ?
            LIMIT 1;";

        try {
            $db = new DatabaseConnection();
            $conn = $db->connect();
            $stmt = $conn->prepare($sql);

            if (!$stmt) {
                throw new Exception("Failed to prepare updateComment query.");
            }

            $content = $comment->getContent();
            $id = $comment->getId();
            $username = $comment->getUser()->getUsername();

            $stmt->bind_param("sis", $content, $id, $username);

            if (!$stmt->execute()) {
                throw new Exception("Failed to update comment:" . $stmt->error);
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
    public function deleteComment(Comment $comment): bool
    {
        $sql = "DELETE FROM comments
            WHERE id = ?
              AND username = ?
            LIMIT 1;";

        try {
            $db = new DatabaseConnection();
            $conn = $db->connect();
            $stmt = $conn->prepare($sql);

            if (!$stmt) {
                throw new Exception("Failed to prepare deleteComment query.");
            }

            $id = $comment->getId();
            $username = $comment->getUser()->getUsername();

            $stmt->bind_param("is", $id, $username);

            if (!$stmt->execute()) {
                throw new Exception("Failed to delete  comment:" . $stmt->error);
            }
            $stmt->close();

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

    #region MAPPER
    private function mapSQLResultToCommentObject(array $row): Comment
    {

        $user = new User();
        $user->setUsername($row['username']);
        $user->setFullname($row['fullname']);
        $news = new News();
        $news->setId($row['news_id']);
        $comment = new Comment();
        $comment->setId($row["id"]);
        $comment->setCreatedAt($row["created_at"]);
        $comment->setUpdatedAt($row["updated_at"]);
        $comment->setContent($row['content']);
        $comment->setReplyToId($row['reply_to_id'] ?? null);
        $comment->setUser($user);
        $comment->setNews($news);
        return $comment;
    }
    #endregion
}
