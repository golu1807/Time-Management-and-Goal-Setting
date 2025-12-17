package com.musicplatform.dao;

import com.musicplatform.model.ListeningHistory;
import com.musicplatform.model.Music;
import com.musicplatform.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ListeningHistoryDAO {

    public void addListeningHistory(int userId, int musicId) throws SQLException {
        String sql = "INSERT INTO listening_history (user_id, music_id) VALUES (?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, musicId);
            stmt.executeUpdate();
        }
    }

    public List<Music> getListeningHistory(int userId) throws SQLException {
        List<Music> history = new ArrayList<>();
        String sql = "SELECT m.* FROM music m JOIN listening_history lh ON m.id = lh.music_id WHERE lh.user_id = ? ORDER BY lh.played_at DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                history.add(new Music(rs.getInt("id"), rs.getString("title"), rs.getString("artist"),
                        rs.getString("album"), rs.getString("genre"), rs.getString("file_path"),
                        rs.getInt("artist_id"), rs.getString("status")));
            }
        }
        return history;
    }
}
