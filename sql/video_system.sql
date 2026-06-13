-- 视频播放系统数据库脚本
CREATE DATABASE IF NOT EXISTS video_system;
USE video_system;

-- 用户表
CREATE TABLE users (
  id INT PRIMARY KEY AUTO_INCREMENT,
  username VARCHAR(50) NOT NULL UNIQUE,
  password VARCHAR(100) NOT NULL,
  email VARCHAR(100),
  role ENUM('user', 'uploader', 'admin') DEFAULT 'user',
  status INT DEFAULT 1,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 视频表
CREATE TABLE videos (
  id INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  uploader_id INT NOT NULL,
  file_path VARCHAR(500) NOT NULL,
  thumbnail_path VARCHAR(500),
  duration INT DEFAULT 0,
  play_count INT DEFAULT 0,
  status ENUM('draft', 'published', 'rejected') DEFAULT 'draft',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (uploader_id) REFERENCES users(id) ON DELETE CASCADE,
  INDEX idx_uploader (uploader_id),
  INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 观看历史表
CREATE TABLE watch_history (
  id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT NOT NULL,
  video_id INT NOT NULL,
  watch_time INT DEFAULT 0,
  watched_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (video_id) REFERENCES videos(id) ON DELETE CASCADE,
  INDEX idx_user (user_id),
  INDEX idx_video (video_id),
  UNIQUE KEY unique_watch (user_id, video_id, watched_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 视频统计表
CREATE TABLE video_stats (
  id INT PRIMARY KEY AUTO_INCREMENT,
  video_id INT NOT NULL UNIQUE,
  total_play_count INT DEFAULT 0,
  total_views INT DEFAULT 0,
  last_played DATETIME,
  FOREIGN KEY (video_id) REFERENCES videos(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 插入测试数据
INSERT INTO users (username, password, email, role) VALUES
('user1', '123456', 'user1@example.com', 'user'),
('uploader1', '123456', 'uploader1@example.com', 'uploader'),
('admin', '123456', 'admin@example.com', 'admin');

COMMIT;
