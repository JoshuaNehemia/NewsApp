SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `NewsApp` DEFAULT CHARACTER SET utf8mb4;
USE `NewsApp`;

-- 1. Countries
CREATE TABLE IF NOT EXISTS `countries` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `code` CHAR(3) NOT NULL COMMENT 'ISO 3166-1 alpha-3 country code',
  `telephone` VARCHAR(5) NOT NULL COMMENT 'International telephone dialing code',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  PRIMARY KEY (`id`),
  CONSTRAINT `uq_countries_code` UNIQUE (`code`)
)
ENGINE=InnoDB
COMMENT='Master list of countries';

-- 2. Country Divisions
CREATE TABLE IF NOT EXISTS `country_divisions` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `country_id` BIGINT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  PRIMARY KEY (`id`),
  CONSTRAINT `uq_country_divisions_country_name`
    UNIQUE (`country_id`, `name`),
  CONSTRAINT `fk_country_divisions_country`
    FOREIGN KEY (`country_id`)
    REFERENCES `countries` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) 
ENGINE=InnoDB
COMMENT='Table for country divisions (provinces, states, regions)';

-- 3. Cities
CREATE TABLE IF NOT EXISTS `cities` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `country_division_id` BIGINT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `latitude` DECIMAL(9,6) NOT NULL COMMENT 'Latitude in degrees',
  `longitude` DECIMAL(9,6) NOT NULL COMMENT 'Longitude in degrees',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  PRIMARY KEY (`id`),
  CONSTRAINT `uq_cities_division_name`
    UNIQUE (`country_division_id`, `name`),
  CONSTRAINT `fk_cities_division`
    FOREIGN KEY (`country_division_id`)
    REFERENCES `country_divisions` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,

  INDEX `idx_cities_lat_lng` (`latitude`, `longitude`)
)
ENGINE=InnoDB
COMMENT='Table for cities list';

-- 4. Medias
CREATE TABLE IF NOT EXISTS `medias` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `slug` VARCHAR(150) NOT NULL,
  `company_name` VARCHAR(100) NOT NULL,
  `media_type` ENUM('news','journal','blog','tv','radio','publisher') NOT NULL,
  `picture_ext` VARCHAR(4) NOT NULL,
  `logo_ext` VARCHAR(4) NOT NULL,
  `website` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `description` TEXT NOT NULL,
  `city_id` BIGINT NULL,

  `is_active` BOOLEAN NOT NULL DEFAULT TRUE,
  `deleted_at` TIMESTAMP NULL,

  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  PRIMARY KEY (`id`),
  CONSTRAINT `uq_medias_slug` 
    UNIQUE (`slug`),
  CONSTRAINT `fk_medias_city`
    FOREIGN KEY (`city_id`)
    REFERENCES `cities` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,

  INDEX `idx_medias_city` (`city_id`)
) 
ENGINE=InnoDB
COMMENT='Media organizations or publishers';

-- 5. Accounts
CREATE TABLE IF NOT EXISTS `accounts` (
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(255) NOT NULL COMMENT 'Hashed password',
  `fullname` VARCHAR(200) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `city_id` BIGINT NOT NULL,
  `role` ENUM('user','writer','admin') NOT NULL DEFAULT 'user',
  `profile_picture_ext` VARCHAR(4),

  `is_active` BOOLEAN NOT NULL DEFAULT TRUE,
  `email_verified_at` TIMESTAMP NULL,
  `last_login_at` TIMESTAMP NULL,
  `password_changed_at` TIMESTAMP NULL,
  `failed_login_attempts` INT NOT NULL DEFAULT 0,
  `locked_until` TIMESTAMP NULL,
  `deleted_at` TIMESTAMP NULL,

  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  PRIMARY KEY (`username`),
  CONSTRAINT `uq_accounts_email` 
    UNIQUE (`email`),
  CONSTRAINT `fk_accounts_city`
    FOREIGN KEY (`city_id`)
    REFERENCES `cities` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,

  INDEX `idx_accounts_city` (`city_id`)
) 
ENGINE=InnoDB
COMMENT='Account table';

