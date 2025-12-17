package com.musicplatform.dao;

import com.musicplatform.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FollowDAO {

    public void followArtist(int listenerId, int artistId) throws SQLException {
        String sql = "INSERT INTO followers (listener_id, artist_id) VALUES (?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, listenerId);
            stmt.setInt(2, artistId);
            stmt.executeUpdate();
        }
    }

    public void unfollowArtist(int listenerId, int artistId) throws SQLException {
        String sql = "DELETE FROM followers WHERE listener_id = ? AND artist_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, listenerId);
            stmt.setInt(2, artistId);
            stmt.executeUpdate();
        }
    }

    public boolean isFollowing(int listenerId, int artistId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM followers WHERE listener_id = ? AND artist_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, listenerId);
            stmt.setInt(2, artistId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }
        return false;
    }

    public List<Integer> getFollowedArtists(int listenerId) throws SQLException {
        List<Integer> followedArtists = new ArrayList<>();
        String sql = "SELECT artist_id FROM followers WHERE listener_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, listenerId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                followedArtists.add(rs.getInt("artist_id"));
            }
        }
        return followedArtists;
    }

    public int getFollowerCount(int artistId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM followers WHERE artist_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, artistId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }
}
