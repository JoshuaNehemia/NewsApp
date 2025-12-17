WITH RECURSIVE comment_tree AS (

    SELECT
        id AS root_comment_id,
        id AS comment_id
    FROM tcomments

    UNION ALL

    SELECT
        ct.root_comment_id,
        c.id AS comment_id
    FROM comment_tree ct
    JOIN tcomments c
        ON c.reply_to_id = ct.comment_id
)
SELECT
    root_comment_id AS comment_id,
    COUNT(*) - 1 AS total_reply_count
FROM comment_tree
GROUP BY root_comment_id;


DELIMITER $$;
CREATE STORED PROCEDURE