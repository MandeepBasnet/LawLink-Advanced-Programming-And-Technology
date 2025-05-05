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

-- Check if gender column exists, if not add it
ALTER TABLE Users ADD COLUMN gender VARCHAR(10);

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
                                                                                     ('admin', '$2a$10$ICaBQFSL3IK5no59ZcmLo..CgrsXynJ5UTq5YmBS7HfxpT8S8tHfO', 'admin@lawlink.com', 'System Administrator', '+977-9812345678', 'ADMIN', true),
                                                                                     ('admin2', '$2a$10$ICaBQFSL3IK5no59ZcmLo..CgrsXynJ5UTq5YmBS7HfxpT8S8tHfO', 'admin2@lawlink.com', 'Assistant Administrator', '+977-9812345679', 'ADMIN', true);

-- Insert admin records into Admins table
INSERT INTO Admins (admin_id)
SELECT user_id FROM Users WHERE role = 'ADMIN';

-- Insert lawyers (password: admin123)
INSERT INTO Users (username, password, email, full_name, phone, address, role, profile_image, is_active) VALUES
                                                                                                             ('zaina.raj', '$2a$10$ICaBQFSL3IK5no59ZcmLo..CgrsXynJ5UTq5YmBS7HfxpT8S8tHfO', 'zaina.raj@lawlink.com', 'Zaina Raj', '+977-9086706541', 'Itahari', 'LAWYER', 'zaina.png', true),
                                                                                                             ('rayan.rajbangsi', '$2a$10$ICaBQFSL3IK5no59ZcmLo..CgrsXynJ5UTq5YmBS7HfxpT8S8tHfO', 'rayan.rajbangsi@lawlink.com', 'Rayan Rajbangsi', '+977-9705523049', 'Itahari', 'LAWYER', 'rayan.png', true),
                                                                                                             ('manish.khanal', '$2a$10$ICaBQFSL3IK5no59ZcmLo..CgrsXynJ5UTq5YmBS7HfxpT8S8tHfO', 'manish.khanal@lawlink.com', 'MANISH KHANAL', '+977-9812395010', 'Kathmandu', 'LAWYER', 'manish.png', true),
                                                                                                             ('baviyan.koirala', '$2a$10$ICaBQFSL3IK5no59ZcmLo..CgrsXynJ5UTq5YmBS7HfxpT8S8tHfO', 'baviyan.koirala@lawlink.com', 'Baviyan Koirala', '+977-9867063791', 'Itahari', 'LAWYER', 'baviyan.png', true),
                                                                                                             ('lalita.puri', '$2a$10$ICaBQFSL3IK5no59ZcmLo..CgrsXynJ5UTq5YmBS7HfxpT8S8tHfO', 'lalita.puri@lawlink.com', 'Lalita Puri', '+977-9706146926', 'Biratnagar', 'LAWYER', 'lalita.png', true),
                                                                                                             ('ashutosh.srivastava', '$2a$10$ICaBQFSL3IK5no59ZcmLo..CgrsXynJ5UTq5YmBS7HfxpT8S8tHfO', 'ashutosh.srivastava@lawlink.com', 'Ashutosh Srivastava', '+977-9823543129', 'Morang', 'LAWYER', 'ashutosh.png', true),
                                                                                                             ('yusha.shrestha', '$2a$10$ICaBQFSL3IK5no59ZcmLo..CgrsXynJ5UTq5YmBS7HfxpT8S8tHfO', 'yusha.shrestha@lawlink.com', 'Yusha Shrestha', '+977-9703304911', 'Tarahara', 'LAWYER', 'yusha.png', true),
                                                                                                             ('anish.basnet', '$2a$10$ICaBQFSL3IK5no59ZcmLo..CgrsXynJ5UTq5YmBS7HfxpT8S8tHfO', 'anish.basnet@lawlink.com', 'Anish Basnet', '+977-9708203041', 'Jhapa', 'LAWYER', 'anish.png', true),
                                                                                                             ('susasa.acharya', '$2a$10$ICaBQFSL3IK5no59ZcmLo..CgrsXynJ5UTq5YmBS7HfxpT8S8tHfO', 'susasa.acharya@lawlink.com', 'SUSASA ACHARYA', '+977-9703129941', 'Biratnagar', 'LAWYER', 'susasa.png', true);

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
                                                                                                             ('john.doe', '$2a$10$ICaBQFSL3IK5no59ZcmLo..CgrsXynJ5UTq5YmBS7HfxpT8S8tHfO', 'john.doe@example.com', 'John Doe', '+977-9812345670', 'Kathmandu', 'CLIENT', 'john.png', true),
                                                                                                             ('jane.smith', '$2a$10$ICaBQFSL3IK5no59ZcmLo..CgrsXynJ5UTq5YmBS7HfxpT8S8tHfO', 'jane.smith@example.com', 'Jane Smith', '+977-9812345671', 'Pokhara', 'CLIENT', 'jane.jpg', true),
                                                                                                             ('robert.wilson', '$2a$10$ICaBQFSL3IK5no59ZcmLo..CgrsXynJ5UTq5YmBS7HfxpT8S8tHfO', 'robert.wilson@example.com', 'Robert Wilson', '+977-9812345672', 'Lalitpur', 'CLIENT', 'robert.jpg', true),
                                                                                                             ('sarah.johnson', '$2a$10$ICaBQFSL3IK5no59ZcmLo..CgrsXynJ5UTq5YmBS7HfxpT8S8tHfO', 'sarah.johnson@example.com', 'Sarah Johnson', '+977-9812345673', 'Bhaktapur', 'CLIENT', 'sarah.jpg', true),
                                                                                                             ('michael.brown', '$2a$10$ICaBQFSL3IK5no59ZcmLo..CgrsXynJ5UTq5YmBS7HfxpT8S8tHfO', 'michael.brown@example.com', 'Michael Brown', '+977-9812345674', 'Dharan', 'CLIENT', 'michael.jpg', true);

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

