
-- Insert Tags linked to Categories

-- Politics
SET @cid = (SELECT id FROM `categories` WHERE `name` = 'Politics');
INSERT IGNORE INTO `tags` (`category_id`, `name`) VALUES 
(@cid, 'Election'), 
(@cid, 'Government'), 
(@cid, 'Parliament'), 
(@cid, 'Corruption'), 
(@cid, 'Policy'), 
(@cid, 'Diplomacy'), 
(@cid, 'Regional Elections');

-- Economy
SET @cid = (SELECT id FROM `categories` WHERE `name` = 'Economy');
INSERT IGNORE INTO `tags` (`category_id`, `name`) VALUES 
(@cid, 'Stock Market'), 
(@cid, 'Inflation'), 
(@cid, 'Banking'), 
(@cid, 'Cryptocurrency'), 
(@cid, 'Real Estate'), 
(@cid, 'SMEs'), 
(@cid, 'Startups');

-- Sports
SET @cid = (SELECT id FROM `categories` WHERE `name` = 'Sports');
INSERT IGNORE INTO `tags` (`category_id`, `name`) VALUES 
(@cid, 'Football'), 
(@cid, 'Badminton'), 
(@cid, 'Basketball'), 
(@cid, 'MotoGP'), 
(@cid, 'Formula 1'), 
(@cid, 'Esports'), 
(@cid, 'Liga 1');

-- Technology
SET @cid = (SELECT id FROM `categories` WHERE `name` = 'Technology');
INSERT IGNORE INTO `tags` (`category_id`, `name`) VALUES 
(@cid, 'Gadgets'), 
(@cid, 'Artificial Intelligence'), 
(@cid, 'Software'), 
(@cid, 'Cybersecurity'), 
(@cid, 'Internet'), 
(@cid, 'Social Media'), 
(@cid, 'Blockchain');

-- Entertainment
SET @cid = (SELECT id FROM `categories` WHERE `name` = 'Entertainment');
INSERT IGNORE INTO `tags` (`category_id`, `name`) VALUES 
(@cid, 'Movies'), 
(@cid, 'Music'), 
(@cid, 'Celebrity'), 
(@cid, 'K-Pop'), 
(@cid, 'Drama'), 
(@cid, 'Concerts'), 
(@cid, 'Arts');

-- Health
SET @cid = (SELECT id FROM `categories` WHERE `name` = 'Health');
INSERT IGNORE INTO `tags` (`category_id`, `name`) VALUES 
(@cid, 'Mental Health'), 
(@cid, 'Nutrition'), 
(@cid, 'Fitness'), 
(@cid, 'Medical Research'), 
(@cid, 'Public Health'), 
(@cid, 'Pandemic');

-- Lifestyle
SET @cid = (SELECT id FROM `categories` WHERE `name` = 'Lifestyle');
INSERT IGNORE INTO `tags` (`category_id`, `name`) VALUES 
(@cid, 'Travel'), 
(@cid, 'Culinary'), 
(@cid, 'Fashion'), 
(@cid, 'Beauty'), 
(@cid, 'Relationships'), 
(@cid, 'Parenting'), 
(@cid, 'Home & Decor');

-- Automotive
SET @cid = (SELECT id FROM `categories` WHERE `name` = 'Automotive');
INSERT IGNORE INTO `tags` (`category_id`, `name`) VALUES 
(@cid, 'Electric Vehicles'), 
(@cid, 'Cars'), 
(@cid, 'Motorcycles'), 
(@cid, 'Traffic'), 
(@cid, 'Modifications'), 
(@cid, 'Reviews');

-- World
SET @cid = (SELECT id FROM `categories` WHERE `name` = 'World');
INSERT IGNORE INTO `tags` (`category_id`, `name`) VALUES 
(@cid, 'Conflict'), 
(@cid, 'United Nations'), 
(@cid, 'Climate Change'), 
(@cid, 'Human Rights'), 
(@cid, 'International Trade');