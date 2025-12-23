package com.timetrack.controller;

import com.timetrack.model.Goal;
import com.timetrack.service.GoalService;
import com.timetrack.util.JwtUtil;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/goals")
public class GoalController {

    private final GoalService goalService;
    private final JwtUtil jwtUtil;

    public GoalController(GoalService goalService, JwtUtil jwtUtil) {
        this.goalService = goalService;
        this.jwtUtil = jwtUtil;
    }

    private Long getUserIdFromRequest(HttpServletRequest request) {
        String token = request.getHeader("Authorization").substring(7);
        return jwtUtil.extractClaim(token, claims -> claims.get("userId", Long.class));
    }

    @GetMapping
    public ResponseEntity<List<Goal>> getGoals(HttpServletRequest request) {
        Long userId = getUserIdFromRequest(request);
        return ResponseEntity.ok(goalService.getUserGoals(userId));
    }

    @PostMapping
    public ResponseEntity<Goal> createGoal(@RequestBody Goal goal, HttpServletRequest request) {
        Long userId = getUserIdFromRequest(request);
        return ResponseEntity.ok(goalService.createGoal(userId, goal));
    }

    @PutMapping("/{id}")
    public ResponseEntity<Goal> updateGoal(@PathVariable Long id, @RequestBody Goal goal) {
        return ResponseEntity.ok(goalService.updateGoal(id, goal));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteGoal(@PathVariable Long id) {
        goalService.deleteGoal(id);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/with-tasks")
    public ResponseEntity<Goal> createGoalWithTasks(@RequestBody com.timetrack.dto.GoalWithTasksRequest request,
            HttpServletRequest httpRequest) {
        Long userId = getUserIdFromRequest(httpRequest);
        Goal goal = new Goal();
        goal.setTitle(request.getTitle());
        goal.setDescription(request.getDescription());
        goal.setTargetHours(request.getTargetHours());

        return ResponseEntity.ok(goalService.createGoalWithTasks(userId, goal, request.getTasks()));
    }
}
