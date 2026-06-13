<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.video.model.WatchHistory" %>
<%@ page import="com.video.service.WatchHistoryService" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>观看历史 - 视频播放系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .navbar { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 15px 30px; color: white; display: flex; justify-content: space-between; align-items: center; }
        .navbar a { color: white; text-decoration: none; margin-left: 20px; }
        .container { padding: 30px; max-width: 1000px; margin: 0 auto; }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background: #f5f5f5; font-weight: bold; }
        tr:hover { background: #f9f9f9; }
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
    <h2>观看历史</h2>
    <% 
        WatchHistoryService service = new WatchHistoryService();
        Integer userId = (Integer) session.getAttribute("userId");
        List<WatchHistory> histories = service.getUserWatchHistory(userId);
    %>
    <table>
        <thead>
            <tr>
                <th>视频标题</th>
                <th>观看时长(秒)</th>
                <th>观看时间</th>
            </tr>
        </thead>
        <tbody>
            <% 
                if (histories != null && !histories.isEmpty()) {
                    for (WatchHistory h : histories) {
            %>
            <tr>
                <td><%= h.getVideoTitle() %></td>
                <td><%= h.getWatchTime() %></td>
                <td><%= h.getWatchedAt() %></td>
            </tr>
            <% 
                    }
                } else {
            %>
            <tr>
                <td colspan="3">暂无观看记录</td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
