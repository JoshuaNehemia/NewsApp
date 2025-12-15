-- ================================================================================================================
-- Geographic
-- ================================================================================================================
-- -----------------------------------------------------
-- Table `tcountries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tcountries` (
  `id` INT NOT NULL AUTO_INCREMENT,
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
  CONSTRAINT `uq_division_country_name`
    UNIQUE (`country_id`, `name`),
  CONSTRAINT `fk_divisions_country`
    FOREIGN KEY (`country_id`)
    REFERENCES `tcountries` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
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
  CONSTRAINT `uq_city_division_name`
    UNIQUE (`country_division_id`, `name`),
  CONSTRAINT `fk_cities_division`
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

  CONSTRAINT `pk_tmedias` PRIMARY KEY (`id`),
  CONSTRAINT `uq_tmedias_slug` UNIQUE (`slug`),
  CONSTRAINT `fk_tmedias_city`
    FOREIGN KEY (`city_id`)
    REFERENCES `tcities` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,

  INDEX `idx_tmedias_city` (`city_id`)
) 
ENGINE=InnoDB
COMMENT='Media organizations or publishers';