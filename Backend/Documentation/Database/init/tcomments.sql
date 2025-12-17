-- -----------------------------------------------------
-- Seed Data for `tnews`
-- Articles written by registered writers
-- -----------------------------------------------------

-- 1. Helper Variables for Categories
SET @cat_pol = (SELECT id FROM tcategories WHERE name = 'Politics' LIMIT 1);
SET @cat_sport = (SELECT id FROM tcategories WHERE name = 'Sports' LIMIT 1);
SET @cat_tech = (SELECT id FROM tcategories WHERE name = 'Technology' LIMIT 1);
SET @cat_biz = (SELECT id FROM tcategories WHERE name = 'Economy' LIMIT 1);

-- 2. Helper Variables for Cities
SET @city_jkt_cent = (SELECT id FROM tcities WHERE name = 'Central Jakarta' LIMIT 1);
SET @city_sby = (SELECT id FROM tcities WHERE name = 'Surabaya' LIMIT 1);
SET @city_jkt_south = (SELECT id FROM tcities WHERE name = 'South Jakarta' LIMIT 1);

-- -----------------------------------------------------
-- 3. Insert News Articles
-- -----------------------------------------------------

-- Article 1: Politics by budi123 (Kompas)
INSERT IGNORE INTO `tnews` 
(`writer_username`, `tcategories_id`, `city_id`, `title`, `slug`, `content`, `is_published`, `view_count`) 
VALUES (
    'budi123', 
    @cat_pol, 
    @city_jkt_cent, 
    'Analysis: The Shifting Coalitions Ahead of 2024 Elections', 
    'analysis-shifting-coalitions-2024', 
    'As the political year approaches, major parties are beginning to consolidate their positions. This comprehensive analysis looks at the potential alliances forming in the capital...', 
    1, 
    1540
);

-- Article 2: Sports by joko123 (Jawa Pos)
INSERT IGNORE INTO `tnews` 
(`writer_username`, `tcategories_id`, `city_id`, `title`, `slug`, `content`, `is_published`, `view_count`) 
VALUES (
    'joko123', 
    @cat_sport, 
    @city_sby, 
    'Persebaya Secures Dramatic Win at Gelora Bung Tomo', 
    'persebaya-secures-dramatic-win-gbt', 
    'In a stunning display of grit, Persebaya Surabaya managed to secure 3 points in the final minutes of the game. The atmosphere at GBT was electric as the Green Force pressed on...', 
    1, 
    5200
);

-- Article 3: Economy by andi123 (Tempo)
INSERT IGNORE INTO `tnews` 
(`writer_username`, `tcategories_id`, `city_id`, `title`, `slug`, `content`, `is_published`, `view_count`) 
VALUES (
    'andi123', 
    @cat_biz, 
    @city_jkt_south, 
    'Impact of Global Interest Rates on Indonesian Startups', 
    'impact-global-rates-indonesian-startups', 
    'The tech winter continues as global interest rates remain high. Many startups in South Jakarta are pivoting towards profitability rather than growth at all costs...', 
    1, 
    890
);

-- Article 4: Politics/Gov by siti123 (Metro TV)
INSERT IGNORE INTO `tnews` 
(`writer_username`, `tcategories_id`, `city_id`, `title`, `slug`, `content`, `is_published`, `view_count`) 
VALUES (
    'siti123', 
    @cat_pol, 
    @city_jkt_cent, 
    'New Infrastructure Bill Passed: What It Means for Java', 
    'new-infrastructure-bill-passed-java', 
    'The House of Representatives has officially passed the new infrastructure bill today. Key provisions include accelerated development for toll roads connecting West and East Java...', 
    1, 
    2100
);

-- Article 5: Draft Article (Not Published) by budi123
INSERT IGNORE INTO `tnews` 
(`writer_username`, `tcategories_id`, `city_id`, `title`, `slug`, `content`, `is_published`, `view_count`) 
VALUES (
    'budi123', 
    @cat_pol, 
    @city_jkt_cent, 
    'Exclusive Interview with Governor Candidate [DRAFT]', 
    'exclusive-interview-governor-candidate-draft', 
    'Pending final approval from editorial team. Notes: Discuss vision for public transportation and flood management...', 
    0, 
    0
);

-- -----------------------------------------------------
-- 4. Seed Data for `tcomments`
-- -----------------------------------------------------

-- Get IDs for the news articles created above
SET @news_pol = (SELECT id FROM tnews WHERE slug = 'analysis-shifting-coalitions-2024' LIMIT 1);
SET @news_sport = (SELECT id FROM tnews WHERE slug = 'persebaya-secures-dramatic-win-gbt' LIMIT 1);
SET @news_biz = (SELECT id FROM tnews WHERE slug = 'impact-global-rates-indonesian-startups' LIMIT 1);

-- 4.1. Politics Discussion
-- Parent Comment by dimas123
INSERT INTO `tcomments` (`tnews_id`, `user_username`, `content`, `created_at`) 
VALUES (@news_pol, 'dimas123', 'Interesting analysis, but I think the coalition map will change again next month.', NOW());

-- Capture ID of the comment above for the reply
SET @parent_comment_1 = LAST_INSERT_ID();

-- Reply by emil123 (replying to dimas123)
INSERT INTO `tcomments` (`tnews_id`, `user_username`, `reply_to_id`, `content`, `created_at`) 
VALUES (@news_pol, 'emil123', @parent_comment_1, 'Agreed. The dynamics in Jakarta are very fluid right now.', NOW());

-- 4.2. Sports Discussion (Recursive Example)
-- Level 1: Parent Comment by rina123
INSERT INTO `tcomments` (`tnews_id`, `user_username`, `content`, `created_at`) 
VALUES (@news_sport, 'rina123', 'What a game! The atmosphere at GBT was insane last night. #Wani', NOW());

-- Capture ID Level 1
SET @lvl1_comment_id = LAST_INSERT_ID();

-- Level 2: Reply by dimas123 (replying to rina123)
INSERT INTO `tcomments` (`tnews_id`, `user_username`, `reply_to_id`, `content`, `created_at`) 
VALUES (@news_sport, 'dimas123', @lvl1_comment_id, 'Wish I could have been there. That last goal was pure class.', NOW());

-- Capture ID Level 2
SET @lvl2_comment_id = LAST_INSERT_ID();

-- Level 3: Reply by joko123 (Writer replying to dimas123)
INSERT INTO `tcomments` (`tnews_id`, `user_username`, `reply_to_id`, `content`, `created_at`) 
VALUES (@news_sport, 'joko123', @lvl2_comment_id, 'Thanks for reading Dimas! The coach really nailed the substitution tactics in the 80th minute.', NOW());

-- Capture ID Level 3
SET @lvl3_comment_id = LAST_INSERT_ID();

-- Level 4: Reply by rina123 (Original poster replying to the Writer/Level 3)
INSERT INTO `tcomments` (`tnews_id`, `user_username`, `reply_to_id`, `content`, `created_at`) 
VALUES (@news_sport, 'rina123', @lvl3_comment_id, 'Exactly Mas Joko! Bringing on the winger changed the pace entirely.', NOW());

-- 4.3. Economy Discussion
-- Parent Comment by emil123
INSERT INTO `tcomments` (`tnews_id`, `user_username`, `content`, `created_at`) 
VALUES (@news_biz, 'emil123', 'This is exactly why local startups need to focus on unit economics ASAP.', NOW());