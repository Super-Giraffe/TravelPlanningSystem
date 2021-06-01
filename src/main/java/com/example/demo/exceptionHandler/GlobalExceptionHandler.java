package com.example.demo.exceptionHandler;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@ControllerAdvice //@ControllerAdvice 该注解定义全局异常处理类
public class GlobalExceptionHandler {
    @ExceptionHandler(value = Exception.class) //@ExceptionHandler 该注解声明异常处理方法
    public ModelAndView defaultErrorHandler(HttpServletRequest req, Exception e) throws Exception {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("login"); //设置视图名称
        return mav;
    }
}
