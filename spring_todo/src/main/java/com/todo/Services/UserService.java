package com.todo.Services;

import com.todo.Models.User;

import java.util.List;

public interface UserService {

    public User save(User user)  ;
    public User update(User user)  ;
    public void delete(User user)  ;
    public User getOne(Long id )  ;
    public List<User> getAll()  ;

}