-- Insert deterministic appointments for multiple lawyers
INSERT INTO Appointments (lawyer_id, client_id, appointment_date, appointment_time, duration, status, notes)
VALUES
    -- Zaina Raj (Property Law)
    ((SELECT user_id FROM Users WHERE username = 'zaina.raj'), (SELECT user_id FROM Users WHERE username = 'john.doe'), '2025-05-01', '09:00:00', 60, 'COMPLETED', 'Property dispute consultation'),
    ((SELECT user_id FROM Users WHERE username = 'zaina.raj'), (SELECT user_id FROM Users WHERE username = 'jane.smith'), '2025-05-01', '10:00:00', 60, 'COMPLETED', 'Land ownership issue'),
    ((SELECT user_id FROM Users WHERE username = 'zaina.raj'), (SELECT user_id FROM Users WHERE username = 'robert.wilson'), '2025-05-02', '11:00:00', 60, 'COMPLETED', 'Real estate contract review'),
    ((SELECT user_id FROM Users WHERE username = 'zaina.raj'), (SELECT user_id FROM Users WHERE username = 'sarah.johnson'), '2025-05-02', '12:00:00', 60, 'COMPLETED', 'Property transfer advice'),
    ((SELECT user_id FROM Users WHERE username = 'zaina.raj'), (SELECT user_id FROM Users WHERE username = 'michael.brown'), '2025-05-03', '09:00:00', 60, 'PENDING', 'Upcoming property consultation'),

    -- Rayan Rajbangsi (Criminal Law)
    ((SELECT user_id FROM Users WHERE username = 'rayan.rajbangsi'), (SELECT user_id FROM Users WHERE username = 'jane.smith'), '2025-05-01', '11:00:00', 60, 'COMPLETED', 'Criminal defense consultation'),
    ((SELECT user_id FROM Users WHERE username = 'rayan.rajbangsi'), (SELECT user_id FROM Users WHERE username = 'robert.wilson'), '2025-05-01', '12:00:00', 60, 'COMPLETED', 'Bail hearing preparation'),
    ((SELECT user_id FROM Users WHERE username = 'rayan.rajbangsi'), (SELECT user_id FROM Users WHERE username = 'sarah.johnson'), '2025-05-02', '09:00:00', 60, 'COMPLETED', 'Case review for charges'),
    ((SELECT user_id FROM Users WHERE username = 'rayan.rajbangsi'), (SELECT user_id FROM Users WHERE username = 'michael.brown'), '2025-05-02', '10:00:00', 60, 'COMPLETED', 'Plea bargain discussion'),
    ((SELECT user_id FROM Users WHERE username = 'rayan.rajbangsi'), (SELECT user_id FROM Users WHERE username = 'john.doe'), '2025-05-03', '11:00:00', 60, 'CONFIRMED', 'Defense strategy meeting'),

    -- Manish Khanal (Family Law)
    ((SELECT user_id FROM Users WHERE username = 'manish.khanal'), (SELECT user_id FROM Users WHERE username = 'robert.wilson'), '2025-05-01', '13:00:00', 60, 'COMPLETED', 'Divorce consultation'),
    ((SELECT user_id FROM Users WHERE username = 'manish.khanal'), (SELECT user_id FROM Users WHERE username = 'sarah.johnson'), '2025-05-01', '14:00:00', 60, 'COMPLETED', 'Child custody discussion'),
    ((SELECT user_id FROM Users WHERE username = 'manish.khanal'), (SELECT user_id FROM Users WHERE username = 'michael.brown'), '2025-05-02', '13:00:00', 60, 'COMPLETED', 'Alimony agreement review'),
    ((SELECT user_id FROM Users WHERE username = 'manish.khanal'), (SELECT user_id FROM Users WHERE username = 'john.doe'), '2025-05-02', '14:00:00', 60, 'COMPLETED', 'Prenuptial agreement advice'),
    ((SELECT user_id FROM Users WHERE username = 'manish.khanal'), (SELECT user_id FROM Users WHERE username = 'jane.smith'), '2025-05-03', '12:00:00', 60, 'PENDING', 'Family dispute mediation'),

    -- Baviyan Koirala (Corporate Law)
    ((SELECT user_id FROM Users WHERE username = 'baviyan.koirala'), (SELECT user_id FROM Users WHERE username = 'sarah.johnson'), '2025-05-01', '15:00:00', 60, 'COMPLETED', 'Business contract review'),
    ((SELECT user_id FROM Users WHERE username = 'baviyan.koirala'), (SELECT user_id FROM Users WHERE username = 'michael.brown'), '2025-05-01', '16:00:00', 60, 'COMPLETED', 'Corporate merger advice'),
    ((SELECT user_id FROM Users WHERE username = 'baviyan.koirala'), (SELECT user_id FROM Users WHERE username = 'john.doe'), '2025-05-02', '15:00:00', 60, 'COMPLETED', 'Startup legal consultation'),
    ((SELECT user_id FROM Users WHERE username = 'baviyan.koirala'), (SELECT user_id FROM Users WHERE username = 'jane.smith'), '2025-05-02', '16:00:00', 60, 'COMPLETED', 'Trademark registration'),
    ((SELECT user_id FROM Users WHERE username = 'baviyan.koirala'), (SELECT user_id FROM Users WHERE username = 'robert.wilson'), '2025-05-03', '13:00:00', 60, 'CONFIRMED', 'Corporate compliance review'),

    -- Lalita Puri (International Law)
    ((SELECT user_id FROM Users WHERE username = 'lalita.puri'), (SELECT user_id FROM Users WHERE username = 'michael.brown'), '2025-05-01', '09:00:00', 60, 'COMPLETED', 'International trade consultation'),
    ((SELECT user_id FROM Users WHERE username = 'lalita.puri'), (SELECT user_id FROM Users WHERE username = 'john.doe'), '2025-05-01', '10:00:00', 60, 'COMPLETED', 'Visa application advice'),
    ((SELECT user_id FROM Users WHERE username = 'lalita.puri'), (SELECT user_id FROM Users WHERE username = 'jane.smith'), '2025-05-02', '09:00:00', 60, 'COMPLETED', 'Cross-border dispute resolution'),
    ((SELECT user_id FROM Users WHERE username = 'lalita.puri'), (SELECT user_id FROM Users WHERE username = 'robert.wilson'), '2025-05-02', '10:00:00', 60, 'COMPLETED', 'International contract review'),
    ((SELECT user_id FROM Users WHERE username = 'lalita.puri'), (SELECT user_id FROM Users WHERE username = 'sarah.johnson'), '2025-05-03', '14:00:00', 60, 'CANCELLED', 'Cancelled international consultation'),

    -- Ashutosh Srivastava (Labour Law)
    ((SELECT user_id FROM Users WHERE username = 'ashutosh.srivastava'), (SELECT user_id FROM Users WHERE username = 'john.doe'), '2025-05-01', '11:00:00', 60, 'COMPLETED', 'Workplace dispute consultation'),
    ((SELECT user_id FROM Users WHERE username = 'ashutosh.srivastava'), (SELECT user_id FROM Users WHERE username = 'jane.smith'), '2025-05-01', '12:00:00', 60, 'COMPLETED', 'Employment contract review'),
    ((SELECT user_id FROM Users WHERE username = 'ashutosh.srivastava'), (SELECT user_id FROM Users WHERE username = 'robert.wilson'), '2025-05-02', '11:00:00', 60, 'COMPLETED', 'Labor law compliance advice'),
    ((SELECT user_id FROM Users WHERE username = 'ashutosh.srivastava'), (SELECT user_id FROM Users WHERE username = 'sarah.johnson'), '2025-05-02', '12:00:00', 60, 'PENDING', 'Upcoming labor dispute consultation'),
    ((SELECT user_id FROM Users WHERE username = 'ashutosh.srivastava'), (SELECT user_id FROM Users WHERE username = 'michael.brown'), '2025-05-03', '15:00:00', 60, 'CANCELLED', 'Cancelled termination advice');

