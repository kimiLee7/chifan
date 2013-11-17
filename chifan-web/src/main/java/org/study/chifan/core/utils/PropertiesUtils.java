/**
 * Copyright (c) 2012 Conversant Solutions. All rights reserved.
 *
 * Created on 2013-05-29.
 */

package org.study.chifan.core.utils;

import org.springframework.context.support.ReloadableResourceBundleMessageSource;

public class PropertiesUtils {

    private static ReloadableResourceBundleMessageSource configurer;

    public static ReloadableResourceBundleMessageSource getConfigurer() {
        return configurer;
    }

    public static void setConfigurer(ReloadableResourceBundleMessageSource autoConfigurer) {
        configurer = autoConfigurer;
    }

    public static String getProperty(String key) {
        return configurer.getMessage(key, null, null);
    }

}
