CREATE TABLE motelroom.rooms (
    id INT AUTO_INCREMENT PRIMARY KEY,
    landlord_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(15, 2) NOT NULL, -- Dùng DECIMAL để tính tiền chính xác
    area DECIMAL(10, 2), -- Diện tích (m2)
    address VARCHAR(255) NOT NULL,
    district VARCHAR(100),
    province VARCHAR(100),
    status ENUM('available', 'rented', 'maintenance') DEFAULT 'available',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Khóa ngoại liên kết với Users
    FOREIGN KEY (landlord_id) REFERENCES users(id) ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;