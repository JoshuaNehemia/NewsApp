-- -----------------------------------------------------------------------------
-- SOUTHEAST ASIA (SEA)
-- -----------------------------------------------------------------------------

-- Indonesia (IDN)
SET @cid = ( SELECT id FROM countries WHERE code = 'IDN' );

INSERT IGNORE INTO
    `country_divisions` (country_id, name)
VALUES (@cid, 'Aceh'),
    (@cid, 'North Sumatra'),
    (@cid, 'West Sumatra'),
    (@cid, 'Riau'),
    (@cid, 'Jambi'),
    (@cid, 'South Sumatra'),
    (@cid, 'Bengkulu'),
    (@cid, 'Lampung'),
    (
        @cid,
        'Bangka Belitung Islands'
    ),
    (@cid, 'Riau Islands'),
    (@cid, 'Jakarta'),
    (@cid, 'West Java'),
    (@cid, 'Central Java'),
    (@cid, 'Yogyakarta'),
    (@cid, 'East Java'),
    (@cid, 'Banten'),
    (@cid, 'Bali'),
    (@cid, 'West Nusa Tenggara'),
    (@cid, 'East Nusa Tenggara'),
    (@cid, 'West Kalimantan'),
    (@cid, 'Central Kalimantan'),
    (@cid, 'South Kalimantan'),
    (@cid, 'East Kalimantan'),
    (@cid, 'North Kalimantan'),
    (@cid, 'North Sulawesi'),
    (@cid, 'Central Sulawesi'),
    (@cid, 'South Sulawesi'),
    (@cid, 'Southeast Sulawesi'),
    (@cid, 'Gorontalo'),
    (@cid, 'West Sulawesi'),
    (@cid, 'Maluku'),
    (@cid, 'North Maluku'),
    (@cid, 'West Papua'),
    (@cid, 'Papua'),
    (@cid, 'Central Papua'),
    (@cid, 'Highland Papua'),
    (@cid, 'South Papua'),
    (@cid, 'Southwest Papua');

-- Malaysia (MYS)
SET @cid = ( SELECT id FROM countries WHERE code = 'MYS' );

INSERT IGNORE INTO
    `country_divisions` (country_id, name)
VALUES (@cid, 'Johor'),
    (@cid, 'Kedah'),
    (@cid, 'Kelantan'),
    (@cid, 'Melaka'),
    (@cid, 'Negeri Sembilan'),
    (@cid, 'Pahang'),
    (@cid, 'Penang'),
    (@cid, 'Perak'),
    (@cid, 'Perlis'),
    (@cid, 'Sabah'),
    (@cid, 'Sarawak'),
    (@cid, 'Selangor'),
    (@cid, 'Terengganu'),
    (@cid, 'Kuala Lumpur'),
    (@cid, 'Labuan'),
    (@cid, 'Putrajaya');

-- Thailand (THA) - Major Provinces & Regions
SET @cid = ( SELECT id FROM countries WHERE code = 'THA' );

INSERT IGNORE INTO
    `country_divisions` (country_id, name)
VALUES (@cid, 'Bangkok'),
    (@cid, 'Chiang Mai'),
    (@cid, 'Phuket'),
    (@cid, 'Chon Buri'),
    (@cid, 'Krabi'),
    (@cid, 'Surat Thani'),
    (@cid, 'Nakhon Ratchasima'),
    (@cid, 'Khon Kaen'),
    (@cid, 'Udon Thani'),
    (@cid, 'Songkhla'),
    (@cid, 'Chiang Rai'),
    (@cid, 'Ayutthaya'),
    (@cid, 'Prachuap Khiri Khan'),
    (@cid, 'Rayong'),
    (@cid, 'Kanchanaburi'),
    (@cid, 'Phang Nga'),
    (@cid, 'Nakhon Si Thammarat'),
    (@cid, 'Nonthaburi'),
    (@cid, 'Pathum Thani'),
    (@cid, 'Samut Prakan');

