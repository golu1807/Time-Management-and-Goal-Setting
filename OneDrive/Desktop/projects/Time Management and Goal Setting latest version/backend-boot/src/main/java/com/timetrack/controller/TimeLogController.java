package com.timetrack.controller;

import com.timetrack.model.TimeLog;
import com.timetrack.service.TimeLogService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/timelogs")
public class TimeLogController {

    private final TimeLogService timeLogService;

    public TimeLogController(TimeLogService timeLogService) {
        this.timeLogService = timeLogService;
    }

    @PostMapping("/start")
    public ResponseEntity<?> startTimer(@RequestBody Map<String, Long> request) {
        Long goalId = request.get("goalId");
        return ResponseEntity.ok(timeLogService.startTimer(goalId));
    }

    @PostMapping("/stop")
    public ResponseEntity<?> stopTimer(@RequestBody Map<String, Long> request) {
        Long goalId = request.get("goalId");
        return ResponseEntity.ok(timeLogService.stopTimer(goalId));
    }

    @GetMapping("/goal/{goalId}")
    public ResponseEntity<List<TimeLog>> getLogs(@PathVariable Long goalId) {
        return ResponseEntity.ok(timeLogService.getLogsForGoal(goalId));
    }
}
