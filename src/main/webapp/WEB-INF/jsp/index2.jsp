<%@ page import="java.util.List" %>
<%@ page import="com.example.demo.POJO.Area" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.bootcss.com/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.bootcss.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script type="text/javascript">
        function del() {
            if(!confirm("确认要删除？")) {
                window.event.returnValue = false;
            }
        }
    </script>
    <title>景点信息管理系统</title>
    <style type="text/css">
        .block{
            width: 1000px;
            height: 50px;
            background-color: #ccc;
            border-radius: 10px;
            margin: 0 auto;
        }
        h3{
            text-align: center;
            padding-top: 12px;
            font-family: "微软雅黑";
        }
        body {
            /*background-color: #eee;*/
        }

        form h1 {
            display: inline-block;
            width: 820px;
        }

        .check {
            padding: 30px 30px;
        }

        form {
            display: inline;
        }

        .contain {
            float: right;
            width: 1000px;
            border-radius: 10px;
            border: 1px #bbb solid;
            background-color: #eee;
            padding-top: 20px;
        }

        button {
            margin-left: 10px;
        }

        .search {
            display: inline-block;
            margin-left: 500px;
        }

        .add {
            float: right;
            margin-right: 50px;
        }
        .pageNav{
            margin-left: 200px;
        }
    </style>
</head>
<body>
<div class="block">
    <h3>欢迎使用景点信息管理系统</h3>
