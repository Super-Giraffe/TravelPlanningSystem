package com.example.demo.controller;

import com.example.demo.POJO.Area;
import com.example.demo.ant_algorithm.Plan;
import com.example.demo.service.AreaService;
import com.example.demo.vo.AreaVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.Banner;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("area")
public class AreaController {

    private List<Area> tripList = new ArrayList<>();

    @Autowired
    private AreaService areaService;

    @RequestMapping("/getAreaByName")
    public ModelAndView getAreaByName(String name, Integer start){
        ModelAndView mav = new ModelAndView();
        mav.addAllObjects(getResultMap(name, start));
        mav.setViewName("index2");
        return mav;
    }

    @RequestMapping("/delete")
    public ModelAndView delete(Integer id, Integer start){
        ModelAndView mav = new ModelAndView();
        areaService.deleteAreaInfo(id);
        mav.addAllObjects(getResultMap(null, start));
        mav.setViewName("index2");
        return mav;
    }

    @RequestMapping("/insert")
    public ModelAndView insert(Area area, Integer start){
        ModelAndView mav = new ModelAndView();
        areaService.addAreaInfo(area);
        mav.addAllObjects(getResultMap(null, start));
        mav.setViewName("index2");
        return mav;
    }

    @RequestMapping("/update")
    public ModelAndView update(Area area, Integer start){
        ModelAndView mav = new ModelAndView();
        areaService.updateAreaInfo(area);
        mav.addAllObjects(getResultMap(null, start));
        mav.setViewName("index2");
        return mav;
    }

    @RequestMapping("getAreaByTerritory")
    public ModelAndView getAreaByTerritory(String territory){
        ModelAndView mav = new ModelAndView();
        List<AreaVo> areaVos = theAreasInTerritory(territory);
        mav.setViewName("index1");
        mav.addObject("areas" ,areaVos);
        mav.addObject("tripList", tripList);
        return mav;
    }

    private HashMap<String, Object> getResultMap(String name, Integer start){
        if ("".equals(name)){
            name = null;
        }
        HashMap<String, Object> result = new HashMap<>();
        List<Area> areas = areaService.getAreaByName(name, start, 10);
        List<Area> all = areaService.getAllAreas();
        result.put("all", all);
        result.put("areas", areas);
        result.put("start", start);
        result.put("name", name);
        return result;
    }

    @RequestMapping("getShortestPath")
    public ModelAndView getShortestPath() throws Exception {
        ModelAndView mav = new ModelAndView();
        List<String> areaNames = tripList.stream().map(Area::getAreaName).collect(Collectors.toList());
        Plan.getShortestPath(areaNames);
        mav.setViewName("success");
        return mav;
    }

    @RequestMapping("addTrip")
    public ModelAndView addTrip(Integer id, String territory){
        List<AreaVo> areas = theAreasInTerritory(territory);
        Area area = areaService.getAreaById(id);
        if (isContained(area) == -1){
            tripList.add(area);
        }
        ModelAndView mav = new ModelAndView();
        mav.addObject("tripList", tripList);
        mav.addObject("areas", areas);
        mav.setViewName("index1");
        return mav;
    }

    @RequestMapping("addFirst")
    public ModelAndView addFirst(Integer id, String territory){
        List<AreaVo> areas = theAreasInTerritory(territory);
        Area area = areaService.getAreaById(id);
        int index = isContained(area);
        if (index != -1){
            tripList.remove(index);
        }
        tripList.add(0, area);
        ModelAndView mav = new ModelAndView();
        mav.setViewName("index1");
        mav.addObject("tripList", tripList);
        mav.addObject("areas", areas);
        return mav;
    }

    @RequestMapping("removeTrip")
    public ModelAndView removeTrip(Integer id, String territory){
        List<AreaVo> areas = theAreasInTerritory(territory);
        for (int i = 0; i < tripList.size(); i++){
            if (tripList.get(i).getId() == id){
                tripList.remove(i);
            }
        }
        ModelAndView mav = new ModelAndView();
        mav.setViewName("index1");
        mav.addObject("tripList", tripList);
        mav.addObject("areas", areas);
        return mav;
    }

    private int isContained(Area area){
        for (int i = 0; i < tripList.size(); i++){
            if (area.getAreaName().equals(tripList.get(i).getAreaName())){
                return i;
            }
        }
        return -1;
    }

    private List<AreaVo> theAreasInTerritory(String territory){
        List<Area> areas = areaService.getAreaInfoByTerritory(territory);
        List<AreaVo> areaVos = new ArrayList<>();
        for (Area area : areas){
            AreaVo areaVo = new AreaVo();
            areaVo.setId(area.getId());
            areaVo.setAreaName(area.getAreaName());
            areaVo.setDesc(area.getDescription());
            areaVo.setTerritory(area.getTerritory());
            areaVos.add(areaVo);
        }
        return areaVos;
    }
}
