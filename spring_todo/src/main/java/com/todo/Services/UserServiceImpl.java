package com.todo.Services;

import com.todo.Models.User;
import com.todo.Repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

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
    public void delete(User user) {
        userRepository.delete(user);
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
