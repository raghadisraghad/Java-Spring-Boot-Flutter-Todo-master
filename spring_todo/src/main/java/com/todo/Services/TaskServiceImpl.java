package com.todo.Services;

import com.todo.Models.Task;
import com.todo.Repositories.TaskRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;
import java.util.Optional;

@Service
public class TaskServiceImpl implements TaskService {
    @Autowired
    private TaskRepository taskRepository;

    @Override
    public Task save(Task task) {
        return  taskRepository.save(task);
    }

    @Override
    public Task update(Task task) {
        return taskRepository.save( task );
    }

    @Override
    public ResponseEntity delete(Long id) {
        Optional<Task> task = taskRepository.findById(id);
        if (task.isPresent()) {
            Task existingTask = task.get();
            existingTask.setUser(null);
            taskRepository.delete(existingTask);
            return new ResponseEntity<>("Task is deleted", HttpStatus.OK);
        }
        return new ResponseEntity<>("Task does not exist", HttpStatus.BAD_REQUEST);
    }

    @Override
    public ResponseEntity deleteAllTasksUser(Long id) {
        taskRepository.deleteAllByUserId(id);
        return new ResponseEntity<>("Tasks deleted", HttpStatus.OK);
    }

    @Override
    public ResponseEntity markAllAsDone(Long id) {
        taskRepository.markAllAsDoneByUserId(id);
        return new ResponseEntity<>("Tasks updated", HttpStatus.OK);
    }

    @Override
    public Task getOne(Long id) {
        Task task = taskRepository.getOne(id);
        return task;
    }

    @Override
    public List<Task> getAll() {
        return taskRepository.findAll();
    }

    @Override
    public List<Task> getUserAll(Long id) {
        return taskRepository.findByUserId(id);
    }
}
