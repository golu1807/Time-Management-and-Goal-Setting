package com.timetrack.service;

import com.timetrack.model.Goal;
import com.timetrack.repository.GoalRepository;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.concurrent.CompletableFuture;

@Service
public class ReminderService {

    private final GoalRepository goalRepository;

    public ReminderService(GoalRepository goalRepository) {
        this.goalRepository = goalRepository;
    }

    // Run every minute for demonstration purposes
    @Scheduled(fixedRate = 60000)
    public void sendGoalReminders() {
        System.out.println("Checking for goal reminders... " + Thread.currentThread().getName());
        List<Goal> goals = goalRepository.findAll(); // In a real app, filter by due date or status

        for (Goal goal : goals) {
            if ("IN_PROGRESS".equals(goal.getStatus())) {
                processReminder(goal);
            }
        }
    }

    @Async
    public CompletableFuture<Void> processReminder(Goal goal) {
        return CompletableFuture.runAsync(() -> {
            try {
                // Simulate processing time (e.g., sending email)
                Thread.sleep(1000);
                System.out.println("Sending reminder for goal: " + goal.getTitle() + " on thread: "
                        + Thread.currentThread().getName());
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        });
    }
}
