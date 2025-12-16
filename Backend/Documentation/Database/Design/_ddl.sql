-- -----------------------------------------------------
-- Schema NewsApp
-- -----------------------------------------------------
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `NewsApp` DEFAULT CHARACTER SET utf8mb4 ;
USE `NewsApp` ;

-- ================================================================================================================
-- Geographic
-- ================================================================================================================

-- -----------------------------------------------------
-- Table `tcountries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tcountries` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `code` CHAR(3) NOT NULL COMMENT 'ISO 3166-1 alpha-3 code',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  CONSTRAINT `pk_tcountries` 
    PRIMARY KEY (`id`),
  CONSTRAINT `uq_tcountries_code` 
    UNIQUE (`code`)
) 
ENGINE=InnoDB
COMMENT='Table for countries list';

-- -----------------------------------------------------
-- Table `tcountry_divisions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tcountry_divisions` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `country_id` BIGINT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  CONSTRAINT `pk_tcountry_divisions` 
    PRIMARY KEY (`id`),
  CONSTRAINT `uq_tcountry_divisions_country_name`
    UNIQUE (`country_id`, `name`),
  CONSTRAINT `fk_tcountry_divisions_country`
    FOREIGN KEY (`country_id`)
    REFERENCES `tcountries` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) 
ENGINE=InnoDB
COMMENT='Table for country divisions (provinces, states, regions)';

-- -----------------------------------------------------
-- Table `tcities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tcities` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `country_division_id` BIGINT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  CONSTRAINT `pk_tcities` 
    PRIMARY KEY (`id`),
  CONSTRAINT `uq_tcities_division_name`
    UNIQUE (`country_division_id`, `name`),
  CONSTRAINT `fk_tcities_division`
    FOREIGN KEY (`country_division_id`)
    REFERENCES `tcountry_divisions` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) 
ENGINE=InnoDB
COMMENT='Table for cities list';

-- -----------------------------------------------------
-- Table `tmedias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tmedias` (
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

  CONSTRAINT `pk_tmedias` 
    PRIMARY KEY (`id`),
  CONSTRAINT `uq_tmedias_slug` 
    UNIQUE (`slug`),
  CONSTRAINT `fk_tmedias_city`
    FOREIGN KEY (`city_id`)
    REFERENCES `tcities` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,

  INDEX `idx_tmedias_city` (`city_id`)
) 
ENGINE=InnoDB
COMMENT='Media organizations or publishers';

-- ================================================================================================================
-- Authentication
-- ================================================================================================================

-- -----------------------------------------------------
-- Table `taccounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taccounts` (
  `username` VARCHAR(100) NOT NULL,
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

  CONSTRAINT `pk_taccounts` 
    PRIMARY KEY (`username`),
  CONSTRAINT `uq_taccounts_email` 
    UNIQUE (`email`),
  CONSTRAINT `fk_taccounts_city`
    FOREIGN KEY (`city_id`)
    REFERENCES `tcities` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,

  INDEX `idx_taccounts_city` (`city_id`)
) 
ENGINE=InnoDB
COMMENT='Account table';

-- -----------------------------------------------------
-- Table `tusers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tusers` (
  `username` VARCHAR(100) NOT NULL,
  `birthdate` DATE NULL COMMENT 'yyyy-mm-dd',
  `gender` ENUM('male','female') NULL,
  `phone` VARCHAR(20) NULL,
  `bio` TEXT NULL,

  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  CONSTRAINT `pk_tusers` 
    PRIMARY KEY (`username`),
  CONSTRAINT `fk_tusers_account`
    FOREIGN KEY (`username`)
    REFERENCES `taccounts` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) 
ENGINE=InnoDB
COMMENT='Extended profile details for standard readers';

-- -----------------------------------------------------
-- Table `twriters`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `twriters` (
  `username` VARCHAR(100) NOT NULL,
  `tmedia_id` BIGINT NOT NULL,

  `role` ENUM('staff','contributor','editor') DEFAULT 'contributor',

  `is_verified` BOOLEAN NOT NULL DEFAULT FALSE,
  `verified_at` TIMESTAMP NULL,
  `verified_by` VARCHAR(100) NULL,

  `joined_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  CONSTRAINT `pk_twriters` 
    PRIMARY KEY (`username`),
  CONSTRAINT `fk_twriters_media`
    FOREIGN KEY (`tmedia_id`)
    REFERENCES `tmedias` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_twriters_account`
    FOREIGN KEY (`username`)
    REFERENCES `taccounts` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  INDEX `idx_twriters_media` (`tmedia_id`),
  INDEX `idx_twriters_active` (`is_active`)
) 
ENGINE=InnoDB
COMMENT='Extended profile details for writers';