-- Vietnam (VNM) - Major Provinces & Municipalities
SET @cid = ( SELECT id FROM countries WHERE code = 'VNM' );

INSERT IGNORE INTO
    `country_divisions` (country_id, name)
VALUES (@cid, 'Hanoi'),
    (@cid, 'Ho Chi Minh City'),
    (@cid, 'Da Nang'),
    (@cid, 'Hai Phong'),
    (@cid, 'Can Tho'),
    (@cid, 'An Giang'),
    (@cid, 'Ba Ria-Vung Tau'),
    (@cid, 'Bac Giang'),
    (@cid, 'Bac Kan'),
    (@cid, 'Bac Lieu'),
    (@cid, 'Bac Ninh'),
    (@cid, 'Ben Tre'),
    (@cid, 'Binh Dinh'),
    (@cid, 'Binh Duong'),
    (@cid, 'Binh Phuoc'),
    (@cid, 'Binh Thuan'),
    (@cid, 'Ca Mau'),
    (@cid, 'Cao Bang'),
    (@cid, 'Dak Lak'),
    (@cid, 'Dak Nong'),
    (@cid, 'Dien Bien'),
    (@cid, 'Dong Nai'),
    (@cid, 'Dong Thap'),
    (@cid, 'Gia Lai'),
    (@cid, 'Ha Giang'),
    (@cid, 'Ha Nam'),
    (@cid, 'Ha Tinh'),
    (@cid, 'Hai Duong'),
    (@cid, 'Hau Giang'),
    (@cid, 'Hoa Binh'),
    (@cid, 'Hung Yen'),
    (@cid, 'Khanh Hoa'),
    (@cid, 'Kien Giang'),
    (@cid, 'Kon Tum'),
    (@cid, 'Lai Chau'),
    (@cid, 'Lam Dong'),
    (@cid, 'Lang Son'),
    (@cid, 'Lao Cai'),
    (@cid, 'Long An'),
    (@cid, 'Nam Dinh'),
    (@cid, 'Nghe An'),
    (@cid, 'Ninh Binh'),
    (@cid, 'Ninh Thuan'),
    (@cid, 'Phu Tho'),
    (@cid, 'Phu Yen'),
    (@cid, 'Quang Binh'),
    (@cid, 'Quang Nam'),
    (@cid, 'Quang Ngai'),
    (@cid, 'Quang Ninh'),
    (@cid, 'Quang Tri'),
    (@cid, 'Soc Trang'),
    (@cid, 'Son La'),
    (@cid, 'Tay Ninh'),
    (@cid, 'Thai Binh'),
    (@cid, 'Thai Nguyen'),
    (@cid, 'Thanh Hoa'),
    (@cid, 'Thua Thien Hue'),
    (@cid, 'Tien Giang'),
    (@cid, 'Tra Vinh'),
    (@cid, 'Tuyen Quang'),
    (@cid, 'Vinh Long'),
    (@cid, 'Vinh Phuc'),
    (@cid, 'Yen Bai');

-- Philippines (PHL) - Major Regions/Provinces
SET @cid = ( SELECT id FROM countries WHERE code = 'PHL' );

INSERT IGNORE INTO
    `country_divisions` (country_id, name)
VALUES (@cid, 'Metro Manila'),
    (@cid, 'Cebu'),
    (@cid, 'Davao del Sur'),
    (@cid, 'Pampanga'),
    (@cid, 'Bulacan'),
    (@cid, 'Cavite'),
    (@cid, 'Laguna'),
    (@cid, 'Batangas'),
    (@cid, 'Rizal'),
    (@cid, 'Quezon'),
    (@cid, 'Iloilo'),
    (@cid, 'Negros Occidental'),
    (@cid, 'Negros Oriental'),
    (@cid, 'Bohol'),
    (@cid, 'Leyte'),
    (@cid, 'Misamis Oriental'),
    (@cid, 'South Cotabato'),
    (@cid, 'Zamboanga del Sur'),
    (@cid, 'Palawan'),
    (@cid, 'Benguet');

