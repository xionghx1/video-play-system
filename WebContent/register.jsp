<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户注册 - 视频播放系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        * { margin: 0; padding: 0; }
        body { font-family: Arial, sans-serif; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; display: flex; justify-content: center; align-items: center; }
        .register-container { background: white; padding: 40px; border-radius: 10px; box-shadow: 0 10px 25px rgba(0,0,0,0.2); width: 100%; max-width: 400px; }
        .register-container h1 { text-align: center; color: #333; margin-bottom: 30px; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; color: #555; font-weight: bold; }
        .form-group input, .form-group select { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; box-sizing: border-box; }
        .form-group input:focus, .form-group select:focus { outline: none; border-color: #667eea; }
        .error { color: #e74c3c; margin-bottom: 15px; text-align: center; }
        .register-btn { width: 100%; padding: 10px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border: none; border-radius: 5px; font-weight: bold; cursor: pointer; }
        .register-btn:hover { transform: translateY(-2px); }
        .login-link { text-align: center; margin-top: 20px; }
        .login-link a { color: #667eea; text-decoration: none; font-weight: bold; }
    </style>
</head>
<body>
<div class="register-container">
    <h1>注册新账号</h1>
    
    <% if (request.getAttribute("error") != null) { %>
    <div class="error">${requestScope.error}</div>
    <% } %>
    
    <form method="post" action="${pageContext.request.contextPath}/register">
        <div class="form-group">
            <label for="username">用户名</label>
            <input type="text" id="username" name="username" required>
        </div>
        <div class="form-group">
            <label for="password">密码</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div class="form-group">
            <label for="confirmPassword">确认密码</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required>
        </div>
        <div class="form-group">
            <label for="email">邮箱</label>
            <input type="email" id="email" name="email" required>
        </div>
        <div class="form-group">
            <label for="role">身份选择</label>
            <select id="role" name="role">
                <option value="user">普通用户</option>
                <option value="uploader">视频上传者</option>
            </select>
        </div>
        <button type="submit" class="register-btn">立即注册</button>
    </form>
    
    <div class="login-link">
        <p>已有账号? <a href="${pageContext.request.contextPath}/index.jsp">立即登录</a></p>
    </div>
</div>
</body>
</html>
