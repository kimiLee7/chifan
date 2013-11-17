package org.study.chifan.core.exception;

import org.study.chifan.core.service.exception.BaseRuntimeException;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonSyntaxException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.validation.BindException;
import org.springframework.validation.ObjectError;
import org.springframework.web.HttpSessionRequiredException;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

public class AdminExceptionHandler {
    public static final String KEY_CODE = "code";
    public static final String KEY_MESSAGE = "message";

    private static final Logger log = LoggerFactory.getLogger(AdminExceptionHandler.class);

    public static void handleException(HttpServletResponse response, Exception ex, Map<String, Object> map) {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);

        if (ex instanceof HttpSessionRequiredException) {
            String responseData = "";
            responseData = new ResponseMessage(ErrorCode.SESSION_EXPIRED).toJsonString();
            try {
                response.getWriter().write(responseData);
                response.getWriter().flush();
                return;
            } catch (IOException e1) {
                e1.printStackTrace();
            }
        }

        if (ex instanceof RuntimeException) {
            log.warn(ex.getClass().getName(), ex);
        } else {
            log.debug(ex.getClass().getName(), ex);
        }

        String code = String.valueOf(ErrorCode.SYSTEM_ERROR.getCode());
        String message;

        if (ex instanceof BindException) {
            List<ObjectError> errors = ((BindException) ex).getBindingResult().getAllErrors();
            if (!errors.isEmpty()) {
                for (ObjectError error : errors) {
                    code = error.getDefaultMessage();
                }
            }

            message = ErrorCode.getMessage(Integer.valueOf(code));

        } else if (ex instanceof AdminException) {
            AdminException adminException = (AdminException) ex;
            code = adminException.getCode();
            message = adminException.getMessage();
        } else if (ex instanceof BaseRuntimeException) {
            BaseRuntimeException baseRuntimeExp = (BaseRuntimeException) ex;
            code = String.valueOf(baseRuntimeExp.getStatusCode());
            message = ex.getMessage();
        } else {
            code = String.valueOf(ErrorCode.SYSTEM_ERROR.getCode());
            message = ex.getMessage();
        }

        if (message == null) {
            message = String.valueOf(ErrorCode.SYSTEM_ERROR);
        }
        map.put(KEY_CODE, code);
        map.put(KEY_MESSAGE, message);

        try {
            response.getWriter().write(convertToJson(map));
            response.getWriter().flush();
            return;
        } catch (IOException e1) {
            e1.printStackTrace();
        }
    }

    private static String convertToJson(Map map){
        Gson gson = new GsonBuilder().create();

        try {
            return gson.toJson(map);
        } catch (JsonSyntaxException e) {
            throw new JsonSyntaxException(e);
        }
    }

}
