-- Enhanced User Roles and Moderation System
-- Run this script to add moderation capabilities to the platform

-- Step 1: Add new columns to users table
ALTER TABLE users ADD COLUMN IF NOT EXISTS role ENUM('LISTENER', 'ARTIST', 'MODERATOR', 'ADMIN') DEFAULT 'ARTIST';
ALTER TABLE users ADD COLUMN IF NOT EXISTS is_verified BOOLEAN DEFAULT FALSE;
ALTER TABLE users ADD COLUMN IF NOT EXISTS moderation_score INT DEFAULT 100;
ALTER TABLE users ADD COLUMN IF NOT EXISTS account_status ENUM('ACTIVE', 'SUSPENDED', 'BANNED') DEFAULT 'ACTIVE';
ALTER TABLE users ADD COLUMN IF NOT EXISTS suspension_until DATETIME NULL;
ALTER TABLE users ADD COLUMN IF NOT EXISTS ban_reason TEXT NULL;

-- Step 2: Content Reports Table
CREATE TABLE IF NOT EXISTS content_reports (
    report_id INT PRIMARY KEY AUTO_INCREMENT,
    content_type ENUM('TRACK', 'COMMENT', 'MESSAGE', 'POST', 'PROJECT') NOT NULL,
    content_id INT NOT NULL,
    reporter_id INT NOT NULL,
    reason ENUM('SPAM', 'INAPPROPRIATE', 'COPYRIGHT', 'HARASSMENT', 'HATE_SPEECH', 'OTHER') NOT NULL,
    description TEXT,
    status ENUM('PENDING', 'UNDER_REVIEW', 'RESOLVED', 'DISMISSED') DEFAULT 'PENDING',
    priority ENUM('LOW', 'MEDIUM', 'HIGH', 'URGENT') DEFAULT 'MEDIUM',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    reviewed_at TIMESTAMP NULL,
    reviewed_by INT NULL,
    resolution_notes TEXT NULL,
    FOREIGN KEY (reporter_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (reviewed_by) REFERENCES users(user_id) ON DELETE SET NULL,
    INDEX idx_status (status),
    INDEX idx_content (content_type, content_id),
    INDEX idx_reporter (reporter_id),
    INDEX idx_created (created_at)
);

-- Step 3: Moderation Actions Log
CREATE TABLE IF NOT EXISTS moderation_actions (
    action_id INT PRIMARY KEY AUTO_INCREMENT,
    moderator_id INT NOT NULL,
    target_user_id INT NULL,
    target_content_id INT NULL,
    content_type VARCHAR(50) NULL,
    action_type ENUM('WARN', 'SUSPEND', 'BAN', 'DELETE_CONTENT', 'APPROVE', 'RESTORE', 'UNBAN') NOT NULL,
    reason TEXT NOT NULL,
    duration_days INT NULL COMMENT 'For suspensions',
    action_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    notes TEXT NULL,
    FOREIGN KEY (moderator_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (target_user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_moderator (moderator_id),
    INDEX idx_target_user (target_user_id),
    INDEX idx_action_date (action_date)
);

-- Step 4: Content Approval Queue
CREATE TABLE IF NOT EXISTS content_approval (
    approval_id INT PRIMARY KEY AUTO_INCREMENT,
    content_type ENUM('TRACK', 'ALBUM', 'POST') NOT NULL,
    content_id INT NOT NULL,
    uploader_id INT NOT NULL,
    status ENUM('PENDING', 'APPROVED', 'REJECTED') DEFAULT 'PENDING',
    reviewed_by INT NULL,
    reviewed_at TIMESTAMP NULL,
    rejection_reason TEXT NULL,
    auto_approved BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (uploader_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (reviewed_by) REFERENCES users(user_id) ON DELETE SET NULL,
    INDEX idx_status (status),
    INDEX idx_uploader (uploader_id),
    INDEX idx_content (content_type, content_id)
);

-- Step 5: Blocked Users Table (for user blocking feature)
CREATE TABLE IF NOT EXISTS blocked_users (
    block_id INT PRIMARY KEY AUTO_INCREMENT,
    blocker_id INT NOT NULL,
    blocked_id INT NOT NULL,
    blocked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    reason VARCHAR(255) NULL,
    FOREIGN KEY (blocker_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (blocked_id) REFERENCES users(user_id) ON DELETE CASCADE,
    UNIQUE KEY unique_block (blocker_id, blocked_id),
    INDEX idx_blocker (blocker_id),
    INDEX idx_blocked (blocked_id)
);

-- Step 6: Spam Filter Patterns (for automated detection)
CREATE TABLE IF NOT EXISTS spam_patterns (
    pattern_id INT PRIMARY KEY AUTO_INCREMENT,
    pattern_text VARCHAR(255) NOT NULL,
    pattern_type ENUM('KEYWORD', 'REGEX', 'URL_PATTERN') DEFAULT 'KEYWORD',
    severity ENUM('LOW', 'MEDIUM', 'HIGH') DEFAULT 'MEDIUM',
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by INT,
    FOREIGN KEY (created_by) REFERENCES users(user_id) ON DELETE SET NULL
);

-- Step 7: User Warnings Table
CREATE TABLE IF NOT EXISTS user_warnings (
    warning_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    issued_by INT NOT NULL,
    warning_type ENUM('SPAM', 'INAPPROPRIATE_CONTENT', 'HARASSMENT', 'POLICY_VIOLATION', 'OTHER') NOT NULL,
    message TEXT NOT NULL,
    severity ENUM('MINOR', 'MAJOR', 'SEVERE') DEFAULT 'MINOR',
    issued_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    acknowledged BOOLEAN DEFAULT FALSE,
    acknowledged_at TIMESTAMP NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (issued_by) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_user (user_id),
    INDEX idx_issued_at (issued_at)
);

-- Step 8: Insert default spam patterns
INSERT INTO spam_patterns (pattern_text, pattern_type, severity) VALUES
('viagra', 'KEYWORD', 'HIGH'),
('cialis', 'KEYWORD', 'HIGH'),
('casino', 'KEYWORD', 'MEDIUM'),
('lottery', 'KEYWORD', 'MEDIUM'),
('click here now', 'KEYWORD', 'LOW'),
('limited time offer', 'KEYWORD', 'LOW');

-- Step 9: Create admin user (if not exists)
UPDATE users SET role = 'ADMIN', is_verified = TRUE WHERE email = 'admin@collabbeats.com';

-- Step 10: Grant moderator role to specific users (example)
-- UPDATE users SET role = 'MODERATOR', is_verified = TRUE WHERE user_id = <specific_user_id>;

COMMIT;
