package com.video.service;

import com.video.dao.VideoDAO;
import com.video.model.Video;
import java.util.List;

/**
 * 视频业务逻辑层
 */
public class VideoService {
    private VideoDAO videoDAO = new VideoDAO();

    /**
     * 上传视频
     */
    public int uploadVideo(String title, String description, int uploaderId, String filePath, String thumbnailPath, int duration) {
        Video video = new Video();
        video.setTitle(title);
        video.setDescription(description);
        video.setUploaderId(uploaderId);
        video.setFilePath(filePath);
        video.setThumbnailPath(thumbnailPath);
        video.setDuration(duration);
        video.setStatus("draft");
        
        return videoDAO.add(video);
    }

    /**
     * 获取视频详情
     */
    public Video getVideoById(int videoId) {
        return videoDAO.findById(videoId);
    }

    /**
     * 获取所有已发布的视频
     */
    public List<Video> getAllPublishedVideos() {
        return videoDAO.findPublished();
    }

    /**
     * 按标题搜索视频
     */
    public List<Video> searchVideos(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getAllPublishedVideos();
        }
        return videoDAO.searchByTitle(keyword);
    }

    /**
     * 获取上传者的视频列表
     */
    public List<Video> getUploaderVideos(int uploaderId) {
        return videoDAO.findByUploaderId(uploaderId);
    }

    /**
     * 更新视频信息
     */
    public boolean updateVideo(int videoId, String title, String description) {
        Video video = videoDAO.findById(videoId);
        if (video == null) {
            return false;
        }
        video.setTitle(title);
        video.setDescription(description);
        return videoDAO.update(video);
    }

    /**
     * 删除视频
     */
    public boolean deleteVideo(int videoId) {
        return videoDAO.delete(videoId);
    }

    /**
     * 发布视频（审核通过）
     */
    public boolean publishVideo(int videoId) {
        Video video = videoDAO.findById(videoId);
        if (video == null) {
            return false;
        }
        video.setStatus("published");
        return videoDAO.update(video);
    }

    /**
     * 拒绝视频
     */
    public boolean rejectVideo(int videoId) {
        Video video = videoDAO.findById(videoId);
        if (video == null) {
            return false;
        }
        video.setStatus("rejected");
        return videoDAO.update(video);
    }

    /**
     * 增加播放次数
     */
    public boolean incrementPlayCount(int videoId) {
        return videoDAO.incrementPlayCount(videoId);
    }

    /**
     * 获取未审核的视频
     */
    public List<Video> getDraftVideos() {
        return videoDAO.findDraftVideos();
    }

    /**
     * 获取视频总数
     */
    public int getTotalVideoCount() {
        return videoDAO.getTotalCount();
    }

    /**
     * 获取总播放数
     */
    public int getTotalPlayCount() {
        return videoDAO.getTotalPlayCount();
    }
}
