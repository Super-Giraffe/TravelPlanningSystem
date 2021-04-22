package com.example.demo.service.impl;

import com.example.demo.POJO.User;
import com.example.demo.dao.UserDao;
import com.example.demo.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Override
    public int registerUser(User user) {
        return userDao.insertUser(user);
    }

    @Override
    public User getUserInfo(Integer id) {
        return userDao.getUser(id);
    }

    @Override
    public List<User> getAllUserInfo() {
        return userDao.getAllUser();
    }

    @Override
    public int updateUserInfo(User user) {
        return userDao.updateUser(user);
    }

    @Override
    public int deleteUserInfo(Integer id) {
        return userDao.deleteUser(id);
    }

    @Override
    public User getUserByName(String userName) {
        return userDao.getUserByName(userName);
    }
}
