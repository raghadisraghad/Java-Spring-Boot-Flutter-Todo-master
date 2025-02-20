package com.todo.Services;

import com.todo.DTOs.UserLogin;
import com.todo.Models.User;
import org.springframework.http.ResponseEntity;

public interface AuthService {
    public String Register(User user)  ;
    public ResponseEntity<String> Login(UserLogin userLogin)  ;
}
