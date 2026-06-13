package com.video.dao;

import com.video.model.WatchHistory;
import com.video.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * 观看历史数据访问层
 */
public class WatchHistoryDAO {

    /**
     * 添加观看记录
     */
    public boolean add(WatchHistory history) {
        String sql = "INSERT INTO watch_history (user_id, video_id, watch_time) VALUES (?, ?, ?)";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, history.getUserId());
            pstmt.setInt(2, history.getVideoId());
            pstmt.setInt(3, history.getWatchTime());
            
            int result = pstmt.executeUpdate();
            DBConnection.close(conn, pstmt);
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * 获取用户的观看历史
     */
    public List<WatchHistory> findByUserId(int userId) {
        List<WatchHistory> histories = new ArrayList<>();
        String sql = "SELECT wh.*, v.title FROM watch_history wh " +
                     "LEFT JOIN videos v ON wh.video_id = v.id " +
                     "WHERE wh.user_id = ? ORDER BY wh.watched_at DESC";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                WatchHistory history = new WatchHistory();
                history.setId(rs.getInt("id"));
                history.setUserId(rs.getInt("user_id"));
                history.setVideoId(rs.getInt("video_id"));
                history.setWatchTime(rs.getInt("watch_time"));
                history.setWatchedAt(rs.getTimestamp("watched_at"));
                try {
                    history.setVideoTitle(rs.getString("title"));
                } catch (Exception e) {
                    // 忽略异常
                }
                histories.add(history);
            }
            DBConnection.close(conn, pstmt, rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return histories;
    }

    /**
     * 删除观看记录
     */
    public boolean delete(int id) {
        String sql = "DELETE FROM watch_history WHERE id = ?";
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
     * 清空用户观看历史
     */
    public boolean clearByUserId(int userId) {
        String sql = "DELETE FROM watch_history WHERE user_id = ?";
        Connection conn = DBConnection.getConnection();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            
            int result = pstmt.executeUpdate();
            DBConnection.close(conn, pstmt);
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
