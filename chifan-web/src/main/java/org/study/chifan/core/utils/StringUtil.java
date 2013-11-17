package org.study.chifan.core.utils;

import org.apache.commons.lang3.StringUtils;

import java.util.List;

/**
 * User: dev
 * Date: 13-7-3 10:57
 */
public class StringUtil {
    public static String getCommaSeparatedString(List<Long> list) {
        StringBuilder stringBuilder = new StringBuilder();
        for (int i = 0; i < list.size(); i++) {
            stringBuilder.append(list.get(i));
            if (i != list.size() - 1) {
                stringBuilder.append(",");
            }
        }

        return stringBuilder.toString();
    }

    public static String getRequestURL(String url, String route) {
        if (StringUtils.isBlank(url) || StringUtils.isBlank(route)) {
            return url;
        }

        if (route.startsWith("/")) {
            route = StringUtil.substring(route, 2, route.length());
        }

        if (!url.endsWith("/")) {
            url = url + "/";
        }

        return url + route;
    }

    public static String substring(String value, int index, int offset) {
        if (StringUtils.isBlank(value)) {
            return null;
        }

        if (index < 1) {
            index = 1;
        }

        index -= 1;
        return value.substring(index, offset);
    }


}