-- ================================================================================================================
-- Preferences and Specialties
-- ================================================================================================================

-- -----------------------------------------------------
-- Table `tcategories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tcategories` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  CONSTRAINT `pk_tcategories`
    PRIMARY KEY (`id`),
  CONSTRAINT `uq_tcategories_name`
    UNIQUE (`name`)
) 
ENGINE=InnoDB
COMMENT='Table for news categories';

-- -----------------------------------------------------
-- Table `ttags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ttags` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `category_id` BIGINT NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  CONSTRAINT `pk_ttags`
    PRIMARY KEY (`id`),
  CONSTRAINT `uq_ttags_category_name`
    UNIQUE (`category_id`, `name`),
  CONSTRAINT `fk_ttags_category`
    FOREIGN KEY (`category_id`)
    REFERENCES `tcategories` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,

  INDEX `idx_ttags_category` (`category_id`)
) 
ENGINE=InnoDB
COMMENT='Keywords/Tags for granular content filtering';

-- -----------------------------------------------------
-- Table `tpreferences`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpreferences` (
  `username` VARCHAR(100) NOT NULL,
  `category_id` BIGINT NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  CONSTRAINT `pk_tpreferences`
    PRIMARY KEY (`username`, `category_id`),
  CONSTRAINT `fk_tpreferences_category`
    FOREIGN KEY (`category_id`)
    REFERENCES `tcategories` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_tpreferences_user`
    FOREIGN KEY (`username`)
    REFERENCES `tusers` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  INDEX `idx_tpreferences_category` (`category_id`)
) 
ENGINE=InnoDB
COMMENT='Stores categories a user is interested in';

-- -----------------------------------------------------
-- Table `tspecialties`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tspecialties` (
  `username` VARCHAR(100) NOT NULL,
  `category_id` BIGINT NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  CONSTRAINT `pk_tspecialties`
    PRIMARY KEY (`username`, `category_id`),
  CONSTRAINT `fk_tspecialties_category`
    FOREIGN KEY (`category_id`)
    REFERENCES `tcategories` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_tspecialties_writer`
    FOREIGN KEY (`username`)
    REFERENCES `twriters` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  INDEX `idx_tspecialties_category` (`category_id`)
) 
ENGINE=InnoDB
COMMENT='Maps writers to their topics of expertise';

-- -----------------------------------------------------
-- Table `tuser_followed_tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tuser_followed_tags` (
  `username` VARCHAR(100) NOT NULL,
  `tag_id` BIGINT NOT NULL,
  `followed_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  CONSTRAINT `pk_tuser_followed_tags`
    PRIMARY KEY (`username`, `tag_id`),

  CONSTRAINT `fk_tuser_followed_tags_user`
    FOREIGN KEY (`username`)
    REFERENCES `tusers` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  CONSTRAINT `fk_tuser_followed_tags_tag`
    FOREIGN KEY (`tag_id`)
    REFERENCES `ttags` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  INDEX `idx_tuser_followed_tags_tag` (`tag_id`)
) 
ENGINE=InnoDB
COMMENT='Many-to-many mapping of users following tags';

-- ================================================================================================================
-- Monetization
-- ================================================================================================================

-- -----------------------------------------------------
-- Table `tsubscriptions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tsubscriptions` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(100) NOT NULL,
  `paid_at` DATETIME NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  `status` ENUM('active', 'expired', 'cancelled') NOT NULL DEFAULT 'active',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  CONSTRAINT `pk_tsubscriptions`
    PRIMARY KEY (`id`),
  CONSTRAINT `fk_tsubscriptions_user`
    FOREIGN KEY (`username`)
    REFERENCES `tusers` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  INDEX `idx_tsubscriptions_user` (`username`)
)
ENGINE = InnoDB
COMMENT = 'Records of user payments and subscription validity';

-- ================================================================================================================
-- News Content
-- ================================================================================================================

-- -----------------------------------------------------
-- Table `tnews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tnews` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `writer_username` VARCHAR(100) NOT NULL,
  `tcategories_id` BIGINT NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `slug` VARCHAR(255) NOT NULL,
  `content` LONGTEXT NOT NULL,
  `is_published` TINYINT(1) DEFAULT 0,
  `view_count` BIGINT DEFAULT 0,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  CONSTRAINT `pk_tnews` 
    PRIMARY KEY (`id`),
  CONSTRAINT `uq_tnews_slug`
    UNIQUE (`slug`),
  CONSTRAINT `fk_tnews_writer`
    FOREIGN KEY (`writer_username`)
    REFERENCES `twriters` (`username`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_tnews_category`
    FOREIGN KEY (`tcategories_id`)
    REFERENCES `tcategories` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
    
  INDEX `idx_tnews_writer` (`writer_username`),
  INDEX `idx_tnews_category` (`tcategories_id`)
)
ENGINE = InnoDB
COMMENT = 'Stores the actual news articles';

