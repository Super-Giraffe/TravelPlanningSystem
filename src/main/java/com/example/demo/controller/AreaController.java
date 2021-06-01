package com.example.demo.controller;

import com.example.demo.POJO.Area;
import com.example.demo.POJO.User;
import com.example.demo.ant_algorithm.Plan;
import com.example.demo.request.RequestInfo;
import com.example.demo.service.AreaService;
import com.example.demo.service.UserService;
import com.example.demo.vo.AreaVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("area")
public class AreaController {

    private List<Area> tripList = new ArrayList<>();

    @Autowired
    private AreaService areaService;

    @Autowired
    private UserService userService;

    @RequestMapping("/view")
    public ModelAndView viewPage(){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("newPage2");
        mav.addAllObjects(getResultMap("", 1));
        return mav;
    }

    @RequestMapping("/getAreaByName")
    public ModelAndView getAreaByName(String name, Integer start){
        ModelAndView mav = new ModelAndView();
        mav.addAllObjects(getResultMap(name, start));
        mav.setViewName("newPage2");
        return mav;
    }

    @RequestMapping("/delete")
    public ModelAndView delete(Integer id, Integer start){
        ModelAndView mav = new ModelAndView();
        areaService.deleteAreaInfo(id);
        mav.addAllObjects(getResultMap("", start));
        mav.setViewName("newPage2");
        return mav;
    }

    @RequestMapping("/insert")
    public ModelAndView insert(Area area, Integer start){
        ModelAndView mav = new ModelAndView();
        areaService.addAreaInfo(area);
        mav.addAllObjects(getResultMap("", start));
        mav.setViewName("newPage2");
        return mav;
    }

    @RequestMapping("/update")
    public ModelAndView update(Area area, Integer start){
        ModelAndView mav = new ModelAndView();
        areaService.updateAreaInfo(area);
        mav.addAllObjects(getResultMap("", start));
        mav.setViewName("newPage2");
        return mav;
    }

    @RequestMapping("getAreaByTerritory")
    public ModelAndView getAreaByTerritory(String territory){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("newPage");
        mav.addAllObjects(getResultMap(territory));
        return mav;
    }

    @RequestMapping("changePwd")
    public ModelAndView changePwd(Integer id, String password1, Integer flag){
        ModelAndView mav = new ModelAndView();
        User user = userService.getUserInfo(id);
        user.setPassword(password1);
        userService.updateUserInfo(user);
        RequestInfo.setInfo("user", user);
        switch (flag){
            case 2:
                mav.setViewName("newPage3");
                mav.addObject("user", user);
                break;
            default:
                mav.setViewName("login");
                break;
        }
        return mav;
    }

    private HashMap<String, Object> getResultMap(String name, Integer start){
        HashMap<String, Object> result = new HashMap<>();
        List<Area> areas = areaService.getAreaByName("%" + name + "%", start, 10);
        List<Area> all = areaService.getAllAreas();
        result.put("all", all.size());
        result.put("areas", areas);
        result.put("start", start);
        result.put("name", name);
        result.put("user", RequestInfo.getInfo("user"));
        return result;
    }

    @RequestMapping("getShortestPath")
    public ModelAndView getShortestPath() throws Exception {
        ModelAndView mav = new ModelAndView();
        List<String> areaNames = tripList.stream().map(Area::getAreaName).collect(Collectors.toList());
        List<List<String>> result = Plan.getShortestPath(areaNames);
        mav.addObject("places", result.get(1));
        mav.addObject("lines", result.get(0));
        mav.setViewName("trip");
        return mav;
    }

    @RequestMapping("addTrip")
    public ModelAndView addTrip(Integer id, String territory){
        Area area = areaService.getAreaById(id);
        User user = (User) RequestInfo.getInfo("user");
        if (isContained(area) == -1){
            areaService.insertUserAndArea(user.getId(), id);
        }
        ModelAndView mav = new ModelAndView();
        mav.addAllObjects(getResultMap(territory));
        mav.setViewName("newPage");
        return mav;
    }

    @RequestMapping("addFirst")
    public ModelAndView addFirst(Integer id, String territory){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("newPage");
        mav.addAllObjects(getResultMap(territory));
        Area area = areaService.getAreaById(id);
        int index = isContained(area);
        if (index != -1){
            tripList.remove(index);
        }
        tripList.add(0, area);
        return mav;
    }

    @RequestMapping("removeTrip")
    public ModelAndView removeTrip(Integer id, String territory){
        User user = (User) RequestInfo.getInfo("user");
        for (int i = 0; i < tripList.size(); i++){
            if (tripList.get(i).getId() == id){
                areaService.deleteUserAndArea(user.getId(), id);
            }
        }
        ModelAndView mav = new ModelAndView();
        mav.setViewName("newPage");
        mav.addAllObjects(getResultMap(territory));
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
            areaVo.setAddress(area.getAddress());
            areaVo.setPrice(area.getPrice());
            areaVo.setSpendTime(area.getSpendTime());
            areaVos.add(areaVo);
        }
        return areaVos;
    }

    private Map<String, Object> getResultMap(String territory){
        User user = (User) RequestInfo.getInfo("user");
        Map<String, Object> resultMap = new HashMap<>();
        List<AreaVo> areas = theAreasInTerritory(territory);
        tripList = areaService.selectUserAndArea(user.getId());
        resultMap.put("tripList", tripList);
        resultMap.put("areas", areas);
        resultMap.put("user", RequestInfo.getInfo("user"));
        return resultMap;
    }
}
