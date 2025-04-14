-- Create the LawLink database
CREATE DATABASE IF NOT EXISTS LawLink;
USE LawLink;

-- Create Admins table
CREATE TABLE IF NOT EXISTS Admins (
                                      admin_id INT AUTO_INCREMENT PRIMARY KEY,
                                      username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    last_login TIMESTAMP NULL,
    is_active BOOLEAN DEFAULT TRUE,
    profile_image VARCHAR(255)
    );

-- Create Lawyers table
CREATE TABLE IF NOT EXISTS Lawyers (
                                       lawyer_id INT AUTO_INCREMENT PRIMARY KEY,
                                       admin_id INT,
                                       username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP NULL,
    is_active BOOLEAN DEFAULT TRUE,
    profile_image VARCHAR(255),
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
    FOREIGN KEY (admin_id) REFERENCES Admins(admin_id)
    );

-- Create Clients table
CREATE TABLE IF NOT EXISTS Clients (
                                       client_id INT AUTO_INCREMENT PRIMARY KEY,
                                       username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP NULL,
    is_active BOOLEAN DEFAULT TRUE,
    profile_image VARCHAR(255),
    date_of_birth DATE,
    gender ENUM('MALE', 'FEMALE', 'OTHER')
    );

-- Create LawyerAvailability table to track days when a lawyer is NOT available
-- By default, lawyers are available every day of the week
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
                                            duration INT NOT NULL DEFAULT 60, -- in minutes
                                            status ENUM('PENDING', 'CONFIRMED', 'COMPLETED', 'CANCELLED') DEFAULT 'PENDING',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (lawyer_id) REFERENCES Lawyers(lawyer_id) ON DELETE CASCADE,
    FOREIGN KEY (client_id) REFERENCES Clients(client_id) ON DELETE CASCADE,
    -- Add a unique constraint to prevent double booking
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

-- Create PracticeAreas table for standardized practice areas
CREATE TABLE IF NOT EXISTS PracticeAreas (
                                             area_id INT AUTO_INCREMENT PRIMARY KEY,
                                             area_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
    );

-- Create LawyerPracticeAreas junction table
CREATE TABLE IF NOT EXISTS LawyerPracticeAreas (
                                                   lawyer_id INT NOT NULL,
                                                   area_id INT NOT NULL,
                                                   PRIMARY KEY (lawyer_id, area_id),
    FOREIGN KEY (lawyer_id) REFERENCES Lawyers(lawyer_id) ON DELETE CASCADE,
    FOREIGN KEY (area_id) REFERENCES PracticeAreas(area_id) ON DELETE CASCADE
    );

-- Insert default admin
INSERT INTO Admins (username, password, email, full_name)
VALUES ('admin', 'admin123', 'admin@lawlink.com', 'System Administrator');

-- Insert practice areas
INSERT INTO PracticeAreas (area_name, description) VALUES
                                                       ('Property Law', 'Legal matters related to real estate, property rights, and transactions'),
                                                       ('Family Law', 'Legal issues related to family relationships, divorce, child custody, etc.'),
                                                       ('Criminal Law', 'Legal defense and prosecution for criminal offenses'),
                                                       ('Corporate Law', 'Legal services for businesses, corporations, and commercial entities'),
                                                       ('Labor Law', 'Legal matters related to employment, workplace rights, and regulations'),
                                                       ('International Law', 'Legal issues crossing international boundaries and jurisdictions');

-- Trigger to create default availability for new lawyers
DELIMITER //
CREATE TRIGGER after_lawyer_insert
    AFTER INSERT ON Lawyers
    FOR EACH ROW
BEGIN
    -- Insert default availability for all days of the week (all available by default)
    INSERT INTO LawyerAvailability (lawyer_id, day_of_week, is_available)
    VALUES
        (NEW.lawyer_id, 'MONDAY', TRUE),
        (NEW.lawyer_id, 'TUESDAY', TRUE),
        (NEW.lawyer_id, 'WEDNESDAY', TRUE),
        (NEW.lawyer_id, 'THURSDAY', TRUE),
        (NEW.lawyer_id, 'FRIDAY', TRUE),
        (NEW.lawyer_id, 'SATURDAY', TRUE),
        (NEW.lawyer_id, 'SUNDAY', TRUE);
END //
DELIMITER ;
