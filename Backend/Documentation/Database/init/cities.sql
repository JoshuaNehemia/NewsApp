-- -----------------------------------------------------------------------------
-- SOUTHEAST ASIA (SEA)
-- -----------------------------------------------------------------------------

-- Indonesia (IDN)
SET @cid = (SELECT id FROM countries WHERE code = 'IDN');

INSERT IGNORE INTO `cities` (country_division_id, name, latitude, longitude)
SELECT id, 'Banda Aceh', 5.5483, 95.3238 FROM country_divisions WHERE country_id = @cid AND name = 'Aceh' UNION ALL
SELECT id, 'Medan', 3.5952, 98.6722 FROM country_divisions WHERE country_id = @cid AND name = 'North Sumatra' UNION ALL
SELECT id, 'Padang', -0.9471, 100.4172 FROM country_divisions WHERE country_id = @cid AND name = 'West Sumatra' UNION ALL
SELECT id, 'Pekanbaru', 0.5071, 101.4478 FROM country_divisions WHERE country_id = @cid AND name = 'Riau' UNION ALL
SELECT id, 'Jambi', -1.6101, 103.6131 FROM country_divisions WHERE country_id = @cid AND name = 'Jambi' UNION ALL
SELECT id, 'Palembang', -2.9761, 104.7754 FROM country_divisions WHERE country_id = @cid AND name = 'South Sumatra' UNION ALL
SELECT id, 'Bengkulu', -3.8004, 102.2655 FROM country_divisions WHERE country_id = @cid AND name = 'Bengkulu' UNION ALL
SELECT id, 'Bandar Lampung', -5.3971, 105.2668 FROM country_divisions WHERE country_id = @cid AND name = 'Lampung' UNION ALL
SELECT id, 'Pangkal Pinang', -2.1312, 106.1161 FROM country_divisions WHERE country_id = @cid AND name = 'Bangka Belitung Islands' UNION ALL
SELECT id, 'Tanjung Pinang', 0.9165, 104.4456 FROM country_divisions WHERE country_id = @cid AND name = 'Riau Islands' UNION ALL
SELECT id, 'Jakarta', -6.2088, 106.8456 FROM country_divisions WHERE country_id = @cid AND name = 'Jakarta' UNION ALL
SELECT id, 'Bandung', -6.9175, 107.6191 FROM country_divisions WHERE country_id = @cid AND name = 'West Java' UNION ALL
SELECT id, 'Semarang', -6.9667, 110.4167 FROM country_divisions WHERE country_id = @cid AND name = 'Central Java' UNION ALL
SELECT id, 'Yogyakarta', -7.7956, 110.3695 FROM country_divisions WHERE country_id = @cid AND name = 'Yogyakarta' UNION ALL
SELECT id, 'Surabaya', -7.2575, 112.7521 FROM country_divisions WHERE country_id = @cid AND name = 'East Java' UNION ALL
SELECT id, 'Serang', -6.1179, 106.1578 FROM country_divisions WHERE country_id = @cid AND name = 'Banten' UNION ALL
SELECT id, 'Denpasar', -8.6705, 115.2126 FROM country_divisions WHERE country_id = @cid AND name = 'Bali' UNION ALL
SELECT id, 'Mataram', -8.5815, 116.1165 FROM country_divisions WHERE country_id = @cid AND name = 'West Nusa Tenggara' UNION ALL
SELECT id, 'Kupang', -10.1772, 123.6070 FROM country_divisions WHERE country_id = @cid AND name = 'East Nusa Tenggara' UNION ALL
SELECT id, 'Pontianak', -0.0227, 109.3425 FROM country_divisions WHERE country_id = @cid AND name = 'West Kalimantan' UNION ALL
SELECT id, 'Palangka Raya', -2.2163, 113.9165 FROM country_divisions WHERE country_id = @cid AND name = 'Central Kalimantan' UNION ALL
SELECT id, 'Banjarbaru', -3.4411, 114.8315 FROM country_divisions WHERE country_id = @cid AND name = 'South Kalimantan' UNION ALL
SELECT id, 'Samarinda', -0.5016, 117.1595 FROM country_divisions WHERE country_id = @cid AND name = 'East Kalimantan' UNION ALL
SELECT id, 'Tanjung Selor', 2.8373, 117.3653 FROM country_divisions WHERE country_id = @cid AND name = 'North Kalimantan' UNION ALL
SELECT id, 'Manado', 1.4748, 124.8428 FROM country_divisions WHERE country_id = @cid AND name = 'North Sulawesi' UNION ALL
SELECT id, 'Palu', -0.9010, 119.8706 FROM country_divisions WHERE country_id = @cid AND name = 'Central Sulawesi' UNION ALL
SELECT id, 'Makassar', -5.1477, 119.4327 FROM country_divisions WHERE country_id = @cid AND name = 'South Sulawesi' UNION ALL
SELECT id, 'Kendari', -3.9972, 122.5121 FROM country_divisions WHERE country_id = @cid AND name = 'Southeast Sulawesi' UNION ALL
SELECT id, 'Gorontalo', 0.5405, 123.0595 FROM country_divisions WHERE country_id = @cid AND name = 'Gorontalo' UNION ALL
SELECT id, 'Mamuju', -2.6778, 118.8787 FROM country_divisions WHERE country_id = @cid AND name = 'West Sulawesi' UNION ALL
SELECT id, 'Ambon', -3.6954, 128.1814 FROM country_divisions WHERE country_id = @cid AND name = 'Maluku' UNION ALL
SELECT id, 'Sofifi', 0.7289, 127.5872 FROM country_divisions WHERE country_id = @cid AND name = 'North Maluku' UNION ALL
SELECT id, 'Manokwari', -0.8615, 134.0620 FROM country_divisions WHERE country_id = @cid AND name = 'West Papua' UNION ALL
SELECT id, 'Jayapura', -2.5916, 140.6690 FROM country_divisions WHERE country_id = @cid AND name = 'Papua' UNION ALL
SELECT id, 'Nabire', -3.3708, 135.4977 FROM country_divisions WHERE country_id = @cid AND name = 'Central Papua' UNION ALL
SELECT id, 'Wamena', -4.0963, 138.9482 FROM country_divisions WHERE country_id = @cid AND name = 'Highland Papua' UNION ALL
SELECT id, 'Merauke', -8.4907, 140.4010 FROM country_divisions WHERE country_id = @cid AND name = 'South Papua' UNION ALL
SELECT id, 'Sorong', -0.8755, 131.2558 FROM country_divisions WHERE country_id = @cid AND name = 'Southwest Papua';