-- Singapore (SGP) - CDCs
SET @cid = ( SELECT id FROM countries WHERE code = 'SGP' );

INSERT IGNORE INTO
    `country_divisions` (country_id, name)
VALUES (@cid, 'Central Singapore'),
    (@cid, 'North East'),
    (@cid, 'North West'),
    (@cid, 'South East'),
    (@cid, 'South West');

-- Myanmar (MMR)
SET @cid = ( SELECT id FROM countries WHERE code = 'MMR' );

INSERT IGNORE INTO
    `country_divisions` (country_id, name)
VALUES (@cid, 'Ayeyarwady'),
    (@cid, 'Bago'),
    (@cid, 'Magway'),
    (@cid, 'Mandalay'),
    (@cid, 'Sagaing'),
    (@cid, 'Tanintharyi'),
    (@cid, 'Yangon'),
    (@cid, 'Chin'),
    (@cid, 'Kachin'),
    (@cid, 'Kayah'),
    (@cid, 'Kayin'),
    (@cid, 'Mon'),
    (@cid, 'Rakhine'),
    (@cid, 'Shan'),
    (
        @cid,
        'Naypyidaw Union Territory'
    );

-- Cambodia (KHM) - Selected Major Provinces
SET @cid = ( SELECT id FROM countries WHERE code = 'KHM' );

INSERT IGNORE INTO
    `country_divisions` (country_id, name)
VALUES (@cid, 'Phnom Penh'),
    (@cid, 'Siem Reap'),
    (@cid, 'Battambang'),
    (@cid, 'Kandal'),
    (@cid, 'Preah Sihanouk'),
    (@cid, 'Kampot');

-- Laos (LAO) - Selected Major Provinces
SET @cid = ( SELECT id FROM countries WHERE code = 'LAO' );

INSERT IGNORE INTO
    `country_divisions` (country_id, name)
VALUES (@cid, 'Vientiane Prefecture'),
    (@cid, 'Luang Prabang'),
    (@cid, 'Champasak'),
    (@cid, 'Savannakhet'),
    (@cid, 'Vientiane Province');

-- Brunei (BRN)
SET @cid = ( SELECT id FROM countries WHERE code = 'BRN' );

INSERT IGNORE INTO
    `country_divisions` (country_id, name)
VALUES (@cid, 'Belait'),
    (@cid, 'Brunei-Muara'),
    (@cid, 'Temburong'),
    (@cid, 'Tutong');

-- East Timor (TLS)
SET @cid = ( SELECT id FROM countries WHERE code = 'TLS' );

INSERT IGNORE INTO
    `country_divisions` (country_id, name)
VALUES (@cid, 'Dili'),
    (@cid, 'Baucau'),
    (@cid, 'Ermera'),
    (@cid, 'Bobonaro');

-- -----------------------------------------------------------------------------
-- AMERICAS (Major)
-- -----------------------------------------------------------------------------

-- United States (USA)
SET @cid = ( SELECT id FROM countries WHERE code = 'USA' );

INSERT IGNORE INTO
    `country_divisions` (country_id, name)
