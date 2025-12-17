package com.musicplatform.model;

import java.util.List;

public class Playlist {
    private int id;
    private String title;
    private int userId; // Listener who created the playlist
    private List<Music> songs;

    // Constructors
    public Playlist() {}

    public Playlist(int id, String title, int userId, List<Music> songs) {
        this.id = id;
        this.title = title;
        this.userId = userId;
        this.songs = songs;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public List<Music> getSongs() { return songs; }
    public void setSongs(List<Music> songs) { this.songs = songs; }
}
