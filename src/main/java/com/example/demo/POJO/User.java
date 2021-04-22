package com.example.demo.POJO;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Data
@Alias("user")
public class User {

    private Integer id;

    private String userName;

    private Integer age;

    private String phone;

    private String password;

    private String sex;

    private Integer sexId;

    private Integer admin;
}
