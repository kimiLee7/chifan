package org.study.chifan.core.controller;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.study.chifan.core.entity.AvailabilityStatus;
import org.study.chifan.core.entity.Shop;
import org.study.chifan.core.service.ShopService;

import java.util.*;

@Controller
@RequestMapping(value = "/shop")
public class ShopController {

    Logger log = LoggerFactory.getLogger(getClass());

    private static final String LOGO_FILE_NAME = "logo.png";
    private static final String AVERT_FILE_NAME = "avert.png";
    private static final String UPLOAD_FILE_FOR_LOGO = "logo";

    @Autowired
    private ShopService shopService;

    @RequestMapping(method = RequestMethod.POST)
    @ResponseBody
    public Map<String, ? extends Object> create(
            @RequestBody Shop shop) {
        shopService.addShop(shop);
        Map<String, Object> entity = new HashMap<>();
        entity.put("id", shop.getId());
        entity.put("name", shop.getName());
        return Collections.singletonMap("entity", entity);
    }

    @RequestMapping(value = "{id}", method = RequestMethod.GET)
    public String get(@PathVariable Integer id, ModelMap model) {
        log.debug("get shop:" + id);

        model.addAttribute("details", shopService.get(id));

        return "shop/detail";
    }


    @RequestMapping(value = "/availability", method = RequestMethod.GET)
    @ResponseBody
    public AvailabilityStatus getAvailability(@RequestParam int id,
                                              @RequestParam String name,
                                              @RequestParam int currentId) {
        if (shopService.ifShopNameAvailable(id, name, currentId)) {
            return AvailabilityStatus.available();
        }
        return AvailabilityStatus.notAvailable(name);
    }

    @RequestMapping(method = RequestMethod.GET)
    @ResponseBody
    public Map<String, ? extends Object> details(@RequestParam int id) {
        return Collections.singletonMap("details", shopService.details(id));
    }


    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, ? extends Object> delete(
            @RequestBody List<Map<String, Object>> targets) {
        List<Integer> ids = new ArrayList<>();
        for (Map id : targets) {
            ids.add(Integer.valueOf((String) id.get("id")));
        }
        shopService.delete(ids);
        return Collections.singletonMap("result", "ok");
    }

}

