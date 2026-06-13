package com.video.model;

import java.util.Date;

/**
 * 观看历史模型类
 */
public class WatchHistory {
    private int id;
    private int userId;
    private int videoId;
    private int watchTime; // 观看时长，单位秒
    private Date watchedAt;
    private String videoTitle; // 视频标题
    private String uploaderName; // 上传者名称

    public WatchHistory() {}

    public WatchHistory(int userId, int videoId, int watchTime) {
        this.userId = userId;
        this.videoId = videoId;
        this.watchTime = watchTime;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getVideoId() {
        return videoId;
    }

    public void setVideoId(int videoId) {
        this.videoId = videoId;
    }

    public int getWatchTime() {
        return watchTime;
    }

    public void setWatchTime(int watchTime) {
        this.watchTime = watchTime;
    }

    public Date getWatchedAt() {
        return watchedAt;
    }

    public void setWatchedAt(Date watchedAt) {
        this.watchedAt = watchedAt;
    }

    public String getVideoTitle() {
        return videoTitle;
    }

    public void setVideoTitle(String videoTitle) {
        this.videoTitle = videoTitle;
    }

    public String getUploaderName() {
        return uploaderName;
    }

    public void setUploaderName(String uploaderName) {
        this.uploaderName = uploaderName;
    }

    @Override
    public String toString() {
        return "WatchHistory{" +
                "id=" + id +
                ", userId=" + userId +
                ", videoId=" + videoId +
                ", watchTime=" + watchTime +
                '}';
    }
}
