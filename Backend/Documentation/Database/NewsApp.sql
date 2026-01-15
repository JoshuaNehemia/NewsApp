-- ============================================================================
-- NewsApp Database Schema
-- Version: 1.0
-- Description: Complete database schema for NewsApp with all tables and relationships
-- ============================================================================

-- Drop database if exists (for fresh install)
-- DROP DATABASE IF EXISTS NewsApp;

-- Create Database
CREATE DATABASE IF NOT EXISTS NewsApp CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE NewsApp;

-- ============================================================================
-- GEOGRAPHY TABLES
-- ============================================================================

-- Countries Table
CREATE TABLE IF NOT EXISTS countries (
    id INT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(3) NOT NULL UNIQUE COMMENT 'Country code (e.g., IDN, USA, SGP)',
    name VARCHAR(100) NOT NULL UNIQUE COMMENT 'Country name',
    telephone VARCHAR(5) COMMENT 'Country telephone code (e.g., +62, +1)',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_code (code),
    INDEX idx_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Country Divisions Table (States, Provinces, etc.)
CREATE TABLE IF NOT EXISTS country_divisions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL COMMENT 'State/Province name',
    country_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_country_divisions_country FOREIGN KEY (country_id) REFERENCES countries(id) ON DELETE CASCADE,
    UNIQUE KEY unique_division_country (name, country_id),
    INDEX idx_country_id (country_id),
    INDEX idx_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Cities Table
CREATE TABLE IF NOT EXISTS cities (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL COMMENT 'City name',
    country_division_id INT NOT NULL,
    latitude DECIMAL(10, 8) COMMENT 'City latitude',
    longitude DECIMAL(11, 8) COMMENT 'City longitude',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_cities_country_division FOREIGN KEY (country_division_id) REFERENCES country_divisions(id) ON DELETE CASCADE,
    INDEX idx_country_division_id (country_division_id),
    INDEX idx_name (name),
    UNIQUE KEY unique_city_division (name, country_division_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- ACCOUNT TABLES
-- ============================================================================

-- Accounts Table (Base table for all account types)
CREATE TABLE IF NOT EXISTS accounts (
    username VARCHAR(50) PRIMARY KEY,
    password VARCHAR(255) NOT NULL COMMENT 'Hashed password',
    fullname VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    role ENUM('user', 'writer', 'admin') NOT NULL DEFAULT 'user' COMMENT 'User role',
    profile_picture_ext VARCHAR(10) COMMENT 'Profile picture extension (jpg, png, etc.)',
    is_active BOOLEAN DEFAULT TRUE,
    locked_until DATETIME COMMENT 'Account lock timestamp',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email (email),
    INDEX idx_role (role)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Users Table (Extended account for regular users)
CREATE TABLE IF NOT EXISTS users (
    username VARCHAR(50) PRIMARY KEY,
    birthdate DATE,
    gender ENUM('male', 'female', 'other'),
    country_id INT,
    phone_number VARCHAR(20),
    biography TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_users_account FOREIGN KEY (username) REFERENCES accounts(username) ON DELETE CASCADE,
    CONSTRAINT fk_users_country FOREIGN KEY (country_id) REFERENCES countries(id) ON DELETE SET NULL,
    INDEX idx_country_id (country_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Media Table (News outlet/organization)
CREATE TABLE IF NOT EXISTS medias (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(150) NOT NULL UNIQUE,
    slug VARCHAR(150) NOT NULL UNIQUE COMMENT 'URL-friendly slug',
    company_name VARCHAR(150),
    media_type ENUM('NEWS', 'JOURNAL', 'BLOG', 'TV', 'RADIO', 'PUBLISHER') DEFAULT 'NEWS',
    picture_ext VARCHAR(10) COMMENT 'Media picture extension',
    logo_ext VARCHAR(10) COMMENT 'Media logo extension',
    website VARCHAR(255),
    email VARCHAR(150),
    description TEXT,
    city_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_medias_city FOREIGN KEY (city_id) REFERENCES cities(id) ON DELETE SET NULL,
    INDEX idx_slug (slug),
    INDEX idx_city_id (city_id),
    INDEX idx_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Writers Table (Extended account for news writers/journalists)
CREATE TABLE IF NOT EXISTS writers (
    username VARCHAR(50) PRIMARY KEY,
    media_id INT,
    biography TEXT,
    is_verified BOOLEAN DEFAULT FALSE COMMENT 'Writer verification status',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_writers_account FOREIGN KEY (username) REFERENCES accounts(username) ON DELETE CASCADE,
    CONSTRAINT fk_writers_media FOREIGN KEY (media_id) REFERENCES medias(id) ON DELETE SET NULL,
    INDEX idx_media_id (media_id),
    INDEX idx_is_verified (is_verified)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- NEWS TABLES
-- ============================================================================

-- Categories Table
CREATE TABLE IF NOT EXISTS categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE,
    slug VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_slug (slug),
    INDEX idx_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tags Table
CREATE TABLE IF NOT EXISTS tags (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE,
    slug VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_slug (slug),
    INDEX idx_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- News Table
CREATE TABLE IF NOT EXISTS news (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL UNIQUE COMMENT 'URL-friendly slug',
    content LONGTEXT NOT NULL COMMENT 'News content/body',
    category_id INT NOT NULL,
    writer_username VARCHAR(50) NOT NULL COMMENT 'Author username',
    media_id INT COMMENT 'Associated media outlet',
    city_id INT COMMENT 'News location city',
    view_count INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_news_category FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE RESTRICT,
    CONSTRAINT fk_news_writer FOREIGN KEY (writer_username) REFERENCES writers(username) ON DELETE CASCADE,
    CONSTRAINT fk_news_media FOREIGN KEY (media_id) REFERENCES medias(id) ON DELETE SET NULL,
    CONSTRAINT fk_news_city FOREIGN KEY (city_id) REFERENCES cities(id) ON DELETE SET NULL,
    INDEX idx_slug (slug),
    INDEX idx_category_id (category_id),
    INDEX idx_writer_username (writer_username),
    INDEX idx_media_id (media_id),
    INDEX idx_city_id (city_id),
    INDEX idx_created_at (created_at),
    FULLTEXT INDEX fulltext_search (title, content)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- News Images Table
CREATE TABLE IF NOT EXISTS news_images (
    id INT PRIMARY KEY AUTO_INCREMENT,
    news_id INT NOT NULL,
    image_ext VARCHAR(10) COMMENT 'Image file extension',
    alt_text VARCHAR(255) COMMENT 'Image alt text',
    position INT DEFAULT 0 COMMENT 'Image display order',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_news_images_news FOREIGN KEY (news_id) REFERENCES news(id) ON DELETE CASCADE,
    INDEX idx_news_id (news_id),
    INDEX idx_position (position)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- News Tags Junction Table
CREATE TABLE IF NOT EXISTS news_tags (
    news_id INT NOT NULL,
    tags_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (news_id, tags_id),
    CONSTRAINT fk_news_tags_news FOREIGN KEY (news_id) REFERENCES news(id) ON DELETE CASCADE,
    CONSTRAINT fk_news_tags_tags FOREIGN KEY (tags_id) REFERENCES tags(id) ON DELETE CASCADE,
    INDEX idx_tags_id (tags_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Comments Table
CREATE TABLE IF NOT EXISTS comments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    news_id INT NOT NULL,
    username VARCHAR(50) NOT NULL COMMENT 'User who commented (must be regular user)',
    reply_to_id INT COMMENT 'Parent comment ID if this is a reply',
    content TEXT NOT NULL COMMENT 'Comment text',
    reply_count INT DEFAULT 0 COMMENT 'Number of replies to this comment',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_comments_news FOREIGN KEY (news_id) REFERENCES news(id) ON DELETE CASCADE,
    CONSTRAINT fk_comments_user FOREIGN KEY (username) REFERENCES users(username) ON DELETE CASCADE,
    CONSTRAINT fk_comments_parent FOREIGN KEY (reply_to_id) REFERENCES comments(id) ON DELETE CASCADE,
    INDEX idx_news_id (news_id),
    INDEX idx_username (username),
    INDEX idx_reply_to_id (reply_to_id),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- INTERACTION TABLES (Likes, Ratings, etc.)
-- ============================================================================

-- Likes/Dislikes Table
CREATE TABLE IF NOT EXISTS likes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    news_id INT NOT NULL,
    username VARCHAR(50) NOT NULL COMMENT 'User who liked/disliked',
    is_like BOOLEAN NOT NULL COMMENT '1 for like, 0 for dislike',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_likes_news FOREIGN KEY (news_id) REFERENCES news(id) ON DELETE CASCADE,
    CONSTRAINT fk_likes_user FOREIGN KEY (username) REFERENCES users(username) ON DELETE CASCADE,
    UNIQUE KEY unique_user_news_like (news_id, username, is_like),
    INDEX idx_news_id (news_id),
    INDEX idx_username (username),
    INDEX idx_is_like (is_like)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Ratings Table
CREATE TABLE IF NOT EXISTS rates (
    id INT PRIMARY KEY AUTO_INCREMENT,
    news_id INT NOT NULL,
    username VARCHAR(50) NOT NULL COMMENT 'User who rated',
    rate DECIMAL(3, 2) NOT NULL COMMENT 'Rating value (1.00 - 5.00)',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_rates_news FOREIGN KEY (news_id) REFERENCES news(id) ON DELETE CASCADE,
    CONSTRAINT fk_rates_user FOREIGN KEY (username) REFERENCES users(username) ON DELETE CASCADE,
    CHECK (rate >= 1 AND rate <= 5),
    UNIQUE KEY unique_user_news_rate (news_id, username),
    INDEX idx_news_id (news_id),
    INDEX idx_username (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- TOKEN TABLES
-- ============================================================================

-- Tokens Table (for email verification, password reset, etc.)
CREATE TABLE IF NOT EXISTS tokens (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    token VARCHAR(255) NOT NULL UNIQUE,
    token_type ENUM('email_verification', 'password_reset', 'api_token') NOT NULL,
    expires_at DATETIME NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_tokens_account FOREIGN KEY (username) REFERENCES accounts(username) ON DELETE CASCADE,
    INDEX idx_username (username),
    INDEX idx_token (token),
    INDEX idx_expires_at (expires_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- INDEXES FOR PERFORMANCE
-- ============================================================================

-- Create additional composite indexes for common queries (if not already created in table definitions)
-- These indexes improve query performance for common operations

-- ============================================================================
-- DUMMY DATA FOR TESTING
-- ============================================================================

-- Insert Countries (3-character ISO codes as per init/countries.sql format)
INSERT INTO countries (code, name, telephone) VALUES
('IDN', 'Indonesia', '+62'),
('USA', 'United States', '+1'),
('SGP', 'Singapore', '+65');

-- Insert Country Divisions
INSERT INTO country_divisions (name, country_id) VALUES
('Jakarta', 1),
('Bali', 1),
('California', 2),
('New York', 2),
('Central Region', 3);

-- Insert Cities
INSERT INTO cities (name, country_division_id, latitude, longitude) VALUES
('Jakarta City', 1, -6.2088, 106.8456),
('Denpasar', 2, -8.6705, 115.2126),
('Los Angeles', 3, 34.0522, -118.2437),
('New York City', 4, 40.7128, -74.0060),
('Singapore City', 5, 1.3521, 103.8198);

-- Insert Media (News Outlets)
INSERT INTO medias (name, slug, company_name, media_type, website, email, description, city_id) VALUES
('Kompas Daily', 'kompas-daily', 'PT Kompas Media Nusantara', 'NEWS', 'https://kompas.com', 'info@kompas.com', 'Leading Indonesian newspaper', 1),
('BBC News', 'bbc-news', 'British Broadcasting Corporation', 'TV', 'https://bbc.com/news', 'contact@bbc.com', 'International news network', 4),
('Straits Times', 'straits-times', 'Singapore Press Holdings', 'NEWS', 'https://straitstimes.com', 'info@sph.com.sg', 'Singapore leading newspaper', 5);

-- Insert Accounts (Users)
INSERT INTO accounts (username, password, fullname, email, role, is_active) VALUES
('john_user', '$2y$10$/INk5B0IxBkQ.0cbQW1pX.BdHiC6INl9rEvTncaW.MrDRW4/2GPO.', 'John Doe', 'john@example.com', 'user', TRUE),
('jane_user', '$2y$10$/INk5B0IxBkQ.0cbQW1pX.BdHiC6INl9rEvTncaW.MrDRW4/2GPO.', 'Jane Smith', 'jane@example.com', 'user', TRUE),
('budi_writer', '$2y$10$/INk5B0IxBkQ.0cbQW1pX.BdHiC6INl9rEvTncaW.MrDRW4/2GPO.', 'Budi Santoso', 'budi@example.com', 'writer', TRUE),
('siti_writer', '$2y$10$/INk5B0IxBkQ.0cbQW1pX.BdHiC6INl9rEvTncaW.MrDRW4/2GPO.', 'Siti Nurhaliza', 'siti@example.com', 'writer', TRUE);

-- Insert Users (extend accounts with role 'user')
INSERT INTO users (username, birthdate, gender, country_id, phone_number, biography) VALUES
('john_user', '1990-05-15', 'male', 1, '081234567890', 'Tech enthusiast and news reader'),
('jane_user', '1992-08-20', 'female', 2, '+16175551234', 'Sports and entertainment lover');

-- Insert Writers (extend accounts with role 'writer')
INSERT INTO writers (username, media_id, biography, is_verified) VALUES
('budi_writer', 1, 'Senior journalist with 10 years experience', TRUE),
('siti_writer', 2, 'International correspondent', TRUE);

-- Insert Categories
INSERT INTO categories (name, slug, description) VALUES
('Technology', 'technology', 'Latest tech news and innovations'),
('Sports', 'sports', 'Sports news and updates'),
('Entertainment', 'entertainment', 'Entertainment and celebrity news'),
('World News', 'world-news', 'International news stories');

-- Insert Tags
INSERT INTO tags (name, slug) VALUES
('Breaking News', 'breaking-news'),
('Featured', 'featured'),
('Analysis', 'analysis'),
('Interview', 'interview'),
('Indonesia', 'indonesia');

-- Insert News
INSERT INTO news (title, slug, content, category_id, writer_username, media_id, city_id) VALUES
(
  'Indonesia Tech Startup Reaches Unicorn Status',
  'indonesia-tech-startup-unicorn',
  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. A tech startup based in Jakarta has recently achieved unicorn status. This milestone represents significant growth in the Southeast Asian tech ecosystem. The company has secured funding from major international investors...',
  1,
  'budi_writer',
  1,
  1
),
(
  'International Football Championship Draws Millions',
  'football-championship-draws-millions',
  'The international football championship has captured the attention of millions worldwide. Teams from around the globe competed in an exciting tournament. The final match was a thrilling contest between two strong teams...',
  2,
  'siti_writer',
  2,
  4
),
(
  'New Hollywood Blockbuster Breaks Box Office Records',
  'hollywood-blockbuster-box-office',
  'A major Hollywood production has broken box office records on its opening weekend. The film features an ensemble cast and spectacular visual effects. Critics have praised the performances and storytelling of this action-packed adventure...',
  3,
  'budi_writer',
  1,
  3
),
(
  'Global Climate Summit Reaches Historic Agreement',
  'climate-summit-historic-agreement',
  'World leaders have reached a historic agreement on climate change at the latest global summit. The agreement includes commitments to reduce carbon emissions and invest in renewable energy. This represents a major step forward in addressing the climate crisis...',
  4,
  'siti_writer',
  2,
  5
);

-- Insert News Tags (Junction Table)
INSERT INTO news_tags (news_id, tags_id) VALUES
(1, 1),  -- First news gets "Breaking News" tag
(1, 5),  -- First news gets "Indonesia" tag
(2, 1),  -- Second news gets "Breaking News" tag
(2, 2),  -- Second news gets "Featured" tag
(3, 2),  -- Third news gets "Featured" tag
(4, 3);  -- Fourth news gets "Analysis" tag

-- Insert News Images
INSERT INTO news_images (news_id, image_ext, alt_text, position) VALUES
(1, 'jpg', 'Tech startup office building', 1),
(1, 'png', 'Startup team celebrating', 2),
(2, 'jpg', 'Football stadium during championship', 1),
(3, 'jpg', 'Movie poster and actors', 1),
(4, 'jpg', 'Global leaders at summit', 1);

-- Insert Comments
INSERT INTO comments (news_id, username, reply_to_id, content) VALUES
(1, 'john_user', NULL, 'Great news about Indonesian tech industry! Very proud of this achievement.'),
(1, 'jane_user', NULL, 'This is inspiring! Hope to see more Indonesian startups succeed globally.'),
(1, 'john_user', 1, 'Absolutely! The future looks bright for Southeast Asian tech.'),
(2, 'jane_user', NULL, 'That was an incredible match! Best championship I have seen.');

-- Update comment reply counts
UPDATE comments SET reply_count = 1 WHERE id = 1;
UPDATE comments SET reply_count = 0 WHERE id = 2;
UPDATE comments SET reply_count = 0 WHERE id = 4;

-- Insert Likes (some likes, some dislikes)
INSERT INTO likes (news_id, username, is_like) VALUES
(1, 'john_user', 1),  -- john likes news 1
(1, 'jane_user', 1),  -- jane likes news 1
(2, 'john_user', 1),  -- john likes news 2
(2, 'jane_user', 0),  -- jane dislikes news 2
(3, 'jane_user', 1),  -- jane likes news 3
(4, 'john_user', 1);  -- john likes news 4

-- Insert Ratings
INSERT INTO rates (news_id, username, rate) VALUES
(1, 'john_user', 4.5),
(1, 'jane_user', 5.0),
(2, 'john_user', 4.0),
(3, 'jane_user', 4.5),
(4, 'john_user', 5.0);

-- Insert Tokens (example: email verification token)
INSERT INTO tokens (username, token, token_type, expires_at) VALUES
('john_user', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9example1', 'email_verification', DATE_ADD(NOW(), INTERVAL 7 DAY)),
('jane_user', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9example2', 'password_reset', DATE_ADD(NOW(), INTERVAL 1 DAY));

-- ============================================================================
-- END OF SCHEMA
-- ============================================================================
