package com.musicplatform.dao;

import com.musicplatform.model.ContentReport;
import com.musicplatform.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ContentReportDAO {

    // Create a new content report
    public boolean createReport(ContentReport report) throws SQLException {
        String sql = "INSERT INTO content_reports (content_type, content_id, reporter_id, reason, description, priority) "
                +
                "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, report.getContentType());
            stmt.setInt(2, report.getContentId());
            stmt.setInt(3, report.getReporterId());
            stmt.setString(4, report.getReason());
            stmt.setString(5, report.getDescription());
            stmt.setString(6, report.getPriority());

            return stmt.executeUpdate() > 0;
        }
    }

    // Get all pending reports
    public List<ContentReport> getPendingReports() throws SQLException {
        String sql = "SELECT cr.*, u.name as reporter_name " +
                "FROM content_reports cr " +
                "JOIN users u ON cr.reporter_id = u.user_id " +
                "WHERE cr.status = 'PENDING' " +
                "ORDER BY cr.priority DESC, cr.created_at ASC";

        return executeReportQuery(sql);
    }

    // Get reports by status
    public List<ContentReport> getReportsByStatus(String status) throws SQLException {
        String sql = "SELECT cr.*, u.name as reporter_name, " +
                "m.name as reviewer_name " +
                "FROM content_reports cr " +
                "JOIN users u ON cr.reporter_id = u.user_id " +
                "LEFT JOIN users m ON cr.reviewed_by = m.user_id " +
                "WHERE cr.status = ? " +
                "ORDER BY cr.created_at DESC";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            return mapReports(stmt.executeQuery());
        }
    }

    // Get report by ID
    public ContentReport getReportById(int reportId) throws SQLException {
        String sql = "SELECT cr.*, u.name as reporter_name, " +
                "m.name as reviewer_name " +
                "FROM content_reports cr " +
                "JOIN users u ON cr.reporter_id = u.user_id " +
                "LEFT JOIN users m ON cr.reviewed_by = m.user_id " +
                "WHERE cr.report_id = ?";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, reportId);
            List<ContentReport> reports = mapReports(stmt.executeQuery());
            return reports.isEmpty() ? null : reports.get(0);
        }
    }

    // Update report status
    public boolean updateReportStatus(int reportId, String status, int reviewedBy, String resolutionNotes)
            throws SQLException {
        String sql = "UPDATE content_reports " +
                "SET status = ?, reviewed_by = ?, reviewed_at = NOW(), resolution_notes = ? " +
                "WHERE report_id = ?";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, reviewedBy);
            stmt.setString(3, resolutionNotes);
            stmt.setInt(4, reportId);

            return stmt.executeUpdate() > 0;
        }
    }

    // Get reports for specific content
    public List<ContentReport> getReportsForContent(String contentType, int contentId) throws SQLException {
        String sql = "SELECT cr.*, u.name as reporter_name " +
                "FROM content_reports cr " +
                "JOIN users u ON cr.reporter_id = u.user_id " +
                "WHERE cr.content_type = ? AND cr.content_id = ? " +
                "ORDER BY cr.created_at DESC";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, contentType);
            stmt.setInt(2, contentId);
            return mapReports(stmt.executeQuery());
        }
    }

    // Get moderation statistics
    public java.util.Map<String, Integer> getModerationStats() throws SQLException {
        java.util.Map<String, Integer> stats = new java.util.HashMap<>();

        String sql = "SELECT status, COUNT(*) as count FROM content_reports GROUP BY status";

        try (Connection conn = DBUtil.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                stats.put(rs.getString("status"), rs.getInt("count"));
            }
        }

        return stats;
    }

    // Helper method to execute report queries
    private List<ContentReport> executeReportQuery(String sql) throws SQLException {
        try (Connection conn = DBUtil.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {

            return mapReports(rs);
        }
    }

    // Helper method to map ResultSet to ContentReport list
    private List<ContentReport> mapReports(ResultSet rs) throws SQLException {
        List<ContentReport> reports = new ArrayList<>();

        while (rs.next()) {
            ContentReport report = new ContentReport();
            report.setReportId(rs.getInt("report_id"));
            report.setContentType(rs.getString("content_type"));
            report.setContentId(rs.getInt("content_id"));
            report.setReporterId(rs.getInt("reporter_id"));
            report.setReporterName(rs.getString("reporter_name"));
            report.setReason(rs.getString("reason"));
            report.setDescription(rs.getString("description"));
            report.setStatus(rs.getString("status"));
            report.setPriority(rs.getString("priority"));
            report.setCreatedAt(rs.getTimestamp("created_at"));
            report.setReviewedAt(rs.getTimestamp("reviewed_at"));

            int reviewedBy = rs.getInt("reviewed_by");
            if (!rs.wasNull()) {
                report.setReviewedBy(reviewedBy);
                report.setReviewerName(rs.getString("reviewer_name"));
            }

            report.setResolutionNotes(rs.getString("resolution_notes"));
            reports.add(report);
        }

        return reports;
    }
}
