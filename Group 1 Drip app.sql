USE dripdb;
DROP TABLE IF EXISTS RecommendationHistory;
DROP TABLE IF EXISTS UserSavedOutfits;
DROP TABLE IF EXISTS Outfits;
DROP TABLE IF EXISTS Preferences;
DROP TABLE IF EXISTS ClothesItems;
DROP TABLE IF EXISTS Profile;
DROP TABLE IF EXISTS Users;

-- 1. Users (Johnny Ngo)
CREATE TABLE Users (
  uid BIGINT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(50) UNIQUE NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 2. Profile (1:1 with Users) (Lan Phan)
CREATE TABLE Profile (
  uid BIGINT PRIMARY KEY,
  name VARCHAR(100),
  height_cm SMALLINT,
  weight_kg SMALLINT,
  gender ENUM('male','female','unisex','other'),
  age INT,
  FOREIGN KEY (uid) REFERENCES Users(uid) ON DELETE CASCADE
);

-- 3. ClothesItems (catalog of clothing) (Syed Ali)

CREATE TABLE ClothesItems (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  item_name VARCHAR(150) NOT NULL,
  type VARCHAR(80),               
  price DECIMAL(10,2) NOT NULL,
  size VARCHAR(50),
  brand VARCHAR(100),
  color VARCHAR(50),
  material VARCHAR(100),
  retailer VARCHAR(100),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 4. Preferences (1:1 with Users) (Lan Phan)

CREATE TABLE Preferences (
  uid BIGINT PRIMARY KEY,
  min_budget DECIMAL(10,2),
  max_budget DECIMAL(10,2),
  color VARCHAR(50),
  size VARCHAR(50),
  occasion VARCHAR(100),
  FOREIGN KEY (uid) REFERENCES Users(uid) ON DELETE CASCADE
);

-- 5. Outfits
CREATE TABLE Outfits (
  outfit_id BIGINT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(150),
  created_by BIGINT, -- FK → Users.uid 
  total_price DECIMAL(10,2),
  occasion VARCHAR(100),
  gender ENUM('male','female','unisex','other'),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (created_by) REFERENCES Users(uid) ON DELETE SET NULL
);

-- 6. UserSavedOutfits (M:N Users ↔ Outfits) (Johnny Ngo)
CREATE TABLE UserSavedOutfits (
  uid BIGINT NOT NULL,
  outfit_id BIGINT NOT NULL,
  saved_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (uid, outfit_id),
  FOREIGN KEY (uid) REFERENCES Users(uid) ON DELETE CASCADE,
  FOREIGN KEY (outfit_id) REFERENCES Outfits(outfit_id) ON DELETE CASCADE
);

-- 7. RecommendationHistory (log of recs shown) (Syed Ahmed)

CREATE TABLE RecommendationHistory (
  rec_id BIGINT PRIMARY KEY AUTO_INCREMENT,
  uid BIGINT NOT NULL,
  outfit_id BIGINT NOT NULL,
  recommended_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  outcome ENUM('ignored','viewed','saved','purchased') DEFAULT 'ignored',
  context_json JSON,
  FOREIGN KEY (uid) REFERENCES Users(uid) ON DELETE CASCADE,
  FOREIGN KEY (outfit_id) REFERENCES Outfits(outfit_id) ON DELETE CASCADE,
  UNIQUE KEY uniq_user_outfit (uid, outfit_id)
);


-- ===== USERS (20) =====
INSERT INTO Users (uid, username, email, password, created_at) VALUES
(1,'johnny','johnny1@example.com','$2y$10$u1','2025-09-01 10:00:00'),
(2,'lan','lan2@example.com','$2y$10$u2','2025-09-01 10:05:00'),
(3,'syed','syed3@example.com','$2y$10$u3','2025-09-01 10:10:00'),
(4,'aidan','aidan4@example.com','$2y$10$u4','2025-09-01 10:15:00'),
(5,'maria','maria5@example.com','$2y$10$u5','2025-09-01 10:20:00'),
(6,'noah','noah6@example.com','$2y$10$u6','2025-09-01 10:25:00'),
(7,'ava','ava7@example.com','$2y$10$u7','2025-09-01 10:30:00'),
(8,'liam','liam8@example.com','$2y$10$u8','2025-09-01 10:35:00'),
(9,'zoe','zoe9@example.com','$2y$10$u9','2025-09-01 10:40:00'),
(10,'kai','kai10@example.com','$2y$10$u10','2025-09-01 10:45:00'),
(11,'leo','leo11@example.com','$2y$10$u11','2025-09-01 10:50:00'),
(12,'mia','mia12@example.com','$2y$10$u12','2025-09-01 10:55:00'),
(13,'ethan','ethan13@example.com','$2y$10$u13','2025-09-01 11:00:00'),
(14,'nina','nina14@example.com','$2y$10$u14','2025-09-01 11:05:00'),
(15,'omar','omar15@example.com','$2y$10$u15','2025-09-01 11:10:00'),
(16,'ruby','ruby16@example.com','$2y$10$u16','2025-09-01 11:15:00'),
(17,'yara','yara17@example.com','$2y$10$u17','2025-09-01 11:20:00'),
(18,'alex','alex18@example.com','$2y$10$u18','2025-09-01 11:25:00'),
(19,'tariq','tariq19@example.com','$2y$10$u19','2025-09-01 11:30:00'),
(20,'sara','sara20@example.com','$2y$10$u20','2025-09-01 11:35:00');

-- ===== PROFILE (20) =====
INSERT INTO Profile (uid, name, height_cm, weight_kg, gender, age) VALUES
(1,'Johnny Ngo',178,74,'male',22),
(2,'Lan Phan',165,58,'female',23),
(3,'Syed Ahmed',180,77,'male',21),
(4,'Aidan V',182,80,'male',22),
(5,'Maria Gomez',168,60,'female',24),
(6,'Noah Lee',176,72,'male',23),
(7,'Ava Patel',162,55,'female',21),
(8,'Liam Chen',179,78,'male',22),
(9,'Zoe Park',164,54,'female',21),
(10,'Kai Ito',174,70,'male',22),
(11,'Leo Rossi',181,79,'male',24),
(12,'Mia Khan',167,57,'female',22),
(13,'Ethan Clark',183,82,'male',23),
(14,'Nina Silva',170,61,'female',22),
(15,'Omar Ali',177,76,'male',25),
(16,'Ruby James',166,59,'female',22),
(17,'Yara Haddad',169,58,'female',23),
(18,'Alex Kim',175,73,'other',22),
(19,'Tariq Hassan',180,81,'male',24),
(20,'Sara Ahmed',165,57,'female',22);

-- ===== CLOTHES ITEMS (20) =====
INSERT INTO ClothesItems
(id, item_name, type, price, size, brand, color, material, retailer, created_at) VALUES
(1,'Slim Fit Jeans','bottom',59.99,'32x32','Levi''s','Dark Blue','Denim','Macy''s','2025-09-02 09:00:00'),
(2,'Classic White Tee','top',14.90,'M','Uniqlo','White','Cotton','Uniqlo','2025-09-02 09:02:00'),
(3,'Air Max 270','shoes',149.95,'US 10','Nike','Black/White','Mesh','Nike','2025-09-02 09:04:00'),
(4,'Essential Hoodie','outerwear',39.99,'L','H&M','Heather Grey','Cotton Blend','H&M','2025-09-02 09:06:00'),
(5,'Oxford Shirt','top',29.99,'M','Zara','Light Blue','Cotton','Zara','2025-09-02 09:08:00'),
(6,'Chino Pants','bottom',34.99,'33x32','H&M','Khaki','Cotton','H&M','2025-09-02 09:10:00'),
(7,'Running Shorts 7"','bottom',28.00,'M','Adidas','Black','Polyester','Adidas','2025-09-02 09:12:00'),
(8,'Puffer Jacket','outerwear',99.99,'L','Zara','Navy','Nylon','Zara','2025-09-02 09:14:00'),
(9,'Crew Socks 6-Pack','accessory',12.99,'L','Hanes','White','Cotton','Walmart','2025-09-02 09:16:00'),
(10,'Leather Belt','accessory',24.99,'34','Calvin Klein','Brown','Leather','Macy''s','2025-09-02 09:18:00'),
(11,'Sports Bra','top',35.00,'M','Nike','Black','Poly/Spandex','Nike','2025-09-02 09:20:00'),
(12,'A-Line Skirt','bottom',39.90,'S','Uniqlo','Black','Polyester','Uniqlo','2025-09-02 09:22:00'),
(13,'Chelsea Boots','shoes',129.00,'US 9','Zara','Brown','Leather','Zara','2025-09-02 09:24:00'),
(14,'Graphic Tee – Retro','top',19.99,'L','Amazon Essentials','Charcoal','Cotton','Amazon','2025-09-02 09:26:00'),
(15,'Fleece Joggers','bottom',24.98,'M','Fruit of the Loom','Black','Fleece','Walmart','2025-09-02 09:28:00'),
(16,'Rain Parka','outerwear',79.99,'M','H&M','Olive','Polyurethane','H&M','2025-09-02 09:30:00'),
(17,'Ultra Light Down','outerwear',69.90,'M','Uniqlo','Black','Nylon/Down','Uniqlo','2025-09-02 09:32:00'),
(18,'Stan Smith','shoes',99.99,'US 10','Adidas','White/Green','Leather','Adidas','2025-09-02 09:34:00'),
(19,'Pleated Dress','top',59.99,'S','Zara','Burgundy','Polyester','Zara','2025-09-02 09:36:00'),
(20,'Wool Overcoat','outerwear',149.99,'L','INC','Camel','Wool Blend','Macy''s','2025-09-02 09:38:00');

-- ===== PREFERENCES (20) =====
INSERT INTO Preferences (uid, min_budget, max_budget, color, size, occasion) VALUES
(1,20.00,120.00,'Black','M','casual'),
(2,15.00,80.00,'White','S','work'),
(3,25.00,200.00,'Navy','M','streetwear'),
(4,30.00,150.00,'Grey','L','casual'),
(5,40.00,220.00,'Burgundy','S','party'),
(6,20.00,130.00,'Olive','M','outdoor'),
(7,10.00,90.00,'Cream','S','brunch'),
(8,25.00,180.00,'Blue','L','smart-casual'),
(9,15.00,110.00,'Charcoal','S','campus'),
(10,20.00,140.00,'Black','M','travel'),
(11,35.00,160.00,'Brown','L','work'),
(12,20.00,120.00,'Beige','S','date'),
(13,30.00,190.00,'Green','L','gym'),
(14,15.00,100.00,'Pink','S','casual'),
(15,25.00,170.00,'Navy','M','interview'),
(16,20.00,150.00,'Teal','S','festival'),
(17,18.00,130.00,'White','M','office'),
(18,22.00,140.00,'Black','M','casual'),
(19,28.00,210.00,'Grey','L','business-casual'),
(20,12.00,95.00,'Blue','S','errands');

-- ===== OUTFITS (20) =====
INSERT INTO Outfits (outfit_id, title, created_by, total_price, occasion, gender, created_at) VALUES
(1,'Campus Chill',1,109.88,'casual','unisex','2025-09-03 10:00:00'),
(2,'Smart Casual Day',3,164.97,'smart-casual','male','2025-09-03 10:05:00'),
(3,'Rainy Day Fit',4,154.98,'outdoor','unisex','2025-09-03 10:10:00'),
(4,'Gym Runner',6,183.95,'gym','male','2025-09-03 10:15:00'),
(5,'Street Minimal',3,134.89,'streetwear','male','2025-09-03 10:20:00'),
(6,'Work Essentials',2,174.98,'work','female','2025-09-03 10:25:00'),
(7,'Evening Date',5,239.98,'date','female','2025-09-03 10:30:00'),
(8,'Weekend Errands',10,97.96,'errands','unisex','2025-09-03 10:35:00'),
(9,'Winter Layered',8,319.88,'casual','male','2025-09-03 10:40:00'),
(10,'Interview Ready',15,199.98,'interview','male','2025-09-03 10:45:00'),
(11,'Brunch Vibes',7,144.88,'brunch','female','2025-09-03 10:50:00'),
(12,'Travel Light',10,169.89,'travel','unisex','2025-09-03 10:55:00'),
(13,'Office Neat',17,189.99,'office','female','2025-09-03 11:00:00'),
(14,'Party Night',5,229.98,'party','female','2025-09-03 11:05:00'),
(15,'Outdoor Hike',6,179.95,'outdoor','unisex','2025-09-03 11:10:00'),
(16,'Business Casual',19,189.97,'business-casual','male','2025-09-03 11:15:00'),
(17,'Minimal Monochrome',1,124.88,'casual','unisex','2025-09-03 11:20:00'),
(18,'Cozy Layers',14,219.88,'casual','female','2025-09-03 11:25:00'),
(19,'Street Classic',3,189.89,'streetwear','male','2025-09-03 11:30:00'),
(20,'Warm & Wool',20,269.98,'casual','unisex','2025-09-03 11:35:00');

-- ===== USER SAVED OUTFITS (≥20, unique pairs) =====
INSERT INTO UserSavedOutfits (uid, outfit_id, saved_at) VALUES
(1,1,'2025-09-04 09:00:00'),
(1,17,'2025-09-04 09:01:00'),
(2,6,'2025-09-04 09:02:00'),
(3,5,'2025-09-04 09:03:00'),
(3,19,'2025-09-04 09:04:00'),
(4,3,'2025-09-04 09:05:00'),
(5,7,'2025-09-04 09:06:00'),
(6,4,'2025-09-04 09:07:00'),
(7,11,'2025-09-04 09:08:00'),
(8,9,'2025-09-04 09:09:00'),
(9,11,'2025-09-04 09:10:00'),
(10,12,'2025-09-04 09:11:00'),
(11,10,'2025-09-04 09:12:00'),
(12,13,'2025-09-04 09:13:00'),
(13,4,'2025-09-04 09:14:00'),
(14,18,'2025-09-04 09:15:00'),
(15,10,'2025-09-04 09:16:00'),
(16,16,'2025-09-04 09:17:00'),
(17,13,'2025-09-04 09:18:00'),
(18,12,'2025-09-04 09:19:00'),
(19,16,'2025-09-04 09:20:00'),
(20,20,'2025-09-04 09:21:00');

-- ===== RECOMMENDATION HISTORY (≥20, no duplicate (uid,outfit_id)) =====
INSERT INTO RecommendationHistory
(rec_id, uid, outfit_id, recommended_at, outcome, context_json) VALUES
(1,1,1,'2025-09-05 10:00:00','viewed','{"weather":"mild","budget":120}'),
(2,1,17,'2025-09-05 10:02:00','saved','{"weather":"mild","budget":120}'),
(3,2,6,'2025-09-05 10:04:00','viewed','{"weather":"office","budget":80}'),
(4,3,5,'2025-09-05 10:06:00','viewed','{"weather":"dry","budget":200}'),
(5,3,19,'2025-09-05 10:08:00','saved','{"weather":"dry","budget":200}'),
(6,4,3,'2025-09-05 10:10:00','ignored','{"weather":"rain","budget":150}'),
(7,5,7,'2025-09-05 10:12:00','viewed','{"weather":"evening","budget":240}'),
(8,6,4,'2025-09-05 10:14:00','purchased','{"weather":"gym","budget":190}'),
(9,7,11,'2025-09-05 10:16:00','viewed','{"weather":"mild","budget":90}'),
(10,8,9,'2025-09-05 10:18:00','viewed','{"weather":"cold","budget":330}'),
(11,9,11,'2025-09-05 10:20:00','saved','{"weather":"brunch","budget":150}'),
(12,10,12,'2025-09-05 10:22:00','viewed','{"weather":"travel","budget":170}'),
(13,11,10,'2025-09-05 10:24:00','viewed','{"weather":"office","budget":200}'),
(14,12,13,'2025-09-05 10:26:00','ignored','{"weather":"office","budget":190}'),
(15,13,4,'2025-09-05 10:28:00','viewed','{"weather":"gym","budget":200}'),
(16,14,18,'2025-09-05 10:30:00','saved','{"weather":"cool","budget":220}'),
(17,15,10,'2025-09-05 10:32:00','viewed','{"weather":"formal","budget":210}'),
(18,16,16,'2025-09-05 10:34:00','viewed','{"weather":"office","budget":150}'),
(19,17,13,'2025-09-05 10:36:00','ignored','{"weather":"office","budget":160}'),
(20,18,12,'2025-09-05 10:38:00','viewed','{"weather":"travel","budget":140}'),
(21,19,16,'2025-09-05 10:40:00','saved','{"weather":"office","budget":210}'),
(22,20,20,'2025-09-05 10:42:00','viewed','{"weather":"cold","budget":270}');
