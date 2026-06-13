<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>修改密码 - 视频播放系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .navbar { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 15px 30px; color: white; display: flex; justify-content: space-between; align-items: center; }
        .navbar a { color: white; text-decoration: none; margin-left: 20px; }
        .container { padding: 30px; max-width: 600px; margin: 0 auto; }
        .form-container { background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: bold; }
        .form-group input { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; box-sizing: border-box; }
        .btn { padding: 10px 20px; background: #667eea; color: white; border: none; border-radius: 5px; cursor: pointer; }
        .message { padding: 10px; margin-bottom: 15px; border-radius: 5px; }
        .success { background: #d4edda; color: #155724; }
        .error { background: #f8d7da; color: #721c24; }
    </style>
</head>
<body>
<div class="navbar">
    <div>🎬 视频播放系统</div>
    <div>
        <a href="${pageContext.request.contextPath}/user/home.jsp">首页</a>
        <a href="${pageContext.request.contextPath}/logout">登出</a>
    </div>
</div>

<div class="container">
    <div class="form-container">
        <h2>修改密码</h2>
        
        <% if (request.getAttribute("message") != null) { %>
        <div class="message success">${requestScope.message}</div>
        <% } %>
        
        <% if (request.getAttribute("error") != null) { %>
        <div class="message error">${requestScope.error}</div>
        <% } %>
        
        <form method="post" action="${pageContext.request.contextPath}/changePassword">
            <div class="form-group">
                <label for="oldPassword">旧密码</label>
                <input type="password" id="oldPassword" name="oldPassword" required>
            </div>
            <div class="form-group">
                <label for="newPassword">新密码</label>
                <input type="password" id="newPassword" name="newPassword" required>
            </div>
            <div class="form-group">
                <label for="confirmPassword">确认新密码</label>
                <input type="password" id="confirmPassword" name="confirmPassword" required>
            </div>
            <button type="submit" class="btn">修改密码</button>
        </form>
    </div>
</div>
</body>
</html>