-- 6. Users (Readers)
CREATE TABLE IF NOT EXISTS `users` (
  `username` VARCHAR(45) NOT NULL,
  `birthdate` DATE NULL COMMENT 'yyyy-mm-dd',
  `gender` ENUM('male','female') NULL,
  `phone_number` VARCHAR(20) NULL,
  `biography` TEXT NULL,

  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  PRIMARY KEY (`username`),
  CONSTRAINT `fk_users_account`
    FOREIGN KEY (`username`)
    REFERENCES `accounts` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) 
ENGINE=InnoDB
COMMENT='Extended profile details for standard readers';

-- 7. Writers
CREATE TABLE IF NOT EXISTS `writers` (
  `username` VARCHAR(45) NOT NULL,
  `media_id` BIGINT NOT NULL,
  `biography` TEXT NULL,

  `is_verified` BOOLEAN NOT NULL DEFAULT FALSE,
  `verified_at` TIMESTAMP NULL,
  `verified_by` VARCHAR(100) NULL,

  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  PRIMARY KEY (`username`),
  CONSTRAINT `fk_writers_media`
    FOREIGN KEY (`media_id`)
    REFERENCES `medias` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_writers_account`
    FOREIGN KEY (`username`)
    REFERENCES `accounts` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  INDEX `idx_writers_media` (`media_id`)
)
ENGINE=InnoDB
COMMENT='Writer profiles associated with media organizations';

-- 8. Categories
CREATE TABLE IF NOT EXISTS `categories` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  PRIMARY KEY (`id`),
  CONSTRAINT `uq_categories_name`
    UNIQUE (`name`)
) 
ENGINE=InnoDB
COMMENT='Table for news categories';

-- 9. Tags
CREATE TABLE IF NOT EXISTS `tags` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `category_id` BIGINT NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  PRIMARY KEY (`id`),
  CONSTRAINT `uq_tags_category_name`
    UNIQUE (`category_id`, `name`),
  CONSTRAINT `fk_tags_category`
    FOREIGN KEY (`category_id`)
    REFERENCES `categories` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,

  INDEX `idx_tags_category` (`category_id`)
) 
ENGINE=InnoDB
COMMENT='Keywords/Tags for granular content filtering';

-- 10. Preferences
CREATE TABLE IF NOT EXISTS `preferences` (
  `username` VARCHAR(45) NOT NULL,
  `category_id` BIGINT NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  PRIMARY KEY (`username`, `category_id`),
  CONSTRAINT `fk_preferences_category`
    FOREIGN KEY (`category_id`)
    REFERENCES `categories` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_preferences_user`
    FOREIGN KEY (`username`)
    REFERENCES `users` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  INDEX `idx_preferences_category` (`category_id`)
) 
ENGINE=InnoDB
COMMENT='Stores categories a user is interested in';

-- 11. Specialties
CREATE TABLE IF NOT EXISTS `specialties` (
  `username` VARCHAR(45) NOT NULL,
  `category_id` BIGINT NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  PRIMARY KEY (`username`, `category_id`),
  CONSTRAINT `fk_specialties_category`
    FOREIGN KEY (`category_id`)
    REFERENCES `categories` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_specialties_writer`
    FOREIGN KEY (`username`)
    REFERENCES `writers` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  INDEX `idx_specialties_category` (`category_id`)
) 
ENGINE=InnoDB
COMMENT='Maps writers to their topics of expertise';

-- 12. User Followed Tags
CREATE TABLE IF NOT EXISTS `user_followed_tags` (
  `username` VARCHAR(45) NOT NULL,
  `tag_id` BIGINT NOT NULL,
  `followed_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  PRIMARY KEY (`username`, `tag_id`),

  CONSTRAINT `fk_user_followed_tags_user`
    FOREIGN KEY (`username`)
    REFERENCES `users` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  CONSTRAINT `fk_user_followed_tags_tag`
    FOREIGN KEY (`tag_id`)
    REFERENCES `tags` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  INDEX `idx_user_followed_tags_tag` (`tag_id`)
) 
ENGINE=InnoDB
COMMENT='Many-to-many mapping of users following tags';