</div>
<div style="display: flex;justify-content: center">
    <div class="contain">
        <%
            int start = (Integer) request.getAttribute("start");
            List<Area> areas = (List<Area>)request.getAttribute("areas");
            String name = (String) request.getAttribute("name");
            if (name == null){
                name = "";
            }
        %>
        <form action="/area/getAreaByName" class="form-inline">
            <h2>景点信息管理</h2>
            <div class="form-group search">
                <input type="text" name="name" value="<%=name%>" class="form-control" placeholder="请输入景区名称"/>
                <input type="hidden" name="start" value="<%=start%>">
                <input type="submit" name="submit" class="btn" value="搜索" />
            </div>
        </form>
        <button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">添加</button>
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="myModalLabel">添加景点信息</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body">
                        <form action="/area/insert" class="form-signin" method="post">
                            <div id="info">
                            </div>
                            <label>景点名称</label>
                            <input type="text" name="areaName" id="areaName" class="form-control" placeholder="请输入景点名称" required autofocus><br>
                            <label>地址</label>
                            <input type="text" name="address" id="address" class="form-control" placeholder="请输入地址" required autofocus><br>
                            <label>门票价格</label>
                            <input type="text" name="price" id="price" class="form-control" placeholder="请输入门票价格" required autofocus><br>
                            <label>游玩时间</label>
                            <input type="text" name="spendTime" id="spendTime" class="form-control" placeholder="请输入游玩时间" required autofocus><br>
                            <label>所在行政区</label>
                            <select name="territory" id="territory" class="form-control" required autofocus>
                                <option value ="西湖区">西湖区</option>
                                <option value ="上城区">上城区</option>
                                <option value="余杭区">余杭区</option>
                                <option value="滨江区">滨江区</option>
                                <option value="其他">其他</option>
                            </select>
                            <label>详细描述</label>
                            <input type="text" name="description" id="description" class="form-control" placeholder="请输入详细描述" required autofocus><br>
                            <input type="hidden" name="start" value="<%=start%>">
                            <div style="display: flex;justify-content: flex-end">
                                <button type="button" class="btn btn-default" data-dismiss="modal" >关闭</button>
                                <button type="submit" class="btn btn-primary">提交</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="pull-left">
            <table class="table table-hover">
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
                    int edit = 0;
                    int pageSize = 10;//指定数据库一次读取多少行
                    int pagesCount = 0;//用于数据库最后读出所有行后总共有多少页
                    int lastRow = ((List<Area>)(request.getAttribute("all"))).size();//记录数据库的最后一行
                    for (Area area : areas){
                        out.print("<tr>");
                        out.print("<td>"+area.getAreaName()+"</td>");
                        out.print("<td>"+area.getAddress()+"</td>");
                        out.print("<td>"+area.getPrice()+"</td>");
                        out.print("<td>"+area.getSpendTime()+"</td>");
                        out.print("<td>"+area.getTerritory()+"</td>");
                        out.print("<td>" +
                                "<button class=\"btn btn-primary\" data-toggle=\"modal\" data-target=\"#editModal" + edit + "\">编辑</button>" +
                                "<div class=\"modal fade\" id=\"editModal" + edit + "\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"myModalLabel\" aria-hidden=\"true\">" +
                                    "<div class=\"modal-dialog\">" +
                                        "<div class=\"modal-content\">" +
                                            "<div class=\"modal-header\">" +
                                                "<h4 class=\"modal-title\" id=\"myModalLabel\">编辑景点信息</h4>" +
                                                "<button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\">&times;</button>" +
                                            "</div>" +
                                            "<div class=\"modal-body\">" +
                                                "<form action=\"/area/update\" class=\"form-signin\" method=\"post\">" +
                                                    "<input type=\"hidden\" name=\"id\" id=\"id\" value=\"" + area.getId() + "\">" +
                                                    "<label>景点名称</label>" +
                                                    "<input type=\"text\" name=\"areaName\" id=\"areaName\" value=\"" + area.getAreaName() +  "\" class=\"form-control\" required autofocus><br>" +
                                                    "<label>地址</label>" +
                                                    "<input type=\"text\" name=\"address\" id=\"address\" value=\"" + area.getAddress() + "\" class=\"form-control\" required autofocus><br>" +
                                                    "<label>门票价格</label>" +
                                                    "<input type=\"text\" name=\"price\" id=\"price\" value=\"" + area.getPrice() + "\" class=\"form-control\" required autofocus><br>" +
                                                    "<label>游玩时间</label>" +
                                                    "<input type=\"text\" name=\"spendTime\" id=\"spendTime\" value=\"" + area.getSpendTime() + "\" class=\"form-control\" required autofocus><br>" +
                                                    "<label>所在行政区</label>" +
                                                    "<input type=\"text\" name=\"territory\" id=\"territory\" value=\"" + area.getTerritory() + "\" class=\"form-control\" required autofocus><br>" +
                                                    "<label>详细描述</label>" +
                                                    "<input type=\"text\" name=\"description\" id=\"description\" value=\"" + area.getDescription() + "\" class=\"form-control\" required autofocus><br>" +
                                                    "<input type=\"hidden\" name=\"start\" value=\"" + start + "\">" +
                                                    "<div style=\"display: flex;justify-content: flex-end\">" +
                                                       "<button type=\"button\" class=\"btn btn-default\" data-dismiss=\"modal\" >关闭</button>" +
                                                        "<button type=\"submit\" class=\"btn btn-primary\">提交</button>" +
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
            <div class="pageNav">
                <ul class="pagination">
                    <%
                        int prePage;//上一页的页数
                        if(start == 1){
                            prePage = 1;//若当前页是第一页，则第一页只能是当前页
                        }else{
                            prePage = start - 1;//除了上述情况外上一页等于当前页-1页
                        }
                    %>
                    <li class="page-item"><a class="page-link" href="/area/getAreaByName?name=<%=name%>&start=<%=prePage%>">上一页</a></li>
                    <%
                        pagesCount = (lastRow % pageSize == 0) ? (lastRow / pageSize) : (lastRow / pageSize + 1);//计算数据库能读出来的全部页数
                        int minpages = (start - 3 > 0) ? (start - 3) : 1;//设定最小页，防止页数小于第一页
                        int maxpages = (start + 3 >= pagesCount) ? (pagesCount) : (start + 3);//设定最大页
                        for(int i = minpages; i <= maxpages ; i++){
                            if(i == start){//当前页和遍历出来的页数相等时，需要通过调用css里面的样式“active"进行高亮
                                out.print("<li class='page-item active'>");
                                out.print("<a class='page-link' href='/area/getAreaByName?name=" + name + "&start=" + i + "'>" + i + "</a>");
                                out.print("</li>");
                            }else{//输出每一个分页
                                out.print("<li class='page-item'>");
                                out.print("<a class='page-link' href='/area/getAreaByName?name=" + name + "&start=" + i+ "'>" + i + "</a>");
                                out.print("</li>");
                            }
                        }
                    %>
                    <%
                        int nextPage;
                        if(start == pagesCount){//下一页的原理和上一页同理
                            nextPage = pagesCount;
                        }else{
                            nextPage = start + 1;
                        }
                    %>
                    <li class="page-item"><a class="page-link" href="/area/getAreaByName?name=<%=name%>&start=<%=nextPage%>">下一页</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
</body>
</html>