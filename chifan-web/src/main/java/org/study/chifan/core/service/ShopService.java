package org.study.chifan.core.service;

import org.study.chifan.core.entity.Shop;

import java.util.List;
import java.util.Map;

public interface ShopService {

    void addShop(Shop shop);

    Shop get(int id);

    boolean ifShopNameAvailable(int id, String name, int currentShopId);

    Shop details(int id);

    void edit(Shop shop);

    void delete(List<Integer> ids);

    List<Shop> listByIds(List<Map<String, Object>> ids);

    List<Shop> listAll();

}
