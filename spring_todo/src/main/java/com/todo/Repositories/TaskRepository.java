package com.todo.Repositories;

import com.todo.Models.Task;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface TaskRepository extends JpaRepository<Task,Long> {
    List<Task> findByUserId(Long userId);
    @Modifying
    @Transactional
    @Query("DELETE Task t WHERE t.user.id = :userId")
    void deleteAllByUserId(Long userId);
    @Modifying
    @Transactional
    @Query("UPDATE Task t SET t.done = true WHERE t.user.id = :userId")
    void markAllAsDoneByUserId(Long userId);
}
