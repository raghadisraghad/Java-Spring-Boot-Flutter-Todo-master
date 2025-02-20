package com.todo.Services;

import com.todo.Models.Task;
import org.springframework.http.ResponseEntity;

import java.util.List;

public interface TaskService {

    public Task save(Task task)  ;
    public Task update(Task task)  ;
    public ResponseEntity markAllAsDone(Long id)  ;
    public ResponseEntity delete(Long id)  ;
    public ResponseEntity deleteAllTasksUser(Long id)  ;
    public Task getOne(Long id)  ;
    public List<Task> getAll()  ;
    public List<Task> getUserAll(Long id)  ;

}
