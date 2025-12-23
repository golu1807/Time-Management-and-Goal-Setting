package com.timetrack.repository;

import com.timetrack.model.TimeLog;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface TimeLogRepository extends JpaRepository<TimeLog, Long> {
    List<TimeLog> findByGoalId(Long goalId);

    Optional<TimeLog> findByGoalIdAndEndTimeIsNull(Long goalId);
}
