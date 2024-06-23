DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS authentication; 
DROP TABLE IF EXISTS transactions; 


-- USERS ------------------------------------------------------


CREATE TABLE users (
	user_id SERIAL PRIMARY KEY,
	first_name VARCHAR,
	last_name VARCHAR,
	fullname VARCHAR,
	email VARCHAR UNIQUE
);

INSERT INTO users (first_name, last_name, title_id, role_id, email)
VALUES ('erin', 'wills', 1, 1, 'ew@mysite.com'),
		('will', 'wright', 1, 1, 'ww@mysite.com'),
		('andrew', 'ng', 1, 1, 'an@mysite.com'),
		('bob', 'turtle', 5, 3, 'bt@mysite.com'),
		('jake', 'powers', 9, 3, 'jp@mysite.com');
		

ALTER TABLE users
ADD fullname VARCHAR;

UPDATE users
SET fullname = initcap(first_name) || ' ' || initcap(last_name)

-- LOGIN -----------------------------------------------------------


-- change so that primary key is also foreign key to users (user_id), keep only username, password_hash
CREATE TABLE authentication (
	id INT PRIMARY KEY REFERENCES users (user_id),
	username VARCHAR,
	password_hash VARCHAR
);

INSERT INTO authentication (login_id, username, password_hash)
VALUES (1, 'ejwadmin', 'alf344t4090j0aojfsfa');

-- Transaction Table 
CREATE TABLE records (
	transaction_id SERIAL PRIMARY KEY,
	date_added TIMESTAMP DEFAULT NOW(),
	date_transaction DATE,
	added_by INT REFERENCES users (user_id),
	payee_id INT REFERENCES users (user_id),
	owee_id INT REFERENCES users (user_id),
	business_name VARCHAR,
	description VARCHAR,
	notes VARCHAR,
	amount NUMERIC,
	primary_ind BOOLEAN
);


ALTER TABLE records
ADD primary_ind BOOLEAN;

UPDATE records
SET primary_ind = TRUE;

INSERT INTO records (added_by, payee_id, owee_id, business_name, description, notes, amount, primary_ind)
SELECT added_by, owee_id, payee_id, business_name, description, notes, (-1*amount), false
FROM records;

ALTER TABLE records
ADD date_added TIMESTAMP;

UPDATE records
SET date_added = NOW();

ALTER TABLE records
ADD date_transaction DATE;

UPDATE records
SET date_transaction = '2024-06-22';
 
		
		
