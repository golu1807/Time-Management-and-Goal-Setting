package com.musicplatform.model;

public class ModerationAction {
    private int actionId;
    private int moderatorId;
    private String moderatorName;
    private Integer targetUserId;
    private String targetUserName;
    private Integer targetContentId;
    private String contentType;
    private String actionType; // WARN, SUSPEND, BAN, DELETE_CONTENT, APPROVE, RESTORE, UNBAN
    private String reason;
    private Integer durationDays;
    private java.sql.Timestamp actionDate;
    private String notes;

    // Default constructor
    public ModerationAction() {
    }

    // Constructor for user-related actions
    public ModerationAction(int moderatorId, int targetUserId, String actionType,
            String reason, Integer durationDays) {
        this.moderatorId = moderatorId;
        this.targetUserId = targetUserId;
        this.actionType = actionType;
        this.reason = reason;
        this.durationDays = durationDays;
    }

    // Constructor for content-related actions
    public ModerationAction(int moderatorId, int targetContentId, String contentType,
            String actionType, String reason) {
        this.moderatorId = moderatorId;
        this.targetContentId = targetContentId;
        this.contentType = contentType;
        this.actionType = actionType;
        this.reason = reason;
    }

    // Getters and Setters
    public int getActionId() {
        return actionId;
    }

    public void setActionId(int actionId) {
        this.actionId = actionId;
    }

    public int getModeratorId() {
        return moderatorId;
    }

    public void setModeratorId(int moderatorId) {
        this.moderatorId = moderatorId;
    }

    public String getModeratorName() {
        return moderatorName;
    }

    public void setModeratorName(String moderatorName) {
        this.moderatorName = moderatorName;
    }

    public Integer getTargetUserId() {
        return targetUserId;
    }

    public void setTargetUserId(Integer targetUserId) {
        this.targetUserId = targetUserId;
    }

    public String getTargetUserName() {
        return targetUserName;
    }

    public void setTargetUserName(String targetUserName) {
        this.targetUserName = targetUserName;
    }

    public Integer getTargetContentId() {
        return targetContentId;
    }

    public void setTargetContentId(Integer targetContentId) {
        this.targetContentId = targetContentId;
    }

    public String getContentType() {
        return contentType;
    }

    public void setContentType(String contentType) {
        this.contentType = contentType;
    }

    public String getActionType() {
        return actionType;
    }

    public void setActionType(String actionType) {
        this.actionType = actionType;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public Integer getDurationDays() {
        return durationDays;
    }

    public void setDurationDays(Integer durationDays) {
        this.durationDays = durationDays;
    }

    public java.sql.Timestamp getActionDate() {
        return actionDate;
    }

    public void setActionDate(java.sql.Timestamp actionDate) {
        this.actionDate = actionDate;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    @Override
    public String toString() {
        return "ModerationAction{" +
                "actionId=" + actionId +
                ", actionType='" + actionType + '\'' +
                ", targetUserId=" + targetUserId +
                ", targetContentId=" + targetContentId +
                ", actionDate=" + actionDate +
                '}';
    }
}
