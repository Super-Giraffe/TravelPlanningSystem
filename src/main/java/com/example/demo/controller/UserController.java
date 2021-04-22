package com.example.demo.controller;

import com.example.demo.POJO.Area;
import com.example.demo.POJO.User;
import com.example.demo.service.AreaService;
import com.example.demo.service.UserService;
import com.example.demo.vo.AreaVo;
import com.example.demo.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.View;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("user")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private AreaService areaService;

    @RequestMapping("/welcome")
    public String welcome(){
        return "login";
    }

    @RequestMapping("/registerPage")
    public String registerPage(){
        return "register";
    }

    @RequestMapping("/register")
    public ModelAndView register(UserVo userVo){
        ModelAndView mav = new ModelAndView();
        User user = new User();
        User oldUser = userService.getUserByName(userVo.getUserName());
        if (oldUser != null){
            //用户名已存在
            mav.setViewName("register");
            mav.addObject("message", "用户名存在!");
            return mav;
        }
        if (!userVo.getPassword1().equals(userVo.getPassword2())){
            //两次密码不一致
            mav.setViewName("register");
            mav.addObject("message", "两次密码不一致");
            return mav;
        }
        user.setUserName(userVo.getUserName());
        user.setPassword(userVo.getPassword1());
        user.setAge(userVo.getAge());
        user.setSexId(userVo.getSexId());
        user.setPhone(userVo.getPhone());
        userService.registerUser(user);
        //注册成功，跳转到登录页面
        mav.setViewName("login");
        return mav;
    }

    @RequestMapping("/login")
    public ModelAndView login(String userName, String password){
        ModelAndView mav = new ModelAndView();
        User user = userService.getUserByName(userName);
        if (user == null){
            //用户不存在
            mav.setViewName("login");
            mav.addObject("message", "用户不存在!");
            return mav;
        }
        if (!user.getPassword().equals(password)){
            //密码错误
            mav.setViewName("login");
            mav.addObject("message", "密码错误");
            return mav;
        }
        if (user.getAdmin() == 1){
            List<Area> areas = areaService.getAreaByName(null, 1, 10);
            List<Area> all = areaService.getAllAreas();
            //管理员账号进入后台界面
            mav.addObject("all", all);
            mav.addObject("start", 1);
            mav.addObject("areas", areas);
            mav.setViewName("index2");
        } else {
            //其他账号进入系统界面
            List<Area> areas = areaService.getAreaInfoByTerritory("西湖区");
            List<AreaVo> areaVos = new ArrayList<>();
            for (Area area : areas){
                AreaVo areaVo = new AreaVo();
                areaVo.setId(area.getId());
                areaVo.setAreaName(area.getAreaName());
                areaVo.setDesc(area.getDescription());
                areaVo.setTerritory(area.getTerritory());
                areaVos.add(areaVo);
            }
            mav.setViewName("index1");
            mav.addObject("areas" ,areaVos);
        }
        //跳转到系统页面
        return mav;
    }
}