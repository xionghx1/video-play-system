package com.video.controller;

import com.video.service.UserService;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 用户注册控制器
 */
public class RegisterServlet extends HttpServlet {
    private UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String email = request.getParameter("email");
        String role = request.getParameter("role");

        // 验证输入
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "请填写所有必填字段");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "两次密码输入不一致");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (role == null || role.trim().isEmpty()) {
            role = "user";
        }

        // 注册用户
        boolean success = userService.register(username, password, email, role);
        if (success) {
            request.setAttribute("message", "注册成功，请使用新账号登录");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "用户名已存在或注册失败");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}
