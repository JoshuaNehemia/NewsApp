CREATE DATABASE  IF NOT EXISTS `newsapp` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `newsapp`;
-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: newsapp
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts` (
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL COMMENT 'Hashed password',
  `fullname` varchar(150) NOT NULL,
  `email` varchar(150) NOT NULL,
  `role` enum('user','writer','admin') NOT NULL DEFAULT 'user' COMMENT 'User role',
  `profile_picture_ext` varchar(10) DEFAULT NULL COMMENT 'Profile picture extension (jpg, png, etc.)',
  `is_active` tinyint(1) DEFAULT 1,
  `locked_until` datetime DEFAULT NULL COMMENT 'Account lock timestamp',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `idx_email` (`email`),
  KEY `idx_role` (`role`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES 
('ahmad_writer','$2y$10$/INk5B0IxBkQ.0cbQW1pX.BdHiC6INl9rEvTncaW.MrDRW4/2GPO.','Ahmad Hidayat','ahmad.hidayat@newsapp.com','writer',NULL,1,NULL,'2026-01-15 08:00:00','2026-01-15 08:00:00'),
('bella_writer','$2y$10$/INk5B0IxBkQ.0cbQW1pX.BdHiC6INl9rEvTncaW.MrDRW4/2GPO.','Bella Kusuma','bella.kusuma@newsapp.com','writer',NULL,1,NULL,'2026-01-15 08:30:00','2026-01-15 08:30:00'),
('citra_writer','$2y$10$/INk5B0IxBkQ.0cbQW1pX.BdHiC6INl9rEvTncaW.MrDRW4/2GPO.','Citra Dewi','citra.dewi@newsapp.com','writer',NULL,1,NULL,'2026-01-15 09:00:00','2026-01-15 09:00:00'),
('doni_writer','$2y$10$/INk5B0IxBkQ.0cbQW1pX.BdHiC6INl9rEvTncaW.MrDRW4/2GPO.','Doni Sutrisno','doni.sutrisno@newsapp.com','writer',NULL,1,NULL,'2026-01-15 09:30:00','2026-01-15 09:30:00'),
('user_alfa','$2y$10$/INk5B0IxBkQ.0cbQW1pX.BdHiC6INl9rEvTncaW.MrDRW4/2GPO.','Alfa Rizki','alfa.rizki@newsapp.com','user',NULL,1,NULL,'2026-01-15 07:00:00','2026-01-15 07:00:00'),
('user_beta','$2y$10$/INk5B0IxBkQ.0cbQW1pX.BdHiC6INl9rEvTncaW.MrDRW4/2GPO.','Beta Sari','beta.sari@newsapp.com','user',NULL,1,NULL,'2026-01-15 07:30:00','2026-01-15 07:30:00'),
('user_gamma','$2y$10$/INk5B0IxBkQ.0cbQW1pX.BdHiC6INl9rEvTncaW.MrDRW4/2GPO.','Gamma Pratama','gamma.pratama@newsapp.com','user',NULL,1,NULL,'2026-01-15 08:00:00','2026-01-15 08:00:00');
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `slug` (`slug`),
  KEY `idx_slug` (`slug`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Technology','technology','Latest tech news and innovations','2026-01-14 20:37:55','2026-01-14 20:37:55'),(2,'Sports','sports','Sports news and updates','2026-01-14 20:37:55','2026-01-14 20:37:55'),(3,'Entertainment','entertainment','Entertainment and celebrity news','2026-01-14 20:37:55','2026-01-14 20:37:55'),(4,'World News','world-news','International news stories','2026-01-14 20:37:55','2026-01-14 20:37:55');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT 'City name',
  `country_division_id` int(11) NOT NULL,
  `latitude` decimal(10,8) DEFAULT NULL COMMENT 'City latitude',
  `longitude` decimal(11,8) DEFAULT NULL COMMENT 'City longitude',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_city_division` (`name`,`country_division_id`),
  KEY `idx_country_division_id` (`country_division_id`),
  KEY `idx_name` (`name`),
  CONSTRAINT `fk_cities_country_division` FOREIGN KEY (`country_division_id`) REFERENCES `country_divisions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities`
