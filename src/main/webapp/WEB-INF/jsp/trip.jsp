<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">

    <title>高德地图展示</title>

    <!-- 新 Bootstrap 核心 CSS 文件 -->
    <link href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">

    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script src="https://cdn.staticfile.org/jquery/2.1.1/jquery.min.js"></script>

    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="http://cache.amap.com/lbs/static/main1119.css"/>

    <script src="http://cache.amap.com/lbs/static/es5.min.js"></script>
    <!-- 这里要配置参数key,将其值设置为高德官网开发者获取的key -->
    <script src="http://webapi.amap.com/maps?v=1.3&key=da2ff7b121b8769eb7cd21071ac29bb0"></script>

    <script type="text/javascript" src="http://cache.amap.com/lbs/static/addToolbar.js"></script>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

    <style type="text/css">

        .center{
            text-align: center;
        }

        .jt{
            line-height: 4;
        }

        .card {
            box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
            transition: 0.3s;
            width: 100%;
            border-radius: 5px;
            font-size: 18px;
            text-align: center;
        }

        #container1{
            position: absolute;
            top: 0px;
            left: 300px;
            right: 0;
            bottom: 0;
        }
        #container2{
            position: absolute;
            top: 0px;
            left: 0px;
            width: 300px;
            bottom: 0;
        }
</style>
</head>
<body>
<div>
    <div id="container2">
        <%
            out.print("<div class='center'><h1>规划路径如下:</h1><br></div>");
            List<String> lines = (List<String>) request.getAttribute("lines");
            for (int i = 0; i < lines.size() - 1; i++){
                out.print("<div class='card' >" + lines.get(i) + "<br></div>");
                out.print("<div style='text-align: center; height:50px'><span class='glyphicon glyphicon-arrow-down jt'></span><br></div>");
            }
            out.print("<div class='card'>" + lines.get(lines.size() - 1) + "<br></div>");
            out.print("<a href='/area/getAreaByTerritory?territory=西湖区' rel='external nofollow' class='btn btn-default' id='btn-reg' style='margin-left:240px; margin-top:40px'>返回</a>");
        %>
    </div>
    <div id="container1"></div>
</div>


<script>
    let t = new Array();
    <%
        List<String> places = (List<String>) request.getAttribute("places");
    %>
    <%   for(int i = 0;i < places.size(); i++){   %>
        t[<%=i%>] = " <%=places.get(i)%> ";
    <%   }   %>
    var path = []
    for(let i = 0; i < t.length; i++){
        let a = t[i].split(',')
        path.push(new AMap.LngLat(parseFloat(a[0]), parseFloat(a[1])))
    }
    var map = new AMap.Map('container1', {
        resizeEnable: true,
        zoom:11,
        center: [120.2, 30.3]

    });
    // 创建折线实例
    var polyline = new AMap.Polyline({
        path: path,
        borderWeight: 2, // 线条宽度，默认为 1
        strokeColor: 'red', // 线条颜色
        lineJoin: 'round', // 折线拐点连接处样式
        showDir: true
    });

    // 将折线添加至地图实例
    map.add(polyline);
    var icon = new AMap.Icon({
        size: new AMap.Size(40, 50),    // 图标尺寸
        image: 'http://a.amap.com/jsapi_demos/static/demo-center/icons/dir-via-marker.png',  // Icon的图像
        imageOffset: new AMap.Pixel(0, -60),  // 图像相对展示区域的偏移量，适于雪碧图等
        imageSize: new AMap.Size(40, 50)   // 根据所设置的大小拉伸或压缩图片
    });
    var marker = new AMap.Marker({
        position: new AMap.LngLat(120.156873,30.260671),
        offset: new AMap.Pixel(-10, -10),
        icon: icon, // 添加 Icon 实例
        title: '北京',
        zoom: 13
    });
    map.add(marker)

</script>
</body>
</html>