-- Insert reviews for all COMPLETED appointments
INSERT INTO Reviews (appointment_id, rating, comment)
SELECT
    a.appointment_id,
    CASE
        WHEN a.appointment_id % 5 = 1 THEN 5
        WHEN a.appointment_id % 5 = 2 THEN 4
        WHEN a.appointment_id % 5 = 3 THEN 3
        WHEN a.appointment_id % 5 = 4 THEN 4
        ELSE 5
        END as rating,
    CASE
        WHEN a.appointment_id % 5 = 1 THEN 'Excellent service, highly professional and thorough.'
        WHEN a.appointment_id % 5 = 2 THEN 'Very helpful, addressed all my concerns effectively.'
        WHEN a.appointment_id % 5 = 3 THEN 'Good experience, but could be more detailed.'
        WHEN a.appointment_id % 5 = 4 THEN 'Satisfactory consultation, met my expectations.'
        ELSE 'Outstanding support, exceeded my expectations.'
        END as comment
FROM Appointments a
WHERE a.status = 'COMPLETED';

-- Insert lawyer practice areas
INSERT INTO LawyerPracticeAreas (lawyer_id, area_id)
SELECT l.lawyer_id, p.area_id
FROM Lawyers l
         CROSS JOIN PracticeAreas p
WHERE RAND() < 0.5; -- Randomly assign practice areas to lawyers