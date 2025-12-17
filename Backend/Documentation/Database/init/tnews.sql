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