<?php

namespace REPOSITORY;

#region REQUIRE
require_once(__DIR__ . "/../MODELS/CORE/DatabaseConnection.php");
require_once(__DIR__ . "/../MODELS/NEWS/Comment.php");
require_once(__DIR__ . "/../MODELS/ACCOUNT/User.php");
#endregion

#region USE
use MODELS\ACCOUNT\User;
use MODELS\NEWS\Comment;
use MODELS\CORE\DatabaseConnection;
use Exception;
#endregion

class RepoComment
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
                c.reply_to_id,
                c.content,
                c.created_at,
                c.updated_at,
                COUNT(rt.comment_id) - 1 AS reply_count
            FROM comments c
            LEFT JOIN reply_tree rt
                ON c.id = rt.root_comment_id
            WHERE c.news_id = ?
            GROUP BY c.id
            ORDER BY c.created_at ASC
            LIMIT ? OFFSET ?;
        ";

        $comments = [];

        try {
            $conn = $this->db->connect();
            $stmt = $conn->prepare($sql);

            if (!$stmt) {
                throw new Exception("Failed to prepare findCommentByNewsId query.");
            }

            $stmt->bind_param("iiii", $news_id, $news_id, $limit, $offset);
            $stmt->execute();

            $result = $stmt->get_result();

            while ($row = $result->fetch_assoc()) {
                $comments[] = $row;
                //TODO: Change to object
            }

            $stmt->close();
            return $comments;

        } catch (Exception $e) {
            throw new Exception("Error fetching comments: " . $e->getMessage());
        }
    }
    #endregion

    #region CREATE
    public function createComment(Comment $comment): bool
    {
        $sql = "
            INSERT INTO comments (
                news_id,
                username,
                reply_to_id,
                content
            ) VALUES (?, ?, ?, ?);
        ";

        try {
            $conn = $this->db->connect();
            $stmt = $conn->prepare($sql);

            if (!$stmt) {
                throw new Exception("Failed to prepare createComment query.");
            }

            $newsId     = $comment->getNews()->getId();
            $username   = $comment->getUser()->getUsername();
            $replyToId  = $comment->getReplyToId();
            $content    = $comment->getContent();

            $stmt->bind_param(
                "isis",
                $newsId,
                $username,
                $replyToId,
                $content
            );

            $success = $stmt->execute();
            $stmt->close();

            return $success;

        } catch (Exception $e) {
            throw new Exception("Error creating comment: " . $e->getMessage());
        }
    }
    #endregion

    #region UPDATE
    public function updateComment(Comment $comment): bool
    {
        $sql = "
            UPDATE comments
            SET content = ?, updated_at = CURRENT_TIMESTAMP
            WHERE id = ?
              AND username = ?
            LIMIT 1;
        ";

        try {
            $conn = $this->db->connect();
            $stmt = $conn->prepare($sql);

            if (!$stmt) {
                throw new Exception("Failed to prepare updateComment query.");
            }

            $content  = $comment->getContent();
            $id       = $comment->getId();
            $username = $comment->getUser()->getUsername();

            $stmt->bind_param("sis", $content, $id, $username);

            $success = $stmt->execute();
            $stmt->close();

            return $success;

        } catch (Exception $e) {
            throw new Exception("Error updating comment: " . $e->getMessage());
        }
    }
    #endregion

    #region DELETE
    public function deleteComment(Comment $comment): bool
    {
        $sql = "
            DELETE FROM comments
            WHERE id = ?
              AND username = ?
            LIMIT 1;
        ";

        try {
            $conn = $this->db->connect();
            $stmt = $conn->prepare($sql);

            if (!$stmt) {
                throw new Exception("Failed to prepare deleteComment query.");
            }

            $id       = $comment->getId();
            $username = $comment->getUser()->getUsername();

            $stmt->bind_param("is", $id, $username);

            $success = $stmt->execute();
            $stmt->close();

            return $success;

        } catch (Exception $e) {
            throw new Exception("Error deleting comment: " . $e->getMessage());
        }
    }
    #endregion
}
