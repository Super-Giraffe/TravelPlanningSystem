<%@ page import="java.util.List" %>
<%@ page import="com.example.demo.POJO.Area" %>
<%@ page import="com.example.demo.vo.AreaVo" %>
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
    <title>景点路线规划系统</title>
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
    <h3>欢迎使用景点路线规划系统</h3>
</div>
<div style="display: flex;justify-content: center">
    <div class="contain">
        <%
            List<AreaVo> areaVos = (List<AreaVo>) request.getAttribute("areas");
            List<Area> tripList = (List<Area>) request.getAttribute("tripList");
        %>
        <div style="display:flex">
            <div style="flex: 3">
                <h2>添加景点</h2>
                <hr/></br>
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
            <div style="margin-right: 10px;flex: 7">
                <h2>景点选择</h2>
                <div>
                    <a href="/area/getAreaByTerritory?territory=西湖区" target="leftFrame">西湖区</a>
                    <a href="/area/getAreaByTerritory?territory=上城区" target="leftFrame">上城区</a>
                    <a href="/area/getAreaByTerritory?territory=余杭区" target="leftFrame">余杭区</a>
                    <a href="/area/getAreaByTerritory?territory=滨江区" target="leftFrame">滨江区</a>
                    <a href="/area/getAreaByTerritory?territory=其他" target="leftFrame">其他</a>
                </div>
                <div class="pull-left">
                    <table class="table table-striped">
                        <thead>
                        <tr>
                            <th>景点名称</th>
                            <th>景点图片</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            int i = 0;
                            for (AreaVo areaVo : areaVos){
                                out.print("<tr>");
                                out.print("<td>"+areaVo.getAreaName()+"</td>");
                                out.print("<td><img src='\\pic\\" + areaVo.getAreaName() + ".jpg' width = '200px'></td>");
                                out.print("<td><a href='/area/addTrip?id="+ areaVo.getId() + "&territory=" + areaVo.getTerritory() + "'><button class='btn btn-primary'>添加行程</button></a>");
                                out.print("<button class='btn btn-primary ' data-toggle='modal' data-target='#detailModal" + i + "'>景点详情</button>" +
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
    </div>
</div>
</body>
</html>