package com.video.controller;

import com.video.service.UserService;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * 修改密码控制器
 */
public class ChangePasswordServlet extends HttpServlet {
    private UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "新密码两次输入不一致");
            request.getRequestDispatcher("/user/change-password.jsp").forward(request, response);
            return;
        }

        boolean success = userService.updatePassword(userId, oldPassword, newPassword);
        if (success) {
            request.setAttribute("message", "密码修改成功");
        } else {
            request.setAttribute("error", "旧密码错误或修改失败");
        }
        request.getRequestDispatcher("/user/change-password.jsp").forward(request, response);
    }
}
