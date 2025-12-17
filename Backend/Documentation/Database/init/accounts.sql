-- -----------------------------------------------------
-- Seed Data for Authentication (`taccounts`, `tusers`, `twriters`)
-- -----------------------------------------------------

-- 1. Helper Variables for Foreign Keys
-- Cities
SET @city_jkt_cent = (SELECT id FROM tcities WHERE name = 'Central Jakarta' LIMIT 1);
SET @city_jkt_west = (SELECT id FROM tcities WHERE name = 'West Jakarta' LIMIT 1);
SET @city_jkt_south = (SELECT id FROM tcities WHERE name = 'South Jakarta' LIMIT 1);
SET @city_sby = (SELECT id FROM tcities WHERE name = 'Surabaya' LIMIT 1);
SET @city_bdg = (SELECT id FROM tcities WHERE name = 'Bandung' LIMIT 1);

-- Media IDs (assuming seed_indonesia_medias.sql has run)
SET @media_kompas = (SELECT id FROM tmedias WHERE slug = 'kompas' LIMIT 1);
SET @media_metro = (SELECT id FROM tmedias WHERE slug = 'metro-tv' LIMIT 1);
SET @media_jawapos = (SELECT id FROM tmedias WHERE slug = 'jawa-pos' LIMIT 1);
SET @media_tempo = (SELECT id FROM tmedias WHERE slug = 'tempo' LIMIT 1);

-- Password Hash (Standard bcrypt for 'password')
SET @default_pass = 'password';

-- -----------------------------------------------------
-- 2. Insert Accounts (Base Table)
-- -----------------------------------------------------
INSERT IGNORE INTO `taccounts` 
(`username`, `password`, `fullname`, `email`, `city_id`, `role`, `email_verified_at`) 
VALUES
-- Admin
('super_admin', @default_pass, 'Super Administrator', 'admin@system.com', @city_jkt_cent, 'admin', NOW()),

-- Writers (associated with specific Media)
('budi123', @default_pass, 'Budi Santoso', 'budi@kompas.id', @city_jkt_cent, 'writer', NOW()),
('siti123', @default_pass, 'Siti Aminah', 'siti@metrotvnews.com', @city_jkt_west, 'writer', NOW()),
('joko123', @default_pass, 'Joko Anwar', 'joko@jawapos.com', @city_sby, 'writer', NOW()),
('andi123', @default_pass, 'Andi Wijaya', 'andi@tempo.co.id', @city_jkt_south, 'writer', NOW()),

-- Regular Users (Readers)
('dimas123', @default_pass, 'Dimas Anggara', 'dimas@gmail.com', @city_jkt_south, 'user', NOW()),
('rina123', @default_pass, 'Rina Nose', 'rina@yahoo.com', @city_sby, 'user', NOW()),
('emil123', @default_pass, 'Kang Emil', 'emil@outlook.com', @city_bdg, 'user', NOW());

-- -----------------------------------------------------
-- 3. Insert Writers (Extended Profile)
-- -----------------------------------------------------
INSERT IGNORE INTO `twriters` 
(`username`, `tmedia_id`, `role`, `is_verified`, `verified_at`, `verified_by`) 
VALUES
('budi123', @media_kompas, 'editor', TRUE, NOW(), 'super_admin'),
('siti123', @media_metro, 'staff', TRUE, NOW(), 'super_admin'),
('joko123', @media_jawapos, 'contributor', TRUE, NOW(), 'super_admin'),
('andi123', @media_tempo, 'staff', TRUE, NOW(), 'super_admin');

-- -----------------------------------------------------
-- 4. Insert Users (Extended Profile)
-- -----------------------------------------------------
INSERT IGNORE INTO `tusers` 
(`username`, `birthdate`, `gender`, `phone`, `bio`) 
VALUES
('dimas123', '1995-05-20', 'male', '081234567890', 'Tech enthusiast living in South Jakarta. Love reading about startups.'),
('rina123', '1998-11-10', 'female', '081298765432', 'Student at Airlangga University. Avid reader of local news.'),
('emil123', '1990-02-15', 'male', '081355556666', 'Creative designer based in Bandung. Coffee lover.');