-- -----------------------------------------------------
-- Seed Data for `tmedias` - Indonesia Media Organizations
-- -----------------------------------------------------

-- 1. Helper Variables for City Lookup (based on previous seeds)
-- We need to find the specific IDs for the cities where these HQs are located.

-- West Jakarta (Metro TV, Media Indonesia)
SET @jkt_west = (
    SELECT c.id FROM tcities c 
    JOIN tcountry_divisions d ON c.country_division_id = d.id 
    JOIN tcountries co ON d.country_id = co.id 
    WHERE c.name = 'West Jakarta' AND d.name = 'Special Region of Jakarta' AND co.code = 'IDN' LIMIT 1
);

-- East Jakarta (TV One)
SET @jkt_east = (
    SELECT c.id FROM tcities c 
    JOIN tcountry_divisions d ON c.country_division_id = d.id 
    JOIN tcountries co ON d.country_id = co.id 
    WHERE c.name = 'East Jakarta' AND d.name = 'Special Region of Jakarta' AND co.code = 'IDN' LIMIT 1
);

-- Central Jakarta (Kompas)
SET @jkt_cent = (
    SELECT c.id FROM tcities c 
    JOIN tcountry_divisions d ON c.country_division_id = d.id 
    JOIN tcountries co ON d.country_id = co.id 
    WHERE c.name = 'Central Jakarta' AND d.name = 'Special Region of Jakarta' AND co.code = 'IDN' LIMIT 1
);

-- South Jakarta (Tempo, Narasi, Berita Satu)
SET @jkt_south = (
    SELECT c.id FROM tcities c 
    JOIN tcountry_divisions d ON c.country_division_id = d.id 
    JOIN tcountries co ON d.country_id = co.id 
    WHERE c.name = 'South Jakarta' AND d.name = 'Special Region of Jakarta' AND co.code = 'IDN' LIMIT 1
);

-- Surabaya (Suara Surabaya, Jawa Pos)
SET @sby = (
    SELECT c.id FROM tcities c 
    JOIN tcountry_divisions d ON c.country_division_id = d.id 
    JOIN tcountries co ON d.country_id = co.id 
    WHERE c.name = 'Surabaya' AND d.name = 'East Java' AND co.code = 'IDN' LIMIT 1
);

-- 2. Insert Media Data
INSERT IGNORE INTO `tmedias` 
(`name`, `slug`, `company_name`, `media_type`, `picture_ext`, `logo_ext`, `website`, `email`, `description`, `city_id`) 
VALUES
-- TV ONE (Pulogadung, East Jakarta)
('TV One', 'tv-one', 'PT Lativi Mediakarya', 'tv', 'jpg', 'png', 'https://www.tvonenews.com', 'redaksi@tvonenews.com', 'TV One is an Indonesian free-to-air television network focusing on news and sports coverage.', @jkt_east),

-- METRO TV (Kedoya, West Jakarta)
('Metro TV', 'metro-tv', 'PT Media Televisi Indonesia', 'tv', 'jpg', 'png', 'https://www.metrotvnews.com', 'redaksi@metrotvnews.com', 'Metro TV is Indonesia\'s first 24-hour news channel, established in 2000.', @jkt_west),

-- KOMPAS (Palmerah Selatan, Central Jakarta)
('Kompas', 'kompas', 'PT Kompas Media Nusantara', 'news', 'jpg', 'png', 'https://www.kompas.id', 'hotline@kompas.id', 'Kompas is one of Indonesia\'s leading national newspapers, known for its in-depth reporting.', @jkt_cent),

-- TEMPO (Palmerah Barat/Kebayoran, South Jakarta)
('Tempo', 'tempo', 'PT Tempo Inti Media Tbk', 'journal', 'jpg', 'png', 'https://www.tempo.co', 'red@tempo.co.id', 'Tempo is an investigative media outlet publishing a weekly magazine and daily news online.', @jkt_south),

-- NARASI (South Jakarta)
('Narasi', 'narasi', 'PT Narasi Citra Sahwahita', 'tv', 'jpg', 'png', 'https://narasi.tv', 'info@narasi.tv', 'Narasi is a digital media and content creation company co-founded by Najwa Shihab.', @jkt_south),

-- Suara Surabaya (Wonokitri, Surabaya)
('Suara Surabaya', 'suara-surabaya', 'PT Radio Suara Surabaya', 'radio', 'jpg', 'png', 'https://www.suarasurabaya.net', 'radio@suarasurabaya.net', 'Suara Surabaya is a pioneering news radio station in Surabaya known for citizen journalism and traffic updates.', @sby),

-- Jawa Pos (Graha Pena, Surabaya)
('Jawa Pos', 'jawa-pos', 'PT Jawa Pos Koran', 'publisher', 'jpg', 'png', 'https://www.jawapos.com', 'redaksi@jawapos.co.id', 'Jawa Pos is a major national daily newspaper based in Surabaya with a wide network across Indonesia.', @sby),

-- MEDIA INDONESIA (Kedoya, West Jakarta)
('Media Indonesia', 'media-indonesia', 'PT Citra Media Nusa Purnama', 'news', 'jpg', 'png', 'https://mediaindonesia.com', 'redaksi@mediaindonesia.com', 'Media Indonesia is a daily newspaper published in Jakarta, focusing on politics and public issues.', @jkt_west),

-- Berita Satu (Gatot Subroto, South Jakarta)
('Berita Satu', 'berita-satu', 'PT BeritaSatu Media Holdings', 'news', 'jpg', 'png', 'https://www.beritasatu.com', 'redaksi@beritasatu.com', 'Berita Satu is a multi-platform media organization delivering news on business, politics, and lifestyle.', @jkt_south);