USE music_platform;

ALTER TABLE albums ADD COLUMN is_public BOOLEAN DEFAULT FALSE;
