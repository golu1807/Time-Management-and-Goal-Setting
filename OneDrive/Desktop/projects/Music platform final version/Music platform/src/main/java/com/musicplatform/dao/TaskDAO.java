package com.musicplatform.dao;

import com.musicplatform.model.Task;
import com.musicplatform.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TaskDAO {

    public void createTask(Task task) throws SQLException {
        String sql = "INSERT INTO tasks (project_id, title, description, status, assigned_to, due_date) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, task.getProjectId());
            stmt.setString(2, task.getTitle());
            stmt.setString(3, task.getDescription());
            stmt.setString(4, task.getStatus());
            if (task.getAssignedTo() > 0)
                stmt.setInt(5, task.getAssignedTo());
            else
                stmt.setNull(5, Types.INTEGER);
            stmt.setDate(6, task.getDueDate());
            stmt.executeUpdate();
        }
    }

    public List<Task> getTasksByProjectId(int projectId) throws SQLException {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT t.*, u.name as assigned_name FROM tasks t LEFT JOIN users u ON t.assigned_to = u.id WHERE t.project_id = ? ORDER BY t.created_at DESC";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, projectId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Task task = new Task();
                    task.setId(rs.getInt("id"));
                    task.setProjectId(rs.getInt("project_id"));
                    task.setTitle(rs.getString("title"));
                    task.setDescription(rs.getString("description"));
                    task.setStatus(rs.getString("status"));
                    task.setAssignedTo(rs.getInt("assigned_to"));
                    task.setAssignedToName(rs.getString("assigned_name"));
                    task.setDueDate(rs.getDate("due_date"));
                    task.setCreatedAt(rs.getTimestamp("created_at"));
                    tasks.add(task);
                }
            }
        }
        return tasks;
    }

    public void updateTaskStatus(int taskId, String status) throws SQLException {
        String sql = "UPDATE tasks SET status = ? WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, taskId);
            stmt.executeUpdate();
        }
    }
}