-- Malaysia (MYS)
SET @cid = (SELECT id FROM countries WHERE code = 'MYS');

INSERT IGNORE INTO `cities` (country_division_id, name, latitude, longitude)
SELECT id, 'Johor Bahru', 1.4927, 103.7414 FROM country_divisions WHERE country_id = @cid AND name = 'Johor' UNION ALL
SELECT id, 'Alor Setar', 6.1184, 100.3682 FROM country_divisions WHERE country_id = @cid AND name = 'Kedah' UNION ALL
SELECT id, 'Kota Bharu', 6.1254, 102.2381 FROM country_divisions WHERE country_id = @cid AND name = 'Kelantan' UNION ALL
SELECT id, 'Malacca City', 2.1960, 102.2405 FROM country_divisions WHERE country_id = @cid AND name = 'Melaka' UNION ALL
SELECT id, 'Seremban', 2.7297, 101.9381 FROM country_divisions WHERE country_id = @cid AND name = 'Negeri Sembilan' UNION ALL
SELECT id, 'Kuantan', 3.8077, 103.3260 FROM country_divisions WHERE country_id = @cid AND name = 'Pahang' UNION ALL
SELECT id, 'George Town', 5.4141, 100.3288 FROM country_divisions WHERE country_id = @cid AND name = 'Penang' UNION ALL
SELECT id, 'Ipoh', 4.5975, 101.0901 FROM country_divisions WHERE country_id = @cid AND name = 'Perak' UNION ALL
SELECT id, 'Kangar', 6.4449, 100.1986 FROM country_divisions WHERE country_id = @cid AND name = 'Perlis' UNION ALL
SELECT id, 'Kota Kinabalu', 5.9804, 116.0753 FROM country_divisions WHERE country_id = @cid AND name = 'Sabah' UNION ALL
SELECT id, 'Kuching', 1.5533, 110.3592 FROM country_divisions WHERE country_id = @cid AND name = 'Sarawak' UNION ALL
SELECT id, 'Shah Alam', 3.0738, 101.5183 FROM country_divisions WHERE country_id = @cid AND name = 'Selangor' UNION ALL
SELECT id, 'Kuala Terengganu', 5.3302, 103.1408 FROM country_divisions WHERE country_id = @cid AND name = 'Terengganu' UNION ALL
SELECT id, 'Kuala Lumpur', 3.1390, 101.6869 FROM country_divisions WHERE country_id = @cid AND name = 'Kuala Lumpur' UNION ALL
SELECT id, 'Victoria', 5.2831, 115.2308 FROM country_divisions WHERE country_id = @cid AND name = 'Labuan' UNION ALL
SELECT id, 'Putrajaya', 2.9264, 101.6964 FROM country_divisions WHERE country_id = @cid AND name = 'Putrajaya';

