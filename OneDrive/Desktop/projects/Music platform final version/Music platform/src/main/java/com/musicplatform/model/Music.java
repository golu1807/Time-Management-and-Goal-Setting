package com.musicplatform.model;

public class Music {
    private int id;
    private String title;
    private String artist;
    private String album;
    private String genre;
    private String filePath;
    private int artistId;
    private String status; // PENDING, APPROVED, REJECTED

    // Constructors
    public Music() {}

    public Music(int id, String title, String artist, String album, String genre, String filePath, int artistId, String status) {
        this.id = id;
        this.title = title;
        this.artist = artist;
        this.album = album;
        this.genre = genre;
        this.filePath = filePath;
        this.artistId = artistId;
        this.status = status;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getArtist() { return artist; }
    public void setArtist(String artist) { this.artist = artist; }

    public String getAlbum() { return album; }
    public void setAlbum(String album) { this.album = album; }

    public String getGenre() { return genre; }
    public void setGenre(String genre) { this.genre = genre; }

    public String getFilePath() { return filePath; }
    public void setFilePath(String filePath) { this.filePath = filePath; }

    public int getArtistId() { return artistId; }
    public void setArtistId(int artistId) { this.artistId = artistId; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