VALUES (@cid, 'Alabama'),
    (@cid, 'Alaska'),
    (@cid, 'Arizona'),
    (@cid, 'Arkansas'),
    (@cid, 'California'),
    (@cid, 'Colorado'),
    (@cid, 'Connecticut'),
    (@cid, 'Delaware'),
    (@cid, 'Florida'),
    (@cid, 'Georgia'),
    (@cid, 'Hawaii'),
    (@cid, 'Idaho'),
    (@cid, 'Illinois'),
    (@cid, 'Indiana'),
    (@cid, 'Iowa'),
    (@cid, 'Kansas'),
    (@cid, 'Kentucky'),
    (@cid, 'Louisiana'),
    (@cid, 'Maine'),
    (@cid, 'Maryland'),
    (@cid, 'Massachusetts'),
    (@cid, 'Michigan'),
    (@cid, 'Minnesota'),
    (@cid, 'Mississippi'),
    (@cid, 'Missouri'),
    (@cid, 'Montana'),
    (@cid, 'Nebraska'),
    (@cid, 'Nevada'),
    (@cid, 'New Hampshire'),
    (@cid, 'New Jersey'),
    (@cid, 'New Mexico'),
    (@cid, 'New York'),
    (@cid, 'North Carolina'),
    (@cid, 'North Dakota'),
    (@cid, 'Ohio'),
    (@cid, 'Oklahoma'),
    (@cid, 'Oregon'),
    (@cid, 'Pennsylvania'),
    (@cid, 'Rhode Island'),
    (@cid, 'South Carolina'),
    (@cid, 'South Dakota'),
    (@cid, 'Tennessee'),
    (@cid, 'Texas'),
    (@cid, 'Utah'),
    (@cid, 'Vermont'),
    (@cid, 'Virginia'),
    (@cid, 'Washington'),
    (@cid, 'West Virginia'),
    (@cid, 'Wisconsin'),
    (@cid, 'Wyoming'),
    (@cid, 'District of Columbia');

-- Canada (CAN)
SET @cid = ( SELECT id FROM countries WHERE code = 'CAN' );

INSERT IGNORE INTO
    `country_divisions` (country_id, name)
VALUES (@cid, 'Alberta'),
    (@cid, 'British Columbia'),
    (@cid, 'Manitoba'),
    (@cid, 'New Brunswick'),
    (
        @cid,
        'Newfoundland and Labrador'
    ),
    (@cid, 'Northwest Territories'),
    (@cid, 'Nova Scotia'),
    (@cid, 'Nunavut'),
    (@cid, 'Ontario'),
    (@cid, 'Prince Edward Island'),
    (@cid, 'Quebec'),
    (@cid, 'Saskatchewan'),
    (@cid, 'Yukon');

-- Brazil (BRA)
SET @cid = ( SELECT id FROM countries WHERE code = 'BRA' );

INSERT IGNORE INTO
    `country_divisions` (country_id, name)
VALUES (@cid, 'Acre'),
    (@cid, 'Alagoas'),
    (@cid, 'Amapá'),
    (@cid, 'Amazonas'),
    (@cid, 'Bahia'),
    (@cid, 'Ceará'),
    (@cid, 'Distrito Federal'),
    (@cid, 'Espírito Santo'),
    (@cid, 'Goiás'),
    (@cid, 'Maranhão'),
    (@cid, 'Mato Grosso'),
    (@cid, 'Mato Grosso do Sul'),
    (@cid, 'Minas Gerais'),
    (@cid, 'Pará'),
    (@cid, 'Paraíba'),
    (@cid, 'Paraná'),
    (@cid, 'Pernambuco'),
    (@cid, 'Piauí'),
    (@cid, 'Rio de Janeiro'),
    (@cid, 'Rio Grande do Norte'),
    (@cid, 'Rio Grande do Sul'),
    (@cid, 'Rondônia'),
    (@cid, 'Roraima'),
    (@cid, 'Santa Catarina'),
    (@cid, 'São Paulo'),
    (@cid, 'Sergipe'),
    (@cid, 'Tocantins');

-- Mexico (MEX) - Major States
SET @cid = ( SELECT id FROM countries WHERE code = 'MEX' );

INSERT IGNORE INTO
    `country_divisions` (country_id, name)
VALUES (@cid, 'Mexico City'),
    (@cid, 'Jalisco'),
    (@cid, 'Nuevo León'),
    (@cid, 'Mexico State'),
    (@cid, 'Puebla'),
    (@cid, 'Veracruz'),
    (@cid, 'Guanajuato'),
    (@cid, 'Baja California'),
    (@cid, 'Yucatán'),
    (@cid, 'Quintana Roo');

