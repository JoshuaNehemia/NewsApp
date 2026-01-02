SET @jakarta_id = (SELECT id FROM cities WHERE name = 'Jakarta' LIMIT 1);
SET @surabaya_id = (SELECT id FROM cities WHERE name = 'Surabaya' LIMIT 1);
SET @bandung_id = (SELECT id FROM cities WHERE name = 'Bandung' LIMIT 1);

INSERT IGNORE INTO `medias` 
(`name`, `slug`, `company_name`, `media_type`, `picture_ext`, `logo_ext`, `website`, `email`, `description`, `city_id`) 
VALUES
-- JAKARTA BASED
(
  'Kompas.com', 
  'kompas-com', 
  'PT Kompas Cyber Media', 
  'news', 
  'jpg', 'png', 
  'https://www.kompas.com', 
  'redaksi@kompas.com', 
  'Leading trusted news site in Indonesia, part of Kompas Gramedia Group.', 
  @jakarta_id
),
(
  'Detik.com', 
  'detik-com', 
  'PT Trans Digital Media', 
  'news', 
  'jpg', 'png', 
  'https://www.detik.com', 
  'redaksi@detik.com', 
  'Pioneer of online news in Indonesia, known for breaking news speed.', 
  @jakarta_id
),
(
  'CNN Indonesia', 
  'cnn-indonesia', 
  'PT Trans News Corpora', 
  'news', 
  'jpg', 'png', 
  'https://www.cnnindonesia.com', 
  'redaksi@cnnindonesia.com', 
  'Indonesian franchise of CNN, providing local and international news.', 
  @jakarta_id
),
(
  'Tribunnews', 
  'tribunnews', 
  'PT Tribun Digital Online', 
  'news', 
  'jpg', 'png', 
  'https://www.tribunnews.com', 
  'redaksi@tribunnews.com', 
  'News portal with a vast network of local news sites across Indonesia.', 
  @jakarta_id
),
(
  'Tempo.co', 
  'tempo-co', 
  'PT Tempo Inti Media Tbk', 
  'news', 
  'jpg', 'png', 
  'https://www.tempo.co', 
  'redaksi@tempo.co.id', 
  'Known for investigative journalism and high-quality reportage.', 
  @jakarta_id
),
(
  'Metro TV', 
  'metro-tv', 
  'PT Media Televisi Indonesia', 
  'tv', 
  'jpg', 'png', 
  'https://www.metrotvnews.com', 
  'redaksi@metrotvnews.com', 
  'Indonesia\'s first 24-hour news channel.', 
  @jakarta_id
),
(
  'TVOne', 
  'tv-one', 
  'PT Lativi Mediakarya', 
  'tv', 
  'jpg', 'png', 
  'https://www.tvonenews.com', 
  'redaksi@tvonenews.com', 
  'News and sports broadcaster, famous for political talk shows.', 
  @jakarta_id
),
(
  'RCTI', 
  'rcti', 
  'PT Rajawali Citra Televisi Indonesia', 
  'tv', 
  'jpg', 'png', 
  'https://www.rcti.tv', 
  'feedback@rcti.tv', 
  'The first private television network in Indonesia, offering entertainment and news.', 
  @jakarta_id
),
(
  'Antara News', 
  'antara-news', 
  'Perum LKBN Antara', 
  'news', 
  'jpg', 'png', 
  'https://www.antaranews.com', 
  'redaksi@antaranews.com', 
  'The official news agency of the government of Indonesia.', 
  @jakarta_id
),
(
  'IDN Times', 
  'idn-times', 
  'IDN Media', 
  'news', 
  'jpg', 'png', 
  'https://www.idntimes.com', 
  'info@idntimes.com', 
  'Multi-platform news and entertainment media for Millennials and Gen Z.', 
  @jakarta_id
),
(
  'Kumparan', 
  'kumparan', 
  'PT Kumparan', 
  'news', 
  'jpg', 'png', 
  'https://www.kumparan.com', 
  'redaksi@kumparan.com', 
  'Hybrid media platform combining news and user-generated content.', 
  @jakarta_id
),
(
  'Tirto.id', 
  'tirto-id', 
  'PT Tirto Indonesia Mandiri', 
  'news', 
  'jpg', 'png', 
  'https://www.tirto.id', 
  'redaksi@tirto.id', 
  'Data-driven journalism and in-depth analysis.', 
  @jakarta_id
),
(
  'Narasi', 
  'narasi', 
  'PT Narasi Citra Sahwahita', 
  'tv', 
  'jpg', 'png', 
  'https://www.narasi.tv', 
  'info@narasi.tv', 
  'Digital media company co-founded by Najwa Shihab, focusing on engaging content.', 
  @jakarta_id
),
(
  'Liputan6', 
  'liputan6', 
  'PT Liputan Enam Dot Com', 
  'news', 
  'jpg', 'png', 
  'https://www.liputan6.com', 
  'redaksi@liputan6.com', 
  'Major news portal under the Emtek group.', 
  @jakarta_id
),
(
  'Republika', 
  'republika', 
  'PT Republika Media Mandiri', 
  'news', 
  'jpg', 'png', 
  'https://www.republika.co.id', 
  'sekretariat@republika.co.id', 
  'National daily newspaper and online portal serving the Muslim community.', 
  @jakarta_id
),
(
  'Bisnis Indonesia', 
  'bisnis-indonesia', 
  'PT Jurnalindo Aksara Grafika', 
  'journal', 
  'jpg', 'png', 
  'https://www.bisnis.com', 
  'redaksi@bisnis.com', 
  'Business and financial news daily.', 
  @jakarta_id
),

-- SURABAYA BASED
(
  'Jawa Pos', 
  'jawa-pos', 
  'PT Jawa Pos Koran', 
  'news', 
  'jpg', 'png', 
  'https://www.jawapos.com', 
  'online@jawapos.com', 
  'One of the largest newspaper conglomerates in Indonesia, based in Surabaya.', 
  @surabaya_id
),
(
  'Suara Surabaya', 
  'suara-surabaya', 
  'PT Radio Suara Surabaya', 
  'radio', 
  'jpg', 'png', 
  'https://www.suarasurabaya.net', 
  'news@suarasurabaya.net', 
  'Prominent radio station and news portal serving East Java.', 
  @surabaya_id
),

-- BANDUNG BASED
(
  'Pikiran Rakyat', 
  'pikiran-rakyat', 
  'PT Pikiran Rakyat Bandung', 
  'news', 
  'jpg', 'png', 
  'https://www.pikiran-rakyat.com', 
  'redaksi@pikiran-rakyat.com', 
  'The largest media group in West Java.', 
  @bandung_id
);