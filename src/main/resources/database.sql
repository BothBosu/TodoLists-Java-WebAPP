-- Create todo_management database
CREATE DATABASE IF NOT EXISTS todo_management;
USE todo_management;

-- Create users table
CREATE TABLE IF NOT EXISTS users (
                                     id INT AUTO_INCREMENT PRIMARY KEY,
                                     first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,  -- BCrypt hashed passwords will be stored here
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Create todos table
CREATE TABLE IF NOT EXISTS todos (
                                     id BIGINT AUTO_INCREMENT PRIMARY KEY,
                                     title VARCHAR(100) NOT NULL,
    username VARCHAR(50) NOT NULL,
    description VARCHAR(500),
    target_date DATE,
    is_done BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    -- Create a foreign key to link todos with users
    FOREIGN KEY (username) REFERENCES users(username) ON DELETE CASCADE ON UPDATE CASCADE
    );

-- Add indexes for performance
CREATE INDEX idx_todos_username ON todos (username);

-- Sample admin user (bcrypt hashed password for 'admin123')
-- Note: This is just for development/testing purposes
INSERT INTO users (first_name, last_name, username, password)
VALUES ('Admin', 'User', 'admin', '$2a$12$CgD8PoAwoOJO1vWIZe3FT.GNQrR3gNtS5PBXwFETmXAYOIw/WH7.2');