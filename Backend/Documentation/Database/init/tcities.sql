-- -----------------------------------------------------
-- Seed Data for `tcities` - Indonesia (Major Cities)
-- -----------------------------------------------------

-- 1. Get Indonesia Country ID
SET @idn = (SELECT id FROM tcountries WHERE code = 'IDN');

-- -----------------------------------------------------
-- Java Region
-- -----------------------------------------------------

-- Special Region of Jakarta (DKI)
SET @div = (SELECT id FROM tcountry_divisions WHERE country_id = @idn AND name = 'Special Region of Jakarta');
INSERT IGNORE INTO `tcities` (`country_division_id`, `name`, `latitude`, `longitude`) VALUES
(@div, 'Central Jakarta', -6.1805, 106.8284),
(@div, 'North Jakarta', -6.1384, 106.8645),
(@div, 'West Jakarta', -6.1674, 106.7637),
(@div, 'South Jakarta', -6.2615, 106.8106),
(@div, 'East Jakarta', -6.2250, 106.9004);

-- West Java
SET @div = (SELECT id FROM tcountry_divisions WHERE country_id = @idn AND name = 'West Java');
INSERT IGNORE INTO `tcities` (`country_division_id`, `name`, `latitude`, `longitude`) VALUES
(@div, 'Bandung', -6.9175, 107.6191),
(@div, 'Bekasi', -6.2383, 106.9756),
(@div, 'Bogor', -6.5971, 106.8060),
(@div, 'Depok', -6.4025, 106.7942),
(@div, 'Cirebon', -6.7320, 108.5523),
(@div, 'Sukabumi', -6.9277, 106.9300),
(@div, 'Tasikmalaya', -7.3274, 108.2207),
(@div, 'Cimahi', -6.8726, 107.5422),
(@div, 'Banjar', -7.3746, 108.5581);

-- Central Java
SET @div = (SELECT id FROM tcountry_divisions WHERE country_id = @idn AND name = 'Central Java');
INSERT IGNORE INTO `tcities` (`country_division_id`, `name`, `latitude`, `longitude`) VALUES
(@div, 'Semarang', -6.9667, 110.4167),
(@div, 'Surakarta (Solo)', -7.5755, 110.8243),
(@div, 'Magelang', -7.4706, 110.2178),
(@div, 'Pekalongan', -6.8886, 109.6753),
(@div, 'Salatiga', -7.3305, 110.5084),
(@div, 'Tegal', -6.8694, 109.1402);

-- Special Region of Yogyakarta
SET @div = (SELECT id FROM tcountry_divisions WHERE country_id = @idn AND name = 'Special Region of Yogyakarta');
INSERT IGNORE INTO `tcities` (`country_division_id`, `name`, `latitude`, `longitude`) VALUES
(@div, 'Yogyakarta', -7.7956, 110.3695);

-- East Java
SET @div = (SELECT id FROM tcountry_divisions WHERE country_id = @idn AND name = 'East Java');
INSERT IGNORE INTO `tcities` (`country_division_id`, `name`, `latitude`, `longitude`) VALUES
(@div, 'Surabaya', -7.2575, 112.7521),
(@div, 'Malang', -7.9666, 112.6326),
(@div, 'Kediri', -7.8485, 112.0278),
(@div, 'Madiun', -7.6298, 111.5240),
(@div, 'Mojokerto', -7.4726, 112.4381),
(@div, 'Pasuruan', -7.6453, 112.9075),
(@div, 'Probolinggo', -7.7543, 113.2159),
(@div, 'Batu', -7.8671, 112.5239),
(@div, 'Blitar', -8.0954, 112.1610);

-- Banten
SET @div = (SELECT id FROM tcountry_divisions WHERE country_id = @idn AND name = 'Banten');
INSERT IGNORE INTO `tcities` (`country_division_id`, `name`, `latitude`, `longitude`) VALUES
(@div, 'Serang', -6.1104, 106.1640),
(@div, 'Tangerang', -6.1731, 106.6300),
(@div, 'Cilegon', -6.0174, 106.0538),
(@div, 'South Tangerang', -6.2886, 106.7179);

-- -----------------------------------------------------
-- Sumatra Region
-- -----------------------------------------------------

-- Ngaroe Aceh Darusallam
SET @div = (SELECT id FROM tcountry_divisions WHERE country_id = @idn AND name = 'Ngaroe Aceh Darusallam');
INSERT IGNORE INTO `tcities` (`country_division_id`, `name`, `latitude`, `longitude`) VALUES
(@div, 'Banda Aceh', 5.5483, 95.3238),
(@div, 'Lhokseumawe', 5.1804, 97.1501),
(@div, 'Langsa', 4.4722, 97.9755),
(@div, 'Sabang', 5.8926, 95.3211);

-- North Sumatra
SET @div = (SELECT id FROM tcountry_divisions WHERE country_id = @idn AND name = 'North Sumatra');
INSERT IGNORE INTO `tcities` (`country_division_id`, `name`, `latitude`, `longitude`) VALUES
(@div, 'Medan', 3.5952, 98.6722),
(@div, 'Pematang Siantar', 2.9628, 99.0607),
(@div, 'Binjai', 3.5991, 98.4875),
(@div, 'Tebing Tinggi', 3.3284, 99.1625);

