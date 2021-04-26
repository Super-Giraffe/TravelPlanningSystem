<%@ page import="com.example.demo.POJO.Area" %>
<%@ page import="java.util.List" %>
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

    <link rel="stylesheet" href="../css/iconfont.css">

    <script type="text/javascript">
        function del() {
            if(!confirm("确认要删除？")) {
                window.event.returnValue = false;
            }
        }
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

    <style type="text/css">
        .right{
            float: right;
        }
    </style>
</head>
<%
    //当前页面
    int start = (Integer) request.getAttribute("start");
    //展示的景点信息
    List<Area> areas = (List<Area>)request.getAttribute("areas");
    //景点总数
    int all = (int) request.getAttribute("all");
    //页面数
    int pageCount = all % 10 == 0 ? all / 10 : all / 10 + 1;
    //搜索名称
    String name = (String) request.getAttribute("name");
    if (name == null){
        name = "";
    }
    User user = (User) request.getAttribute("user");
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
                <li><a href="/area/view">景点管理</a></li>
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
<table class="table table-striped">
    <thead>
    <tr>
        <th>景点名称</th>
        <th>地址</th>
        <th>门票价格(元)</th>
        <th>游玩时间(小时)</th>
        <th>所在行政区</th>
    </tr>
    </thead>
    <tbody>
    <%
        for (Area area : areas){
            int edit = 0;
            out.print("<tr>");
            out.print("<td>"+area.getAreaName()+"</td>");
            out.print("<td>"+area.getAddress()+"</td>");
            out.print("<td>"+area.getPrice()+"</td>");
            out.print("<td>"+area.getSpendTime()+"</td>");
            out.print("<td>"+area.getTerritory()+"</td>");
            out.print("<td>" +
                    "<button class='icon' data-toggle='modal' data-target='#editModal" + edit + "'>编辑</button>" +
                    "<div class='modal fade' id='editModal" + edit + "' tabindex='-1' role='dialog' aria-labelledby='myModalLabel' aria-hidden='true'>" +
                    "<div class='modal-dialog'>" +
                    "<div class='modal-content'>" +
                    "<div class='modal-header'>" +
                    "<h4 class='modal-title' id='myModalLabel'>编辑景点信息</h4>" +
                    "<button type='button' class='close' data-dismiss='modal' aria-hidden='true'>&times;</button>" +
                    "</div>" +
                    "<div class='modal-body'>" +
                    "<form action='/area/update' class='form-signin' method='post'>" +
                    "<input type='hidden' name='id' id='id' value='" + area.getId() + "'>" +
                    "<label>景点名称</label>" +
                    "<input type='text' name='areaName' id='areaName' value='" + area.getAreaName() +  "' class='form-control' required autofocus><br>" +
                    "<label>地址</label>" +
                    "<input type='text' name='address' id='address' value='" + area.getAddress() + "' class='form-control' required autofocus><br>" +
                    "<label>门票价格</label>" +
                    "<input type='text' name='price' id='price' value='" + area.getPrice() + "' class='form-control' required autofocus><br>" +
                    "<label>游玩时间</label>" +
                    "<input type='text' name='spendTime' id='spendTime' value='" + area.getSpendTime() + "' class='form-control' required autofocus><br>" +
                    "<label>所在行政区</label>" +
                    "<input type='text' name='territory' id='territory' value='" + area.getTerritory() + "' class='form-control' required autofocus><br>" +
                    "<label>详细描述</label>" +
                    "<input type='text' name='description' id='description' value='" + area.getDescription() + "' class='form-control' required autofocus><br>" +
                    "<input type='hidden' name='start' value='" + start + "'>" +
                    "<div style='display: flex;justify-content: flex-end'>" +
                    "<button type='button' class='btn btn-default' data-dismiss='modal' >关闭</button>" +
                    "<button type='submit' class='btn btn-primary'>提交</button>" +
                    "</div>" +
                    "</form>" +
                    "</div>" +
                    "</div>" +
                    "</div>" +
                    "</div>" +
                    "</td>");
            out.print("<td><a href='/area/delete?id=" + area.getId() + "&start=" + start +"' onclick='javascript:return del();'><button class='btn btn-danger'>删除</button></a></td>");
            out.print("</tr>");
            edit++;
        }
    %>
    </tbody>
</table>
<div class="right">
    <nav aria-label="Page navigation">
        <ul class="pagination">
            <%
                int pre = 1;
                int next = pageCount;
                if (start > 1 && start < pageCount){
                    pre = start - 1;
                    next = start + 1;
                }
                out.print("<li>" +
                    "<a href='/area/getAreaByName?name=" + name + "&start=" + pre + "' aria-label='Previous'>" +
                    "<span aria-hidden='true'>&laquo;</span>" +
                    "</a>" +
                    "</li>");
                for (int i = 1; i <= pageCount; i++){
                    out.print("<li><a href='/area/getAreaByName?name=" + name + "&start=" + i + "'>" + i + "</a></li>");
                }
                out.print("<li>" +
                    "<a href='/area/getAreaByName?name=" + name + "&start=" + next + "' aria-label='Next'>" +
                    "<span aria-hidden='true'>&raquo;</span>" +
                    "</a>" +
                    "</li>");
            %>
        </ul>
    </nav>
</div>
</body>
</html>