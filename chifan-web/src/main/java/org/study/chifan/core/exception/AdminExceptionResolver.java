package org.study.chifan.core.exception;

import com.google.common.collect.Maps;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

@Component
public class AdminExceptionResolver implements HandlerExceptionResolver {
    public static final String KEY_ERROR = "error";


    public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) {
        final Map<String, Object> map = Maps.newHashMap();

        AdminExceptionHandler.handleException(response, ex, map);

        return null;
    }


}
