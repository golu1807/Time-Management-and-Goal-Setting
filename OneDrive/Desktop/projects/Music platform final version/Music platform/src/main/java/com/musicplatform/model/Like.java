package com.musicplatform.model;

import java.sql.Timestamp;

public class Like {
    private int userId;
    private int musicId;
    private Timestamp likedAt;

    public Like() {}

    public Like(int userId, int musicId, Timestamp likedAt) {
        this.userId = userId;
        this.musicId = musicId;
        this.likedAt = likedAt;
    }

    // Getters and Setters
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public int getMusicId() { return musicId; }
    public void setMusicId(int musicId) { this.musicId = musicId; }
    public Timestamp getLikedAt() { return likedAt; }
    public void setLikedAt(Timestamp likedAt) { this.likedAt = likedAt; }
}
