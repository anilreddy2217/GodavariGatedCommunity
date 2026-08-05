-- Database Setup for Godavari Gated Community Complaint Tracker
-- This script is optional - Hibernate will create tables automatically
-- Use this only if you want to manually create the database and add an admin user

CREATE DATABASE IF NOT EXISTS godavari_gated_community_db;
USE godavari_gated_community_db;

-- Tables will be created automatically by Hibernate
-- But if you want to create them manually:

CREATE TABLE IF NOT EXISTS residents (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE,
    full_name VARCHAR(100),
    role VARCHAR(20) NOT NULL,
    phone VARCHAR(15),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS complaints (
    complaint_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    category VARCHAR(50) NOT NULL,
    subject VARCHAR(200) NOT NULL,
    description TEXT NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES residents(id) ON DELETE CASCADE
);

-- Insert default admin user (password: admin123)
INSERT INTO residents (username, password, email, full_name, role, phone) 
VALUES ('admin', 'admin123', 'admin@godavari.com', 'System Administrator', 'owner', '9999999999')
ON DUPLICATE KEY UPDATE username=username;

-- Insert sample user (password: user123)
INSERT INTO residents (username, password, email, full_name, role, phone) 
VALUES ('user1', 'user123', 'user1@godavari.com', 'John Doe', 'user', '8888888888')
ON DUPLICATE KEY UPDATE username=username;

-- Sample complaints
INSERT INTO complaints (user_id, category, subject, description, status) 
VALUES 
(2, 'Service', 'Water Supply Issue', 'No water supply in Block A since morning', 'Pending'),
(2, 'Technical', 'Lift Not Working', 'Lift in Tower 2 is not functioning', 'In Progress');
