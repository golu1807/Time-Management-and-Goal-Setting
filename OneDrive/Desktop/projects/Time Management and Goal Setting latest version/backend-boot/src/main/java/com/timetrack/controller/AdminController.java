package com.timetrack.controller;

import com.timetrack.model.Goal;
import com.timetrack.service.GoalService;
import com.timetrack.repository.UserRepository;
import com.timetrack.repository.GoalRepository;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/admin")
public class AdminController {

    private final UserRepository userRepository;
    private final GoalRepository goalRepository;
    private final GoalService goalService;

    public AdminController(UserRepository userRepository, GoalRepository goalRepository, GoalService goalService) {
        this.userRepository = userRepository;
        this.goalRepository = goalRepository;
        this.goalService = goalService;
    }

    @GetMapping("/usage-summary")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<Map<String, Object>> getUsageSummary() {
        Map<String, Object> summary = new HashMap<>();

        // Total users
        long totalUsers = userRepository.count();
        long activeUsers = userRepository.findAll().stream()
                .filter(u -> "ACTIVE".equals(u.getStatus()))
                .count();

        // Total goals
        long totalGoals = goalRepository.count();
        long completedGoals = goalRepository.findAll().stream()
                .filter(g -> "COMPLETED".equals(g.getStatus()))
                .count();

        summary.put("totalUsers", totalUsers);
        summary.put("activeUsers", activeUsers);
        summary.put("totalGoals", totalGoals);
        summary.put("completedGoals", completedGoals);
        summary.put("inProgressGoals", totalGoals - completedGoals);

        return ResponseEntity.ok(summary);
    }

    @GetMapping("/goals")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<List<Goal>> getAllGoals(
            @RequestParam(required = false) Long userId,
            @RequestParam(required = false) String status) {
        List<Goal> goals = goalRepository.findAll();

        // Filter by userId if provided
        if (userId != null) {
            goals = goals.stream()
                    .filter(g -> g.getUser().getId().equals(userId))
                    .toList();
        }

        // Filter by status if provided
        if (status != null) {
            goals = goals.stream()
                    .filter(g -> status.equals(g.getStatus()))
                    .toList();
        }

        return ResponseEntity.ok(goals);
    }
}
