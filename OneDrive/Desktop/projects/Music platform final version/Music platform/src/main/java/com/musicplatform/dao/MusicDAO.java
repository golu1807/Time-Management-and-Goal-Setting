package com.musicplatform.dao;

import com.musicplatform.model.Music;
import com.musicplatform.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MusicDAO {

    public void createMusic(Music music) throws SQLException {
        String sql = "INSERT INTO music (title, artist, album, genre, file_path, artist_id, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, music.getTitle());
            stmt.setString(2, music.getArtist());
            stmt.setString(3, music.getAlbum());
            stmt.setString(4, music.getGenre());
            stmt.setString(5, music.getFilePath());
            stmt.setInt(6, music.getArtistId());
            stmt.setString(7, music.getStatus());
            stmt.executeUpdate();
        }
    }

    public Music getMusicById(int id) throws SQLException {
        String sql = "SELECT * FROM music WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Music(rs.getInt("id"), rs.getString("title"), rs.getString("artist"),
                        rs.getString("album"), rs.getString("genre"), rs.getString("file_path"),
                        rs.getInt("artist_id"), rs.getString("status"));
            }
        }
        return null;
    }

    public List<Music> getAllMusic() throws SQLException {
        List<Music> musicList = new ArrayList<>();
        String sql = "SELECT * FROM music WHERE status = 'APPROVED'";
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                musicList.add(new Music(rs.getInt("id"), rs.getString("title"), rs.getString("artist"),
                        rs.getString("album"), rs.getString("genre"), rs.getString("file_path"),
                        rs.getInt("artist_id"), rs.getString("status")));
            }
        }
        return musicList;
    }

    public List<Music> getMusicByArtist(int artistId) throws SQLException {
        List<Music> musicList = new ArrayList<>();
        String sql = "SELECT * FROM music WHERE artist_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, artistId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                musicList.add(new Music(rs.getInt("id"), rs.getString("title"), rs.getString("artist"),
                        rs.getString("album"), rs.getString("genre"), rs.getString("file_path"),
                        rs.getInt("artist_id"), rs.getString("status")));
            }
        }
        return musicList;
    }

    public void updateMusic(Music music) throws SQLException {
        String sql = "UPDATE music SET title = ?, album = ?, genre = ?, status = ? WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, music.getTitle());
            stmt.setString(2, music.getAlbum());
            stmt.setString(3, music.getGenre());
            stmt.setString(4, music.getStatus());
            stmt.setInt(5, music.getId());
            stmt.executeUpdate();
        }
    }

    public void deleteMusic(int id) throws SQLException {
        String sql = "DELETE FROM music WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }
}
