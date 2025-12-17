package com.musicplatform.dao;

import com.musicplatform.model.Album;
import com.musicplatform.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AlbumDAO {

    public void createAlbum(Album album) throws SQLException {
        String sql = "INSERT INTO albums (title, artist_id, release_date, description, is_public) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, album.getTitle());
            stmt.setInt(2, album.getArtistId());
            stmt.setDate(3, album.getReleaseDate());
            stmt.setString(4, album.getDescription());
            stmt.setBoolean(5, album.isPublic());
            stmt.executeUpdate();
        }
    }

    public List<Album> getAlbumsByArtist(int artistId) throws SQLException {
        List<Album> albums = new ArrayList<>();
        String sql = "SELECT * FROM albums WHERE artist_id = ? ORDER BY release_date DESC";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, artistId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    albums.add(mapResultSetToAlbum(rs));
                }
            }
        }
        return albums;
    }

    public List<Album> getAllAlbums() throws SQLException {
        List<Album> albums = new ArrayList<>();
        String sql = "SELECT * FROM albums ORDER BY release_date DESC";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                albums.add(mapResultSetToAlbum(rs));
            }
        }
        return albums;
    }

    public Album getAlbumById(int id) throws SQLException {
        String sql = "SELECT * FROM albums WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToAlbum(rs);
                }
            }
        }
        return null;
    }

    public void updateAlbum(Album album) throws SQLException {
        String sql = "UPDATE albums SET title = ?, description = ?, release_date = ?, is_public = ? WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, album.getTitle());
            stmt.setString(2, album.getDescription());
            stmt.setDate(3, album.getReleaseDate());
            stmt.setBoolean(4, album.isPublic());
            stmt.setInt(5, album.getId());
            stmt.executeUpdate();
        }
    }

    public void deleteAlbum(int id) throws SQLException {
        String sql = "DELETE FROM albums WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    private Album mapResultSetToAlbum(ResultSet rs) throws SQLException {
        return new Album(
                rs.getInt("id"),
                rs.getString("title"),
                rs.getInt("artist_id"),
                rs.getDate("release_date"),
                rs.getString("description"),
                rs.getBoolean("is_public"),
                rs.getTimestamp("created_at"));
    }
}
