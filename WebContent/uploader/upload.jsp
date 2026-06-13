<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>上传视频 - 视频播放系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .navbar { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 15px 30px; color: white; display: flex; justify-content: space-between; align-items: center; }
        .navbar a { color: white; text-decoration: none; margin-left: 20px; }
        .container { padding: 30px; max-width: 800px; margin: 0 auto; }
        .form-container { background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; font-weight: bold; }
        .form-group input, .form-group textarea { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; box-sizing: border-box; font-family: Arial; }
        .form-group textarea { min-height: 100px; resize: vertical; }
        .upload-btn { padding: 10px 20px; background: #667eea; color: white; border: none; border-radius: 5px; cursor: pointer; }
    </style>
</head>
<body>
<div class="navbar">
    <div>🎬 视频播放系统</div>
    <div>
        <a href="${pageContext.request.contextPath}/uploader/dashboard.jsp">返回后台</a>
        <a href="${pageContext.request.contextPath}/logout">登出</a>
    </div>
</div>

<div class="container">
    <div class="form-container">
        <h2>上传新视频</h2>
        <form method="post" enctype="multipart/form-data" action="${pageContext.request.contextPath}/uploadVideo">
            <div class="form-group">
                <label for="title">视频标题</label>
                <input type="text" id="title" name="title" required>
            </div>
            <div class="form-group">
                <label for="description">视频描述</label>
                <textarea id="description" name="description" required></textarea>
            </div>
            <div class="form-group">
                <label for="videoFile">视频文件</label>
                <input type="file" id="videoFile" name="videoFile" accept="video/*" required>
            </div>
            <div class="form-group">
                <label for="duration">视频时长(秒)</label>
                <input type="number" id="duration" name="duration" required>
            </div>
            <button type="submit" class="upload-btn">上传视频</button>
        </form>
    </div>
</div>
</body>
</html>