-- -----------------------------------------------------
-- Table `tlikes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tlikes` (
  `tnews_id` BIGINT NOT NULL,
  `username` VARCHAR(100) NOT NULL,
  `is_like` TINYINT NOT NULL COMMENT '1 for like, 0 for dislike',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  CONSTRAINT `pk_tlikes`
    PRIMARY KEY(`tnews_id`, `username`),
  CONSTRAINT `fk_tlikes_user`
    FOREIGN KEY (`username`)
    REFERENCES `tusers` (`username`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_tlikes_news`
    FOREIGN KEY (`tnews_id`)
    REFERENCES `tnews` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    
  INDEX `idx_tlikes_user` (`username`),
  INDEX `idx_tlikes_news` (`tnews_id`)
)
ENGINE = InnoDB
COMMENT = 'Stores the like and dislike of news articles';

-- -----------------------------------------------------
-- Table `trate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trate` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `tnews_id` BIGINT NOT NULL,
  `username` VARCHAR(100) NOT NULL,
  `rate` INT NOT NULL COMMENT 'From 0 - 5',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  CONSTRAINT `pk_trate`
    PRIMARY KEY (`id`),
  CONSTRAINT `fk_trate_user`
    FOREIGN KEY (`username`)
    REFERENCES `tusers` (`username`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_trate_news`
    FOREIGN KEY (`tnews_id`)
    REFERENCES `tnews` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  INDEX `idx_trate_user` (`username`),
  INDEX `idx_trate_news` (`tnews_id`)
)
ENGINE = InnoDB
COMMENT = 'Stores the numeric rating of articles';

-- -----------------------------------------------------
-- Table `timages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `timages` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `tnews_id` BIGINT NOT NULL,
  `image_path` VARCHAR(255) NOT NULL,
  `alt_text` VARCHAR(150) NULL,
  `sort_order` INT DEFAULT 0,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  CONSTRAINT `pk_timages`
    PRIMARY KEY (`id`),
  CONSTRAINT `fk_timages_news`
    FOREIGN KEY (`tnews_id`)
    REFERENCES `tnews` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,

  INDEX `idx_timages_news` (`tnews_id`)
)
ENGINE = InnoDB
COMMENT = 'Gallery images attached to an article';

-- -----------------------------------------------------
-- Table `tcomments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tcomments` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `tnews_id` BIGINT NOT NULL,
  `user_username` VARCHAR(100) NOT NULL,
  `reply_to_id` BIGINT NULL DEFAULT NULL,
  `content` TEXT NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  CONSTRAINT `pk_tcomments`
    PRIMARY KEY (`id`),
  CONSTRAINT `fk_tcomments_parent`
    FOREIGN KEY (`reply_to_id`)
    REFERENCES `tcomments` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tcomments_news`
    FOREIGN KEY (`tnews_id`)
    REFERENCES `tnews` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tcomments_user`
    FOREIGN KEY (`user_username`)
    REFERENCES `tusers` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  INDEX `idx_tcomments_parent` (`reply_to_id`),
  INDEX `idx_tcomments_news` (`tnews_id`),
  INDEX `idx_tcomments_user` (`user_username`)
)
ENGINE = InnoDB
COMMENT = 'Threaded comments section for articles';

-- -----------------------------------------------------
-- Table `tcomment_likes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tcomment_likes` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `comment_id` BIGINT NOT NULL,
  `username` VARCHAR(100) NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  CONSTRAINT `pk_tcomment_likes`
    PRIMARY KEY (`id`),
  CONSTRAINT `fk_tcomment_likes_user`
    FOREIGN KEY (`username`)
    REFERENCES `tusers` (`username`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_tcomment_likes_comment`
    FOREIGN KEY (`comment_id`)
    REFERENCES `tcomments` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    
  INDEX `idx_tcomment_likes_user` (`username`),
  INDEX `idx_tcomment_likes_comment` (`comment_id`)
)
ENGINE = InnoDB
COMMENT = 'Stores likes for comments';

