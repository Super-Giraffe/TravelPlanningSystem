package com.example.demo.service.impl;

import com.example.demo.POJO.Area;
import com.example.demo.dao.AreaDao;
import com.example.demo.service.AreaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AreaServiceImpl implements AreaService {

    @Autowired
    private AreaDao areaDao;

    @Override
    public List<Area> getAreaByName(String areaName, Integer start, Integer limit) {
        return areaDao.getAreaByName(areaName, (start - 1) * limit, limit);
    }

    @Override
    public List<Area> getAllAreas() {
        return areaDao.getAllArea();
    }

    @Override
    public int addAreaInfo(Area area) {
        return areaDao.addArea(area);
    }

    @Override
    public int updateAreaInfo(Area area) {
        return areaDao.updateArea(area);
    }

    @Override
    public int deleteAreaInfo(Integer id) {
        return areaDao.deleteArea(id);
    }

    @Override
    public List<Area> getAreaInfoByTerritory(String territory) {
        return areaDao.getAreaByTerritory(territory);
    }

    @Override
    public Area getAreaById(Integer id) {
        return areaDao.getAreaById(id);
    }
}
