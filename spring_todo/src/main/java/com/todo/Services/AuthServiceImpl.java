package com.todo.Services;

import com.todo.DTOs.UserLogin;
import com.todo.Models.User;
import com.todo.Repositories.UserRepository;
import com.todo.Utils.JWT;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Service
public class AuthServiceImpl implements AuthService {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private JWT jwt;

    @Override
    public String Register(User user) {
        userRepository.save(user);
        return "Registred Successfully";
    }

    @Override
    public ResponseEntity<String> Login(UserLogin userLogin) {
        Optional<User> userOptional = userRepository.findByUsername(userLogin.getUsername());

        if (userOptional.isEmpty()) {
            return ResponseEntity.status(401).body("Invalid username or password");
        }

        User user = userOptional.get();

        if (!user.getPassword().equals(userLogin.getPassword())) {
            return ResponseEntity.status(401).body("Invalid username or password");
        }

        List<String> roles = Collections.emptyList();
        String token = jwt.generateToken(user.getId(), roles);

        return ResponseEntity.ok(token);
    }
}
