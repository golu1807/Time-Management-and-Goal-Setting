package com.timemanagement.dao;

import com.timemanagement.model.Goal;
import com.timemanagement.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class GoalDAO {
    public void addGoal(Goal goal) {
        String sql = "INSERT INTO goals (description, is_completed) VALUES (?, ?)";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setString(1, goal.getDescription());
            stmt.setBoolean(2, goal.isCompleted());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Goal> getAllGoals() {
        List<Goal> goals = new ArrayList<>();
        String sql = "SELECT * FROM goals";
        try (Connection connection = DatabaseConnection.getConnection();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                goals.add(new Goal(rs.getInt("id"), rs.getString("description"), rs.getBoolean("is_completed")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return goals;
    }

    public void completeGoal(int goalId) {
        String sql = "UPDATE goals SET is_completed = true WHERE id = ?";
        try (Connection connection = DatabaseConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.setInt(1, goalId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
