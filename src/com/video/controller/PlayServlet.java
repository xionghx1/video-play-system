package com.video.controller;

import com.video.service.VideoService;
import com.video.service.WatchHistoryService;
import com.video.model.Video;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * 视频播放控制器
 */
public class PlayServlet extends HttpServlet {
    private VideoService videoService = new VideoService();
    private WatchHistoryService watchHistoryService = new WatchHistoryService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        String videoIdStr = request.getParameter("id");

        if (videoIdStr == null || videoIdStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/user/home.jsp");
            return;
        }

        try {
            int videoId = Integer.parseInt(videoIdStr);
            Video video = videoService.getVideoById(videoId);

            if (video == null || !"published".equals(video.getStatus())) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            // 增加播放次数
            videoService.incrementPlayCount(videoId);

            // 添加观看历史记录
            if (userId != null) {
                watchHistoryService.addWatchHistory(userId, videoId, 0);
            }

            request.setAttribute("video", video);
            request.getRequestDispatcher("/user/play.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
}
