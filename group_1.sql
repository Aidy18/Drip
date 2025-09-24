CREATE DATABASE dripdb;
USE dripdb;
-- this is here so we can copy+paste the stuff we write in


create table preferences(uid bigint, min_budget decimal(10, 2), max_budget decimal(10, 2), color varchar(50), size varchar(50), occasion varchar(100), primary key (uid), foreign key (uid) references Users(uid) on delete cascade);
INSERT INTO preferences (uid, min_budget, max_budget, color, size, occasion) VALUES
(1001, 15.50, 45.99, 'Red', 'Medium', 'Casual daily wear'),
(1002, 30.00, 75.25, 'Blue', 'Large', 'Office formal meetings'),
(1003, 12.99, 40.00, 'Black', 'Small', 'Outdoor sports activities'),
(1004, 55.00, 120.50, 'White', 'Medium', 'Evening parties and events'),
(1005, 25.00, 65.75, 'Green', 'Large', 'Weekend casual outings'),
(1006, 40.25, 85.00, 'Yellow', 'Extra Large', 'Business casual attire'),
(1007, 10.00, 35.50, 'Pink', 'Small', 'Relaxed home wear'),
(1008, 38.99, 90.00, 'Purple', 'Medium', 'Festivals and celebrations'),
(1009, 18.50, 45.00, 'Orange', 'Large', 'Gym and workout sessions'),
(1010, 28.00, 60.00, 'Grey', 'Medium', 'Casual meetups and gatherings'),
(1011, 47.00, 110.00, 'Navy Blue', 'Extra Large', 'Corporate events and dinners'),
(1012, 14.00, 37.25, 'Brown', 'Small', 'Home lounging and casual wear'),
(1013, 26.50, 70.00, 'Teal', 'Medium', 'Night outs and parties'),
(1014, 33.75, 78.50, 'Maroon', 'Large', 'Formal office meetings'),
(1015, 22.00, 55.50, 'Beige', 'Medium', 'Weekend casuals'),
(1016, 42.00, 92.75, 'Black', 'Extra Large', 'Special occasions and events'),
(1017, 13.50, 39.99, 'Red', 'Small', 'Sports and activewear'),
(1018, 60.00, 125.00, 'White', 'Large', 'Formal evening parties'),
(1019, 9.99, 27.50, 'Blue', 'Medium', 'Daily casual wear'),
(1020, 36.00, 88.00, 'Green', 'Large', 'Celebrations and festivals');