-- 13. Subscriptions
CREATE TABLE IF NOT EXISTS `subscriptions` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `paid_at` DATETIME NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  `status` ENUM('active', 'expired', 'cancelled') NOT NULL DEFAULT 'active',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_subscriptions_user`
    FOREIGN KEY (`username`)
    REFERENCES `users` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  INDEX `idx_subscriptions_user` (`username`)
)
ENGINE = InnoDB
COMMENT = 'Records of user payments and subscription validity';

-- 14. News
CREATE TABLE IF NOT EXISTS `news` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `writer_username` VARCHAR(45) NOT NULL,
  `category_id` BIGINT NOT NULL,
  `city_id` BIGINT NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `slug` VARCHAR(255) NOT NULL,
  `content` LONGTEXT NOT NULL,
  `is_published` BOOLEAN NOT NULL DEFAULT FALSE,
  `view_count` BIGINT NOT NULL DEFAULT 0,

  `latitude` DECIMAL(9,6) NULL,
  `longitude` DECIMAL(9,6) NULL,

  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  PRIMARY KEY (`id`),
  CONSTRAINT `uq_news_slug` UNIQUE (`slug`),

  CONSTRAINT `fk_news_writer`
    FOREIGN KEY (`writer_username`)
    REFERENCES `writers` (`username`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,

  CONSTRAINT `fk_news_category`
    FOREIGN KEY (`category_id`)
    REFERENCES `categories` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,

  CONSTRAINT `fk_news_city`
    FOREIGN KEY (`city_id`)
    REFERENCES `cities` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,

  INDEX `idx_news_writer` (`writer_username`),
  INDEX `idx_news_category` (`category_id`),
  INDEX `idx_news_city` (`city_id`)
)
ENGINE=InnoDB
COMMENT='Published news articles';

-- 15. Likes
CREATE TABLE IF NOT EXISTS `likes` (
  `news_id` BIGINT NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `is_like` TINYINT NOT NULL COMMENT '1 for like, 0 for dislike',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  PRIMARY KEY(`news_id`, `username`),
  CONSTRAINT `fk_likes_user`
    FOREIGN KEY (`username`)
    REFERENCES `users` (`username`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_likes_news`
    FOREIGN KEY (`news_id`)
    REFERENCES `news` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    
  INDEX `idx_likes_user` (`username`),
  INDEX `idx_likes_news` (`news_id`)
)
ENGINE = InnoDB
COMMENT = 'Stores the like and dislike of news articles';

-- 16. Rate
CREATE TABLE IF NOT EXISTS `rate` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `news_id` BIGINT NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `rate` INT NOT NULL COMMENT 'From 0 - 5',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_rate_user`
    FOREIGN KEY (`username`)
    REFERENCES `users` (`username`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_rate_news`
    FOREIGN KEY (`news_id`)
    REFERENCES `news` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  INDEX `idx_rate_user` (`username`),
  INDEX `idx_rate_news` (`news_id`)
)
ENGINE = InnoDB
COMMENT = 'Stores the numeric rating of articles';

-- 17. News Images
CREATE TABLE IF NOT EXISTS `news_images` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `news_id` BIGINT NOT NULL,
  `image_path` VARCHAR(255) NOT NULL COMMENT 'Relative or absolute path to the image file',
  `alt_text` VARCHAR(150) NULL COMMENT 'Alternative text for accessibility and SEO',
  `sort_order` INT NOT NULL DEFAULT 0 COMMENT 'Display order of images per article',

  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  PRIMARY KEY (`id`),

  CONSTRAINT `fk_news_images_news`
    FOREIGN KEY (`news_id`)
    REFERENCES `news` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  INDEX `idx_news_images_news_id` (`news_id`)
)
ENGINE = InnoDB
COMMENT = 'Stores gallery images associated with news articles';

