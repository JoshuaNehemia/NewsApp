-- Create News

-- Retrieve News (Image-retrieve later)
SELECT
    n.`id` AS 'news_id',
    n.`title` AS 'news_title',
    n.`slug` AS 'news_slug',
    n.`content` AS 'news_content',
    n.`view_count` AS 'news_views',
    ctg.`id` AS 'category_id',
    ctg.`name` AS 'category_name',
    ct.`id` AS 'city_id',
    ct.`name` AS 'city_name',
    cd.`name` AS 'country_division_name',
    cm.`name` AS 'country_name',
    m.`id` AS 'media_id',
    m.`name` AS 'media_name',
    m.`slug` AS 'media_slug',
    m.`logo_ext` AS 'media_logo_ext',
    w.`username` AS 'writer_username',
    a.`fullname` AS 'writer_fullname'
FROM
    news n
    INNER JOIN `categories` ctg ON n.`category_id` = ctg.`id`
    LEFT JOIN `cities` ct ON n.`city_id` = ct.`id`
    LEFT JOIN `country_divisions` cd ON ct.`country_division_id` = cd.`id`
    LEFT JOIN `countries` cm ON cd.`country_id` = cm.`id`
    LEFT JOIN `medias` m ON n.`media_id` = m.`id`
    LEFT JOIN `writers` w ON n.`writer_username` = w.`username`
    INNER JOIN `accounts` a ON w.`username` = a.`username`;
-- Update News

-- Delete News