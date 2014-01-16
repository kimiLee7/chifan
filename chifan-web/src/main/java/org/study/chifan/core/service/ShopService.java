package org.study.chifan.core.service;

import org.study.chifan.core.entity.Category;
import org.study.chifan.core.entity.Order;
import org.study.chifan.core.entity.Shop;

import java.util.List;
import java.util.Map;

public interface ShopService {

    List<Shop> listAll();

    Shop get(int id);

    void add(Shop shop);

    boolean ifShopNameAvailable(int id, String name, int currentShopId);

    void edit(Shop shop);

    void delete(List<Integer> ids);

    List<Shop> listByIds(List<Map<String, Object>> ids);

    List<Category> listAllProducts(long shopId);

    void submitOrder(Order order);
}
