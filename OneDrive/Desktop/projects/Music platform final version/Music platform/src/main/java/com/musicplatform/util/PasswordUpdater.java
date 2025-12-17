package com.musicplatform.util;

import at.favre.lib.crypto.bcrypt.BCrypt;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class PasswordUpdater {
    public static void main(String[] args) {
        updatePassword("admin@music.com", "admin123");
        updatePassword("artist1@music.com", "artist123");
        updatePassword("listener1@music.com", "listener123");
        updatePassword("testuser@music.com", "test123");
    }

    private static void updatePassword(String email, String plainPassword) {
        String hashedPassword = BCrypt.withDefaults().hashToString(12, plainPassword.toCharArray());
        String sql = "UPDATE users SET password = ? WHERE email = ?";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, hashedPassword);
            stmt.setString(2, email);
            int rows = stmt.executeUpdate();
            System.out.println("Updated password for " + email + ": " + (rows > 0 ? "SUCCESS" : "USER NOT FOUND"));
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
