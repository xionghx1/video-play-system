package com.video.util;

import java.security.MessageDigest;

/**
 * MD5加密工具类
 */
public class MD5Utils {
    /**
     * MD5加密
     */
    public static String encrypt(String text) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(text.getBytes());
            byte[] digest = md.digest();
            
            StringBuilder sb = new StringBuilder();
            for (byte b : digest) {
                sb.append(String.format("%02x", b & 0xff));
            }
            return sb.toString();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 验证密码
     */
    public static boolean verify(String text, String hash) {
        return encrypt(text).equals(hash);
    }
}
