<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.video.model.Video" %>
<%@ page import="com.video.service.VideoService" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>上传者后台 - 视频播放系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .navbar { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 15px 30px; color: white; display: flex; justify-content: space-between; align-items: center; }
        .navbar a { color: white; text-decoration: none; margin-left: 20px; }
        .container { padding: 30px; max-width: 1200px; margin: 0 auto; }
        .dashboard { display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 20px; margin-bottom: 30px; }
        .stat-card { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); text-align: center; }
        .stat-value { font-size: 32px; font-weight: bold; color: #667eea; }
        .upload-btn { padding: 10px 20px; background: #667eea; color: white; border: none; border-radius: 5px; cursor: pointer; margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background: #f5f5f5; font-weight: bold; }
        .btn-small { padding: 5px 10px; margin: 0 3px; border: none; border-radius: 3px; cursor: pointer; }
        .btn-edit { background: #3498db; color: white; }
        .btn-delete { background: #e74c3c; color: white; }
    </style>
</head>
<body>
<div class="navbar">
    <div>🎬 视频播放系统 - 上传者后台</div>
    <div>
        <a href="${pageContext.request.contextPath}/uploader/upload.jsp">上传视频</a>
        <a href="${pageContext.request.contextPath}/logout">登出</a>
    </div>
</div>

<div class="container">
    <h2>欢迎, ${sessionScope.username}</h2>
    
    <% 
        Integer uploaderId = (Integer) session.getAttribute("userId");
        VideoService videoService = new VideoService();
        List<Video> videos = videoService.getUploaderVideos(uploaderId);
        int totalCount = videos.size();
        int totalPlay = 0;
        for (Video v : videos) {
            totalPlay += v.getPlayCount();
        }
    %>
    
    <div class="dashboard">
        <div class="stat-card">
            <div>我的视频数</div>
            <div class="stat-value"><%= totalCount %></div>
        </div>
        <div class="stat-card">
            <div>总播放次数</div>
            <div class="stat-value"><%= totalPlay %></div>
        </div>
        <div class="stat-card">
            <div>平均播放</div>
            <div class="stat-value"><%= totalCount > 0 ? totalPlay / totalCount : 0 %></div>
        </div>
    </div>

    <h3>我的视频</h3>
    <button class="upload-btn" onclick="window.location.href='${pageContext.request.contextPath}/uploader/upload.jsp'">+ 上传新视频</button>
    
    <table>
        <thead>
            <tr>
                <th>视频标题</th>
                <th>状态</th>
                <th>播放次数</th>
                <th>上传时间</th>
                <th>操作</th>
            </tr>
        </thead>
        <tbody>
            <% 
                if (videos != null && !videos.isEmpty()) {
                    for (Video video : videos) {
            %>
            <tr>
                <td><%= video.getTitle() %></td>
                <td><%= video.getStatus() %></td>
                <td><%= video.getPlayCount() %></td>
                <td><%= video.getCreatedAt() %></td>
                <td>
                    <button class="btn-small btn-edit">编辑</button>
                    <button class="btn-small btn-delete">删除</button>
                </td>
            </tr>
            <% 
                    }
                } else {
            %>
            <tr>
                <td colspan="5">还没有上传任何视频</td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
