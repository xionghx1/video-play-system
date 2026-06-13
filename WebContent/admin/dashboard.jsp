<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.video.model.User" %>
<%@ page import="com.video.model.Video" %>
<%@ page import="com.video.service.UserService" %>
<%@ page import="com.video.service.VideoService" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>管理员后台 - 视频播放系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .navbar { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 15px 30px; color: white; display: flex; justify-content: space-between; align-items: center; }
        .navbar a { color: white; text-decoration: none; margin-left: 20px; }
        .container { padding: 30px; max-width: 1200px; margin: 0 auto; }
        .dashboard { display: grid; grid-template-columns: 1fr 1fr 1fr 1fr; gap: 20px; margin-bottom: 30px; }
        .stat-card { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); text-align: center; }
        .stat-value { font-size: 32px; font-weight: bold; color: #667eea; margin-top: 10px; }
        .tabs { margin-bottom: 20px; border-bottom: 2px solid #ddd; }
        .tab { display: inline-block; padding: 10px 20px; cursor: pointer; border-bottom: 3px solid transparent; }
        .tab.active { border-bottom-color: #667eea; font-weight: bold; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background: #f5f5f5; font-weight: bold; }
        .btn-small { padding: 5px 10px; margin: 0 3px; border: none; border-radius: 3px; cursor: pointer; }
        .btn-delete { background: #e74c3c; color: white; }
        .btn-publish { background: #27ae60; color: white; }
        .btn-reject { background: #e74c3c; color: white; }
    </style>
</head>
<body>
<div class="navbar">
    <div>🎬 视频播放系统 - 管理员后台</div>
    <div>
        <a href="${pageContext.request.contextPath}/logout">登出</a>
    </div>
</div>

<div class="container">
    <h2>系统概览</h2>
    
    <% 
        UserService userService = new UserService();
        VideoService videoService = new VideoService();
        int totalVideos = videoService.getTotalVideoCount();
        int totalPlays = videoService.getTotalPlayCount();
        List<User> allUsers = userService.getAllUsers();
        List<User> uploaders = userService.getUsersByRole("uploader");
        List<Video> draftVideos = videoService.getDraftVideos();
    %>
    
    <div class="dashboard">
        <div class="stat-card">
            <div>系统用户总数</div>
            <div class="stat-value"><%= allUsers.size() %></div>
        </div>
        <div class="stat-card">
            <div>视频上传者</div>
            <div class="stat-value"><%= uploaders.size() %></div>
        </div>
        <div class="stat-card">
            <div>发布视频总数</div>
            <div class="stat-value"><%= totalVideos %></div>
        </div>
        <div class="stat-card">
            <div>总播放次数</div>
            <div class="stat-value"><%= totalPlays %></div>
        </div>
    </div>

    <div class="tabs">
        <span class="tab active" onclick="showTab('draft')">待审核视频</span>
        <span class="tab" onclick="showTab('users')">用户管理</span>
    </div>

    <div id="draft" class="tab-content">
        <h3>待审核视频 (<%= draftVideos.size() %>)</h3>
        <table>
            <thead>
                <tr>
                    <th>视频标题</th>
                    <th>上传者</th>
                    <th>上传时间</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    if (draftVideos != null && !draftVideos.isEmpty()) {
                        for (Video video : draftVideos) {
                %>
                <tr>
                    <td><%= video.getTitle() %></td>
                    <td><%= video.getUploaderName() %></td>
                    <td><%= video.getCreatedAt() %></td>
                    <td>
                        <button class="btn-small btn-publish">通过</button>
                        <button class="btn-small btn-reject">拒绝</button>
                    </td>
                </tr>
                <% 
                        }
                    } else {
                %>
                <tr>
                    <td colspan="4">暂无待审核视频</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <div id="users" class="tab-content" style="display:none;">
        <h3>用户管理 (<%= allUsers.size() %>)</h3>
        <table>
            <thead>
                <tr>
                    <th>用户名</th>
                    <th>邮箱</th>
                    <th>身份</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    if (allUsers != null && !allUsers.isEmpty()) {
                        for (User user : allUsers) {
                %>
                <tr>
                    <td><%= user.getUsername() %></td>
                    <td><%= user.getEmail() %></td>
                    <td><%= user.getRole() %></td>
                    <td><%= user.getStatus() == 1 ? "启用" : "禁用" %></td>
                    <td>
                        <button class="btn-small btn-delete">删除</button>
                    </td>
                </tr>
                <% 
                        }
                    } else {
                %>
                <tr>
                    <td colspan="5">暂无用户</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>

<script>
    function showTab(tabName) {
        var tabs = document.querySelectorAll('.tab-content');
        tabs.forEach(function(tab) {
            tab.style.display = 'none';
        });
        document.getElementById(tabName).style.display = 'block';
        
        var tabButtons = document.querySelectorAll('.tab');
        tabButtons.forEach(function(btn) {
            btn.classList.remove('active');
        });
        event.target.classList.add('active');
    }
</script>
</body>
</html>
