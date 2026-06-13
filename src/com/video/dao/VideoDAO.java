package com.video.dao;

import com.video.model.Video;
import com.video.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * 视频数据访问层
 */
public class VideoDAO {

    /**
     * 新增视频
     */
    public int add(Video video) {
        String sql = "INSERT INTO videos (title, description, uploader_id, file_path, thumbnail_path, duration, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setString(1, video.getTitle());
            pstmt.setString(2, video.getDescription());
            pstmt.setInt(3, video.getUploaderId());
            pstmt.setString(4, video.getFilePath());
            pstmt.setString(5, video.getThumbnailPath());
            pstmt.setInt(6, video.getDuration());
            pstmt.setString(7, video.getStatus() != null ? video.getStatus() : "draft");
            
            int result = pstmt.executeUpdate();
            if (result > 0) {
                ResultSet rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    int videoId = rs.getInt(1);
                    // 插入视频统计记录
                    String statsSql = "INSERT INTO video_stats (video_id, total_play_count, total_views) VALUES (?, 0, 0)";
                    PreparedStatement statsPstmt = conn.prepareStatement(statsSql);
                    statsPstmt.setInt(1, videoId);
                    statsPstmt.executeUpdate();
                    DBConnection.close(conn, statsPstmt);
                    return videoId;
                }
            }
            DBConnection.close(conn, pstmt);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    /**
     * 根据ID查询视频
     */
    public Video findById(int id) {
        String sql = "SELECT v.*, u.username FROM videos v LEFT JOIN users u ON v.uploader_id = u.id WHERE v.id = ?";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                Video video = mapToVideo(rs);
                DBConnection.close(conn, pstmt, rs);
                return video;
            }
            DBConnection.close(conn, pstmt, rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * 查询所有已发布的视频
     */
    public List<Video> findPublished() {
        List<Video> videos = new ArrayList<>();
        String sql = "SELECT v.*, u.username FROM videos v LEFT JOIN users u ON v.uploader_id = u.id " +
                     "WHERE v.status = 'published' ORDER BY v.created_at DESC";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Video video = mapToVideo(rs);
                videos.add(video);
            }
            DBConnection.close(conn, pstmt, rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return videos;
    }

    /**
     * 按标题搜索视频
     */
    public List<Video> searchByTitle(String keyword) {
        List<Video> videos = new ArrayList<>();
        String sql = "SELECT v.*, u.username FROM videos v LEFT JOIN users u ON v.uploader_id = u.id " +
                     "WHERE v.status = 'published' AND v.title LIKE ? ORDER BY v.created_at DESC";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "%" + keyword + "%");
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Video video = mapToVideo(rs);
                videos.add(video);
            }
            DBConnection.close(conn, pstmt, rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return videos;
    }

    /**
     * 获取上传者的视频列表
     */
    public List<Video> findByUploaderId(int uploaderId) {
        List<Video> videos = new ArrayList<>();
        String sql = "SELECT v.*, u.username FROM videos v LEFT JOIN users u ON v.uploader_id = u.id " +
                     "WHERE v.uploader_id = ? ORDER BY v.created_at DESC";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, uploaderId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Video video = mapToVideo(rs);
                videos.add(video);
            }
            DBConnection.close(conn, pstmt, rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return videos;
    }

    /**
     * 更新视频信息
     */
    public boolean update(Video video) {
        String sql = "UPDATE videos SET title = ?, description = ?, status = ? WHERE id = ?";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, video.getTitle());
            pstmt.setString(2, video.getDescription());
            pstmt.setString(3, video.getStatus());
            pstmt.setInt(4, video.getId());
            
            int result = pstmt.executeUpdate();
            DBConnection.close(conn, pstmt);
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * 删除视频
     */
    public boolean delete(int id) {
        String sql = "DELETE FROM videos WHERE id = ?";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            
            int result = pstmt.executeUpdate();
            DBConnection.close(conn, pstmt);
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * 增加播放次数
     */
    public boolean incrementPlayCount(int videoId) {
        String sql = "UPDATE videos SET play_count = play_count + 1 WHERE id = ?";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, videoId);
            
            int result = pstmt.executeUpdate();
            DBConnection.close(conn, pstmt);
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * 获取所有未审核视频
     */
    public List<Video> findDraftVideos() {
        List<Video> videos = new ArrayList<>();
        String sql = "SELECT v.*, u.username FROM videos v LEFT JOIN users u ON v.uploader_id = u.id " +
                     "WHERE v.status = 'draft' ORDER BY v.created_at DESC";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Video video = mapToVideo(rs);
                videos.add(video);
            }
            DBConnection.close(conn, pstmt, rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return videos;
    }

    /**
     * 获取视频总数
     */
    public int getTotalCount() {
        String sql = "SELECT COUNT(*) as cnt FROM videos WHERE status = 'published'";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                int count = rs.getInt("cnt");
                DBConnection.close(conn, pstmt, rs);
                return count;
            }
            DBConnection.close(conn, pstmt, rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * 获取总播放数
     */
    public int getTotalPlayCount() {
        String sql = "SELECT SUM(play_count) as total FROM videos WHERE status = 'published'";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                int total = rs.getInt("total");
                DBConnection.close(conn, pstmt, rs);
                return total;
            }
            DBConnection.close(conn, pstmt, rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * 映射数据库记录到Video对象
     */
    private Video mapToVideo(ResultSet rs) throws SQLException {
        Video video = new Video();
        video.setId(rs.getInt("id"));
        video.setTitle(rs.getString("title"));
        video.setDescription(rs.getString("description"));
        video.setUploaderId(rs.getInt("uploader_id"));
        video.setFilePath(rs.getString("file_path"));
        video.setThumbnailPath(rs.getString("thumbnail_path"));
        video.setDuration(rs.getInt("duration"));
        video.setPlayCount(rs.getInt("play_count"));
        video.setStatus(rs.getString("status"));
        video.setCreatedAt(rs.getTimestamp("created_at"));
        video.setUpdatedAt(rs.getTimestamp("updated_at"));
        try {
            video.setUploaderName(rs.getString("username"));
        } catch (Exception e) {
            // 忽略异常
        }
        return video;
    }
}
