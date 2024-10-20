--Creation of the users table
DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	fullname VARCHAR(100) NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL
	);

--Creation of the status table
DROP TABLE IF EXISTS status;
CREATE TABLE status (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name VARCHAR(30) UNIQUE NOT NULL
	);

--Creation of the tasks table
DROP TABLE IF EXISTS tasks;
CREATE TABLE tasks (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	title VARCHAR(30) NOT NULL,
	description text DEFAULT NULL,
	status_id INTEGER NOT NULL,
	user_id INTEGER,
	FOREIGN KEY (status_id) REFERENCES status(id),
	FOREIGN KEY (user_id) REFERENCES users(id)
	    ON DELETE CASCADE
	);
