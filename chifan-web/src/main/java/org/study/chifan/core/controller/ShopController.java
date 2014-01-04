package org.study.chifan.core.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value = "/shop")
public class ShopController {

    private Logger logger = LoggerFactory.getLogger(getClass());

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list() {
        logger.debug("retrieve shop list.");

        return "shop/list";
    }
}

