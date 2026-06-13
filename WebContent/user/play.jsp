<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.video.model.Video" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>视频播放 - 视频播放系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .navbar { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 15px 30px; color: white; display: flex; justify-content: space-between; align-items: center; }
        .navbar .logo { font-size: 24px; font-weight: bold; }
        .navbar a { color: white; text-decoration: none; margin-left: 20px; }
        .container { padding: 30px; max-width: 1000px; margin: 0 auto; }
        .player { background: black; width: 100%; height: 500px; display: flex; align-items: center; justify-content: center; color: white; font-size: 24px; margin-bottom: 20px; border-radius: 8px; }
        .video-info { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        .video-title { font-size: 28px; font-weight: bold; margin-bottom: 10px; }
        .video-meta { color: #666; margin-bottom: 15px; }
        .video-description { color: #333; line-height: 1.6; }
    </style>
</head>
<body>
<div class="navbar">
    <div class="logo">🎬 视频播放系统</div>
    <div>
        <a href="${pageContext.request.contextPath}/user/home.jsp">返回首页</a>
        <a href="${pageContext.request.contextPath}/logout">登出</a>
    </div>
</div>

<div class="container">
    <% 
        com.video.model.Video video = (com.video.model.Video) request.getAttribute("video");
        if (video != null) {
    %>
    <div class="player">🎬 视频播放器 (此处显示视频)</div>
    
    <div class="video-info">
        <div class="video-title"><%= video.getTitle() %></div>
        <div class="video-meta">
            上传者: <%= video.getUploaderName() %> | 
            时长: <%= video.getDuration() %>秒 | 
            播放次数: <%= video.getPlayCount() %>
        </div>
        <div class="video-description">
            <strong>视频简介:</strong><br>
            <%= video.getDescription() %>
        </div>
    </div>
    <% } else { %>
    <p>视频不存在</p>
    <% } %>
</div>
</body>
</html>
