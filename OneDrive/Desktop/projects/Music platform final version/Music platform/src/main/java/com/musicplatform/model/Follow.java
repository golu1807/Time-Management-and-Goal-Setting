package com.musicplatform.model;

import java.sql.Timestamp;

public class Follow {
    private int listenerId;
    private int artistId;
    private Timestamp followedAt;

    // Constructors
    public Follow() {}

    public Follow(int listenerId, int artistId, Timestamp followedAt) {
        this.listenerId = listenerId;
        this.artistId = artistId;
        this.followedAt = followedAt;
    }

    // Getters and Setters
    public int getListenerId() { return listenerId; }
    public void setListenerId(int listenerId) { this.listenerId = listenerId; }

    public int getArtistId() { return artistId; }
    public void setArtistId(int artistId) { this.artistId = artistId; }

    public Timestamp getFollowedAt() { return followedAt; }
    public void setFollowedAt(Timestamp followedAt) { this.followedAt = followedAt; }
}
