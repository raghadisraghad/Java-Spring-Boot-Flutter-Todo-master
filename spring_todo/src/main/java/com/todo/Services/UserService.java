package com.todo.Services;

import com.todo.Models.User;
import org.springframework.http.ResponseEntity;

import java.util.List;

public interface UserService {

    public User save(User user)  ;
    public User update(User user)  ;
    public ResponseEntity delete(Long id)  ;
    public User getOne(Long id)  ;
    public List<User> getAll()  ;

}
