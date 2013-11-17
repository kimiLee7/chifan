package org.study.chifan.core.controller;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.study.chifan.core.annotation.AdminRequired;
import org.study.chifan.core.entity.Administrator;

import java.util.Collections;
import java.util.Map;

@Controller
// @RequestMapping(value = "/index")
// @SessionAttributes("currentAdmin")
public class IndexController extends BaseController {

    @Value("${report.server.url}")
    private String REPORT_SERVER_URL;

    protected Logger log = LoggerFactory.getLogger(getClass());

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index(
            @AdminRequired Administrator currentAdmin,
            ModelMap model) {
        if (currentAdmin == null) {
            return "login";
        }
        log.debug(StringUtils.join("/index--currentAdmin=[", currentAdmin.getAdminId(), "]"));
        model.addAttribute("report_server", REPORT_SERVER_URL);
        return "index";
    }

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String root(
            @AdminRequired Administrator currentAdmin) {

        if (currentAdmin == null) {
            return "login";
        }
        log.debug(StringUtils.join("currentAdmin=[", currentAdmin.getAdminId(),
                "]"));
        return "index";
    }


    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login() {
        return "login";
    }

    @RequestMapping(value = "/forgotPassword", method = RequestMethod.GET)
    public String forgotPassword() {
        return "forgot_password";
    }

    @RequestMapping(value = "/logout", method = RequestMethod.POST)
    public String logout(SessionStatus session) {
        session.setComplete();
        return "redirect:login";
    }


    @RequestMapping(value = "/logout2", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, ? extends Object> logout2(
            SessionStatus session) {
        session.setComplete();
        return Collections.singletonMap("result", "ok");
    }


}
