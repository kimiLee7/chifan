/*
* Copyright (c) 2012 Conversant Solutions. All rights reserved.
*
* Created on Mar 12, 2013 11:01:51 AM
*/
package org.study.chifan.core.controller;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.study.chifan.core.annotation.AdminRequired;
import org.study.chifan.core.entity.Administrator;
import org.study.chifan.core.service.AdministratorService;

import java.util.Collections;
import java.util.Map;


@Controller
@RequestMapping(value = "/mysettings")
@SessionAttributes("currentAdmin")
public class MySettingsController {

    private static final Logger log = LoggerFactory.getLogger(MySettingsController.class);

    @Autowired
    private AdministratorService administratorService;

    @RequestMapping(method = RequestMethod.GET)
    public String getCurrentAdmin() {

        return "mysettings/main";
    }


    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, ? extends Object> edit(
            @AdminRequired Administrator currentAdmin,
            @RequestBody Administrator admin, ModelMap model) {

        if (log.isDebugEnabled()) {
            log.debug("currentAdmin=" + currentAdmin.getId() + " ----name=AdminLogAspect" + currentAdmin.getAdminId());
        }
        administratorService.edit(admin);

        String password = admin.getPassword();
        if (StringUtils.isNotBlank(password)) {
            administratorService.resetPassword(admin);
        }
        admin = administratorService.details(admin.getId());
        admin.setPassword("");
        model.addAttribute("currentAdmin", admin);

        return Collections.singletonMap("adminId", admin.getAdminId());
    }
}