-- West Sumatra
SET @div = (SELECT id FROM tcountry_divisions WHERE country_id = @idn AND name = 'West Sumatra');
INSERT IGNORE INTO `tcities` (`country_division_id`, `name`, `latitude`, `longitude`) VALUES
(@div, 'Padang', -0.9471, 100.4172),
(@div, 'Bukittinggi', -0.3039, 100.3732),
(@div, 'Payakumbuh', -0.2229, 100.6341),
(@div, 'Pariaman', -0.6264, 100.1206);

-- Riau
SET @div = (SELECT id FROM tcountry_divisions WHERE country_id = @idn AND name = 'Riau');
INSERT IGNORE INTO `tcities` (`country_division_id`, `name`, `latitude`, `longitude`) VALUES
(@div, 'Pekanbaru', 0.5071, 101.4478),
(@div, 'Dumai', 1.6776, 101.4482);

-- Riau Islands
SET @div = (SELECT id FROM tcountry_divisions WHERE country_id = @idn AND name = 'Riau Islands');
INSERT IGNORE INTO `tcities` (`country_division_id`, `name`, `latitude`, `longitude`) VALUES
(@div, 'Tanjung Pinang', 0.9165, 104.4485),
(@div, 'Batam', 1.0456, 104.0305);

-- Jambi
SET @div = (SELECT id FROM tcountry_divisions WHERE country_id = @idn AND name = 'Jambi');
INSERT IGNORE INTO `tcities` (`country_division_id`, `name`, `latitude`, `longitude`) VALUES
(@div, 'Jambi', -1.6099, 103.6073),
(@div, 'Sungai Penuh', -2.0645, 101.3934);

-- South Sumatra
SET @div = (SELECT id FROM tcountry_divisions WHERE country_id = @idn AND name = 'South Sumatra');
INSERT IGNORE INTO `tcities` (`country_division_id`, `name`, `latitude`, `longitude`) VALUES
(@div, 'Palembang', -2.9761, 104.7754),
(@div, 'Lubuklinggau', -3.2952, 102.8601),
(@div, 'Prabumulih', -3.4283, 104.2272);

-- Bengkulu
SET @div = (SELECT id FROM tcountry_divisions WHERE country_id = @idn AND name = 'Bengkulu');
INSERT IGNORE INTO `tcities` (`country_division_id`, `name`, `latitude`, `longitude`) VALUES
(@div, 'Bengkulu', -3.7928, 102.2608);

-- Lampung
SET @div = (SELECT id FROM tcountry_divisions WHERE country_id = @idn AND name = 'Lampung');
INSERT IGNORE INTO `tcities` (`country_division_id`, `name`, `latitude`, `longitude`) VALUES
(@div, 'Bandar Lampung', -5.3971, 105.2668),
(@div, 'Metro', -5.1131, 105.3085);

-- -----------------------------------------------------
-- Kalimantan (Borneo) Region
-- -----------------------------------------------------

-- West Kalimantan
SET @div = (SELECT id FROM tcountry_divisions WHERE country_id = @idn AND name = 'West Kalimantan');
INSERT IGNORE INTO `tcities` (`country_division_id`, `name`, `latitude`, `longitude`) VALUES
(@div, 'Pontianak', -0.0263, 109.3425),
(@div, 'Singkawang', 0.9103, 108.9877);

-- Central Kalimantan
SET @div = (SELECT id FROM tcountry_divisions WHERE country_id = @idn AND name = 'Central Kalimantan');
INSERT IGNORE INTO `tcities` (`country_division_id`, `name`, `latitude`, `longitude`) VALUES
(@div, 'Palangkaraya', -2.2136, 113.9213);

-- South Kalimantan
SET @div = (SELECT id FROM tcountry_divisions WHERE country_id = @idn AND name = 'South Kalimantan');
INSERT IGNORE INTO `tcities` (`country_division_id`, `name`, `latitude`, `longitude`) VALUES
(@div, 'Banjarmasin', -3.3186, 114.5944),
(@div, 'Banjarbaru', -3.4410, 114.8319);

-- East Kalimantan
SET @div = (SELECT id FROM tcountry_divisions WHERE country_id = @idn AND name = 'East Kalimantan');
INSERT IGNORE INTO `tcities` (`country_division_id`, `name`, `latitude`, `longitude`) VALUES
(@div, 'Samarinda', -0.5017, 117.1537),
(@div, 'Balikpapan', -1.2379, 116.8529),
(@div, 'Bontang', 0.1330, 117.5000);

-- North Kalimantan
SET @div = (SELECT id FROM tcountry_divisions WHERE country_id = @idn AND name = 'North Kalimantan');
INSERT IGNORE INTO `tcities` (`country_division_id`, `name`, `latitude`, `longitude`) VALUES
(@div, 'Tarakan', 3.3274, 117.5746);

