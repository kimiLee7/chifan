package org.study.chifan.core.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.study.chifan.core.entity.Order;
import org.study.chifan.core.service.ShopService;

@Controller
//@RequestMapping(value = "/shop")
public class ShopController {

    private Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    private ShopService shopService;

    @RequestMapping(value = "/shop/list", method = RequestMethod.GET)
    public String list(ModelMap model) {
        logger.debug("retrieve shop list.");

        model.addAttribute("records", shopService.listAll());

        return "shop/list";
    }

    @RequestMapping(value = "/shop/{shopId}/menu", method = RequestMethod.GET)
    public String menu(@PathVariable Integer shopId, ModelMap model) {
        logger.debug("retrieve shop menu.");

        model.addAttribute("shop", shopService.get(shopId));
        model.addAttribute("categories", shopService.listAllProducts(shopId));

        return "shop/menu";
    }

    @RequestMapping(value = "/order", method = RequestMethod.POST)
    public String submitOrder(@RequestBody Order order,ModelMap model) {
        logger.debug("submit order.");

        shopService.submitOrder(order);
        return "shop/order";
    }

}

