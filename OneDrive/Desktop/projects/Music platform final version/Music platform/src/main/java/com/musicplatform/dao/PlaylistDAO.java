package com.musicplatform.dao;

import com.musicplatform.model.Music;
import com.musicplatform.model.Playlist;
import com.musicplatform.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PlaylistDAO {

    public void createPlaylist(Playlist playlist) throws SQLException {
        String sql = "INSERT INTO playlists (title, user_id) VALUES (?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, playlist.getTitle());
            stmt.setInt(2, playlist.getUserId());
            stmt.executeUpdate();
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                playlist.setId(rs.getInt(1));
            }
        }
    }

    public Playlist getPlaylistById(int id) throws SQLException {
        String sql = "SELECT * FROM playlists WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Playlist playlist = new Playlist(rs.getInt("id"), rs.getString("title"), rs.getInt("user_id"), null);
                playlist.setSongs(getSongsInPlaylist(id));
                return playlist;
            }
        }
        return null;
    }

    public List<Playlist> getPlaylistsByUser(int userId) throws SQLException {
        List<Playlist> playlists = new ArrayList<>();
        String sql = "SELECT * FROM playlists WHERE user_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Playlist playlist = new Playlist(rs.getInt("id"), rs.getString("title"), rs.getInt("user_id"), null);
                playlist.setSongs(getSongsInPlaylist(rs.getInt("id")));
                playlists.add(playlist);
            }
        }
        return playlists;
    }

    public void addSongToPlaylist(int playlistId, int musicId) throws SQLException {
        String sql = "INSERT INTO playlist_songs (playlist_id, music_id) VALUES (?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, playlistId);
            stmt.setInt(2, musicId);
            stmt.executeUpdate();
        }
    }

    public void removeSongFromPlaylist(int playlistId, int musicId) throws SQLException {
        String sql = "DELETE FROM playlist_songs WHERE playlist_id = ? AND music_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, playlistId);
            stmt.setInt(2, musicId);
            stmt.executeUpdate();
        }
    }

    private List<Music> getSongsInPlaylist(int playlistId) throws SQLException {
        List<Music> songs = new ArrayList<>();
        String sql = "SELECT m.* FROM music m JOIN playlist_songs ps ON m.id = ps.music_id WHERE ps.playlist_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, playlistId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                songs.add(new Music(rs.getInt("id"), rs.getString("title"), rs.getString("artist"),
                        rs.getString("album"), rs.getString("genre"), rs.getString("file_path"),
                        rs.getInt("artist_id"), rs.getString("status")));
            }
        }
        return songs;
    }

    public void deletePlaylist(int id) throws SQLException {
        String sql1 = "DELETE FROM playlist_songs WHERE playlist_id = ?";
        String sql2 = "DELETE FROM playlists WHERE id = ?";
        Connection conn = null;
        try {
            conn = DBUtil.getConnection();
            conn.setAutoCommit(false);
            try (PreparedStatement stmt1 = conn.prepareStatement(sql1)) {
                stmt1.setInt(1, id);
                stmt1.executeUpdate();
            }
            try (PreparedStatement stmt2 = conn.prepareStatement(sql2)) {
                stmt2.setInt(1, id);
                stmt2.executeUpdate();
            }
            conn.commit();
        } catch (SQLException e) {
            if (conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
        }
    }
}
