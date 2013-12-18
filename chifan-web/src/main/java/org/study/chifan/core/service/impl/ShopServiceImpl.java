package org.study.chifan.core.service.impl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.study.chifan.core.dao.ShopDao;
import org.study.chifan.core.entity.Shop;
import org.study.chifan.core.service.ShopService;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;


@Service
public class ShopServiceImpl implements ShopService {

    private static final Logger logger = LoggerFactory.getLogger(ShopServiceImpl.class);

    @Autowired
    private ShopDao shopDao;

    @Transactional
    public void addShop(Shop shop) {

        shopDao.update(shop);

    }

    public Shop get(int id) {
        return shopDao.getDetails(id);
    }

    public boolean ifShopNameAvailable(int id, String name, int currentId) {
        Shop shop = new Shop();
        shop.setName(name);

        if (id > 0) {
            shop.setId(id);
            final int quotaCount = shopDao.findCountByIdAndName(shop);
            if (quotaCount <= 1) {
                return true;
            }
        } else {
            final int userCount = shopDao.findCountByName(shop);
            if (userCount <= 0) {
                return true;
            }
        }
        return false;
    }


    public Shop details(int id) {
        return shopDao.get(id);
    }

    @Transactional
    public void edit(Shop shop) {


        shopDao.update(shop);
    }

    @Transactional
    public void delete(List<Integer> ids) {
        shopDao.softDelete(ids);
    }


    @Override
    public List<Shop> listByIds(List<Map<String, Object>> ids) {
        List<Shop> list = new ArrayList();
        for (Map id : ids) {

            list.add(this.details(Integer.valueOf((String) id.get("id"))));

        }
        return list;
    }

    @Override
    public List<Shop> listAll() {
        return shopDao.listAll();
    }

}
