package com.musicplatform.dao;

import com.musicplatform.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LikeDAO {

    public void likeSong(int userId, int musicId) throws SQLException {
        String sql = "INSERT INTO likes (user_id, music_id) VALUES (?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, musicId);
            stmt.executeUpdate();
        }
    }

    public void unlikeSong(int userId, int musicId) throws SQLException {
        String sql = "DELETE FROM likes WHERE user_id = ? AND music_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, musicId);
            stmt.executeUpdate();
        }
    }

    public boolean isLiked(int userId, int musicId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM likes WHERE user_id = ? AND music_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, musicId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }
        return false;
    }

    public int getLikeCount(int musicId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM likes WHERE music_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, musicId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }
}
