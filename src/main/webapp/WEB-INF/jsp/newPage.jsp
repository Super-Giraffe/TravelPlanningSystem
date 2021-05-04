<%@ page import="com.example.demo.POJO.User" %>
<%@ page import="com.example.demo.vo.AreaVo" %>
<%@ page import="com.example.demo.POJO.Area" %>
<%@ page import="java.util.List" %>
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

    <!-- 引入样式 -->
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <!-- 引入组件库 -->
    <script src="https://unpkg.com/element-ui/lib/index.js"></script>

    <style type="text/css">
        .right{
            float: right;
        }
        .hr{
            margin-top: 51px;
            margin-bottom: 20px;
            border: 0;
            border-top: 1px solid #eee;
        }
    </style>
</head>
<%
    List<AreaVo> areaVos = (List<AreaVo>) request.getAttribute("areas");
    List<Area> tripList = (List<Area>) request.getAttribute("tripList");
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
            <a class="navbar-brand" href="#">景点路线规划系统</a>
        </div>
        <div>
            <ul class="nav navbar-nav">
                <li><a href="/user/user">用户管理</a></li>
                <li><a href="/area/getAreaByTerritory?territory=西湖区">景点管理</a></li>
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
<div style="display:flex">
    <div style="flex: 3; margin-left: 20px">
        <h2>添加景点</h2>
        <hr class="hr"/></br>
        <%
            if (tripList != null && tripList.size() > 0){
                out.print("<div class='list-group'>");
                for (int index = 0; index < tripList.size(); index++){
                    if (index == 0){
                        out.print("<div style='display:flex'><div style='flex:2'>" + tripList.get(index).getAreaName() + "</div><div style='flex:1'><a href='/area/addFirst?id="+ tripList.get(index).getId() + "&territory="+ tripList.get(index).getTerritory() + "'><button class='btn btn-primary'>  起点  </button></a></div>" + "<div style='flex:1'><a href='/area/removeTrip?id="+ tripList.get(index).getId() + "&territory="+ tripList.get(index).getTerritory() + "'><button class='btn btn-default'>移除</button></a></div></div>");
                    } else {
                        out.print("<div style='display:flex'><div style='flex:2'>" + tripList.get(index).getAreaName() + "</div><div style='flex:1'><a href='/area/addFirst?id="+ tripList.get(index).getId() + "&territory="+ tripList.get(index).getTerritory() + "'><button class='btn btn-primary'>设为起点</button></a></div>" + "<div style='flex:1'><a href='/area/removeTrip?id="+ tripList.get(index).getId() + "&territory="+ tripList.get(index).getTerritory() + "'><button class='btn btn-default'>移除</button></a></div></div>");
                    }
                    out.print("</br>");
                }
                out.print("</div>");
                if (tripList.size() > 1){
                    out.print("<a href='/area/getShortestPath'><button class='btn btn-primary'>规划路线</button></a>");
                }
            };
        %>
    </div>
    <div style="margin-right: 10px;flex: 7; margin-left: 10px">
        <h2>景点选择</h2>
        <div>
            <ul class="nav nav-tabs nav-justified">
                <li role="presentation"><a href="/area/getAreaByTerritory?territory=西湖区">西湖区</a></li>
                <li role="presentation"><a href="/area/getAreaByTerritory?territory=上城区">上城区</a></li>
                <li role="presentation"><a href="/area/getAreaByTerritory?territory=余杭区">余杭区</a></li>
                <li role="presentation"><a href="/area/getAreaByTerritory?territory=滨江区">滨江区</a></li>
                <li role="presentation"><a href="/area/getAreaByTerritory?territory=其他">其他</a></li>
            </ul>
        </div>
        <div class="pull-left">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th width="150px">景点名称</th>
                    <th width="200px">景点图片</th>
                    <th width="200px">地址</th>
                    <th width="100px">门票价格(元)</th>
                    <th width="150px">游玩时间(小时)</th>
                </tr>
                </thead>
                <tbody>
                <%
                    int i = 0;
                    for (AreaVo areaVo : areaVos){
                        out.print("<tr>");
                        out.print("<td width='150px'>"+areaVo.getAreaName()+"</td>");
                        out.print("<td><img src='\\pic\\" + areaVo.getAreaName() + ".jpg' width = '200px'></td>");
                        out.print("<td width='250px'>"+areaVo.getAddress()+"</td>");
                        out.print("<td width='100px'>"+areaVo.getPrice()+"</td>");
                        out.print("<td width='150px'>"+areaVo.getSpendTime()+"</td>");
                        out.print("<td><a href='/area/addTrip?id="+ areaVo.getId() + "&territory=" + areaVo.getTerritory() + "'><button class='btn btn-primary'>添加行程</button></a></td>");
                        out.print("<td><button class='btn btn-primary ' data-toggle='modal' data-target='#detailModal" + i + "'>景点详情</button>" +
                                "<div class='modal fade' id='detailModal" + i + "' tabindex='-1' role='dialog' aria-labelledby='myModalLabel' aria-hidden='true'>" +
                                "<div class='modal-dialog'>" +
                                "<div class='modal-content'>" +
                                "<div class='modal-header'>" +
                                "<h4 class='modal-title' id='myModalLabel'>景点详情</h4>" +
                                "<button type='button' class='close' data-dismiss='modal' aria-hidden='true'>&times;</button>" +
                                "</div>" +
                                "<div class='modal-body'>" +
                                areaVo.getDesc() +
                                "</div>" +
                                "</div>" +
                                "</div>" +
                                "</div>" +
                                "</td>");
                        out.print("</tr>");
                        i++;
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>