-- -----------------------------------------------------
-- Table `treports`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `treports` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `reporter_username` VARCHAR(100) NOT NULL,
  `comment_id` BIGINT NOT NULL,
  `reason` ENUM('Spam', 'Harassment', 'Misinformation', 'Other') NOT NULL,
  `description` TEXT NULL,
  `status` ENUM('pending', 'reviewed', 'dismissed') DEFAULT 'pending',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  CONSTRAINT `pk_treports`
    PRIMARY KEY (`id`),
  CONSTRAINT `fk_treports_reporter` 
    FOREIGN KEY (`reporter_username`) 
    REFERENCES `taccounts` (`username`)
    ON DELETE CASCADE 
    ON UPDATE CASCADE,
  CONSTRAINT `fk_treports_comment` 
    FOREIGN KEY (`comment_id`) 
    REFERENCES `tcomments` (`id`)
    ON DELETE CASCADE 
    ON UPDATE CASCADE,

  INDEX `idx_treports_reporter` (`reporter_username`),
  INDEX `idx_treports_comment` (`comment_id`)
) 
ENGINE = InnoDB 
COMMENT = 'Moderation queue for reported content';

-- -----------------------------------------------------
-- Table `tbookmarks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tbookmarks` (
  `user_username` VARCHAR(100) NOT NULL,
  `tnews_id` BIGINT NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  CONSTRAINT `pk_tbookmarks`
    PRIMARY KEY (`user_username`, `tnews_id`),
  CONSTRAINT `fk_tbookmarks_user`
    FOREIGN KEY (`user_username`)
    REFERENCES `tusers` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_tbookmarks_news`
    FOREIGN KEY (`tnews_id`)
    REFERENCES `tnews` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,

  INDEX `idx_tbookmarks_news` (`tnews_id`)
)
ENGINE = InnoDB
COMMENT = 'Saved articles/Reading list for users';

-- -----------------------------------------------------
-- Table `tnews_tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tnews_tags` (
  `tnews_id` BIGINT NOT NULL,
  `ttags_id` BIGINT NOT NULL,
  
  CONSTRAINT `pk_tnews_tags`
    PRIMARY KEY (`tnews_id`, `ttags_id`),
  CONSTRAINT `fk_tnews_tags_news`
    FOREIGN KEY (`tnews_id`)
    REFERENCES `tnews` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tnews_tags_tag`
    FOREIGN KEY (`ttags_id`)
    REFERENCES `ttags` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,

  INDEX `idx_tnews_tags_tag` (`ttags_id`)
)
ENGINE = InnoDB
COMMENT = 'Links articles to specific tags';

-- -----------------------------------------------------
-- Table `tfollows`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tfollows` (
  `user_username` VARCHAR(100) NOT NULL,
  `writer_username` VARCHAR(100) NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  
  CONSTRAINT `pk_tfollows`
    PRIMARY KEY (`user_username`, `writer_username`),
  CONSTRAINT `fk_tfollows_user` 
    FOREIGN KEY (`user_username`) 
    REFERENCES `tusers` (`username`) 
    ON DELETE CASCADE,
  CONSTRAINT `fk_tfollows_writer` 
    FOREIGN KEY (`writer_username`) 
    REFERENCES `twriters` (`username`) 
    ON DELETE CASCADE
) 
ENGINE = InnoDB
COMMENT = 'User follows Writer relationship';

-- -----------------------------------------------------
-- Table `treading_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `treading_history` (
  `user_username` VARCHAR(100) NOT NULL,
  `tnews_id` BIGINT NOT NULL,
  `last_viewed_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  CONSTRAINT `pk_treading_history`
    PRIMARY KEY (`user_username`, `tnews_id`),
  CONSTRAINT `fk_treading_history_user`
    FOREIGN KEY (`user_username`)
    REFERENCES `tusers` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_treading_history_news`
    FOREIGN KEY (`tnews_id`)
    REFERENCES `tnews` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  INDEX `idx_treading_history_news` (`tnews_id`)
) 
ENGINE = InnoDB
COMMENT = 'Tracks recently viewed articles for users';