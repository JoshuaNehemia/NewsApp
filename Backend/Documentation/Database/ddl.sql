-- MySQL Workbench Synchronization
-- Fixed and Optimized Version
-- Schema: NewsApp

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema NewsApp
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `NewsApp` DEFAULT CHARACTER SET utf8mb4 ;
USE `NewsApp` ;

-- -----------------------------------------------------
-- Table `tcountries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tcountries` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `code` VARCHAR(3) NOT NULL COMMENT 'ISO 3166-1 alpha-3 code',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = 'Lookup table for global country list';

-- -----------------------------------------------------
-- Table `taccounts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taccounts` (
  `username` VARCHAR(50) NOT NULL,
  `password` VARCHAR(255) NULL COMMENT 'Nullable to support Social Auth only accounts',
  `fullname` VARCHAR(200) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `profile_picture_ext` VARCHAR(4) NULL DEFAULT NULL,
  `tcountries_id` INT NOT NULL,
  `role` ENUM('user', 'writer', 'admin') NOT NULL DEFAULT 'user',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`username`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_taccounts_tcountries_idx` (`tcountries_id` ASC) VISIBLE,
  CONSTRAINT `fk_taccounts_tcountries`
    FOREIGN KEY (`tcountries_id`)
    REFERENCES `tcountries` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = 'Core authentication table for all system users (Base Table)';


-- -----------------------------------------------------
-- Table `tcategories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tcategories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = 'Taxonomy for categorizing content';

-- -----------------------------------------------------
-- Table `tusers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tusers` (
  `username` VARCHAR(50) NOT NULL,
  `birthdate` DATE NULL,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`username`),
  CONSTRAINT `fk_tusers_taccounts`
    FOREIGN KEY (`username`)
    REFERENCES `taccounts` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = 'Extended profile details for standard readers';

-- -----------------------------------------------------
-- Table `tpreferences`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tpreferences` (
  `username` VARCHAR(50) NOT NULL,
  `tcategories_id` INT NOT NULL,
  PRIMARY KEY (`username`, `tcategories_id`),
  INDEX `fk_pref_categories_idx` (`tcategories_id` ASC) VISIBLE,
  INDEX `fk_pref_users_idx` (`username` ASC) VISIBLE,
  CONSTRAINT `fk_pref_categories`
    FOREIGN KEY (`tcategories_id`)
    REFERENCES `tcategories` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pref_users`
    FOREIGN KEY (`username`)
    REFERENCES `tusers` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = 'Stores categories a user is interested in';

-- -----------------------------------------------------
-- Table `tmedias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tmedias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `company_name` VARCHAR(100) NOT NULL,
  `picture_ext` VARCHAR(4) NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = 'Media organizations or publishers';

-- -----------------------------------------------------
-- Table `twriters`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `twriters` (
  `username` VARCHAR(50) NOT NULL,
  `tmedia_id` INT NOT NULL,
  `is_verified` TINYINT(1) NOT NULL DEFAULT 0,
  `bio` TEXT NOT NULL,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`username`),
  INDEX `fk_twriters_tmedia_idx` (`tmedia_id` ASC) VISIBLE,
  CONSTRAINT `fk_twriters_tmedia`
    FOREIGN KEY (`tmedia_id`)
    REFERENCES `tmedias` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_twriters_taccounts`
    FOREIGN KEY (`username`)
    REFERENCES `taccounts` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = 'Extended profile details for writers';

-- -----------------------------------------------------
-- Table `tsubscriptions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tsubscriptions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(50) NOT NULL,
  `paid_at` DATETIME NOT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  `status` ENUM('active', 'expired', 'cancelled') NOT NULL DEFAULT 'active',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_tsubscriptions_tusers_idx` (`username` ASC) VISIBLE,
  CONSTRAINT `fk_tsubscriptions_tusers`
    FOREIGN KEY (`username`)
    REFERENCES `tusers` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = 'Records of user payments and subscription validity';

-- -----------------------------------------------------
-- Table `tspecialties`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tspecialties` (
  `username` VARCHAR(50) NOT NULL,
  `tcategories_id` INT NOT NULL,
  PRIMARY KEY (`username`, `tcategories_id`),
  INDEX `fk_spec_categories_idx` (`tcategories_id` ASC) VISIBLE,
  INDEX `fk_spec_writers_idx` (`username` ASC) VISIBLE,
  CONSTRAINT `fk_spec_categories`
    FOREIGN KEY (`tcategories_id`)
    REFERENCES `tcategories` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_spec_writers`
    FOREIGN KEY (`username`)
    REFERENCES `twriters` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = 'Maps writers to their topics of expertise';

-- -----------------------------------------------------
-- Table `tnews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tnews` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `writer_username` VARCHAR(50) NOT NULL,
  `tcategories_id` INT NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `slug` VARCHAR(255) NOT NULL,
  `content` LONGTEXT NOT NULL,
  `is_published` TINYINT(1) DEFAULT 0,
  `view_count` BIGINT DEFAULT 0,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `slug_UNIQUE` (`slug` ASC) VISIBLE,
  INDEX `fk_tnews_twriters_idx` (`writer_username` ASC) VISIBLE,
  INDEX `fk_tnews_tcategories_idx` (`tcategories_id` ASC) VISIBLE,
  CONSTRAINT `fk_tnews_twriters`
    FOREIGN KEY (`writer_username`)
    REFERENCES `twriters` (`username`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_tnews_tcategories`
    FOREIGN KEY (`tcategories_id`)
    REFERENCES `tcategories` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = 'Stores the actual news articles';

-- -----------------------------------------------------
-- Table `tlikes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tlikes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tnews_id` INT NOT NULL,
  `username` VARCHAR(50) NOT NULL,
  `is_like` TINYINT NOT NULL COMMENT '1 for like, 0 for dislike',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_tlikes_tusers_idx` (`username` ASC) VISIBLE,
  INDEX `fk_tlikes_tnews_idx` (`tnews_id` ASC) VISIBLE,
  CONSTRAINT `fk_tlikes_tusers`
    FOREIGN KEY (`username`)
    REFERENCES `tusers` (`username`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_tlikes_tnews`
    FOREIGN KEY (`tnews_id`)
    REFERENCES `tnews` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = 'Stores the like and dislike of news articles';

-- -----------------------------------------------------
-- Table `trate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `trate` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tnews_id` INT NOT NULL,
  `username` VARCHAR(50) NOT NULL,
  `rate` INT NOT NULL COMMENT 'From 0 - 5',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_trate_tusers_idx` (`username` ASC) VISIBLE,
  INDEX `fk_trate_tnews_idx` (`tnews_id` ASC) VISIBLE,
  CONSTRAINT `fk_trate_tusers`
    FOREIGN KEY (`username`)
    REFERENCES `tusers` (`username`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_trate_tnews`
    FOREIGN KEY (`tnews_id`)
    REFERENCES `tnews` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = 'Stores the numeric rating of articles';

-- -----------------------------------------------------
-- Table `timages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `timages` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tnews_id` INT NOT NULL,
  `image_path` VARCHAR(255) NOT NULL,
  `alt_text` VARCHAR(150) NULL,
  `sort_order` INT DEFAULT 0,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_timages_tnews_idx` (`tnews_id` ASC) VISIBLE,
  CONSTRAINT `fk_timages_tnews`
    FOREIGN KEY (`tnews_id`)
    REFERENCES `tnews` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Gallery images attached to an article';

-- -----------------------------------------------------
-- Table `tcomments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tcomments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tnews_id` INT NOT NULL,
  `user_username` VARCHAR(50) NOT NULL,
  `reply_to_id` INT NULL DEFAULT NULL,
  `content` TEXT NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_tcomments_parent_idx` (`reply_to_id` ASC) VISIBLE,
  INDEX `fk_tcomments_news_idx` (`tnews_id` ASC) VISIBLE,
  INDEX `fk_tcomments_users_idx` (`user_username` ASC) VISIBLE,
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
  CONSTRAINT `fk_tcomments_users`
    FOREIGN KEY (`user_username`)
    REFERENCES `tusers` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = 'Threaded comments section for articles';

-- -----------------------------------------------------
-- Table `tcomment_likes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tcomment_likes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `comment_id` INT NOT NULL,
  `username` VARCHAR(50) NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_tcomlikes_users_idx` (`username` ASC) VISIBLE,
  INDEX `fk_tcomlikes_comments_idx` (`comment_id` ASC) VISIBLE,
  CONSTRAINT `fk_tcomlikes_users`
    FOREIGN KEY (`username`)
    REFERENCES `tusers` (`username`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_tcomlikes_comments`
    FOREIGN KEY (`comment_id`)
    REFERENCES `tcomments` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
COMMENT = 'Stores likes for comments';

-- -----------------------------------------------------
-- Table `treports`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `treports` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `reporter_username` VARCHAR(50) NOT NULL,
  `comment_id` INT NOT NULL,
  `reason` ENUM('Spam', 'Harassment', 'Misinformation', 'Other') NOT NULL,
  `description` TEXT NULL,
  `status` ENUM('pending', 'reviewed', 'dismissed') DEFAULT 'pending',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_reports_user_idx` (`reporter_username` ASC) VISIBLE,
  INDEX `fk_reports_comment_idx` (`comment_id` ASC) VISIBLE,
  CONSTRAINT `fk_reports_user` 
    FOREIGN KEY (`reporter_username`) 
    REFERENCES `taccounts` (`username`)
    ON DELETE CASCADE 
    ON UPDATE CASCADE,
  CONSTRAINT `fk_reports_comment` 
    FOREIGN KEY (`comment_id`) 
    REFERENCES `tcomments` (`id`)
    ON DELETE CASCADE 
    ON UPDATE CASCADE
) ENGINE = InnoDB COMMENT = 'Moderation queue for reported content';

-- -----------------------------------------------------
-- Table `tbookmarks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tbookmarks` (
  `user_username` VARCHAR(50) NOT NULL,
  `tnews_id` INT NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_username`, `tnews_id`),
  INDEX `fk_bookmarks_news_idx` (`tnews_id` ASC) VISIBLE,
  CONSTRAINT `fk_bookmarks_users`
    FOREIGN KEY (`user_username`)
    REFERENCES `tusers` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_bookmarks_news`
    FOREIGN KEY (`tnews_id`)
    REFERENCES `tnews` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Saved articles/Reading list for users';

-- -----------------------------------------------------
-- Table `ttags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ttags` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = 'Keywords/Tags for granular content filtering';

-- -----------------------------------------------------
-- Table `tnews_tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tnews_tags` (
  `tnews_id` INT NOT NULL,
  `ttags_id` INT NOT NULL,
  PRIMARY KEY (`tnews_id`, `ttags_id`),
  INDEX `fk_newstags_tags_idx` (`ttags_id` ASC) VISIBLE,
  CONSTRAINT `fk_newstags_news`
    FOREIGN KEY (`tnews_id`)
    REFERENCES `tnews` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_newstags_tags`
    FOREIGN KEY (`ttags_id`)
    REFERENCES `ttags` (`id`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Links articles to specific tags';

-- -----------------------------------------------------
-- Table `tfollows`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tfollows` (
  `user_username` VARCHAR(50) NOT NULL,
  `writer_username` VARCHAR(50) NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_username`, `writer_username`),
  CONSTRAINT `fk_follow_user` FOREIGN KEY (`user_username`) REFERENCES `tusers` (`username`) ON DELETE CASCADE,
  CONSTRAINT `fk_follow_writer` FOREIGN KEY (`writer_username`) REFERENCES `twriters` (`username`) ON DELETE CASCADE
) ENGINE = InnoDB
COMMENT = 'User follows Writer relationship';

-- -----------------------------------------------------
-- Table `treading_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `treading_history` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_username` VARCHAR(50) NOT NULL,
  `tnews_id` INT NOT NULL,
  `last_viewed_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_hist_news_idx` (`tnews_id` ASC) VISIBLE,
  CONSTRAINT `fk_hist_users`
    FOREIGN KEY (`user_username`)
    REFERENCES `tusers` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_hist_news`
    FOREIGN KEY (`tnews_id`)
    REFERENCES `tnews` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB
COMMENT = 'Tracks recently viewed articles for users';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;