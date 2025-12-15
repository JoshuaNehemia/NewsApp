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

  CONSTRAINT `pk_taccounts` PRIMARY KEY (`username`),
  CONSTRAINT `uq_taccounts_email` UNIQUE (`email`),

  CONSTRAINT `fk_accounts_city`
    FOREIGN KEY (`city_id`)
    REFERENCES `tcities` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,

  INDEX `idx_accounts_city` (`city_id`)
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

  CONSTRAINT `pk_tusers` PRIMARY KEY (`username`),
  CONSTRAINT `fk_tusers_taccounts`
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
  `username` VARCHAR(50) NOT NULL,
  `tmedia_id` BIGINT NOT NULL,

  `role` ENUM('staff','contributor','editor') DEFAULT 'contributor',

  `is_verified` BOOLEAN NOT NULL DEFAULT FALSE,
  `verified_at` TIMESTAMP NULL,
  `verified_by` VARCHAR(100) NULL,

  `joined_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  CONSTRAINT `pk_twriters` 
    PRIMARY KEY (`username`),
  CONSTRAINT `fk_twriters_tmedia`
    FOREIGN KEY (`tmedia_id`)
    REFERENCES `tmedias` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_twriters_taccounts`
    FOREIGN KEY (`username`)
    REFERENCES `taccounts` (`username`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

  INDEX `idx_twriters_media` (`tmedia_id`),
  INDEX `idx_twriters_active` (`is_active`)
) 
ENGINE=InnoDB
COMMENT='Extended profile details for writers';
