package com.musicplatform.model;

import java.sql.Timestamp;

public class ListeningHistory {
    private int id;
    private int userId;
    private int musicId;
    private Timestamp playedAt;

    public ListeningHistory() {}

    public ListeningHistory(int id, int userId, int musicId, Timestamp playedAt) {
        this.id = id;
        this.userId = userId;
        this.musicId = musicId;
        this.playedAt = playedAt;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public int getMusicId() { return musicId; }
    public void setMusicId(int musicId) { this.musicId = musicId; }
    public Timestamp getPlayedAt() { return playedAt; }
    public void setPlayedAt(Timestamp playedAt) { this.playedAt = playedAt; }
}
