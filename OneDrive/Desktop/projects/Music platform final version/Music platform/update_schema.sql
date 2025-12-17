USE music_platform;

-- Projects table
CREATE TABLE IF NOT EXISTS projects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    deadline DATE,
    status ENUM('PLANNING', 'IN_PROGRESS', 'COMPLETED', 'ARCHIVED') DEFAULT 'PLANNING',
    created_by INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE CASCADE
);

-- Project Collaborators table
CREATE TABLE IF NOT EXISTS project_collaborators (
    project_id INT NOT NULL,
    user_id INT NOT NULL,
    role VARCHAR(100) DEFAULT 'Collaborator',
    joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (project_id, user_id),
    FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- System Settings table
CREATE TABLE IF NOT EXISTS system_settings (
    setting_key VARCHAR(100) PRIMARY KEY,
    setting_value TEXT,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Albums table
CREATE TABLE IF NOT EXISTS albums (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    artist_id INT NOT NULL,
    release_date DATE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (artist_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Add album_id to music table if it doesn't exist
-- Note: This might fail if column exists, but safe to run if not. 
-- For safety in this script, we'll try to add it. If it fails, it fails (or we can check).
-- simpler to just run the ALTER and ignore error if it exists, or use a stored procedure, but for this env, just running it is fine.
-- However, to avoid error stopping script, I'll put it at the end.

ALTER TABLE music ADD COLUMN album_id INT;
ALTER TABLE music ADD CONSTRAINT fk_music_album FOREIGN KEY (album_id) REFERENCES albums(id) ON DELETE SET NULL;
