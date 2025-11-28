package com.yourapp.model;

public class Task {
    private int id;
    private String description;
    private int timeSpent;

    public Task(int id, String description, int timeSpent) {
        this.id = id;
        this.description = description;
        this.timeSpent = timeSpent;
    }

    public int getId() {
        return id;
    }

    public String getDescription() {
        return description;
    }

    public int getTimeSpent() {
        return timeSpent;
    }

    @Override
    public String toString() {
        return description + " (Time spent: " + timeSpent + " minutes)";
    }
}
