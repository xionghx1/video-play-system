<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.video.model.Video" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户首页 - 视频播放系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .navbar { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 15px 30px; color: white; display: flex; justify-content: space-between; align-items: center; }
        .navbar .logo { font-size: 24px; font-weight: bold; }
        .navbar .nav-links { display: flex; gap: 20px; }
        .navbar a { color: white; text-decoration: none; }
        .navbar a:hover { text-decoration: underline; }
        .container { padding: 30px; max-width: 1200px; margin: 0 auto; }
        .search-bar { margin-bottom: 30px; }
        .search-bar form { display: flex; gap: 10px; }
        .search-bar input { flex: 1; padding: 10px; border: 1px solid #ddd; border-radius: 5px; }
        .search-bar button { padding: 10px 20px; background: #667eea; color: white; border: none; border-radius: 5px; cursor: pointer; }
        .video-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(250px, 1fr)); gap: 20px; }
        .video-card { background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 8px rgba(0,0,0,0.1); transition: transform 0.3s; }
        .video-card:hover { transform: translateY(-5px); box-shadow: 0 4px 12px rgba(0,0,0,0.15); }
        .video-thumbnail { width: 100%; height: 150px; background: #e0e0e0; display: flex; align-items: center; justify-content: center; color: #999; }
        .video-info { padding: 15px; }
        .video-title { font-weight: bold; margin-bottom: 8px; }
        .video-uploader { color: #666; font-size: 12px; margin-bottom: 8px; }
        .video-stats { color: #999; font-size: 12px; }
        .video-card a { text-decoration: none; color: inherit; display: block; }
    </style>
</head>
<body>
<div class="navbar">
    <div class="logo">🎬 视频播放系统</div>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/user/home.jsp">首页</a>
        <a href="${pageContext.request.contextPath}/user/watch-history.jsp">观看历史</a>
        <a href="${pageContext.request.contextPath}/user/change-password.jsp">修改密码</a>
        <span>欢迎, ${sessionScope.username}</span>
        <a href="${pageContext.request.contextPath}/logout">登出</a>
    </div>
</div>

<div class="container">
    <h2>浏览视频</h2>
    <div class="search-bar">
        <form method="get" action="${pageContext.request.contextPath}/search">
            <input type="text" name="keyword" placeholder="搜索视频...">
            <button type="submit">搜索</button>
        </form>
    </div>

    <div class="video-grid">
        <% 
            @SuppressWarnings("unchecked")
            List<Video> videos = (List<Video>) request.getAttribute("videos");
            if (videos != null && !videos.isEmpty()) {
                for (Video video : videos) {
        %>
        <div class="video-card">
            <a href="${pageContext.request.contextPath}/play?id=<%= video.getId() %>">
                <div class="video-thumbnail">📹</div>
                <div class="video-info">
                    <div class="video-title"><%= video.getTitle() %></div>
                    <div class="video-uploader">上传者: <%= video.getUploaderName() %></div>
                    <div class="video-stats">播放: <%= video.getPlayCount() %> 次</div>
                </div>
            </a>
        </div>
        <% 
                }
            } else {
        %>
        <p>暂无视频</p>
        <% } %>
    </div>
</div>
</body>
</html>
