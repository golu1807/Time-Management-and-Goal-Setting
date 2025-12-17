package com.musicplatform.service;

import com.musicplatform.dao.ContentReportDAO;
import com.musicplatform.model.ContentReport;

import com.musicplatform.util.DBUtil;

import java.sql.*;
import java.util.List;
import java.util.Map;

public class ModerationService {
    private ContentReportDAO reportDAO;

    public ModerationService() {
        this.reportDAO = new ContentReportDAO();
    }

    /**
     * Submit a content report
     */
    public boolean reportContent(String contentType, int contentId, int reporterId,
            String reason, String description) {
        try {
            // Check if user has already reported this content
            List<ContentReport> existing = reportDAO.getReportsForContent(contentType, contentId);
            for (ContentReport report : existing) {
                if (report.getReporterId() == reporterId &&
                        report.getStatus().equals("PENDING")) {
                    return false; // Already reported
                }
            }

            ContentReport report = new ContentReport(contentType, contentId, reporterId, reason, description);

            // Auto-escalate certain types
            if ("HARASSMENT".equals(reason) || "HATE_SPEECH".equals(reason)) {
                report.setPriority("HIGH");
            }

            return reportDAO.createReport(report);
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Get all pending reports for moderation queue
     */
    public List<ContentReport> getModerationQueue() {
        try {
            return reportDAO.getPendingReports();
        } catch (SQLException e) {
            e.printStackTrace();
            return new java.util.ArrayList<>();
        }
    }

    /**
     * Get reports by status
     */
    public List<ContentReport> getReportsByStatus(String status) {
        try {
            return reportDAO.getReportsByStatus(status);
        } catch (SQLException e) {
            e.printStackTrace();
            return new java.util.ArrayList<>();
        }
    }

    /**
     * Review a report and take action
     */
    public boolean reviewReport(int reportId, int moderatorId, String action, String notes) {
        try {
            ContentReport report = reportDAO.getReportById(reportId);
            if (report == null) {
                return false;
            }

            String newStatus = "RESOLVED";
            if ("DISMISS".equals(action)) {
                newStatus = "DISMISSED";
            }

            boolean updated = reportDAO.updateReportStatus(reportId, newStatus, moderatorId, notes);

            // If resolved, take appropriate action on the content
            if (updated && "RESOLVED".equals(newStatus)) {
                handleContentAction(report, moderatorId, notes);
            }

            return updated;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Handle action on reported content
     */
    private void handleContentAction(ContentReport report, int moderatorId, String notes) {
        // This would integrate with other DAOs to hide/delete content
        // For now, just log the action
        System.out.println("Content action taken: " + report.getContentType() +
                " ID:" + report.getContentId() + " - " + notes);
    }

    /**
     * Suspend a user account
     */
    public boolean suspendUser(int userId, int moderatorId, int durationDays, String reason) {
        String sql = "UPDATE users SET account_status = 'SUSPENDED', " +
                "suspension_until = DATE_ADD(NOW(), INTERVAL ? DAY) " +
                "WHERE user_id = ?";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, durationDays);
            stmt.setInt(2, userId);
            boolean suspended = stmt.executeUpdate() > 0;

            if (suspended) {
                logModerationAction(moderatorId, userId, "SUSPEND", reason, durationDays);
            }

            return suspended;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Ban a user permanently
     */
    public boolean banUser(int userId, int moderatorId, String reason) {
        String sql = "UPDATE users SET account_status = 'BANNED', ban_reason = ? " +
                "WHERE user_id = ?";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, reason);
            stmt.setInt(2, userId);
            boolean banned = stmt.executeUpdate() > 0;

            if (banned) {
                logModerationAction(moderatorId, userId, "BAN", reason, null);
            }

            return banned;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Unban a user
     */
    public boolean unbanUser(int userId, int moderatorId, String reason) {
        String sql = "UPDATE users SET account_status = 'ACTIVE', ban_reason = NULL, " +
                "suspension_until = NULL WHERE user_id = ?";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            boolean unbanned = stmt.executeUpdate() > 0;

            if (unbanned) {
                logModerationAction(moderatorId, userId, "UNBAN", reason, null);
            }

            return unbanned;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Log a moderation action
     */
    private void logModerationAction(int moderatorId, int targetUserId, String actionType,
            String reason, Integer durationDays) {
        String sql = "INSERT INTO moderation_actions (moderator_id, target_user_id, action_type, reason, duration_days) "
                +
                "VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, moderatorId);
            stmt.setInt(2, targetUserId);
            stmt.setString(3, actionType);
            stmt.setString(4, reason);
            if (durationDays != null) {
                stmt.setInt(5, durationDays);
            } else {
                stmt.setNull(5, Types.INTEGER);
            }

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Get moderation statistics
     */
    public Map<String, Integer> getModerationStats() {
        try {
            return reportDAO.getModerationStats();
        } catch (SQLException e) {
            e.printStackTrace();
            return new java.util.HashMap<>();
        }
    }

    /**
     * Check if user's account is active
     */
    public String checkUserStatus(int userId) {
        String sql = "SELECT account_status, suspension_until FROM users WHERE user_id = ?";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String status = rs.getString("account_status");

                // Check if suspension has expired
                if ("SUSPENDED".equals(status)) {
                    Timestamp suspensionUntil = rs.getTimestamp("suspension_until");
                    if (suspensionUntil != null && suspensionUntil.before(new Timestamp(System.currentTimeMillis()))) {
                        // Suspension expired, reactivate account
                        reactivateUser(userId);
                        return "ACTIVE";
                    }
                }

                return status;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return "UNKNOWN";
    }

    /**
     * Reactivate user after suspension expiry
     */
    private void reactivateUser(int userId) {
        String sql = "UPDATE users SET account_status = 'ACTIVE', suspension_until = NULL WHERE user_id = ?";

        try (Connection conn = DBUtil.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
