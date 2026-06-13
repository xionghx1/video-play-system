package com.video.service;

import com.video.dao.UserDAO;
import com.video.model.User;
import com.video.util.MD5Utils;

/**
 * 用户业务逻辑层
 */
public class UserService {
    private UserDAO userDAO = new UserDAO();

    /**
     * 用户登录
     */
    public User login(String username, String password) {
        String encryptedPassword = MD5Utils.encrypt(password);
        return userDAO.login(username, encryptedPassword);
    }

    /**
     * 用户注册
     */
    public boolean register(String username, String password, String email, String role) {
        // 检查用户名是否存在
        if (userDAO.findByUsername(username) != null) {
            return false;
        }
        
        User user = new User();
        user.setUsername(username);
        user.setPassword(MD5Utils.encrypt(password));
        user.setEmail(email);
        user.setRole(role);
        user.setStatus(1);
        
        return userDAO.add(user);
    }

    /**
     * 修改密码
     */
    public boolean updatePassword(int userId, String oldPassword, String newPassword) {
        User user = userDAO.findById(userId);
        if (user == null) {
            return false;
        }
        
        // 验证旧密码
        if (!MD5Utils.verify(oldPassword, user.getPassword())) {
            return false;
        }
        
        // 更新新密码
        String encryptedNewPassword = MD5Utils.encrypt(newPassword);
        return userDAO.updatePassword(userId, encryptedNewPassword);
    }

    /**
     * 获取用户信息
     */
    public User getUserById(int userId) {
        return userDAO.findById(userId);
    }

    /**
     * 获取所有用户
     */
    public java.util.List<User> getAllUsers() {
        return userDAO.findAll();
    }

    /**
     * 获取指定角色的用户
     */
    public java.util.List<User> getUsersByRole(String role) {
        return userDAO.findByRole(role);
    }

    /**
     * 删除用户
     */
    public boolean deleteUser(int userId) {
        return userDAO.delete(userId);
    }

    /**
     * 更新用户状态
     */
    public boolean updateUserStatus(int userId, int status) {
        User user = userDAO.findById(userId);
        if (user == null) {
            return false;
        }
        user.setStatus(status);
        return userDAO.update(user);
    }
}
