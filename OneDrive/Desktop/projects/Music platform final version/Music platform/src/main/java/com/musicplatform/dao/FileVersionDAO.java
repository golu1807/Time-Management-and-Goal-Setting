package com.musicplatform.dao;

import com.musicplatform.model.FileVersion;
import com.musicplatform.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FileVersionDAO {

    public void addFileVersion(FileVersion file) throws SQLException {
        String sql = "INSERT INTO file_versions (project_id, file_name, version_number, uploaded_by, file_path, description) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, file.getProjectId());
            stmt.setString(2, file.getFileName());
            stmt.setInt(3, file.getVersionNumber());
            stmt.setInt(4, file.getUploadedBy());
            stmt.setString(5, file.getFilePath());
            stmt.setString(6, file.getDescription());
            stmt.executeUpdate();
        }
    }

    public List<FileVersion> getFilesByProjectId(int projectId) throws SQLException {
        List<FileVersion> files = new ArrayList<>();
        String sql = "SELECT f.*, u.name as uploader_name FROM file_versions f JOIN users u ON f.uploaded_by = u.id WHERE f.project_id = ? ORDER BY f.upload_date DESC";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, projectId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    FileVersion file = new FileVersion();
                    file.setId(rs.getInt("id"));
                    file.setProjectId(rs.getInt("project_id"));
                    file.setFileName(rs.getString("file_name"));
                    file.setVersionNumber(rs.getInt("version_number"));
                    file.setUploadedBy(rs.getInt("uploaded_by"));
                    file.setUploadedByName(rs.getString("uploader_name"));
                    file.setFilePath(rs.getString("file_path"));
                    file.setDescription(rs.getString("description"));
                    file.setUploadDate(rs.getTimestamp("upload_date"));
                    files.add(file);
                }
            }
        }
        return files;
    }

    public int getNextVersionNumber(int projectId, String fileName) throws SQLException {
        String sql = "SELECT MAX(version_number) FROM file_versions WHERE project_id = ? AND file_name = ?";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, projectId);
            stmt.setString(2, fileName);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) + 1;
                }
            }
        }
        return 1;
    }
}
