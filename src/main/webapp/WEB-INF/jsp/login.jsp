<%@ page contentType="text/html; charset=utf-8" language="java"%>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>登录</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
</head>
<html>
<body class="container">
    <div class="row">
        <div class="col-md-4">
        </div>
        <div class="col-md-4">
            <form class="form-signin" method="post" action="/user/login">
                <h2 class="form-signin-heading">欢迎来到旅行规划系统</h2>
                <label>用户名</label>
                <input type="text" name="userName" id="userName" class="form-control" placeholder="请输入用户名" required autofocus><br>
                <label>密码</label>
                <input type="password" name="password" id="password" class="form-control" placeholder="请输入密码" required>
                <div class="checkbox">
                    <label>
                        <input type="checkbox" value="remember-me" checked="checked">记住密码
                    </label>
                </div>
                <button type="submit" class="btn btn-primary" id="btn-login">登录</button>
                <a href="/user/registerPage" rel="external nofollow" class="btn btn-default">注册</a>
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
</body>
</html>
