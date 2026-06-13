package com.video.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * 登录验证过滤器
 */
public class LoginFilter implements Filter {
    private static final String[] PUBLIC_PATHS = {"/index.jsp", "/login", "/register", "/register.jsp"};

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String path = requestURI.substring(contextPath.length());

        // 检查是否是公开路径
        boolean isPublicPath = false;
        for (String publicPath : PUBLIC_PATHS) {
            if (path.equals(publicPath) || path.startsWith("/css/") || path.startsWith("/js/")) {
                isPublicPath = true;
                break;
            }
        }

        // 如果是公开路径，直接放行
        if (isPublicPath) {
            chain.doFilter(request, response);
            return;
        }

        // 检查用户是否已登录
        if (session == null || session.getAttribute("user") == null) {
            httpResponse.sendRedirect(contextPath + "/index.jsp");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig config) throws ServletException {
    }

    @Override
    public void destroy() {
    }
}
