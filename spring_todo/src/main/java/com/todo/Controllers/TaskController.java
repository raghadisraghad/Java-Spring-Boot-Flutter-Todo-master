package com.todo.Controllers;

import com.todo.Models.Task;
import com.todo.Repositories.TaskRepository;
import com.todo.Services.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping(path = "/tasks")
@CrossOrigin(origins = "*", methods = {RequestMethod.GET, RequestMethod.POST})
public class TaskController {

    @Autowired
    private TaskService taskService;

    @GetMapping
    public List<Task> getAll(){
        return taskService.getAll();
    }

    @GetMapping("/user/{id}")
    public List<Task> getUserAll(@PathVariable Long id){
        return taskService.getUserAll(id);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Task> getOne(@PathVariable Long id) {
        Optional<Task> task = Optional.ofNullable(taskService.getOne(id));
        return task.map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.status(HttpStatus.NOT_FOUND).build());
    }

    @PostMapping
    public ResponseEntity<Task> create(@RequestBody Task task) {
        Task savedTask =  taskService.save(task);
        return new ResponseEntity<>(savedTask, HttpStatus.CREATED);
    }

    @PutMapping
    public ResponseEntity<Task> update(@RequestBody Task task) {
        task = taskService.update(task);
        return new ResponseEntity<>(task, HttpStatus.OK);
    }

    @PutMapping("/done/{id}")
    public ResponseEntity markAllAsDone(@PathVariable Long id) {
        return taskService.markAllAsDone(id);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity delete(@PathVariable Long id) {
        return taskService.delete(id);
    }

    @DeleteMapping("/all/{id}")
    public ResponseEntity deleteAllTasksUser(@PathVariable Long id) {
        return taskService.deleteAllTasksUser(id);
    }
}
