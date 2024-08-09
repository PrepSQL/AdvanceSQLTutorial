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
INSERT INTO CUSTOMER VALUES(1, 'James', 'Smith', 'james@gmail.com');
INSERT INTO CUSTOMER VALUES(2, 'Michael', 'Brown', 'michael@gmail.com');
INSERT INTO CUSTOMER VALUES(3, 'John', 'Miller', 'john@gmail.com');
INSERT INTO CUSTOMER VALUES(4, 'William', 'Johnson', 'william@gmail.com');
INSERT INTO CUSTOMER VALUES(5, 'George', 'Jones', 'george@gmail.com');
INSERT INTO CUSTOMER VALUES(6, 'Henry', 'Davis', 'henry@gmail.com');
INSERT INTO CUSTOMER VALUES(7, 'Britney', 'Williams', 'britney@gmail.com');
INSERT INTO CUSTOMER VALUES(8, 'Tailor', 'Swift', 'tailor@gmail.com');
INSERT INTO CUSTOMER VALUES(9, 'Joseph', 'Clark', 'joseph@gmail.com');
INSERT INTO CUSTOMER VALUES(10, 'Jim', 'carrey', 'jim@gmail.com');
INSERT INTO CUSTOMER VALUES(11, 'Ram', 'Basnet', 'ram@gmail.com');
INSERT INTO CUSTOMER VALUES(12, 'Anita', 'Karki', 'anita@gmail.com');
INSERT INTO CUSTOMER VALUES(13, 'Uogu', 'Wale', 'uogu@gmail.com');
INSERT INTO CUSTOMER VALUES(14, 'Sanjog', 'Thapa', 'sanjog@gmail.com');
INSERT INTO CUSTOMER VALUES(15, 'Sai', 'Kumar', 'sai@gmail.com');




-- INSERT DATA INTO Product
INSERT INTO Product VALUES (1, 'Mango', 2.3, 'Fruit', 'Mango fresh from market. 2.3 dollars per pound!');
INSERT INTO Product VALUES (2, 'Orange', 1.3,  'Fruit','Orange fresh from market. 2.3 dollars per pound!');
INSERT INTO Product VALUES (3, 'Apple', 2,  'Fruit','Apple fresh from market from california. 2 dollars per pound!');
INSERT INTO Product VALUES (4, 'Cabbage', 1, 'Vegetable','Cabbage fresh from market. 1 dollars per pound!');
INSERT INTO Product VALUES (5, 'Tomato', 1.2, 'Vegetable', 'Tomato fresh from market. 1.2 dollars per pound!');
INSERT INTO Product VALUES (6, 'Cauliflower', 2.9, 'Vegetable', 'Cauliflower fresh from market. 2.9 dollars per pound!');
INSERT INTO Product VALUES (7, 'Broccoli', 3, 'Vegetable', 'Broccoli fresh from market. 3 dollars per pound!');
INSERT INTO Product VALUES (8, 'Mango Juic', 5,'Grocery', 'Mango juice fresh from market. 5 dollars per bottle!');
INSERT INTO Product VALUES (9, 'Milk', 2.3, 'Grocery', 'Milk fresh from market. 2.3 dollars per gallon!');
INSERT INTO Product VALUES (10, 'Bread', 4.2, 'Grocery', 'Bread fresh from market. 4.2 dollars per bag!');


-- INSERT DATA INTO Orders
INSERT INTO Orders VALUES (1, 1, 1, 1, '2024-01-01');
INSERT INTO Orders VALUES (2, 1, 2, 3, '2024-01-01');
INSERT INTO Orders VALUES (3, 3, 10, 2, '2024-01-01');
INSERT INTO Orders VALUES (4, 3, 9, 2, '2024-01-01');

INSERT INTO Orders VALUES (5, 5, 5, 3, '2024-01-02');
INSERT INTO Orders VALUES (6, 6, 6, 1, '2024-01-02');
INSERT INTO Orders VALUES (7, 7, 8, 4, '2024-01-02');

INSERT INTO Orders VALUES (8, 11, 2, 1, '2024-01-03');
INSERT INTO Orders VALUES (9, 12, 3, 1, '2024-01-03');
INSERT INTO Orders VALUES (10, 13, 3, 1, '2024-01-03');

INSERT INTO Orders VALUES (11, 14, 2, 3, '2024-02-04');
INSERT INTO Orders VALUES (12, 3, 10, 2, '2024-02-04');
INSERT INTO Orders VALUES (13, 3, 9, 2, '2024-02-04');

INSERT INTO Orders VALUES (14, 15, 5, 3, '2024-03-05');
INSERT INTO Orders VALUES (15, 8, 6, 2, '2024-03-05');
INSERT INTO Orders VALUES (16, 10, 9, 2, '2024-03-05');
