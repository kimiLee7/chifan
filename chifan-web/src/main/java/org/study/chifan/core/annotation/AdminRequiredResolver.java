/**
 * Copyright (c) 2012 Conversant Solutions. All rights reserved.
 *
 * Created on 13-5-8.
 */
package org.study.chifan.core.annotation;

import org.springframework.core.MethodParameter;
import org.springframework.web.bind.support.WebArgumentResolver;
import org.springframework.web.context.request.NativeWebRequest;
import org.study.chifan.core.entity.Administrator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * TODO
 *
 * @author allen.zhang
 */
public class AdminRequiredResolver implements WebArgumentResolver {

    @Override
    public Administrator resolveArgument(MethodParameter methodParameter,
                                         NativeWebRequest webRequest) throws Exception {

        if (methodParameter.hasParameterAnnotation(AdminRequired.class)) {
            return getAdminFromSession(webRequest);
        }
        return null;
    }

    protected Administrator getAdminFromSession(NativeWebRequest webRequest) {
        HttpServletRequest httpRequest = (HttpServletRequest) webRequest.getNativeRequest();
        HttpSession httpSession = httpRequest.getSession();
        if (httpSession == null) {
            return null;
        } else {
            Object obj = httpSession.getAttribute("currentAdmin");
            Administrator currentAdmin = null;
            if (obj != null) {
                currentAdmin = (Administrator) obj;
            } else {
            }
            return currentAdmin;
        }
    }
}
