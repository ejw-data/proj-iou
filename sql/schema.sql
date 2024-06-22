DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS authentication; 


-- USERS ------------------------------------------------------


CREATE TABLE users (
	user_id SERIAL PRIMARY KEY,
	first_name VARCHAR,
	last_name VARCHAR,
	email VARCHAR UNIQUE
);

INSERT INTO users (first_name, last_name, title_id, role_id, email)
VALUES ('erin', 'wills', 1, 1, 'ew@mysite.com'),
		('will', 'wright', 1, 1, 'ww@mysite.com'),
		('andrew', 'ng', 1, 1, 'an@mysite.com'),
		('bob', 'turtle', 5, 3, 'bt@mysite.com'),
		('jake', 'powers', 9, 3, 'jp@mysite.com');
		



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
	added_by INT REFERENCES users (user_id),
	payee_id INT REFERENCES users (user_id),
	owee_id INT REFERENCES users (user_id),
	business_name VARCHAR,
	description VARCHAR,
	notes VARCHAR,
	amount NUMERIC
);





 
		
		
