<%@ page import="com.example.demo.POJO.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- 新 Bootstrap 核心 CSS 文件 -->
    <link href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>

    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <style type="text/css">
        .right{
            float: right;
        }
    </style>
</head>
<%
    User user = (User) request.getAttribute("user");
    String url = "/area/view";
    if (user.getAdmin() == 0){
        url = "/area/getAreaByTerritory?territory=西湖区";
    }
%>
<body>
<nav class="navbar navbar-default" role="navigation">
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="myModalLabel">修改密码</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">
                    <form action="/area/changePwd" id="form" class="form-signin" method="post">
                        <div id="info">
                        </div>
                        <input type="hidden" name="id" value="<%=user.getId()%>">
                        <input type="hidden" name="flag" value="1">
                        <label>新密码</label>
                        <input type="password" name="password1" id="password1" class="form-control" placeholder="请输入新密码" required autofocus><br>
                        <label>确认密码</label>
                        <input type="password" name="password2" id="password2" class="form-control" placeholder="请输入确认密码" required autofocus onkeyup="check()"><span id="tip"></span><br>
                        <div style="display: flex;justify-content: flex-end">
                            <button type="button" class="btn btn-default" data-dismiss="modal" >关闭</button>
                            <button type="submit" id="submit" class="btn btn-primary">提交</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="#">景点信息管理系统</a>
        </div>
        <div>
            <ul class="nav navbar-nav">
                <li><a href="/user/user">用户管理</a></li>
                <li><a href="<%=url%>">景点管理</a></li>
            </ul>
            <div class="right">
                <ul class="nav navbar-nav">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <%
                                out.print(user.getUserName());
                            %>
                            <b class="caret"></b>
                        </a>
                        <ul class="dropdown-menu">
                            <li><a data-toggle="modal" data-target="#myModal">修改密码</a></li>
                            <li><a href="/user/welcome">退出系统</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</nav>
</body>
</html>