-- -----------------------------------------------------------------------------
-- ASIA & OCEANIA (Major)
-- -----------------------------------------------------------------------------

-- Australia (AUS)
SET @cid = ( SELECT id FROM countries WHERE code = 'AUS' );

INSERT IGNORE INTO
    `country_divisions` (country_id, name)
VALUES (@cid, 'New South Wales'),
    (@cid, 'Victoria'),
    (@cid, 'Queensland'),
    (@cid, 'Western Australia'),
    (@cid, 'South Australia'),
    (@cid, 'Tasmania'),
    (
        @cid,
        'Australian Capital Territory'
    ),
    (@cid, 'Northern Territory');

-- China (CHN)
SET @cid = ( SELECT id FROM countries WHERE code = 'CHN' );

INSERT IGNORE INTO
    `country_divisions` (country_id, name)
VALUES (@cid, 'Beijing'),
    (@cid, 'Tianjin'),
    (@cid, 'Hebei'),
    (@cid, 'Shanxi'),
    (@cid, 'Inner Mongolia'),
    (@cid, 'Liaoning'),
    (@cid, 'Jilin'),
    (@cid, 'Heilongjiang'),
    (@cid, 'Shanghai'),
    (@cid, 'Jiangsu'),
    (@cid, 'Zhejiang'),
    (@cid, 'Anhui'),
    (@cid, 'Fujian'),
    (@cid, 'Jiangxi'),
    (@cid, 'Shandong'),
    (@cid, 'Henan'),
    (@cid, 'Hubei'),
    (@cid, 'Hunan'),
    (@cid, 'Guangdong'),
    (@cid, 'Guangxi'),
    (@cid, 'Hainan'),
    (@cid, 'Chongqing'),
    (@cid, 'Sichuan'),
    (@cid, 'Guizhou'),
    (@cid, 'Yunnan'),
    (@cid, 'Tibet'),
    (@cid, 'Shaanxi'),
    (@cid, 'Gansu'),
    (@cid, 'Qinghai'),
    (@cid, 'Ningxia'),
    (@cid, 'Xinjiang'),
    (@cid, 'Hong Kong'),
    (@cid, 'Macau');

-- India (IND)
SET @cid = ( SELECT id FROM countries WHERE code = 'IND' );

INSERT IGNORE INTO
    `country_divisions` (country_id, name)
VALUES (@cid, 'Andhra Pradesh'),
    (@cid, 'Arunachal Pradesh'),
    (@cid, 'Assam'),
    (@cid, 'Bihar'),
    (@cid, 'Chhattisgarh'),
    (@cid, 'Goa'),
    (@cid, 'Gujarat'),
    (@cid, 'Haryana'),
    (@cid, 'Himachal Pradesh'),
    (@cid, 'Jharkhand'),
    (@cid, 'Karnataka'),
    (@cid, 'Kerala'),
    (@cid, 'Madhya Pradesh'),
    (@cid, 'Maharashtra'),
    (@cid, 'Manipur'),
    (@cid, 'Meghalaya'),
    (@cid, 'Mizoram'),
    (@cid, 'Nagaland'),
    (@cid, 'Odisha'),
    (@cid, 'Punjab'),
    (@cid, 'Rajasthan'),
    (@cid, 'Sikkim'),
    (@cid, 'Tamil Nadu'),
    (@cid, 'Telangana'),
    (@cid, 'Tripura'),
    (@cid, 'Uttar Pradesh'),
    (@cid, 'Uttarakhand'),
    (@cid, 'West Bengal'),
    (@cid, 'Delhi');

-- Japan (JPN) - Major Prefectures
SET @cid = ( SELECT id FROM countries WHERE code = 'JPN' );

INSERT IGNORE INTO
    `country_divisions` (country_id, name)