-- Thailand (THA)
SET @cid = (SELECT id FROM countries WHERE code = 'THA');

INSERT IGNORE INTO `cities` (country_division_id, name, latitude, longitude)
SELECT id, 'Bangkok', 13.7563, 100.5018 FROM country_divisions WHERE country_id = @cid AND name = 'Bangkok' UNION ALL
SELECT id, 'Chiang Mai', 18.7883, 98.9853 FROM country_divisions WHERE country_id = @cid AND name = 'Chiang Mai' UNION ALL
SELECT id, 'Phuket', 7.8804, 98.3923 FROM country_divisions WHERE country_id = @cid AND name = 'Phuket' UNION ALL
SELECT id, 'Chon Buri', 13.3611, 100.9847 FROM country_divisions WHERE country_id = @cid AND name = 'Chon Buri' UNION ALL
SELECT id, 'Krabi', 8.0855, 98.9063 FROM country_divisions WHERE country_id = @cid AND name = 'Krabi';

-- Vietnam (VNM)
SET @cid = (SELECT id FROM countries WHERE code = 'VNM');

INSERT IGNORE INTO `cities` (country_division_id, name, latitude, longitude)
SELECT id, 'Hanoi', 21.0285, 105.8542 FROM country_divisions WHERE country_id = @cid AND name = 'Hanoi' UNION ALL
SELECT id, 'Ho Chi Minh City', 10.8231, 106.6297 FROM country_divisions WHERE country_id = @cid AND name = 'Ho Chi Minh City' UNION ALL
SELECT id, 'Da Nang', 16.0544, 108.2022 FROM country_divisions WHERE country_id = @cid AND name = 'Da Nang' UNION ALL
SELECT id, 'Hai Phong', 20.8449, 106.6881 FROM country_divisions WHERE country_id = @cid AND name = 'Hai Phong' UNION ALL
SELECT id, 'Can Tho', 10.0452, 105.7469 FROM country_divisions WHERE country_id = @cid AND name = 'Can Tho';

-- Philippines (PHL)
SET @cid = (SELECT id FROM countries WHERE code = 'PHL');

INSERT IGNORE INTO `cities` (country_division_id, name, latitude, longitude)
SELECT id, 'Manila', 14.5995, 120.9842 FROM country_divisions WHERE country_id = @cid AND name = 'Metro Manila' UNION ALL
SELECT id, 'Cebu City', 10.3157, 123.8854 FROM country_divisions WHERE country_id = @cid AND name = 'Cebu' UNION ALL
SELECT id, 'Davao City', 7.1907, 125.4553 FROM country_divisions WHERE country_id = @cid AND name = 'Davao del Sur' UNION ALL
SELECT id, 'San Fernando', 15.0286, 120.6898 FROM country_divisions WHERE country_id = @cid AND name = 'Pampanga';

