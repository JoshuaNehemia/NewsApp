-- -----------------------------------------------------
-- Seed Data for `tcategories`
-- Standard News Categories
-- -----------------------------------------------------

INSERT IGNORE INTO `tcategories` (`name`) VALUES 
('National'),
('World'),
('Politics'),
('Business'),
('Economy'),
('Technology'),
('Science'),
('Health'),
('Sports'),
('Entertainment'),
('Lifestyle'),
('Travel'),
('Automotive'),
('Education'),
('Opinion'),
('Environment'),
('Culture');

-- -----------------------------------------------------
-- Seed Data for `ttags`
-- Granular tags associated with categories
-- -----------------------------------------------------

-- 1. Sports (Football, Badminton, Racing)
SET @cat = (SELECT id FROM tcategories WHERE name = 'Sports');
INSERT IGNORE INTO `ttags` (`category_id`, `name`) VALUES
(@cat, 'Football'),
(@cat, 'Premier League'),
(@cat, 'Champions League'),
(@cat, 'Liga 1 Indonesia'),
(@cat, 'Real Madrid'),
(@cat, 'Manchester United'),
(@cat, 'Timnas Indonesia'),
(@cat, 'Badminton'),
(@cat, 'Formula 1'),
(@cat, 'MotoGP'),
(@cat, 'Basketball'),
(@cat, 'NBA');

-- 2. Politics (Elections, Government)
SET @cat = (SELECT id FROM tcategories WHERE name = 'Politics');
INSERT IGNORE INTO `ttags` (`category_id`, `name`) VALUES
(@cat, 'Pemilu 2024'),
(@cat, 'Presidential Election'),
(@cat, 'DPR RI'),
(@cat, 'KPK'),
(@cat, 'Corruption'),
(@cat, 'Foreign Policy'),
(@cat, 'Human Rights'),
(@cat, 'Regional Elections (Pilkada)');

-- 3. Technology (AI, Gadgets, Digital)
SET @cat = (SELECT id FROM tcategories WHERE name = 'Technology');
INSERT IGNORE INTO `ttags` (`category_id`, `name`) VALUES
(@cat, 'Artificial Intelligence'),
(@cat, 'Smartphones'),
(@cat, 'Apple'),
(@cat, 'Samsung'),
(@cat, 'Startup'),
(@cat, 'Cybersecurity'),
(@cat, 'Social Media'),
(@cat, 'Blockchain'),
(@cat, 'Cryptocurrency'),
(@cat, '5G Network');

-- 4. Business & Economy (Markets, Finance)
SET @cat = (SELECT id FROM tcategories WHERE name = 'Economy');
INSERT IGNORE INTO `ttags` (`category_id`, `name`) VALUES
(@cat, 'IHSG'),
(@cat, 'Inflation'),
(@cat, 'Interest Rates'),
(@cat, 'Banking'),
(@cat, 'UMKM (SMEs)'),
(@cat, 'Digital Economy'),
(@cat, 'Investment'),
(@cat, 'Export-Import');

-- 5. Entertainment (Movies, Music)
SET @cat = (SELECT id FROM tcategories WHERE name = 'Entertainment');
INSERT IGNORE INTO `ttags` (`category_id`, `name`) VALUES
(@cat, 'Movies'),
(@cat, 'K-Pop'),
(@cat, 'Music'),
(@cat, 'Celebrity Gossip'),
(@cat, 'Netflix'),
(@cat, 'Indonesian Film'),
(@cat, 'Concerts'),
(@cat, 'Drama Series');

-- 6. Automotive (Cars, Bikes)
SET @cat = (SELECT id FROM tcategories WHERE name = 'Automotive');
INSERT IGNORE INTO `ttags` (`category_id`, `name`) VALUES
(@cat, 'Electric Vehicles (EV)'),
(@cat, 'Motorcycles'),
(@cat, 'Car Reviews'),
(@cat, 'Traffic Regulations'),
(@cat, 'GIIAS'),
(@cat, 'Toyota'),
(@cat, 'Honda');

-- 7. Health (Wellness, Disease)
SET @cat = (SELECT id FROM tcategories WHERE name = 'Health');
INSERT IGNORE INTO `ttags` (`category_id`, `name`) VALUES
(@cat, 'Mental Health'),
(@cat, 'Nutrition'),
(@cat, 'COVID-19'),
(@cat, 'Fitness'),
(@cat, 'Medical Research'),
(@cat, 'Public Health'),
(@cat, 'Healthy Diet');

-- 8. Environment (Climate, Nature)
SET @cat = (SELECT id FROM tcategories WHERE name = 'Environment');
INSERT IGNORE INTO `ttags` (`category_id`, `name`) VALUES
(@cat, 'Climate Change'),
(@cat, 'Pollution'),
(@cat, 'Renewable Energy'),
(@cat, 'Conservation'),
(@cat, 'Global Warming'),
(@cat, 'Sustainability');

