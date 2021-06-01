package com.example.demo.dao;

import com.example.demo.POJO.Area;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AreaDao {

    Area getAreaById(Integer id);

    List<Area> getAreaByName(@Param("areaName") String areaName,
                       @Param(value = "start") Integer start,
                       @Param(value = "limit") Integer limit);

    List<Area> getAllArea();

    int addArea(Area area);

    int updateArea(Area area);

    int deleteArea(Integer id);

    List<Area> getAreaByTerritory(String territory);

    int insertUserAndArea(@Param("userId") Integer userId, @Param("areaId") Integer areaId);

    int deleteUserAndArea(@Param("userId") Integer userId, @Param("areaId") Integer areaId);

    List<Area> selectUserAndArea(Integer userId);
}
