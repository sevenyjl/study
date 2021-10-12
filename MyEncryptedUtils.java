package utils;

import cn.hutool.core.util.StrUtil;

public class MyEncryptedUtils {

    public static String encrypted(String s) {
        int i = Math.abs(s.hashCode() % 107);
        return (char) i + encrypted(s, i);
    }

    public static String decode(String s) {
        char c = s.charAt(0);
        return decode(s.substring(1), c);
    }

    public static String encrypted(String s, int num) {
        if (StrUtil.isEmpty(s)) {
            return s;
        }
        char c = s.charAt(0);
        num = num + c;
        char[] chars = s.toCharArray();
        StringBuilder stringBuilder = new StringBuilder();
        for (char aChar : chars) {
            stringBuilder.append((char) (((int) aChar) + num));
        }
        return stringBuilder.toString();
    }

    public static String decode(String s, int num) {
        if (StrUtil.isEmpty(s)) {
            return s;
        }
        char c = s.charAt(0);
        num = (c - num) / 2 + num;
        char[] chars = s.toCharArray();
        StringBuilder stringBuilder = new StringBuilder();
        for (char aChar : chars) {
            stringBuilder.append((char) (((int) aChar) - num));
        }
        return stringBuilder.toString();
    }
}
