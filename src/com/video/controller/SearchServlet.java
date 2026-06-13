package com.video.controller;

import com.video.service.VideoService;
import com.video.model.Video;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * 视频搜索控制器
 */
public class SearchServlet extends HttpServlet {
    private VideoService videoService = new VideoService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String keyword = request.getParameter("keyword");
        List<Video> videos;

        if (keyword == null || keyword.trim().isEmpty()) {
            videos = videoService.getAllPublishedVideos();
        } else {
            videos = videoService.searchVideos(keyword);
        }

        request.setAttribute("videos", videos);
        request.setAttribute("keyword", keyword);
        request.getRequestDispatcher("/user/search-result.jsp").forward(request, response);
    }
}
