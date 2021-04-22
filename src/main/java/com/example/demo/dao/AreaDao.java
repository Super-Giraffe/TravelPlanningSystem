package com.example.demo.dao;

import com.example.demo.POJO.Area;
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
}
