# 视频播放系统

## 项目简介

本项目是基于 Java、JavaWeb、Servlet、JDBC 和 MVC 模式实现的简易视频播放系统。系统分为三个用户角色：普通用户、视频上传者和系统管理员。

## 功能模块

### 一、普通用户端功能
1. 用户登录，修改个人登录密码
2. 浏览全站视频资源，按标题搜索视频
3. 在线播放视频，查看视频简介信息
4. 查看个人观看历史记录

### 二、视频上传者端功能
1. 上传者账号登录个人视频后台
2. 上传、编辑、删除个人发布视频
3. 查看个人所有视频播放数据
4. 修改视频简介，管理个人视频资源

### 三、系统管理员端功能
1. 超级管理员登录后台
2. 管理普通用户、视频上传者账号（增删改查）
3. 审核全部视频内容，删除违规视频
4. 查看全站视频总量与整体播放数据

## 技术栈

- **后端框架**: JavaWeb (Servlet)
- **数据库**: MySQL
- **持久层**: JDBC
- **设计模式**: MVC 模式
- **前端**: JSP, HTML, CSS, JavaScript
- **安全**: MD5 密码加密

## 项目结构

```
video-play-system/
├── src/com/video/
│   ├── controller/          # 控制层（Servlet）
│   │   ├── LoginServlet.java
│   │   ├── LogoutServlet.java
│   │   └── ...
│   ├── service/             # 业务逻辑层
│   │   ├── UserService.java
│   │   ├── VideoService.java
│   │   └── WatchHistoryService.java
│   ├── dao/                 # 数据访问层（JDBC）
│   │   ├── UserDAO.java
│   │   ├── VideoDAO.java
│   │   └── WatchHistoryDAO.java
│   ├── model/               # 模型类（实体）
│   │   ├── User.java
│   │   ├── Video.java
│   │   └── WatchHistory.java
│   ├── util/                # 工具类
│   │   ├── DBConnection.java
│   │   └── MD5Utils.java
│   └── filter/              # 过滤器（登录验证等）
├── WebContent/
│   ├── index.jsp                # 统一登录入口
│   ├── css/
│   │   └── style.css
│   ├── js/
│   ├── user/                    # 普通用户页面
│   ├── uploader/                # 视频上传者页面
│   └── admin/                   # 系统管理员页面
├── sql/
│   └── video_system.sql         # 数据库脚本
└── README.md
```

## 数据库设计

### 用户表 (users)
- id: 用户ID
- username: 用户名
- password: 密码 (MD5加密)
- email: 邮箱
- role: 用户角色 (user/uploader/admin)
- status: 用户状态 (0=禁用, 1=启用)
- created_at: 创建时间
- updated_at: 更新时间

### 视频表 (videos)
- id: 视频ID
- title: 视频标题
- description: 视频描述
- uploader_id: 上传者ID
- file_path: 文件路径
- thumbnail_path: 缩略图路径
- duration: 时长(秒)
- play_count: 播放次数
- status: 视频状态 (draft/published/rejected)
- created_at: 创建时间
- updated_at: 更新时间

### 观看历史表 (watch_history)
- id: 记录ID
- user_id: 用户ID
- video_id: 视频ID
- watch_time: 观看时长(秒)
- watched_at: 观看时间

### 视频统计表 (video_stats)
- id: 统计ID
- video_id: 视频ID
- total_play_count: 总播放次数
- total_views: 总浏览次数
- last_played: 最后播放时间

## 安装和配置

### 1. 环境要求
- Java JDK 8 或更高版本
- Apache Tomcat 8.0 或更高版本
- MySQL 5.7 或更高版本

### 2. 数据库配置
1. 在 MySQL 中执行 `sql/video_system.sql` 脚本创建数据库和表
2. 修改 `src/com/video/util/DBConnection.java` 中的数据库连接信息

### 3. 项目部署
1. 将项目打包为 WAR 文件
2. 将 WAR 文件放入 Tomcat 的 webapps 目录
3. 重启 Tomcat 服务器

## 默认用户账号

| 用户名 | 密码 | 角色 | 功能描述 |
|--------|------|------|----------|
| user1 | 123456 | user | 普通用户 |
| uploader1 | 123456 | uploader | 视频上传者 |
| admin | 123456 | admin | 系统管理员 |

## 使用说明

### 普通用户
1. 访问首页，使用 user1 账号登录
2. 在首页浏览所有已发布的视频
3. 使用搜索功能查找感兴趣的视频
4. 点击视频进行在线播放
5. 查看个人观看历史记录

### 视频上传者
1. 使用 uploader1 账号登录
2. 进入上传者后台
3. 上传新视频，填写标题和描述
4. 查看所有已上传的视频
5. 编辑或删除视频信息
6. 查看视频播放数据统计

### 系统管理员
1. 使用 admin 账号登录
2. 进入管理员后台
3. 管理所有用户账号
4. 审核并发布或拒绝视频
5. 查看全站统计数据

## API 端点

### 用户相关
- `POST /login` - 用户登录
- `GET /logout` - 用户登出
- `POST /register` - 用户注册
- `POST /changePassword` - 修改密码

### 视频相关
- `GET /videos` - 获取所有已发布视频
- `GET /video/<id>` - 获取视频详情
- `POST /uploadVideo` - 上传视频
- `POST /updateVideo` - 更新视频信息
- `POST /deleteVideo` - 删除视频
- `POST /publishVideo` - 发布视频

### 管理员相关
- `GET /admin/users` - 获取所有用户
- `POST /admin/deleteUser` - 删除用户
- `GET /admin/draftVideos` - 获取未审核视频
- `POST /admin/reviewVideo` - 审核视频

## 常见问题

### Q: 无法连接数据库
A: 请检查 DBConnection.java 中的数据库连接信息是否正确，确保 MySQL 服务已启动。

### Q: 视频文件无法上传
A: 请检查服务器文件上传目录的权限设置，确保 Tomcat 用户有写入权限。

### Q: 登录失败
A: 请检查用户名和密码是否正确，确保用户账号处于启用状态。

## 安全性说明

- 所有密码均采用 MD5 加密存储
- 用户会话采用 HttpSession 管理
- 需要实现登录过滤器验证用户权限
- 数据库操作采用 PreparedStatement 防止 SQL 注入

## 后续功能扩展

1. 实现用户权限验证过滤器
2. 添加视频缩略图处理功能
3. 实现弹幕功能
4. 添加视频推荐算法
5. 支持用户评论功能
6. 实现视频分类管理
7. 添加用户等级系统

## 许可证

MIT License

## 联系方式

如有任何问题或建议，欢迎提出 Issue 或 Pull Request。
