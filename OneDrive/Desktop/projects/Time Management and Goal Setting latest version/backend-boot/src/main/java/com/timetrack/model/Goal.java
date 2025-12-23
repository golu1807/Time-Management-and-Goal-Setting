package com.timetrack.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "goals")
public class Goal {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    @NotNull(message = "Title is required")
    @Size(min = 3, max = 100, message = "Title must be between 3 and 100 characters")
    private String title;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(name = "target_hours")
    @NotNull(message = "Target hours is required")
    @Positive(message = "Target hours must be positive")
    private Double targetHours;

    @Column(nullable = false)
    private String status; // IN_PROGRESS, COMPLETED

    @Column
    private LocalDate deadline;

    @Column
    private String category; // Personal, Work, etc.

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        if (status == null || status.isEmpty()) {
            status = "IN_PROGRESS";
        }
        if (category == null || category.isEmpty()) {
            category = "Personal";
        }
    }

    public Goal() {
    }

    public Goal(Long id, String title, String description, Double targetHours, String status, LocalDate deadline,
            String category, LocalDateTime createdAt, User user) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.targetHours = targetHours;
        this.status = status;
        this.deadline = deadline;
        this.category = category;
        this.createdAt = createdAt;
        this.user = user;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Double getTargetHours() {
        return targetHours;
    }

    public void setTargetHours(Double targetHours) {
        this.targetHours = targetHours;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public LocalDate getDeadline() {
        return deadline;
    }

    public void setDeadline(LocalDate deadline) {
        this.deadline = deadline;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }
}
