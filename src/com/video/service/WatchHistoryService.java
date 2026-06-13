package com.video.service;

import com.video.dao.WatchHistoryDAO;
import com.video.model.WatchHistory;
import java.util.List;

/**
 * 观看历史业务逻辑层
 */
public class WatchHistoryService {
    private WatchHistoryDAO watchHistoryDAO = new WatchHistoryDAO();

    /**
     * 添加观看记录
     */
    public boolean addWatchHistory(int userId, int videoId, int watchTime) {
        WatchHistory history = new WatchHistory();
        history.setUserId(userId);
        history.setVideoId(videoId);
        history.setWatchTime(watchTime);
        
        return watchHistoryDAO.add(history);
    }

    /**
     * 获取用户观看历史
     */
    public List<WatchHistory> getUserWatchHistory(int userId) {
        return watchHistoryDAO.findByUserId(userId);
    }

    /**
     * 删除观看记录
     */
    public boolean deleteWatchHistory(int historyId) {
        return watchHistoryDAO.delete(historyId);
    }

    /**
     * 清空用户观看历史
     */
    public boolean clearUserWatchHistory(int userId) {
        return watchHistoryDAO.clearByUserId(userId);
    }
}
