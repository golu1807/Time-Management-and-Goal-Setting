package com.timemanagement;

public class Task {
    private String description;
    private int timeSpent; // in minutes

    public Task(String description) {
        this.description = description;
        this.timeSpent = 0;
    }

    public String getDescription() {
        return description;
    }

    public void addTime(int minutes) {
        timeSpent += minutes;
    }

    public int getTimeSpent() {
        return timeSpent;
    }

    @Override
    public String toString() {
        return description + " - Time spent: " + timeSpent + " minutes";
    }
}
