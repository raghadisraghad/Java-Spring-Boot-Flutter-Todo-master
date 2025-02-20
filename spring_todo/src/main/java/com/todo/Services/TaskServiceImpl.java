package com.todo.Services;

import com.todo.Models.Task;
import com.todo.Repositories.TaskRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

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
    public void delete(Task task) {
        taskRepository.delete(task);
    }

    @Override
    public Task getOne(Long id) {
        return taskRepository.findById(id).orElse(null);
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
