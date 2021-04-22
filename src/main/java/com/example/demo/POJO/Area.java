package com.example.demo.POJO;

import lombok.Data;
import org.apache.ibatis.type.Alias;

@Alias("area")
@Data
public class Area {

    private Integer id;

    private String areaName;

    private String address;

    private Integer price;

    private Integer spendTime;

    private String territory;

    private String description;
}