VALUES (@cid, 'Tokyo'),
    (@cid, 'Kanagawa'),
    (@cid, 'Osaka'),
    (@cid, 'Aichi'),
    (@cid, 'Saitama'),
    (@cid, 'Chiba'),
    (@cid, 'Hyogo'),
    (@cid, 'Hokkaido'),
    (@cid, 'Fukuoka'),
    (@cid, 'Kyoto');

-- South Korea (KOR)
SET @cid = ( SELECT id FROM countries WHERE code = 'KOR' );

INSERT IGNORE INTO
    `country_divisions` (country_id, name)
VALUES (@cid, 'Seoul'),
    (@cid, 'Busan'),
    (@cid, 'Incheon'),
    (@cid, 'Daegu'),
    (@cid, 'Daejeon'),
    (@cid, 'Gwangju'),
    (@cid, 'Ulsan'),
    (@cid, 'Gyeonggi-do'),
    (@cid, 'Gangwon-do');

-- -----------------------------------------------------------------------------
-- EUROPE (Major)
-- -----------------------------------------------------------------------------

-- United Kingdom (GBR)
SET @cid = ( SELECT id FROM countries WHERE code = 'GBR' );

INSERT IGNORE INTO
    `country_divisions` (country_id, name)
VALUES (@cid, 'England'),
    (@cid, 'Scotland'),
    (@cid, 'Wales'),
    (@cid, 'Northern Ireland');

-- Germany (DEU)
SET @cid = ( SELECT id FROM countries WHERE code = 'DEU' );

INSERT IGNORE INTO
    `country_divisions` (country_id, name)
VALUES (@cid, 'Baden-Württemberg'),
    (@cid, 'Bavaria'),
    (@cid, 'Berlin'),
    (@cid, 'Brandenburg'),
    (@cid, 'Bremen'),
    (@cid, 'Hamburg'),
    (@cid, 'Hesse'),
    (@cid, 'Lower Saxony'),
    (
        @cid,
        'Mecklenburg-Vorpommern'
    ),
    (
        @cid,
        'North Rhine-Westphalia'
    ),
    (@cid, 'Rhineland-Palatinate'),
    (@cid, 'Saarland'),
    (@cid, 'Saxony'),
    (@cid, 'Saxony-Anhalt'),
    (@cid, 'Schleswig-Holstein'),
    (@cid, 'Thuringia');

-- France (FRA) - Regions
SET @cid = ( SELECT id FROM countries WHERE code = 'FRA' );

INSERT IGNORE INTO
    `country_divisions` (country_id, name)
VALUES (@cid, 'Île-de-France'),
    (@cid, 'Auvergne-Rhône-Alpes'),
    (@cid, 'Hauts-de-France'),
    (@cid, 'Nouvelle-Aquitaine'),
    (@cid, 'Occitanie'),
    (@cid, 'Grand Est'),
    (
        @cid,
        'Provence-Alpes-Côte d\'Azur'
    ),
    (@cid, 'Pays de la Loire'),
    (@cid, 'Brittany'),
    (@cid, 'Normandy');

-- Italy (ITA) - Major Regions
SET @cid = ( SELECT id FROM countries WHERE code = 'ITA' );

INSERT IGNORE INTO
    `country_divisions` (country_id, name)
VALUES (@cid, 'Lombardy'),
    (@cid, 'Lazio'),
    (@cid, 'Campania'),
    (@cid, 'Veneto'),
    (@cid, 'Sicily'),
    (@cid, 'Emilia-Romagna'),
    (@cid, 'Piedmont'),
    (@cid, 'Tuscany');

-- Russia (RUS) - Major Federal Subjects
SET @cid = ( SELECT id FROM countries WHERE code = 'RUS' );

INSERT IGNORE INTO
    `country_divisions` (country_id, name)
VALUES (@cid, 'Moscow'),
    (@cid, 'Saint Petersburg'),
    (@cid, 'Moscow Oblast'),
    (@cid, 'Krasnodar Krai'),
    (@cid, 'Sverdlovsk Oblast'),
    (@cid, 'Tatarstan');