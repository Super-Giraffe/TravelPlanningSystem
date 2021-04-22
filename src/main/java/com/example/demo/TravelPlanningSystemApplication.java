package com.example.demo;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.stereotype.Repository;

@SpringBootApplication
@EntityScan("com.example.demo.pojo")
@MapperScan(
        basePackages = "com.example.demo.dao",
        sqlSessionFactoryRef = "sqlSessionFactory",
        sqlSessionTemplateRef = "sqlSessionTemplate",
        annotationClass = Repository.class
)
public class TravelPlanningSystemApplication {

    public static void main(String[] args) {
        SpringApplication.run(TravelPlanningSystemApplication.class, args);
    }

}
