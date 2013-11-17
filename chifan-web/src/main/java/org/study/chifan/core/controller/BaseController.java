package org.study.chifan.core.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.HttpSessionRequiredException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.SessionAttributes;


@Controller
//@RequestMapping(value = "/index")
@SessionAttributes("currentAdmin")
public class BaseController {

    protected Logger log = LoggerFactory.getLogger(getClass());

    @ExceptionHandler(HttpSessionRequiredException.class)
    public String reLogin() {
        log.debug("session invalidate. ReLogin.");
        return "redirect:/login";
    }


}