-- 9. Travel (Tourism)
SET @cat = (SELECT id FROM tcategories WHERE name = 'Travel');
INSERT IGNORE INTO `ttags` (`category_id`, `name`) VALUES
(@cat, 'Bali Tourism'),
(@cat, 'Culinary Travel'),
(@cat, 'Hidden Gems'),
(@cat, 'Hotel Reviews'),
(@cat, 'Flight Deals'),
(@cat, 'Visa Policy');

-- -----------------------------------------------------
-- Seed Data for User Preferences, Writer Specialties, and Followed Tags
-- -----------------------------------------------------

-- 1. Helper Variables for Categories
SET @cat_pol = (SELECT id FROM tcategories WHERE name = 'Politics' LIMIT 1);
SET @cat_sport = (SELECT id FROM tcategories WHERE name = 'Sports' LIMIT 1);
SET @cat_tech = (SELECT id FROM tcategories WHERE name = 'Technology' LIMIT 1);
SET @cat_biz = (SELECT id FROM tcategories WHERE name = 'Economy' LIMIT 1);
SET @cat_ent = (SELECT id FROM tcategories WHERE name = 'Entertainment' LIMIT 1);
SET @cat_auto = (SELECT id FROM tcategories WHERE name = 'Automotive' LIMIT 1);

-- -----------------------------------------------------
-- 2. User Preferences (`tpreferences`)
-- -----------------------------------------------------
-- dimas123 (formerly reader_jkt) likes Tech and Politics
INSERT IGNORE INTO `tpreferences` (`username`, `category_id`) VALUES ('dimas123', @cat_tech);
INSERT IGNORE INTO `tpreferences` (`username`, `category_id`) VALUES ('dimas123', @cat_pol);

-- rina123 (formerly reader_sby) likes Sports and Entertainment
INSERT IGNORE INTO `tpreferences` (`username`, `category_id`) VALUES ('rina123', @cat_sport);
INSERT IGNORE INTO `tpreferences` (`username`, `category_id`) VALUES ('rina123', @cat_ent);

-- emil123 (formerly reader_bdg) likes Automotive and Business
INSERT IGNORE INTO `tpreferences` (`username`, `category_id`) VALUES ('emil123', @cat_auto);
INSERT IGNORE INTO `tpreferences` (`username`, `category_id`) VALUES ('emil123', @cat_biz);

-- -----------------------------------------------------
-- 3. Writer Specialties (`tspecialties`)
-- -----------------------------------------------------
-- budi123 (formerly editor_kompas) specializes in Politics
INSERT IGNORE INTO `tspecialties` (`username`, `category_id`) VALUES ('budi123', @cat_pol);

-- siti123 (formerly journo_metro) specializes in Politics
INSERT IGNORE INTO `tspecialties` (`username`, `category_id`) VALUES ('siti123', @cat_pol);

-- joko123 (formerly writer_jawapos) specializes in Sports
INSERT IGNORE INTO `tspecialties` (`username`, `category_id`) VALUES ('joko123', @cat_sport);

-- andi123 (formerly investigator_tempo) specializes in Politics and Economy
INSERT IGNORE INTO `tspecialties` (`username`, `category_id`) VALUES ('andi123', @cat_pol);
INSERT IGNORE INTO `tspecialties` (`username`, `category_id`) VALUES ('andi123', @cat_biz);

-- -----------------------------------------------------
-- 4. User Followed Tags (`tuser_followed_tags`)
-- -----------------------------------------------------

-- Helper to find tag IDs
SET @tag_pemilu = (SELECT id FROM ttags WHERE name = 'Pemilu 2024' LIMIT 1);
SET @tag_startup = (SELECT id FROM ttags WHERE name = 'Startup' LIMIT 1);
SET @tag_liga1 = (SELECT id FROM ttags WHERE name = 'Liga 1 Indonesia' LIMIT 1);
SET @tag_kpop = (SELECT id FROM ttags WHERE name = 'K-Pop' LIMIT 1);
SET @tag_ev = (SELECT id FROM ttags WHERE name = 'Electric Vehicles (EV)' LIMIT 1);

-- dimas123 follows Pemilu 2024 & Startups
INSERT IGNORE INTO `tuser_followed_tags` (`username`, `tag_id`) VALUES 
('dimas123', @tag_pemilu),
('dimas123', @tag_startup);

-- rina123 follows Liga 1 & K-Pop
INSERT IGNORE INTO `tuser_followed_tags` (`username`, `tag_id`) VALUES 
('rina123', @tag_liga1),
('rina123', @tag_kpop);

-- emil123 follows EV
INSERT IGNORE INTO `tuser_followed_tags` (`username`, `tag_id`) VALUES 
('emil123', @tag_ev);