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

    <script type="text/javascript">
        function check() {
            var pwd1 = document.getElementById("password1").value;
            var pwd2 = document.getElementById("password2").value;

            if (pwd1 == pwd2) {
                document.getElementById("tip").innerHTML="<br><font color='green'>两次密码输入一致</font>";
                document.getElementById("submit").disabled = false;
            } else {
                document.getElementById("tip").innerHTML="<br><font color='red'>两次输入密码不一致!</font>";
                document.getElementById("submit").disabled = true;
            }
        }
    </script>
</head>
<%
    User user = (User) request.getAttribute("user");
    String url = "/area/view";
    if (user.getAdmin() == 0){
        url = "/area/getAreaByTerritory?territory=西湖区";
    }
    Integer flag = 0;
    if (request.getAttribute("flag") != null){
        flag = (Integer) request.getAttribute("flag");
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
<%
    out.print("<div style='display:flex'>" +
                "<div class='col-sm-3 col-md-2 sidebar' style='flex: 2; margin-left: 20px'>" +
                    "<ul class='nav nav-sidebar'>" +
                        "<li class='active'><a href='/user/flag/0'>我的账号</a></li>" +
                        "<li><a href='/user/flag/1'>绑定手机</a></li>" +
                        "<li><a href='/user/flag/2'>登录密码</a></li>" +
                    "</ul>" +
                "</div>"
    );
    switch (flag){
        case 0:
            String sex = user.getSexId() == 0 ? "男" : "女";
            out.print("<div class='col-md-4' style='margin-right: 10px;flex: 8; margin-left: 10px; width:200px'>" +
                    "<form class='form-signin' method='post' action='/user/update'>" +
                    "<h2 class='form-signin-heading'>个人信息</h2>" +
                    "<label>用户名:</label>" +
                    "<input type='text' name='userName' id='userName' value='" + user.getUserName() + "' class='form-control' disabled='true'><br>" +
                    "<label>年龄:</label>" +
                    "<input type='text' name='age' id='age' value='" + user.getAge() + "' class='form-control' disabled='true'><br>" +
                    "<label>性别:</label>" +
                    "<input type='text' name='sex' id='sex' value='" + sex + "' class='form-control' disabled='true'><br>" +
                    "<label>手机号:</label>" +
                    "<input type='text' name='phone' id='phone' value='" + user.getPhone() + "' class='form-control' disabled='true'>" +
                    "</form>" +
                    "</div>"
            );
            break;
        case 1:
            out.print("<div class='col-md-4' style='margin-right: 10px;flex: 8; margin-left: 10px; width:200px'>" +
                    "<form class='form-signin' method='post' action='/user/update'>" +
                    "<h2 class='form-signin-heading'>请设置新手机号</h2>" +
                    "<input type='hidden' name='flag' value='2'>" +
                    "<input type='hidden' name='id' value='" + user.getId() + "'>" +
                    "<label>用户名:</label>" +
                    "<input type='text' name='userName' id='userName' value='" + user.getUserName() + "' class='form-control' disabled='true'><br>" +
                    "<label>手机号</label>" +
                    "<input type='text' name='phone' id='phone' class='form-control' placeholder='请输入手机号' required><br>" +
                    "<button type='submit' class='btn btn-primary' id='btn-login'>确定</button>" +
                    "</form>" +
                    "</div>"
            );
            break;
        case 2:
            out.print("<div class='col-md-4' style='margin-right: 10px;flex: 8; margin-left: 10px; width:200px'>" +
                        "<form class='form-signin' method='post' action='/area/changePwd'>" +
                            "<h2 class='form-signin-heading'>请设置新密码</h2>" +
                            "<input type='hidden' name='flag' value='1'>" +
                            "<input type='hidden' name='id' value='" + user.getId() + "'>" +
                            "<label>用户名:</label>" +
                            "<input type='text' name='userName' id='userName' value='" + user.getUserName() + "' class='form-control' disabled='true'><br>" +
                            "<label>密码</label>" +
                            "<input type='password' name='password1' id='password' class='form-control' placeholder='请输入密码' required><br>" +
                            "<button type='submit' class='btn btn-primary' id='btn-login'>确定</button>" +
                        "</form>" +
                    "</div>"
            );
            break;
        default:
            break;
    }
    out.print("</div>");
%>
</body>
</html>