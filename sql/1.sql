-- Drop the function if it already exists
DROP FUNCTION IF EXISTS uuid_generate_v4;

-- Create the UUID generation function
CREATE FUNCTION uuid_generate_v4() RETURNS CHAR(36) 
    DETERMINISTIC 
    RETURN LOWER(CONCAT(
        SUBSTRING(MD5(RAND()) FROM 1 FOR 8), '-',
        SUBSTRING(MD5(RAND()) FROM 9 FOR 4), '-4',
        SUBSTRING(MD5(RAND()) FROM 13 FOR 3), '-',
        SUBSTRING('89ab', FLOOR(RAND()*4+1), 1),
        SUBSTRING(MD5(RAND()) FROM 17 FOR 3), '-',
        SUBSTRING(MD5(RAND()) FROM 21 FOR 12)
    ));

-- Create the users table without the default value for id
CREATE TABLE users (
    id CHAR(36) PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    password TEXT,
    create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Create a trigger to set the default value for id
DELIMITER //
CREATE TRIGGER before_insert_users
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
    IF NEW.id IS NULL THEN
        SET NEW.id = uuid_generate_v4();
    END IF;
END;
//
DELIMITER ;

-- Create the notes table without the default value for id
CREATE TABLE notes (
    id CHAR(36) PRIMARY KEY,
    parent_id CHAR(36),
    user_id CHAR(36) NOT NULL,
    title TEXT,
    content TEXT,
    is_published BOOLEAN NOT NULL DEFAULT FALSE,
    create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (parent_id) REFERENCES notes (id),
    FOREIGN KEY (user_id) REFERENCES users (id)
);

-- Create a trigger to set the default value for id
DELIMITER //
CREATE TRIGGER before_insert_notes
BEFORE INSERT ON notes
FOR EACH ROW
BEGIN
    IF NEW.id IS NULL THEN
        SET NEW.id = uuid_generate_v4();
    END IF;
END;
//
DELIMITER ;
