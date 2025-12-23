package com.timetrack.service;

import com.timetrack.model.Goal;
import com.timetrack.model.TimeLog;
import com.timetrack.repository.GoalRepository;
import com.timetrack.repository.TimeLogRepository;
import org.springframework.stereotype.Service;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class TimeLogService {

    private final TimeLogRepository timeLogRepository;
    private final GoalRepository goalRepository;

    public TimeLogService(TimeLogRepository timeLogRepository, GoalRepository goalRepository) {
        this.timeLogRepository = timeLogRepository;
        this.goalRepository = goalRepository;
    }

    public TimeLog startTimer(Long goalId) {
        // Check if there is already a running timer for this goal
        Optional<TimeLog> running = timeLogRepository.findByGoalIdAndEndTimeIsNull(goalId);
        if (running.isPresent()) {
            throw new RuntimeException("Timer already running for this goal");
        }

        Goal goal = goalRepository.findById(goalId).orElseThrow(() -> new RuntimeException("Goal not found"));
        TimeLog timeLog = new TimeLog();
        timeLog.setGoal(goal);
        timeLog.setStartTime(LocalDateTime.now());
        return timeLogRepository.save(timeLog);
    }

    public TimeLog stopTimer(Long goalId) {
        TimeLog timeLog = timeLogRepository.findByGoalIdAndEndTimeIsNull(goalId)
                .orElseThrow(() -> new RuntimeException("No running timer found for this goal"));

        timeLog.setEndTime(LocalDateTime.now());
        long duration = Duration.between(timeLog.getStartTime(), timeLog.getEndTime()).toMinutes();
        timeLog.setDurationMinutes(duration);
        return timeLogRepository.save(timeLog);
    }

    public List<TimeLog> getLogsForGoal(Long goalId) {
        return timeLogRepository.findByGoalId(goalId);
    }
}
