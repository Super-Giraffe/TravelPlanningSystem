package com.example.demo.controller;

import com.example.demo.POJO.Area;
import com.example.demo.POJO.User;
import com.example.demo.request.RequestInfo;
import com.example.demo.service.AreaService;
import com.example.demo.service.UserService;
import com.example.demo.vo.AreaVo;
import com.example.demo.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;

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

    @RequestMapping("user")
    public ModelAndView userPage(){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("newPage3");
        mav.addObject("user", RequestInfo.getInfo("user"));
        return mav;
    }

    @RequestMapping("/register")
    public ModelAndView register(UserVo userVo){
        ModelAndView mav = new ModelAndView();
        User oldUser = userService.getUserByName(userVo.getUserName());
        if (oldUser != null){
            //用户名已存在
            mav.setViewName("register");
            mav.addObject("message", "用户名已存在!");
            return mav;
        }
        if (!userVo.getPassword1().equals(userVo.getPassword2())){
            //两次密码不一致
            mav.setViewName("register");
            mav.addObject("message", "两次密码不一致");
            return mav;
        }
        User user = copyUser(userVo);
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
            mav.addObject("all", all.size());
            mav.addObject("start", 1);
            mav.addObject("areas", areas);
            mav.setViewName("newPage2");
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
                areaVo.setAddress(area.getAddress());
                areaVo.setPrice(area.getPrice());
                areaVo.setSpendTime(area.getSpendTime());
                areaVos.add(areaVo);
            }
            mav.setViewName("newPage");
            mav.addObject("tripList", areaService.selectUserAndArea(user.getId()));
            mav.addObject("areas" ,areaVos);
        }
        RequestInfo.setInfo("user", user);
        mav.addObject("user", user);
        //跳转到系统页面
        return mav;
    }

    @RequestMapping("/flag/{flag}")
    public ModelAndView getFlag(@PathVariable int flag){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("newPage3");
        mav.addObject("user", RequestInfo.getInfo("user"));
        mav.addObject("flag", flag);
        return mav;
    }

    @RequestMapping("/update")
    public ModelAndView updateUser(UserVo userVo){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("newPage3");
        User user = copyUser(userVo);
        userService.updateUserInfo(user);
        RequestInfo.setInfo("user", userService.getUserInfo(userVo.getId()));
        mav.addObject("user", RequestInfo.getInfo("user"));
        return mav;
    }

    private User copyUser(UserVo userVo){
        User user = new User();
        user.setId(userVo.getId());
        user.setUserName(userVo.getUserName());
        user.setPassword(userVo.getPassword1());
        user.setAge(userVo.getAge());
        user.setSexId(userVo.getSexId());
        user.setPhone(userVo.getPhone());
        return user;
    }
}