-- 18. Comments
CREATE TABLE IF NOT EXISTS `comments` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `news_id` BIGINT NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `reply_to_id` BIGINT NULL DEFAULT NULL,
  `content` TEXT NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_comments_parent`
    FOREIGN KEY (`reply_to_id`)
    REFERENCES `comments` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comments_news`
    FOREIGN KEY (`news_id`)
    REFERENCES `news` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comments_user`
    FOREIGN KEY (`username`)
    REFERENCES `users` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  INDEX `idx_comments_parent` (`reply_to_id`),
  INDEX `idx_comments_news` (`news_id`),
  INDEX `idx_comments_user` (`username`)
)
ENGINE = InnoDB
COMMENT = 'Threaded comments section for articles';

-- 19. Comment Likes
CREATE TABLE IF NOT EXISTS `comment_likes` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `comment_id` BIGINT NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_comment_likes_user`
    FOREIGN KEY (`username`)
    REFERENCES `users` (`username`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comment_likes_comment`
    FOREIGN KEY (`comment_id`)
    REFERENCES `comments` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    
  INDEX `idx_comment_likes_user` (`username`),
  INDEX `idx_comment_likes_comment` (`comment_id`)
)
ENGINE = InnoDB
COMMENT = 'Stores likes for comments';

-- 20. Reports
CREATE TABLE IF NOT EXISTS `reports` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `reporter_username` VARCHAR(45) NOT NULL,
  `comment_id` BIGINT NOT NULL,
  `reason` ENUM('Spam', 'Harassment', 'Misinformation', 'Other') NOT NULL,
  `description` TEXT NULL,
  `status` ENUM('pending', 'reviewed', 'dismissed') DEFAULT 'pending',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_reports_reporter` 
    FOREIGN KEY (`reporter_username`) 
    REFERENCES `accounts` (`username`)
    ON DELETE CASCADE 
    ON UPDATE CASCADE,
  CONSTRAINT `fk_reports_comment` 
    FOREIGN KEY (`comment_id`) 
    REFERENCES `comments` (`id`)
    ON DELETE CASCADE 
    ON UPDATE CASCADE,

  INDEX `idx_reports_reporter` (`reporter_username`),
  INDEX `idx_reports_comment` (`comment_id`)
) 
ENGINE = InnoDB 
COMMENT = 'Moderation queue for reported content';

-- 21. News Tags
CREATE TABLE IF NOT EXISTS `news_tags` (
  `news_id` BIGINT NOT NULL,
  `tags_id` BIGINT NOT NULL,
  
  PRIMARY KEY (`news_id`, `tags_id`),
  CONSTRAINT `fk_news_tags_news`
    FOREIGN KEY (`news_id`)
    REFERENCES `news` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_news_tags_tag`
    FOREIGN KEY (`tags_id`)
    REFERENCES `tags` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,

  INDEX `idx_news_tags_tag` (`tags_id`)
)
ENGINE = InnoDB
COMMENT = 'Links articles to specific tags';

-- 22. Follows
CREATE TABLE IF NOT EXISTS `follows` (
  `username` VARCHAR(45) NOT NULL,
  `writer_username` VARCHAR(45) NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  PRIMARY KEY (`username`, `writer_username`),
  CONSTRAINT `fk_follows_user` 
    FOREIGN KEY (`username`) 
    REFERENCES `users` (`username`) 
    ON DELETE CASCADE,
  CONSTRAINT `fk_follows_writer` 
    FOREIGN KEY (`writer_username`) 
    REFERENCES `writers` (`username`) 
    ON DELETE CASCADE
) 
ENGINE = InnoDB
COMMENT = 'User follows Writer relationship';

-- 23. Reading History
CREATE TABLE IF NOT EXISTS `reading_history` (
  `username` VARCHAR(45) NOT NULL,
  `news_id` BIGINT NOT NULL,
  `last_viewed_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  PRIMARY KEY (`username`, `news_id`),
  CONSTRAINT `fk_reading_history_user`
    FOREIGN KEY (`username`)
    REFERENCES `users` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_reading_history_news`
    FOREIGN KEY (`news_id`)
    REFERENCES `news` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  INDEX `idx_reading_history_news` (`news_id`)
) 
ENGINE = InnoDB
COMMENT = 'Tracks recently viewed articles for users';

-- 24. User Session Tokens
CREATE TABLE IF NOT EXISTS `user_session_tokens` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,

  `token_hash` CHAR(64) NOT NULL COMMENT 'SHA-256 hash of the session token',
  `device_name` VARCHAR(100) NULL COMMENT 'Browser or device identifier',
  `ip_address` VARCHAR(45) NULL COMMENT 'IPv4 or IPv6 address',

  `expires_at` TIMESTAMP NOT NULL,
  `revoked_at` TIMESTAMP NULL,

  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `last_used_at` TIMESTAMP NULL,

  PRIMARY KEY (`id`),

  CONSTRAINT `uq_user_session_tokens_token`
    UNIQUE (`token_hash`),

  CONSTRAINT `fk_user_session_tokens_user`
    FOREIGN KEY (`username`)
    REFERENCES `accounts` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  INDEX `idx_user_session_tokens_user` (`username`),
  INDEX `idx_user_session_tokens_expiry` (`expires_at`)
)
ENGINE=InnoDB
COMMENT='Stores active and historical login session tokens for users';