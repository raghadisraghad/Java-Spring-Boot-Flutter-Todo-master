package com.todo.Services;

import com.todo.Models.Task;

import java.util.List;

public interface TaskService {

    public Task save(Task task)  ;
    public Task update(Task task)  ;
    public void delete(Task task)  ;
    public Task getOne(Long id )  ;
    public List<Task> getAll()  ;
    public List<Task> getUserAll(Long id)  ;

}
