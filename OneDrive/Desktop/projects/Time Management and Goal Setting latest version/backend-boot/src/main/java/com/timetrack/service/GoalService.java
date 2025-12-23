package com.timetrack.service;

import com.timetrack.model.Goal;
import com.timetrack.model.User;
import com.timetrack.repository.GoalRepository;
import com.timetrack.repository.UserRepository;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class GoalService {

    private final GoalRepository goalRepository;
    private final UserRepository userRepository;
    private final org.springframework.jdbc.core.JdbcTemplate jdbcTemplate;

    public GoalService(GoalRepository goalRepository, UserRepository userRepository,
            org.springframework.jdbc.core.JdbcTemplate jdbcTemplate) {
        this.goalRepository = goalRepository;
        this.userRepository = userRepository;
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<Goal> getUserGoals(Long userId) {
        return goalRepository.findByUserId(userId);
    }

    public Goal createGoal(Long userId, Goal goal) {
        User user = userRepository.findById(userId).orElseThrow(() -> new RuntimeException("User not found"));
        goal.setUser(user);
        goal.setStatus("IN_PROGRESS");
        return goalRepository.save(goal);
    }

    public Goal updateGoal(Long goalId, Goal updatedGoal) {
        Goal goal = goalRepository.findById(goalId).orElseThrow(() -> new RuntimeException("Goal not found"));
        goal.setTitle(updatedGoal.getTitle());
        goal.setDescription(updatedGoal.getDescription());
        goal.setTargetHours(updatedGoal.getTargetHours());
        goal.setStatus(updatedGoal.getStatus());
        return goalRepository.save(goal);
    }

    public void deleteGoal(Long goalId) {
        goalRepository.deleteById(goalId);
    }

    @org.springframework.transaction.annotation.Transactional
    public Goal createGoalWithTasks(Long userId, Goal goal, List<com.timetrack.model.Task> tasks) {
        // 1. Save Goal using JPA
        User user = userRepository.findById(userId).orElseThrow(() -> new RuntimeException("User not found"));
        goal.setUser(user);
        goal.setStatus("IN_PROGRESS");
        Goal savedGoal = goalRepository.save(goal);

        // 2. Save Tasks using JDBC (Batch Insert)
        String sql = "INSERT INTO tasks (description, status, goal_id) VALUES (?, ?, ?)";

        jdbcTemplate.batchUpdate(sql, new org.springframework.jdbc.core.BatchPreparedStatementSetter() {
            @Override
            public void setValues(java.sql.PreparedStatement ps, int i) throws java.sql.SQLException {
                com.timetrack.model.Task task = tasks.get(i);
                ps.setString(1, task.getDescription());
                ps.setString(2, task.getStatus());
                ps.setLong(3, savedGoal.getId());
            }

            @Override
            public int getBatchSize() {
                return tasks.size();
            }
        });

        return savedGoal;
    }
}
