-- CREATE TABLE Customer
CREATE TABLE Customer (
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(255) NOT NULL,
	last_name  VARCHAR(255) NOT NULL,
	email VARCHAR(255)
);

-- CREATE TABLE Product
CREATE TABLE Product(
	product_id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	unit_price FLOAT NOT NULL, -- DEFAULT 0.0
	category_name VARCHAR(255),
	description TEXT
);

-- CREATE TABLE Orders
CREATE TABLE Orders(
	order_id SERIAL PRIMARY KEY,
	customer_id INTEGER REFERENCES Customer(customer_id) ON DELETE SET NULL,  --- with mentioned the target column
	product_id INTEGER REFERENCES Product ON DELETE SET NULL, --without mentioning the target column
	item_ordered_count int NOT NULL DEFAULT 1,
	ordered_date DATE 
);


-- Insert data into appropriate tables

-- INSERT DATA INTO Customer
INSERT INTO CUSTOMER VALUES 
(1, 'James', 'Smith', 'james@gmail.com'),
(2, 'Michael', 'Brown', 'michael@gmail.com'),
(3, 'John', 'Miller', 'john@gmail.com'),
(4, 'William', 'Johnson', 'william@gmail.com'),
(5, 'George', 'Jones', 'george@gmail.com'),
(6, 'Henry', 'Davis', 'henry@gmail.com'),
(7, 'Britney', 'Williams', 'britney@gmail.com'),
(8, 'Tailor', 'Swift', 'tailor@gmail.com'),
(9, 'Joseph', 'Clark', 'joseph@gmail.com'),
(10, 'Jim', 'carrey', 'jim@gmail.com'),
(11, 'Ram', 'Basnet', 'ram@gmail.com'),
(12, 'Anita', 'Karki', 'anita@gmail.com'),
(13, 'Uogu', 'Wale', 'uogu@gmail.com'),
(14, 'Sanjog', 'Thapa', 'sanjog@gmail.com'),
(15, 'Sai', 'Kumar', 'sai@gmail.com');




-- INSERT DATA INTO Product
INSERT INTO Product VALUES 
(1, 'Mango', 2.3, 'Fruit', 'Mango fresh from market. 2.3 dollars per pound!'),
(2, 'Orange', 1.3,  'Fruit','Orange fresh from market. 2.3 dollars per pound!'),
(3, 'Apple', 2,  'Fruit','Apple fresh from market from california. 2 dollars per pound!'),
(4, 'Cabbage', 1, 'Vegetable','Cabbage fresh from market. 1 dollars per pound!'),
(5, 'Tomato', 1.2, 'Vegetable', 'Tomato fresh from market. 1.2 dollars per pound!'),
(6, 'Cauliflower', 2.9, 'Vegetable', 'Cauliflower fresh from market. 2.9 dollars per pound!'),
(7, 'Broccoli', 3, 'Vegetable', 'Broccoli fresh from market. 3 dollars per pound!'),
(8, 'Mango Juic', 5,'Grocery', 'Mango juice fresh from market. 5 dollars per bottle!'),
(9, 'Milk', 2.3, 'Grocery', 'Milk fresh from market. 2.3 dollars per gallon!'),
(10, 'Bread', 4.2, 'Grocery', 'Bread fresh from market. 4.2 dollars per bag!');


-- INSERT DATA INTO Orders
INSERT INTO Orders VALUES 
(1, 1, 1, 1, '2024-01-01'),
(2, 1, 2, 3, '2024-01-01'),
(3, 3, 10, 2, '2024-01-01'),
(4, 3, 9, 2, '2024-01-01'),
(5, 5, 5, 3, '2024-01-02'),
(6, 6, 6, 1, '2024-01-02'),
(7, 7, 8, 4, '2024-01-02'),
(8, 11, 2, 1, '2024-01-03'),
(9, 12, 3, 1, '2024-01-03'),
(10, 13, 3, 1, '2024-01-03'),
(11, 14, 2, 3, '2024-02-04'),
(12, 3, 10, 2, '2024-02-04'),
(13, 3, 9, 2, '2024-02-04'),
(14, 15, 5, 3, '2024-03-05'),
(15, 8, 6, 2, '2024-03-05'),
(16, 10, 9, 2, '2024-03-05');


-- Table for tournament participants
CREATE TABLE TournamentParticipants(
	participant_id SERIAL PRIMARY KEY,
	participant_name VARCHAR(255) NOT NULL,
	parent_id int,
	is_player boolean
);


-- Insert data into Tournamentparticipants
INSERT INTO TournamentParticipants VALUES 
(1, 'James Smith', NULL, FALSE),
(2, 'Michael Brown', 10 , TRUE),
(3, 'John Miller',11 , TRUE),
(4, 'William Johnson',12, TRUE),
(5, 'George Jones', 13 , TRUE),
(6, 'Henry Davis', 14, TRUE),
(7, 'Britney Williams',15 ,TRUE),
(8, 'Tom Swift', 18,TRUE),
(9, 'Joseph Clark', 19, TRUE),
(10, 'Jim Brown', NULL, FALSE),
(11, 'Ram Miller',NULL, FALSE),
(12, 'Anita Johnson', NULL, FALSE),
(13, 'Uogu Jones', NULL,FALSE),
(14, 'Sanjog Davis', NULL,FALSE),
(15, 'Sai Williams', NULL,FALSE),
(16, 'Harry Potter', 20, TRUE),
(17, 'Peter Parker', 21, TRUE),
(18, 'Harry Swift', NULL, FALSE),
(19, 'Peter Clark', NULL, FALSE),
(20, 'John Potter', NULL, FALSE),
(21, 'Samantha Parker', NULL, FALSE);