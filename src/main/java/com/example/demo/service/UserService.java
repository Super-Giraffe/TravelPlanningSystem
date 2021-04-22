package com.example.demo.service;

import com.example.demo.POJO.User;

import java.util.List;

public interface UserService {

    //注册用户
    int registerUser(User user);

    //获取用户信息
    User getUserInfo(Integer id);

    //获取所有用户信息
    List<User> getAllUserInfo();

    //修改用户信息
    int updateUserInfo(User user);

    //删除用户信息
    int deleteUserInfo(Integer id);

    //根据用户名获取用户
    User getUserByName(String userName);
}