--

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
INSERT INTO `cities` VALUES (1,'Jakarta City',1,-6.20880000,106.84560000,'2026-01-14 20:37:55','2026-01-14 20:37:55'),(2,'Denpasar',2,-8.67050000,115.21260000,'2026-01-14 20:37:55','2026-01-14 20:37:55'),(3,'Los Angeles',3,34.05220000,-118.24370000,'2026-01-14 20:37:55','2026-01-14 20:37:55'),(4,'New York City',4,40.71280000,-74.00600000,'2026-01-14 20:37:55','2026-01-14 20:37:55'),(5,'Singapore City',5,1.35210000,103.81980000,'2026-01-14 20:37:55','2026-01-14 20:37:55');
/*!40000 ALTER TABLE `cities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `news_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL COMMENT 'User who commented (must be regular user)',
  `reply_to_id` int(11) DEFAULT NULL COMMENT 'Parent comment ID if this is a reply',
  `content` text NOT NULL COMMENT 'Comment text',
  `reply_count` int(11) DEFAULT 0 COMMENT 'Number of replies to this comment',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_news_id` (`news_id`),
  KEY `idx_username` (`username`),
  KEY `idx_reply_to_id` (`reply_to_id`),
  KEY `idx_created_at` (`created_at`),
  CONSTRAINT `fk_comments_news` FOREIGN KEY (`news_id`) REFERENCES `news` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_comments_parent` FOREIGN KEY (`reply_to_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_comments_user` FOREIGN KEY (`username`) REFERENCES `users` (`username`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES 
(1,1,'john_user',NULL,'Incredible breakthrough! This AI development will revolutionize the industry.',2,'2026-01-15 09:30:00','2026-01-15 09:30:00'),
(2,1,'jane_user',NULL,'Great article explaining the technical aspects clearly.',0,'2026-01-15 10:00:00','2026-01-15 10:00:00'),
(3,1,'john_user',1,'Absolutely! Looking forward to seeing practical applications.',0,'2026-01-15 10:15:00','2026-01-15 10:15:00'),
(4,2,'feyfekjuwle',NULL,'Quantum computing is the future! Exciting times ahead.',1,'2026-01-15 11:00:00','2026-01-15 11:00:00'),
(5,2,'jane_user',2,'When will we see this in commercial products?',0,'2026-01-15 11:30:00','2026-01-15 11:30:00'),
(6,3,'john_user',NULL,'What an amazing championship match!',1,'2026-01-15 12:00:00','2026-01-15 12:00:00'),
(7,3,'feyfekjuwle',6,'The teamwork was exceptional throughout the tournament.',0,'2026-01-15 12:30:00','2026-01-15 12:30:00'),
(8,4,'jane_user',NULL,'Olympic spirit at its finest!',0,'2026-01-15 13:00:00','2026-01-15 13:00:00');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `countries`
--

DROP TABLE IF EXISTS `countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `countries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(3) NOT NULL COMMENT 'Country code (e.g., IDN, USA, SGP)',
  `name` varchar(100) NOT NULL COMMENT 'Country name',
  `telephone` varchar(5) DEFAULT NULL COMMENT 'Country telephone code (e.g., +62, +1)',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  UNIQUE KEY `name` (`name`),
  KEY `idx_code` (`code`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `countries`
--

LOCK TABLES `countries` WRITE;
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` VALUES (1,'IDN','Indonesia','+62','2026-01-14 20:37:55','2026-01-14 20:37:55'),(2,'USA','United States','+1','2026-01-14 20:37:55','2026-01-14 20:37:55'),(3,'SGP','Singapore','+65','2026-01-14 20:37:55','2026-01-14 20:37:55');
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country_divisions`
--

DROP TABLE IF EXISTS `country_divisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `country_divisions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT 'State/Province name',
  `country_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_division_country` (`name`,`country_id`),
  KEY `idx_country_id` (`country_id`),
  KEY `idx_name` (`name`),
  CONSTRAINT `fk_country_divisions_country` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country_divisions`
--

LOCK TABLES `country_divisions` WRITE;
/*!40000 ALTER TABLE `country_divisions` DISABLE KEYS */;
INSERT INTO `country_divisions` VALUES (1,'Jakarta',1,'2026-01-14 20:37:55','2026-01-14 20:37:55'),(2,'Bali',1,'2026-01-14 20:37:55','2026-01-14 20:37:55'),(3,'California',2,'2026-01-14 20:37:55','2026-01-14 20:37:55'),(4,'New York',2,'2026-01-14 20:37:55','2026-01-14 20:37:55'),(5,'Central Region',3,'2026-01-14 20:37:55','2026-01-14 20:37:55');
/*!40000 ALTER TABLE `country_divisions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `news_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL COMMENT 'User who liked/disliked',
  `is_like` tinyint(1) NOT NULL COMMENT '1 for like, 0 for dislike',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_news_like` (`news_id`,`username`,`is_like`),
  KEY `idx_news_id` (`news_id`),
  KEY `idx_username` (`username`),
  KEY `idx_is_like` (`is_like`),
  CONSTRAINT `fk_likes_news` FOREIGN KEY (`news_id`) REFERENCES `news` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_likes_user` FOREIGN KEY (`username`) REFERENCES `users` (`username`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES 
(1,1,'jane_user',1,'2026-01-15 09:45:00'),
(2,1,'john_user',1,'2026-01-15 10:00:00'),
(3,2,'jane_user',1,'2026-01-15 10:45:00'),
(4,2,'feyfekjuwle',1,'2026-01-15 11:00:00'),
(5,3,'john_user',1,'2026-01-15 12:00:00'),
(6,4,'jane_user',1,'2026-01-15 13:15:00'),
(7,4,'feyfekjuwle',1,'2026-01-15 13:30:00'),
(8,5,'john_user',1,'2026-01-15 14:30:00'),
(9,5,'jane_user',1,'2026-01-15 14:45:00'),
(10,6,'feyfekjuwle',1,'2026-01-15 16:00:00'),
(11,7,'jane_user',1,'2026-01-15 17:00:00'),
(12,8,'john_user',1,'2026-01-15 18:30:00');
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medias`
--

DROP TABLE IF EXISTS `medias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `slug` varchar(150) NOT NULL COMMENT 'URL-friendly slug',
  `company_name` varchar(150) DEFAULT NULL,
  `media_type` enum('NEWS','JOURNAL','BLOG','TV','RADIO','PUBLISHER') DEFAULT 'NEWS',
  `picture_ext` varchar(10) DEFAULT NULL COMMENT 'Media picture extension',
  `logo_ext` varchar(10) DEFAULT NULL COMMENT 'Media logo extension',
  `website` varchar(255) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `city_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `slug` (`slug`),
  KEY `idx_slug` (`slug`),
  KEY `idx_city_id` (`city_id`),
  KEY `idx_name` (`name`),
  CONSTRAINT `fk_medias_city` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medias`
--

LOCK TABLES `medias` WRITE;
/*!40000 ALTER TABLE `medias` DISABLE KEYS */;
INSERT INTO `medias` VALUES (1,'Kompas Daily','kompas-daily','PT Kompas Media Nusantara','NEWS',NULL,NULL,'https://kompas.com','info@kompas.com','Leading Indonesian newspaper',1,'2026-01-14 20:37:55','2026-01-14 20:37:55'),(2,'BBC News','bbc-news','British Broadcasting Corporation','TV',NULL,NULL,'https://bbc.com/news','contact@bbc.com','International news network',4,'2026-01-14 20:37:55','2026-01-14 20:37:55'),(3,'Straits Times','straits-times','Singapore Press Holdings','NEWS',NULL,NULL,'https://straitstimes.com','info@sph.com.sg','Singapore leading newspaper',5,'2026-01-14 20:37:55','2026-01-14 20:37:55');
/*!40000 ALTER TABLE `medias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `news` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL COMMENT 'URL-friendly slug',
  `content` longtext NOT NULL COMMENT 'News content/body',
  `category_id` int(11) NOT NULL,
  `writer_username` varchar(50) NOT NULL COMMENT 'Author username',
  `media_id` int(11) DEFAULT NULL COMMENT 'Associated media outlet',
  `city_id` int(11) DEFAULT NULL COMMENT 'News location city',
  `view_count` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `idx_slug` (`slug`),
  KEY `idx_category_id` (`category_id`),
  KEY `idx_writer_username` (`writer_username`),
  KEY `idx_media_id` (`media_id`),
  KEY `idx_city_id` (`city_id`),
  KEY `idx_created_at` (`created_at`),
  FULLTEXT KEY `fulltext_search` (`title`,`content`),
  CONSTRAINT `fk_news_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  CONSTRAINT `fk_news_city` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_news_media` FOREIGN KEY (`media_id`) REFERENCES `medias` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_news_writer` FOREIGN KEY (`writer_username`) REFERENCES `writers` (`username`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
INSERT INTO `news` VALUES 
(1,'AI Breakthrough: New Neural Network Achieves Human-Level Performance','ai-breakthrough-neural-network','Recent developments in artificial intelligence have shown remarkable progress. A new neural network architecture has achieved human-level performance on complex tasks. This breakthrough is expected to revolutionize machine learning applications across various industries. Researchers believe this could lead to significant advancements in natural language processing, computer vision, and autonomous systems.','1','ahmad_writer','1','1','150','2026-01-15 09:00:00','2026-01-15 09:00:00'),
(2,'Quantum Computing Milestone: First Practical Application Deployed','quantum-computing-milestone-practical','A major tech company has successfully deployed the first practical quantum computing application. This represents a significant step forward in quantum technology commercialization. The system has demonstrated computational advantages over traditional supercomputers for specific problems. Industry experts predict this will accelerate quantum computing adoption across financial services and drug discovery sectors.','1','ahmad_writer','2','4','89','2026-01-15 10:30:00','2026-01-15 10:30:00'),
(3,'Championship Final: Thrilling Victory Crowned New Champions','championship-final-thrilling-victory','The international sports championship concluded with an exciting final match watched by millions globally. The defending champions fought fiercely but ultimately fell to the challenger team in a dramatic finish. The winning team displayed exceptional teamwork and tactical brilliance throughout the tournament. Fans celebrated the victory with unprecedented enthusiasm across the nation.','2','bella_writer','1','1','245','2026-01-15 11:00:00','2026-01-15 11:00:00'),
(4,'Olympic Games Begin: Spectacular Opening Ceremony Delights World Audience','olympic-games-begin-spectacular','The Olympic Games opened with a breathtaking ceremony featuring thousands of performers and cutting-edge production. Athletes from over 200 nations gathered to compete in various sporting events. The ceremony showcased cultural diversity and humanity\'s passion for athletic excellence. Nations highlighted their heritage through stunning artistic performances and technological displays.','2','bella_writer','1','3','198','2026-01-15 12:45:00','2026-01-15 12:45:00'),
(5,'Blockbuster Movie Shatters Box Office Records','blockbuster-movie-shatters-box-office','A highly anticipated superhero film has broken multiple box office records on its opening weekend. The film features an all-star cast and groundbreaking visual effects that impressed critics and audiences alike. Industry analysts predict it will become one of the highest-grossing films of all time. The movie\'s success reflects the continued popularity of franchise entertainment.','3','citra_writer','2','3','567','2026-01-15 14:00:00','2026-01-15 14:00:00'),
(6,'Award Season Brings Surprises: Unexpected Winners Dominate Ceremonies','award-season-surprises-unexpected-winners','The prestigious entertainment awards ceremony delivered unexpected results with several surprise winners. Industry veterans were surprised by the selections made by voting members. The awards celebrated diverse talent and fresh perspectives in filmmaking. Major studios reacted to the results with mixed reactions regarding future production strategies.','3','citra_writer','1','3','423','2026-01-15 15:30:00','2026-01-15 15:30:00'),
(7,'Global Peace Summit Achieves Historic Accord on Climate Action','global-peace-summit-historic-accord','World leaders from all nations convened at the global peace summit to address pressing international issues. The summit resulted in a historic accord on climate change mitigation and sustainable development. Nations committed to significant carbon reduction targets and renewable energy investments. The agreement represents unprecedented cooperation among countries for global environmental protection.','4','doni_writer','2','5','156','2026-01-15 16:45:00','2026-01-15 16:45:00'),
(8,'International Crisis: Humanitarian Response Mobilized Globally','international-crisis-humanitarian-response','A major humanitarian crisis has prompted international organizations to mobilize emergency response efforts. Governments and NGOs are coordinating to provide medical aid, food supplies, and shelter to affected populations. The United Nations coordinated the relief efforts, demonstrating international solidarity. Donors pledged billions of dollars in support to assist the recovery efforts.','4','doni_writer','2','4','287','2026-01-15 18:00:00','2026-01-15 18:00:00');
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news_categories`
--

DROP TABLE IF EXISTS `news_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `news_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `news_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `news_id` (`news_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `fk_nc_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_nc_news` FOREIGN KEY (`news_id`) REFERENCES `news` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news_categories`
--

LOCK TABLES `news_categories` WRITE;
/*!40000 ALTER TABLE `news_categories` DISABLE KEYS */;
INSERT INTO `news_categories` VALUES 
(1,1,1),
(2,1,4),
(3,2,1),
(4,2,4),
(5,3,2),
(6,3,4),
(7,4,2),
(8,4,4),
(9,5,3),
(10,5,4),
(11,6,3),
(12,7,4),
(13,8,4);
/*!40000 ALTER TABLE `news_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news_images`
--

DROP TABLE IF EXISTS `news_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `news_images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `news_id` int(11) NOT NULL,
  `image_path` varchar(500) DEFAULT NULL,
  `image_ext` varchar(10) DEFAULT NULL COMMENT 'Image file extension',
  `alt_text` varchar(255) DEFAULT NULL COMMENT 'Image alt text',
  `position` int(11) DEFAULT 0 COMMENT 'Image display order',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `idx_news_id` (`news_id`),
  KEY `idx_position` (`position`),
  CONSTRAINT `fk_news_images_news` FOREIGN KEY (`news_id`) REFERENCES `news` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news_images`
--

LOCK TABLES `news_images` WRITE;
/*!40000 ALTER TABLE `news_images` DISABLE KEYS */;
INSERT INTO `news_images` VALUES 
(1,1,NULL,'jpg','AI Neural Network Architecture',1,'2026-01-15 09:00:00'),
(2,1,NULL,'jpg','Deep Learning Visualization',2,'2026-01-15 09:00:00'),
(3,1,NULL,'jpg','Research Lab with AI Systems',3,'2026-01-15 09:00:00'),
(4,1,NULL,'jpg','Data Science Team Presentation',4,'2026-01-15 09:00:00'),
(5,2,NULL,'jpg','Quantum Computer Hardware',1,'2026-01-15 10:30:00'),
(6,2,NULL,'jpg','Quantum Processing Diagram',2,'2026-01-15 10:30:00'),
(7,2,NULL,'jpg','Tech Lab Facility',3,'2026-01-15 10:30:00'),
(8,2,NULL,'jpg','Scientists Working on Quantum Systems',4,'2026-01-15 10:30:00'),
(9,3,NULL,'jpg','Championship Final Stadium',1,'2026-01-15 11:00:00'),
(10,3,NULL,'jpg','Winning Team Celebration',2,'2026-01-15 11:00:00'),
(11,3,NULL,'jpg','Trophy Presentation Ceremony',3,'2026-01-15 11:00:00'),
(12,3,NULL,'jpg','Crowd Reaction and Fans',4,'2026-01-15 11:00:00'),
(13,4,NULL,'jpg','Olympic Opening Ceremony',1,'2026-01-15 12:45:00'),
(14,4,NULL,'jpg','Athletes Parade',2,'2026-01-15 12:45:00'),
(15,4,NULL,'jpg','Artistic Performance',3,'2026-01-15 12:45:00'),
(16,4,NULL,'jpg','Olympic Stadium Lighting',4,'2026-01-15 12:45:00'),
(17,5,NULL,'jpg','Movie Poster Feature',1,'2026-01-15 14:00:00'),
(18,5,NULL,'jpg','Cast Interview',2,'2026-01-15 14:00:00'),
(19,5,NULL,'jpg','Action Scene Still',3,'2026-01-15 14:00:00'),
(20,5,NULL,'jpg','Box Office Record Board',4,'2026-01-15 14:00:00'),
(21,6,NULL,'jpg','Award Ceremony Stage',1,'2026-01-15 15:30:00'),
(22,6,NULL,'jpg','Winners on Red Carpet',2,'2026-01-15 15:30:00'),
(23,6,NULL,'jpg','Award Trophy Close-up',3,'2026-01-15 15:30:00'),
(24,6,NULL,'jpg','Audience Reaction',4,'2026-01-15 15:30:00'),
(25,7,NULL,'jpg','World Leaders at Summit',1,'2026-01-15 16:45:00'),
(26,7,NULL,'jpg','Climate Action Agreement',2,'2026-01-15 16:45:00'),
(27,7,NULL,'jpg','Conference Hall Session',3,'2026-01-15 16:45:00'),
(28,7,NULL,'jpg','Renewable Energy Presentation',4,'2026-01-15 16:45:00'),
(29,8,NULL,'jpg','Humanitarian Aid Distribution',1,'2026-01-15 18:00:00'),
(30,8,NULL,'jpg','Relief Organization Workers',2,'2026-01-15 18:00:00'),
(31,8,NULL,'jpg','Medical Aid Station',3,'2026-01-15 18:00:00'),
(32,8,NULL,'jpg','Community Support Effort',4,'2026-01-15 18:00:00');
/*!40000 ALTER TABLE `news_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news_tags`
--

DROP TABLE IF EXISTS `news_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `news_tags` (
  `news_id` int(11) NOT NULL,
  `tags_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`news_id`,`tags_id`),
  KEY `idx_tags_id` (`tags_id`),
  CONSTRAINT `fk_news_tags_news` FOREIGN KEY (`news_id`) REFERENCES `news` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_news_tags_tags` FOREIGN KEY (`tags_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news_tags`
--

LOCK TABLES `news_tags` WRITE;
/*!40000 ALTER TABLE `news_tags` DISABLE KEYS */;
INSERT INTO `news_tags` VALUES 
(1,1,'2026-01-15 09:00:00'),
(1,2,'2026-01-15 09:00:00'),
(2,1,'2026-01-15 10:30:00'),
(2,2,'2026-01-15 10:30:00'),
(3,2,'2026-01-15 11:00:00'),
(3,4,'2026-01-15 11:00:00'),
(4,2,'2026-01-15 12:45:00'),
(4,3,'2026-01-15 12:45:00'),
(5,2,'2026-01-15 14:00:00'),
(5,4,'2026-01-15 14:00:00'),
(6,2,'2026-01-15 15:30:00'),
(6,4,'2026-01-15 15:30:00'),
(7,3,'2026-01-15 16:45:00'),
(8,3,'2026-01-15 18:00:00');
/*!40000 ALTER TABLE `news_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rates`
--

DROP TABLE IF EXISTS `rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `news_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL COMMENT 'User who rated',
  `rate` decimal(3,2) NOT NULL COMMENT 'Rating value (1.00 - 5.00)',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_news_rate` (`news_id`,`username`),
  KEY `idx_news_id` (`news_id`),
  KEY `idx_username` (`username`),
  CONSTRAINT `fk_rates_news` FOREIGN KEY (`news_id`) REFERENCES `news` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_rates_user` FOREIGN KEY (`username`) REFERENCES `users` (`username`) ON DELETE CASCADE,
  CONSTRAINT `CONSTRAINT_1` CHECK (`rate` >= 1 and `rate` <= 5)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rates`
--

LOCK TABLES `rates` WRITE;
/*!40000 ALTER TABLE `rates` DISABLE KEYS */;
INSERT INTO `rates` VALUES 
(1,1,'john_user',4.50,'2026-01-15 09:30:00','2026-01-15 09:30:00'),
(2,1,'jane_user',5.00,'2026-01-15 10:00:00','2026-01-15 10:00:00'),
(3,1,'feyfekjuwle',4.00,'2026-01-15 10:30:00','2026-01-15 10:30:00'),
(4,2,'john_user',4.50,'2026-01-15 11:00:00','2026-01-15 11:00:00'),
(5,2,'jane_user',5.00,'2026-01-15 11:30:00','2026-01-15 11:30:00'),
(6,3,'john_user',4.50,'2026-01-15 12:00:00','2026-01-15 12:00:00'),
(7,3,'jane_user',4.50,'2026-01-15 12:30:00','2026-01-15 12:30:00'),
(8,3,'feyfekjuwle',4.00,'2026-01-15 13:00:00','2026-01-15 13:00:00'),
(9,4,'john_user',5.00,'2026-01-15 13:30:00','2026-01-15 13:30:00'),
(10,4,'jane_user',5.00,'2026-01-15 14:00:00','2026-01-15 14:00:00'),
(11,5,'john_user',5.00,'2026-01-15 14:45:00','2026-01-15 14:45:00'),
(12,5,'jane_user',5.00,'2026-01-15 15:00:00','2026-01-15 15:00:00'),
(13,5,'feyfekjuwle',4.50,'2026-01-15 15:30:00','2026-01-15 15:30:00'),
(14,6,'john_user',4.00,'2026-01-15 16:00:00','2026-01-15 16:00:00'),
(15,6,'jane_user',4.50,'2026-01-15 16:30:00','2026-01-15 16:30:00'),
(16,7,'john_user',4.50,'2026-01-15 17:15:00','2026-01-15 17:15:00'),
(17,7,'feyfekjuwle',5.00,'2026-01-15 17:45:00','2026-01-15 17:45:00'),
(18,8,'jane_user',4.00,'2026-01-15 18:45:00','2026-01-15 18:45:00');
/*!40000 ALTER TABLE `rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `slug` (`slug`),
  KEY `idx_slug` (`slug`),
  KEY `idx_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (1,'Breaking News','breaking-news','2026-01-14 20:37:55'),(2,'Featured','featured','2026-01-14 20:37:55'),(3,'Analysis','analysis','2026-01-14 20:37:55'),(4,'Interview','interview','2026-01-14 20:37:55'),(5,'Indonesia','indonesia','2026-01-14 20:37:55');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `token` varchar(255) NOT NULL,
  `token_type` enum('email_verification','password_reset','api_token') NOT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`),
  KEY `idx_username` (`username`),
  KEY `idx_token` (`token`),
  KEY `idx_expires_at` (`expires_at`),
  CONSTRAINT `fk_tokens_account` FOREIGN KEY (`username`) REFERENCES `accounts` (`username`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
INSERT INTO `tokens` VALUES (1,'john_user','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9example1','email_verification','2026-01-22 03:37:55','2026-01-14 20:37:55'),(2,'jane_user','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9example2','password_reset','2026-01-16 03:37:55','2026-01-14 20:37:55');
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `username` varchar(50) NOT NULL,
  `birthdate` date DEFAULT NULL,
  `gender` enum('male','female','other') DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `biography` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`username`),
  KEY `idx_country_id` (`country_id`),
  CONSTRAINT `fk_users_account` FOREIGN KEY (`username`) REFERENCES `accounts` (`username`) ON DELETE CASCADE,
  CONSTRAINT `fk_users_country` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES 
('user_alfa','1995-03-12','male',1,'085612345678','Penggemar berita teknologi dan inovasi digital','2026-01-15 07:00:00','2026-01-15 07:00:00'),
('user_beta','1998-07-22','female',1,'082198765432','Pecinta olahraga dan pertandingan internasional','2026-01-15 07:30:00','2026-01-15 07:30:00'),
('user_gamma','1992-11-08','male',2,'(65)67654321','Pembaca berita seni dan budaya dari Singapura','2026-01-15 08:00:00','2026-01-15 08:00:00');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `writers`
--

DROP TABLE IF EXISTS `writers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `writers` (
  `username` varchar(50) NOT NULL,
  `media_id` int(11) DEFAULT NULL,
  `biography` text DEFAULT NULL,
  `is_verified` tinyint(1) DEFAULT 0 COMMENT 'Writer verification status',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`username`),
  KEY `idx_media_id` (`media_id`),
  KEY `idx_is_verified` (`is_verified`),
  CONSTRAINT `fk_writers_account` FOREIGN KEY (`username`) REFERENCES `accounts` (`username`) ON DELETE CASCADE,
  CONSTRAINT `fk_writers_media` FOREIGN KEY (`media_id`) REFERENCES `medias` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `writers`
--

LOCK TABLES `writers` WRITE;
/*!40000 ALTER TABLE `writers` DISABLE KEYS */;
INSERT INTO `writers` VALUES 
('ahmad_writer',1,'Jurnalis berpengalaman di bidang teknologi dan startup',1,'2026-01-15 08:00:00','2026-01-15 08:00:00'),
('bella_writer',2,'Reporter olahraga dengan track record coverage internasional',1,'2026-01-15 08:30:00','2026-01-15 08:30:00'),
('citra_writer',1,'Koresponden hiburan dan selebriti',0,'2026-01-15 09:00:00','2026-01-15 09:00:00'),
('doni_writer',2,'Jurnalis politik dan berita dunia',1,'2026-01-15 09:30:00','2026-01-15 09:30:00');
/*!40000 ALTER TABLE `writers` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-15  6:29:59
