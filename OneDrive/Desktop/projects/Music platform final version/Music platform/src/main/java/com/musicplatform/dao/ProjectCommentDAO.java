package com.musicplatform.dao;

import com.musicplatform.model.ProjectComment;
import com.musicplatform.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProjectCommentDAO {

    public void addComment(ProjectComment comment) throws SQLException {
        String sql = "INSERT INTO project_comments (project_id, user_id, content) VALUES (?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, comment.getProjectId());
            stmt.setInt(2, comment.getUserId());
            stmt.setString(3, comment.getContent());
            stmt.executeUpdate();
        }
    }

    public List<ProjectComment> getCommentsByProjectId(int projectId) throws SQLException {
        List<ProjectComment> comments = new ArrayList<>();
        String sql = "SELECT c.*, u.name as user_name FROM project_comments c JOIN users u ON c.user_id = u.id WHERE c.project_id = ? ORDER BY c.created_at ASC";
        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, projectId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    ProjectComment comment = new ProjectComment();
                    comment.setId(rs.getInt("id"));
                    comment.setProjectId(rs.getInt("project_id"));
                    comment.setUserId(rs.getInt("user_id"));
                    comment.setUserName(rs.getString("user_name"));
                    comment.setContent(rs.getString("content"));
                    comment.setCreatedAt(rs.getTimestamp("created_at"));
                    comments.add(comment);
                }
            }
        }
        return comments;
    }
}
