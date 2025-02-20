package com.todo.Services;

import com.todo.Models.Task;
import com.todo.Models.User;
import com.todo.Repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserRepository userRepository;

    @Override
    public User save(User user) {
        return  userRepository.save(user);
    }

    @Override
    public User update(User user) {
//        if (user.getEmail() != null) {
//            List<User> existingUsers = userRepository.findAll();
//            for (User u : existingUsers) {
//                if (u.getEmail().equals(user.getEmail()) && !u.getId().equals(user.getId())) {
//                    throw new RuntimeException("Email is already in use by another user");
//                }
//            }
//        }
        return userRepository.save( user );
    }

    @Override
    public ResponseEntity delete(Long id) {
        Optional<User> user = userRepository.findById(id);
        if (user.isPresent()) {
            User existingUser = user.get();
            userRepository.delete(existingUser);
            return new ResponseEntity<>("User is deleted", HttpStatus.OK);
        }
        return new ResponseEntity<>("User does not exist", HttpStatus.BAD_REQUEST);
    }

    @Override
    public User getOne(Long id) {
        return userRepository.findById(id).orElse(null);
    }

    @Override
    public List<User> getAll() {
        return userRepository.findAll();
    }
}
