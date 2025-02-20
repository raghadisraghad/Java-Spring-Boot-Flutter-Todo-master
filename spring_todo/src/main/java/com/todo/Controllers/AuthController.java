package com.todo.Controllers;

import com.todo.DTOs.UserLogin;
import com.todo.Models.User;
import com.todo.Repositories.UserRepository;
import com.todo.Services.AuthService;
import com.todo.Utils.JWT;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(path = "/auth")
public class AuthController {

    @Autowired
    private AuthService authService;

    @Autowired
    private JWT jwt;

    @Autowired
    private UserRepository userRepository;

    @PostMapping("/register")
    public String Register(@RequestBody User user) {
        return authService.Register(user);
    }

    @PostMapping("/login")
    public ResponseEntity<String> login(@RequestBody UserLogin userLogin) {
        return authService.Login(userLogin);
    }
}