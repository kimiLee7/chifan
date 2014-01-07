package org.study.chifan.core.service.impl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.study.chifan.core.dao.ShopDao;
import org.study.chifan.core.entity.Category;
import org.study.chifan.core.entity.Order;
import org.study.chifan.core.entity.Product;
import org.study.chifan.core.entity.Shop;
import org.study.chifan.core.service.ShopService;
import org.study.chifan.core.service.TokenGenerator;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;


@Service
public class ShopServiceImpl implements ShopService {

    private Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    private ShopDao shopDao;

    @Autowired
    private TokenGenerator tokenGenerator;

    @Transactional
    public void add(Shop shop) {
        shopDao.add(shop);
    }

    public Shop get(int id) {
        return shopDao.get(id);
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
            list.add(this.get(Integer.valueOf((String) id.get("id"))));
        }
        return list;
    }

    @Override
    public List<Shop> listAll() {
        return shopDao.listAll();
    }

    @Override
    public List<Category> listAllProducts(long shopId) {

        return generateProducts();
    }

    @Override
    public void submitOrder(Order order) {
        //todo
    }

    private ArrayList<Category> generateProducts() {
        final ArrayList<Category> categories = new ArrayList<Category>();

        categories.add(generateProductsOfOneCategory("招牌套餐", 4));
        categories.add(generateProductsOfOneCategory("经典小炒", 8));
        categories.add(generateProductsOfOneCategory("盖浇饭", 12));

        return categories;
    }

    private Category generateProductsOfOneCategory(String categoryName, int productNum) {

        final Category category = new Category(categoryName);
        category.setId(tokenGenerator.generateInt());

        Product product = new Product("红烧狮子头2只+炒时蔬+菜饭", new BigDecimal(2000), category);
        product.setId(tokenGenerator.generateInt());

        for (int i = 0; i < productNum; i++) {
            category.putInProduct(product);
        }

        return category;
    }
}
