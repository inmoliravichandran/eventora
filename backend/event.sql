CREATE DATABASE IF NOT EXISTS eventora_db;
USE eventora_db;

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    role VARCHAR(50) DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Events/Services table
CREATE TABLE IF NOT EXISTS services (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2),
    description TEXT,
    image_url VARCHAR(500),
    rating DECIMAL(3,2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bookings table
CREATE TABLE IF NOT EXISTS bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    service_id INT,
    event_date DATE,
    guests INT,
    total_price DECIMAL(10,2),
    status VARCHAR(50) DEFAULT 'pending',
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (service_id) REFERENCES services(id)
);

-- Cart table
CREATE TABLE IF NOT EXISTS cart (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    service_id INT,
    quantity INT DEFAULT 1,
    added_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (service_id) REFERENCES services(id)
);

-- Insert sample services
INSERT INTO services (name, category, price, description, rating) VALUES
('Premium Wedding Package', 'wedding', 150000, 'Complete wedding arrangement including venue decoration, catering for 100 guests, photography, and coordination.', 4.8),
('Ultimate Birthday Package', 'birthday', 75000, 'Theme decorations, catering, custom cake, entertainment, and party favors.', 4.9),
('Corporate Gala Package', 'corporate', 250000, 'Full event management including venue, AV equipment, catering, and professional hosting.', 4.7),
('Premium Photography', 'photography', 45000, 'Professional photography with 2 photographers, 8 hours coverage, edited photos.', 4.9);