-- -----------------------------------------------------------------------------
-- AMERICAS (Major)
-- -----------------------------------------------------------------------------

-- United States (USA)
SET @cid = (SELECT id FROM countries WHERE code = 'USA');

INSERT IGNORE INTO `cities` (country_division_id, name, latitude, longitude)
SELECT id, 'Montgomery', 32.3792, -86.3077 FROM country_divisions WHERE country_id = @cid AND name = 'Alabama' UNION ALL
SELECT id, 'Juneau', 58.3019, -134.4197 FROM country_divisions WHERE country_id = @cid AND name = 'Alaska' UNION ALL
SELECT id, 'Phoenix', 33.4484, -112.0740 FROM country_divisions WHERE country_id = @cid AND name = 'Arizona' UNION ALL
SELECT id, 'Little Rock', 34.7465, -92.2896 FROM country_divisions WHERE country_id = @cid AND name = 'Arkansas' UNION ALL
SELECT id, 'Sacramento', 38.5816, -121.4944 FROM country_divisions WHERE country_id = @cid AND name = 'California' UNION ALL
SELECT id, 'Denver', 39.7392, -104.9903 FROM country_divisions WHERE country_id = @cid AND name = 'Colorado' UNION ALL
SELECT id, 'Hartford', 41.7658, -72.6734 FROM country_divisions WHERE country_id = @cid AND name = 'Connecticut' UNION ALL
SELECT id, 'Dover', 39.1582, -75.5244 FROM country_divisions WHERE country_id = @cid AND name = 'Delaware' UNION ALL
SELECT id, 'Tallahassee', 30.4383, -84.2807 FROM country_divisions WHERE country_id = @cid AND name = 'Florida' UNION ALL
SELECT id, 'Atlanta', 33.7490, -84.3880 FROM country_divisions WHERE country_id = @cid AND name = 'Georgia' UNION ALL
SELECT id, 'Honolulu', 21.3069, -157.8583 FROM country_divisions WHERE country_id = @cid AND name = 'Hawaii' UNION ALL
SELECT id, 'Boise', 43.6150, -116.2023 FROM country_divisions WHERE country_id = @cid AND name = 'Idaho' UNION ALL
SELECT id, 'Springfield', 39.7817, -89.6501 FROM country_divisions WHERE country_id = @cid AND name = 'Illinois' UNION ALL
SELECT id, 'Indianapolis', 39.7684, -86.1581 FROM country_divisions WHERE country_id = @cid AND name = 'Indiana' UNION ALL
SELECT id, 'Des Moines', 41.6195, -93.5932 FROM country_divisions WHERE country_id = @cid AND name = 'Iowa' UNION ALL
SELECT id, 'Topeka', 39.0473, -95.6752 FROM country_divisions WHERE country_id = @cid AND name = 'Kansas' UNION ALL
SELECT id, 'Frankfort', 38.2009, -84.8733 FROM country_divisions WHERE country_id = @cid AND name = 'Kentucky' UNION ALL
SELECT id, 'Baton Rouge', 30.4515, -91.1871 FROM country_divisions WHERE country_id = @cid AND name = 'Louisiana' UNION ALL
SELECT id, 'Augusta', 44.3106, -69.7795 FROM country_divisions WHERE country_id = @cid AND name = 'Maine' UNION ALL
SELECT id, 'Annapolis', 38.9784, -76.4922 FROM country_divisions WHERE country_id = @cid AND name = 'Maryland' UNION ALL
SELECT id, 'Boston', 42.3601, -71.0589 FROM country_divisions WHERE country_id = @cid AND name = 'Massachusetts' UNION ALL
SELECT id, 'Lansing', 42.7325, -84.5555 FROM country_divisions WHERE country_id = @cid AND name = 'Michigan' UNION ALL
SELECT id, 'Saint Paul', 44.9537, -93.0900 FROM country_divisions WHERE country_id = @cid AND name = 'Minnesota' UNION ALL
SELECT id, 'Jackson', 32.2988, -90.1848 FROM country_divisions WHERE country_id = @cid AND name = 'Mississippi' UNION ALL
SELECT id, 'Jefferson City', 38.5767, -92.1735 FROM country_divisions WHERE country_id = @cid AND name = 'Missouri' UNION ALL
SELECT id, 'Helena', 46.5891, -112.0391 FROM country_divisions WHERE country_id = @cid AND name = 'Montana' UNION ALL
SELECT id, 'Lincoln', 40.8136, -96.7026 FROM country_divisions WHERE country_id = @cid AND name = 'Nebraska' UNION ALL
SELECT id, 'Carson City', 39.1638, -119.7674 FROM country_divisions WHERE country_id = @cid AND name = 'Nevada' UNION ALL
SELECT id, 'Concord', 43.2081, -71.5376 FROM country_divisions WHERE country_id = @cid AND name = 'New Hampshire' UNION ALL
SELECT id, 'Trenton', 40.2206, -74.7597 FROM country_divisions WHERE country_id = @cid AND name = 'New Jersey' UNION ALL
SELECT id, 'Santa Fe', 35.6870, -105.9378 FROM country_divisions WHERE country_id = @cid AND name = 'New Mexico' UNION ALL
SELECT id, 'Albany', 42.6526, -73.7562 FROM country_divisions WHERE country_id = @cid AND name = 'New York' UNION ALL
SELECT id, 'Raleigh', 35.7796, -78.6382 FROM country_divisions WHERE country_id = @cid AND name = 'North Carolina' UNION ALL
SELECT id, 'Bismarck', 46.8083, -100.7837 FROM country_divisions WHERE country_id = @cid AND name = 'North Dakota' UNION ALL
SELECT id, 'Columbus', 39.9612, -82.9988 FROM country_divisions WHERE country_id = @cid AND name = 'Ohio' UNION ALL
SELECT id, 'Oklahoma City', 35.4676, -97.5164 FROM country_divisions WHERE country_id = @cid AND name = 'Oklahoma' UNION ALL
SELECT id, 'Salem', 44.9429, -123.0351 FROM country_divisions WHERE country_id = @cid AND name = 'Oregon' UNION ALL
SELECT id, 'Harrisburg', 40.2732, -76.8867 FROM country_divisions WHERE country_id = @cid AND name = 'Pennsylvania' UNION ALL
SELECT id, 'Providence', 41.8240, -71.4128 FROM country_divisions WHERE country_id = @cid AND name = 'Rhode Island' UNION ALL
SELECT id, 'Columbia', 34.0007, -81.0348 FROM country_divisions WHERE country_id = @cid AND name = 'South Carolina' UNION ALL
SELECT id, 'Pierre', 44.3683, -100.3510 FROM country_divisions WHERE country_id = @cid AND name = 'South Dakota' UNION ALL
SELECT id, 'Nashville', 36.1627, -86.7816 FROM country_divisions WHERE country_id = @cid AND name = 'Tennessee' UNION ALL
SELECT id, 'Austin', 30.2672, -97.7431 FROM country_divisions WHERE country_id = @cid AND name = 'Texas' UNION ALL
SELECT id, 'Salt Lake City', 40.7608, -111.8910 FROM country_divisions WHERE country_id = @cid AND name = 'Utah' UNION ALL
SELECT id, 'Montpelier', 44.2601, -72.5754 FROM country_divisions WHERE country_id = @cid AND name = 'Vermont' UNION ALL
SELECT id, 'Richmond', 37.5407, -77.4360 FROM country_divisions WHERE country_id = @cid AND name = 'Virginia' UNION ALL
SELECT id, 'Olympia', 47.0379, -122.9007 FROM country_divisions WHERE country_id = @cid AND name = 'Washington' UNION ALL
SELECT id, 'Charleston', 38.3498, -81.6326 FROM country_divisions WHERE country_id = @cid AND name = 'West Virginia' UNION ALL
SELECT id, 'Madison', 43.0731, -89.4012 FROM country_divisions WHERE country_id = @cid AND name = 'Wisconsin' UNION ALL
SELECT id, 'Cheyenne', 41.1400, -104.8202 FROM country_divisions WHERE country_id = @cid AND name = 'Wyoming';