-- -----------------------------------------------------
-- Sulawesi Region
-- -----------------------------------------------------

-- North Sulawesi
SET @div = (SELECT id FROM tcountry_divisions WHERE country_id = @idn AND name = 'North Sulawesi');
INSERT IGNORE INTO `tcities` (`country_division_id`, `name`, `latitude`, `longitude`) VALUES
(@div, 'Manado', 1.4748, 124.8428),
(@div, 'Bitung', 1.4404, 125.1217),
(@div, 'Tomohon', 1.3204, 124.8398);

-- Central Sulawesi
SET @div = (SELECT id FROM tcountry_divisions WHERE country_id = @idn AND name = 'Central Sulawesi');
INSERT IGNORE INTO `tcities` (`country_division_id`, `name`, `latitude`, `longitude`) VALUES
(@div, 'Palu', -0.9003, 119.8781);

-- South Sulawesi
SET @div = (SELECT id FROM tcountry_divisions WHERE country_id = @idn AND name = 'South Sulawesi');
INSERT IGNORE INTO `tcities` (`country_division_id`, `name`, `latitude`, `longitude`) VALUES
(@div, 'Makassar', -5.1477, 119.4328),
(@div, 'Parepare', -3.9975, 119.6331),
(@div, 'Palopo', -2.9945, 120.1953);

-- Southeast Sulawesi
SET @div = (SELECT id FROM tcountry_divisions WHERE country_id = @idn AND name = 'Southeast Sulawesi');
INSERT IGNORE INTO `tcities` (`country_division_id`, `name`, `latitude`, `longitude`) VALUES
(@div, 'Kendari', -3.9985, 122.5126),
(@div, 'Baubau', -5.4633, 122.5998);

-- Gorontalo
SET @div = (SELECT id FROM tcountry_divisions WHERE country_id = @idn AND name = 'Gorontalo');
INSERT IGNORE INTO `tcities` (`country_division_id`, `name`, `latitude`, `longitude`) VALUES
(@div, 'Gorontalo', 0.5333, 123.0667);

-- West Sulawesi
SET @div = (SELECT id FROM tcountry_divisions WHERE country_id = @idn AND name = 'West Sulawesi');
INSERT IGNORE INTO `tcities` (`country_division_id`, `name`, `latitude`, `longitude`) VALUES
(@div, 'Mamuju', -2.6686, 118.8621);

-- -----------------------------------------------------
-- Nusa Tenggara & Bali
-- -----------------------------------------------------

-- Bali
SET @div = (SELECT id FROM tcountry_divisions WHERE country_id = @idn AND name = 'Bali');
INSERT IGNORE INTO `tcities` (`country_division_id`, `name`, `latitude`, `longitude`) VALUES
(@div, 'Denpasar', -8.6705, 115.2126);

-- West Nusa Tenggara
SET @div = (SELECT id FROM tcountry_divisions WHERE country_id = @idn AND name = 'West Nusa Tenggara');
INSERT IGNORE INTO `tcities` (`country_division_id`, `name`, `latitude`, `longitude`) VALUES
(@div, 'Mataram', -8.5833, 116.1167),
(@div, 'Bima', -8.4609, 118.7188);

-- East Nusa Tenggara
SET @div = (SELECT id FROM tcountry_divisions WHERE country_id = @idn AND name = 'East Nusa Tenggara');
INSERT IGNORE INTO `tcities` (`country_division_id`, `name`, `latitude`, `longitude`) VALUES
(@div, 'Kupang', -10.1772, 123.6070);

-- -----------------------------------------------------
-- Maluku & Papua
-- -----------------------------------------------------

-- Maluku
SET @div = (SELECT id FROM tcountry_divisions WHERE country_id = @idn AND name = 'Maluku');
INSERT IGNORE INTO `tcities` (`country_division_id`, `name`, `latitude`, `longitude`) VALUES
(@div, 'Ambon', -3.6554, 128.1908),
(@div, 'Tual', -5.6242, 132.7500);

-- North Maluku
SET @div = (SELECT id FROM tcountry_divisions WHERE country_id = @idn AND name = 'North Maluku');
INSERT IGNORE INTO `tcities` (`country_division_id`, `name`, `latitude`, `longitude`) VALUES
(@div, 'Ternate', 0.7833, 127.3667),
(@div, 'Tidore Islands', 0.6908, 127.4104);

-- Papua
SET @div = (SELECT id FROM tcountry_divisions WHERE country_id = @idn AND name = 'Papua');
INSERT IGNORE INTO `tcities` (`country_division_id`, `name`, `latitude`, `longitude`) VALUES
(@div, 'Jayapura', -2.5916, 140.6690);

-- West Papua
SET @div = (SELECT id FROM tcountry_divisions WHERE country_id = @idn AND name = 'West Papua');
INSERT IGNORE INTO `tcities` (`country_division_id`, `name`, `latitude`, `longitude`) VALUES
(@div, 'Sorong', -0.8761, 131.2558),
(@div, 'Manokwari', -0.8614, 134.0620);