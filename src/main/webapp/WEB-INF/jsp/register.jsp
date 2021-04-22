<%@ page contentType="text/html; charset=utf-8" language="java"%>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>注册</title>
    <%--<link href="css/bootstrap.min.css" rel="external nofollow" rel="external nofollow" rel="external nofollow" rel="external nofollow" rel="external nofollow" rel="stylesheet">--%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-4">
        </div>
        <div class="col-md-4">
            <form class="form-signin" action="/user/register" method="post">
                <h2 class="form-signin-heading">注册用户</h2>
                <div id="info">
                </div>
                <label>用户名</label>
                <input type="text" name="userName" id="userName" class="form-control" placeholder="请输入用户名" required autofocus><br>
                <label>密码</label>
                <input type="password" name="password1" id="password1" class="form-control" placeholder="请输入密码" required><br>
                <label>确认密码</label>
                <input type="password" name="password2" id="password2" class="form-control" placeholder="请再次输入密码" required maxLength="16"><br>
                <label>年龄</label>
                <input type="text" name="age" id="age" class="form-control" placeholder="请输入年龄" required autofocus><br>
                <label>手机号</label>
                <input type="text" name="phone" id="phone" class="form-control" placeholder="请输入手机号" required autofocus><br>
                <label>性别</label>
                <label><input type = "radio" name = "sexId" value="0" required autofocus>男</label>
                <label><input type = "radio" name = "sexId" value="0" required autofocus>女</label><br>
                <button type="submit" class="btn btn-primary" id="btn_reg">注册</button>
                <a href="/user/welcome" rel="external nofollow" class="btn btn-default" id="btn-reg">返回登录</a>
            </form>
            <%
                String message = (String) request.getAttribute("message");
            %>
            <%
                if(message != null){
                    out.println("<div class='alert alert-danger' role='alert'>"+ message + "</div>");
                }
            %>
        </div>
        <div class="col-md-4">
        </div>
    </div>
</div>
</body>
</html>