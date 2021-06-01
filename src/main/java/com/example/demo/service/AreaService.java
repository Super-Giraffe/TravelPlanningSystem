package com.example.demo.service;

import com.example.demo.POJO.Area;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AreaService {

    //根据名称查询景区
    List<Area> getAreaByName(String areaName, Integer start, Integer limit);

    //查询所有景区
    List<Area> getAllAreas();

    //添加景区
    int addAreaInfo(Area area);

    //修改景区信息
    int updateAreaInfo(Area area);

    //删除景区信息
    int deleteAreaInfo(Integer id);

    //根据所属地查询景区
    List<Area> getAreaInfoByTerritory(String territory);

    //根据id查询景区
    Area getAreaById(Integer id);

    int insertUserAndArea(Integer userId, Integer areaId);

    int deleteUserAndArea(Integer userId, Integer areaId);

    List<Area> selectUserAndArea(Integer userId);
}
