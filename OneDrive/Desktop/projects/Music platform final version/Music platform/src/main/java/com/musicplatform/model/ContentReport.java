package com.musicplatform.model;

public class ContentReport {
    private int reportId;
    private String contentType; // TRACK, COMMENT, MESSAGE, POST, PROJECT
    private int contentId;
    private int reporterId;
    private String reporterName;
    private String reason; // SPAM, INAPPROPRIATE, COPYRIGHT, HARASSMENT, HATE_SPEECH, OTHER
    private String description;
    private String status; // PENDING, UNDER_REVIEW, RESOLVED, DISMISSED
    private String priority; // LOW, MEDIUM, HIGH, URGENT
    private java.sql.Timestamp createdAt;
    private java.sql.Timestamp reviewedAt;
    private Integer reviewedBy;
    private String reviewerName;
    private String resolutionNotes;

    // Default constructor
    public ContentReport() {
    }

    // Full constructor
    public ContentReport(String contentType, int contentId, int reporterId,
            String reason, String description) {
        this.contentType = contentType;
        this.contentId = contentId;
        this.reporterId = reporterId;
        this.reason = reason;
        this.description = description;
        this.status = "PENDING";
        this.priority = "MEDIUM";
    }

    // Getters and Setters
    public int getReportId() {
        return reportId;
    }

    public void setReportId(int reportId) {
        this.reportId = reportId;
    }

    public String getContentType() {
        return contentType;
    }

    public void setContentType(String contentType) {
        this.contentType = contentType;
    }

    public int getContentId() {
        return contentId;
    }

    public void setContentId(int contentId) {
        this.contentId = contentId;
    }

    public int getReporterId() {
        return reporterId;
    }

    public void setReporterId(int reporterId) {
        this.reporterId = reporterId;
    }

    public String getReporterName() {
        return reporterName;
    }

    public void setReporterName(String reporterName) {
        this.reporterName = reporterName;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPriority() {
        return priority;
    }

    public void setPriority(String priority) {
        this.priority = priority;
    }

    public java.sql.Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(java.sql.Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public java.sql.Timestamp getReviewedAt() {
        return reviewedAt;
    }

    public void setReviewedAt(java.sql.Timestamp reviewedAt) {
        this.reviewedAt = reviewedAt;
    }

    public Integer getReviewedBy() {
        return reviewedBy;
    }

    public void setReviewedBy(Integer reviewedBy) {
        this.reviewedBy = reviewedBy;
    }

    public String getReviewerName() {
        return reviewerName;
    }

    public void setReviewerName(String reviewerName) {
        this.reviewerName = reviewerName;
    }

    public String getResolutionNotes() {
        return resolutionNotes;
    }

    public void setResolutionNotes(String resolutionNotes) {
        this.resolutionNotes = resolutionNotes;
    }

    @Override
    public String toString() {
        return "ContentReport{" +
                "reportId=" + reportId +
                ", contentType='" + contentType + '\'' +
                ", contentId=" + contentId +
                ", reason='" + reason + '\'' +
                ", status='" + status + '\'' +
                ", priority='" + priority + '\'' +
                '}';
    }
}
