package com.example.demo.dao;

import com.example.demo.POJO.User;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserDao {

    int insertUser(User user);

    User getUser(Integer id);

    List<User> getAllUser();

    int updateUser(User user);

    int deleteUser(Integer id);

    User getUserByName(String userName);
}
