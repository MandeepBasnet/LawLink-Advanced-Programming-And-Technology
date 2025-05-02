-- Create the LawLink database
CREATE DATABASE IF NOT EXISTS c5_db;
USE c5_db;

-- Create Users table (base table for all user types)
CREATE TABLE IF NOT EXISTS Users (
                       user_id INT AUTO_INCREMENT PRIMARY KEY,
                       username VARCHAR(50) NOT NULL UNIQUE,
                       password VARCHAR(255) NOT NULL,
    password_salt VARCHAR(100),
                       email VARCHAR(100) NOT NULL UNIQUE,
                       full_name VARCHAR(100) NOT NULL,
                       phone VARCHAR(20),
                       address TEXT,
    role ENUM('ADMIN', 'LAWYER', 'CLIENT') NOT NULL DEFAULT 'CLIENT',
                       registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       last_login TIMESTAMP NULL,
                       is_active BOOLEAN DEFAULT TRUE,
                       profile_image VARCHAR(255),
                       session_token VARCHAR(255),
                       session_expiry TIMESTAMP NULL,
                       reset_token VARCHAR(255),
    reset_token_expiry TIMESTAMP NULL,
    otp VARCHAR(6) NULL,
    otp_expiry TIMESTAMP NULL
);

-- Create Admins table (extends Users)
CREATE TABLE IF NOT EXISTS Admins (
    admin_id INT PRIMARY KEY,
    FOREIGN KEY (admin_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Create Lawyers table (extends Users)
CREATE TABLE IF NOT EXISTS Lawyers (
                         lawyer_id INT PRIMARY KEY,
                         specialization VARCHAR(100) NOT NULL,
    practice_areas TEXT NOT NULL,
                         experience_years INT NOT NULL,
                         education TEXT NOT NULL,
                         license_number VARCHAR(50) NOT NULL,
                         about_me TEXT,
                         consultation_fee DECIMAL(10, 2) NOT NULL,
                         is_verified BOOLEAN DEFAULT FALSE,
                         is_available BOOLEAN DEFAULT TRUE,
                         rating DECIMAL(3, 2) DEFAULT 0.0,
                         FOREIGN KEY (lawyer_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Create Clients table (extends Users)
CREATE TABLE IF NOT EXISTS Clients (
                         client_id INT PRIMARY KEY,
                         date_of_birth DATE,
    gender ENUM('MALE', 'FEMALE', 'OTHER'),
                         FOREIGN KEY (client_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Create LawyerAvailability table
CREATE TABLE IF NOT EXISTS LawyerAvailability (
    lawyer_id INT NOT NULL,
                                    day_of_week ENUM('MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY', 'SATURDAY', 'SUNDAY') NOT NULL,
                                    is_available BOOLEAN DEFAULT TRUE,
                                    PRIMARY KEY (lawyer_id, day_of_week),
                                    FOREIGN KEY (lawyer_id) REFERENCES Lawyers(lawyer_id) ON DELETE CASCADE
);

-- Create Appointments table
CREATE TABLE IF NOT EXISTS Appointments (
                              appointment_id INT AUTO_INCREMENT PRIMARY KEY,
                              lawyer_id INT NOT NULL,
                              client_id INT NOT NULL,
                              appointment_date DATE NOT NULL,
                              appointment_time TIME NOT NULL,
    duration INT NOT NULL DEFAULT 60,
                              status ENUM('PENDING', 'CONFIRMED', 'COMPLETED', 'CANCELLED') DEFAULT 'PENDING',
                              notes TEXT,
                              created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                              updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                              FOREIGN KEY (lawyer_id) REFERENCES Lawyers(lawyer_id) ON DELETE CASCADE,
    FOREIGN KEY (client_id) REFERENCES Clients(client_id) ON DELETE CASCADE,
    UNIQUE KEY unique_appointment (lawyer_id, appointment_date, appointment_time)
);

-- Create Reviews table
CREATE TABLE IF NOT EXISTS Reviews (
                         review_id INT AUTO_INCREMENT PRIMARY KEY,
                         appointment_id INT NOT NULL,
                         rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
                         comment TEXT,
                         review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                         FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id) ON DELETE CASCADE
);

-- Create PracticeAreas table
CREATE TABLE IF NOT EXISTS PracticeAreas (
    area_id INT AUTO_INCREMENT PRIMARY KEY,
    area_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    image VARCHAR(255)
);

-- Create LawyerPracticeAreas junction table
CREATE TABLE IF NOT EXISTS LawyerPracticeAreas (
    lawyer_id INT NOT NULL,
    area_id INT NOT NULL,
    PRIMARY KEY (lawyer_id, area_id),
    FOREIGN KEY (lawyer_id) REFERENCES Lawyers(lawyer_id) ON DELETE CASCADE,
    FOREIGN KEY (area_id) REFERENCES PracticeAreas(area_id) ON DELETE CASCADE
);

-- Insert practice areas
INSERT INTO PracticeAreas (area_name, description, image) VALUES
('Property Law', 'Legal matters related to real estate, property rights, and transactions', 'property-law.png'),
('Family Law', 'Legal issues related to family relationships, divorce, child custody, etc.', 'family-law.png'),
('Criminal Law', 'Legal defense and prosecution for criminal offenses', 'criminal-law.png'),
('Corporate Law', 'Legal services for businesses, corporations, and commercial entities', 'corporate-law.png'),
('Labour Law', 'Legal matters related to employment, workplace rights, and regulations', 'labour-law.png'),
('International Law', 'Legal issues crossing international boundaries and jurisdictions', 'international-law.png');

-- Insert admin users (password: admin123)
INSERT INTO Users (username, password, email, full_name, phone, role, is_active) VALUES
    ('admin', '$2a$10$QFkc5TYJ0FYG9J5FKgzCp.MuKqGJI1ohYm7AHJUdB0QMtYwZYdH4e', 'admin@lawlink.com', 'System Administrator', '+977-9812345678', 'ADMIN', true),
    ('admin2', '$2a$10$QFkc5TYJ0FYG9J5FKgzCp.MuKqGJI1ohYm7AHJUdB0QMtYwZYdH4e', 'admin2@lawlink.com', 'Assistant Administrator', '+977-9812345679', 'ADMIN', true);

-- Insert admin records into Admins table
INSERT INTO Admins (admin_id)
SELECT user_id FROM Users WHERE role = 'ADMIN';

-- Insert lawyers (password: admin123)
INSERT INTO Users (username, password, email, full_name, phone, address, role, profile_image, is_active) VALUES
    ('zaina.raj', '$2a$10$QFkc5TYJ0FYG9J5FKgzCp.MuKqGJI1ohYm7AHJUdB0QMtYwZYdH4e', 'zaina.raj@lawlink.com', 'Zaina Raj', '+977-9086706541', 'Itahari', 'LAWYER', 'zaina.jpg', true),
    ('rayan.rajbangsi', '$2a$10$QFkc5TYJ0FYG9J5FKgzCp.MuKqGJI1ohYm7AHJUdB0QMtYwZYdH4e', 'rayan.rajbangsi@lawlink.com', 'Rayan Rajbangsi', '+977-9705523049', 'Itahari', 'LAWYER', 'rayan.jpg', true),
    ('manish.khanal', '$2a$10$QFkc5TYJ0FYG9J5FKgzCp.MuKqGJI1ohYm7AHJUdB0QMtYwZYdH4e', 'manish.khanal@lawlink.com', 'MANISH KHANAL', '+977-9812395010', 'Kathmandu', 'LAWYER', 'manish.jpg', true),
    ('baviyan.koirala', '$2a$10$QFkc5TYJ0FYG9J5FKgzCp.MuKqGJI1ohYm7AHJUdB0QMtYwZYdH4e', 'baviyan.koirala@lawlink.com', 'Baviyan Koirala', '+977-9867063791', 'Itahari', 'LAWYER', 'baviyan.jpg', true),
    ('lalita.puri', '$2a$10$QFkc5TYJ0FYG9J5FKgzCp.MuKqGJI1ohYm7AHJUdB0QMtYwZYdH4e', 'lalita.puri@lawlink.com', 'Lalita Puri', '+977-9706146926', 'Biratnagar', 'LAWYER', 'lalita.jpg', true),
    ('ashutosh.srivastava', '$2a$10$QFkc5TYJ0FYG9J5FKgzCp.MuKqGJI1ohYm7AHJUdB0QMtYwZYdH4e', 'ashutosh.srivastava@lawlink.com', 'Ashutosh Srivastava', '+977-9823543129', 'Morang', 'LAWYER', 'ashutosh.jpg', true),
    ('yusha.shrestha', '$2a$10$QFkc5TYJ0FYG9J5FKgzCp.MuKqGJI1ohYm7AHJUdB0QMtYwZYdH4e', 'yusha.shrestha@lawlink.com', 'Yusha Shrestha', '+977-9703304911', 'Tarahara', 'LAWYER', 'yusha.jpg', true),
    ('anish.basnet', '$2a$10$QFkc5TYJ0FYG9J5FKgzCp.MuKqGJI1ohYm7AHJUdB0QMtYwZYdH4e', 'anish.basnet@lawlink.com', 'Anish Basnet', '+977-9708203041', 'Jhapa', 'LAWYER', 'anish.jpg', true),
    ('susasa.acharya', '$2a$10$QFkc5TYJ0FYG9J5FKgzCp.MuKqGJI1ohYm7AHJUdB0QMtYwZYdH4e', 'susasa.acharya@lawlink.com', 'SUSASA ACHARYA', '+977-9703129941', 'Biratnagar', 'LAWYER', 'susasa.jpg', true);

-- Insert lawyer details
INSERT INTO Lawyers (lawyer_id, specialization, practice_areas, experience_years, education, license_number, about_me, consultation_fee, is_verified, is_available, rating)
SELECT u.user_id,
       CASE
           WHEN u.username = 'zaina.raj' THEN 'Property Law'
           WHEN u.username = 'rayan.rajbangsi' THEN 'Criminal Law'
           WHEN u.username = 'manish.khanal' THEN 'Family Law'
           WHEN u.username = 'baviyan.koirala' THEN 'Corporate Law'
           WHEN u.username = 'lalita.puri' THEN 'International Law'
           WHEN u.username = 'ashutosh.srivastava' THEN 'Labour Law'
           WHEN u.username = 'yusha.shrestha' THEN 'Property Law'
           WHEN u.username = 'anish.basnet' THEN 'Criminal Law'
           WHEN u.username = 'susasa.acharya' THEN 'Family Law'
           END as specialization,
       CASE
           WHEN u.username = 'zaina.raj' THEN 'Property Law, Corporate Law'
           WHEN u.username = 'rayan.rajbangsi' THEN 'Criminal Law, International Law'
           WHEN u.username = 'manish.khanal' THEN 'Family Law, Labour Law'
           WHEN u.username = 'baviyan.koirala' THEN 'Corporate Law, Property Law'
           WHEN u.username = 'lalita.puri' THEN 'International Law, Family Law'
           WHEN u.username = 'ashutosh.srivastava' THEN 'Labour Law, Criminal Law'
           WHEN u.username = 'yusha.shrestha' THEN 'Property Law, Family Law'
           WHEN u.username = 'anish.basnet' THEN 'Criminal Law, Corporate Law'
           WHEN u.username = 'susasa.acharya' THEN 'Family Law, International Law'
           END as practice_areas,
       FLOOR(RAND() * 10) + 5 as experience_years,
       'LLB, Bar Council of Nepal' as education,
       CONCAT('NPL', LPAD(FLOOR(RAND() * 10000), 4, '0')) as license_number,
       CONCAT('Experienced lawyer specializing in ', 
           CASE
               WHEN u.username = 'zaina.raj' THEN 'Property Law'
               WHEN u.username = 'rayan.rajbangsi' THEN 'Criminal Law'
               WHEN u.username = 'manish.khanal' THEN 'Family Law'
               WHEN u.username = 'baviyan.koirala' THEN 'Corporate Law'
               WHEN u.username = 'lalita.puri' THEN 'International Law'
               WHEN u.username = 'ashutosh.srivastava' THEN 'Labour Law'
               WHEN u.username = 'yusha.shrestha' THEN 'Property Law'
               WHEN u.username = 'anish.basnet' THEN 'Criminal Law'
               WHEN u.username = 'susasa.acharya' THEN 'Family Law'
           END) as about_me,
       FLOOR(RAND() * (5000 - 2000 + 1)) + 2000 as consultation_fee,
       true as is_verified,
       true as is_available,
       ROUND(RAND() * 2 + 3, 1) as rating
FROM Users u
WHERE u.role = 'LAWYER';

-- Insert clients (password: admin123)
INSERT INTO Users (username, password, email, full_name, phone, address, role, profile_image, is_active) VALUES
    ('john.doe', '$2a$10$QFkc5TYJ0FYG9J5FKgzCp.MuKqGJI1ohYm7AHJUdB0QMtYwZYdH4e', 'john.doe@example.com', 'John Doe', '+977-9812345670', 'Kathmandu', 'CLIENT', 'john.jpg', true),
    ('jane.smith', '$2a$10$QFkc5TYJ0FYG9J5FKgzCp.MuKqGJI1ohYm7AHJUdB0QMtYwZYdH4e', 'jane.smith@example.com', 'Jane Smith', '+977-9812345671', 'Pokhara', 'CLIENT', 'jane.jpg', true),
    ('robert.wilson', '$2a$10$QFkc5TYJ0FYG9J5FKgzCp.MuKqGJI1ohYm7AHJUdB0QMtYwZYdH4e', 'robert.wilson@example.com', 'Robert Wilson', '+977-9812345672', 'Lalitpur', 'CLIENT', 'robert.jpg', true),
    ('sarah.johnson', '$2a$10$QFkc5TYJ0FYG9J5FKgzCp.MuKqGJI1ohYm7AHJUdB0QMtYwZYdH4e', 'sarah.johnson@example.com', 'Sarah Johnson', '+977-9812345673', 'Bhaktapur', 'CLIENT', 'sarah.jpg', true),
    ('michael.brown', '$2a$10$QFkc5TYJ0FYG9J5FKgzCp.MuKqGJI1ohYm7AHJUdB0QMtYwZYdH4e', 'michael.brown@example.com', 'Michael Brown', '+977-9812345674', 'Dharan', 'CLIENT', 'michael.jpg', true);

-- Insert client details
INSERT INTO Clients (client_id, date_of_birth, gender)
SELECT user_id, 
       DATE_SUB(CURRENT_DATE, INTERVAL FLOOR(RAND() * 30) + 20 YEAR),
       CASE FLOOR(RAND() * 3)
           WHEN 0 THEN 'MALE'
           WHEN 1 THEN 'FEMALE'
           ELSE 'OTHER'
       END
FROM Users 
WHERE role = 'CLIENT';

-- Insert lawyer availability
INSERT INTO LawyerAvailability (lawyer_id, day_of_week, is_available)
SELECT l.lawyer_id, d.day, true
FROM Lawyers l
CROSS JOIN (
    SELECT 'MONDAY' as day UNION ALL
    SELECT 'TUESDAY' UNION ALL
    SELECT 'WEDNESDAY' UNION ALL
    SELECT 'THURSDAY' UNION ALL
    SELECT 'FRIDAY'
) d;

-- Insert appointments
INSERT INTO Appointments (lawyer_id, client_id, appointment_date, appointment_time, duration, status, notes)
SELECT 
    l.lawyer_id,
    c.client_id,
    DATE_ADD(CURRENT_DATE, INTERVAL FLOOR(RAND() * 30) DAY),
    MAKETIME(FLOOR(RAND() * 8) + 9, FLOOR(RAND() * 12) * 5, 0),
    60,
    CASE FLOOR(RAND() * 4)
        WHEN 0 THEN 'PENDING'
        WHEN 1 THEN 'CONFIRMED'
        WHEN 2 THEN 'COMPLETED'
        ELSE 'CANCELLED'
    END,
    CONCAT('Appointment for ', 
           CASE FLOOR(RAND() * 6)
               WHEN 0 THEN 'Property Law consultation'
               WHEN 1 THEN 'Family Law matter'
               WHEN 2 THEN 'Criminal case review'
               WHEN 3 THEN 'Corporate legal advice'
               WHEN 4 THEN 'Labor dispute'
               ELSE 'International legal matter'
           END)
FROM Lawyers l
CROSS JOIN Clients c
LIMIT 20;

-- Insert reviews for completed appointments
INSERT INTO Reviews (appointment_id, rating, comment)
SELECT 
    a.appointment_id,
    FLOOR(RAND() * 5) + 1,
    CASE FLOOR(RAND() * 5)
        WHEN 0 THEN 'Excellent service and very professional'
        WHEN 1 THEN 'Very knowledgeable and helpful'
        WHEN 2 THEN 'Good experience overall'
        WHEN 3 THEN 'Satisfactory service'
        ELSE 'Could be better'
    END
FROM Appointments a
WHERE a.status = 'COMPLETED';

-- Insert lawyer practice areas
INSERT INTO LawyerPracticeAreas (lawyer_id, area_id)
SELECT l.lawyer_id, p.area_id
FROM Lawyers l
CROSS JOIN PracticeAreas p
WHERE RAND() < 0.5; -- Randomly assign practice areas to lawyers

UPDATE users
SET password = '$2a$10$/n4cAJAuieAlz95eM1myw.ZEBilpGXVivrDmDWTTHhbllgj7pYwre';

-- Check if gender column exists, if not add it
ALTER TABLE users ADD COLUMN IF NOT EXISTS gender VARCHAR(10);
