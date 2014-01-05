package org.study.chifan.core.dao;

import org.apache.ibatis.annotations.Param;
import org.study.chifan.core.annotation.DataAccessRepository;
import org.study.chifan.core.entity.Shop;

import java.util.List;

@DataAccessRepository
public interface ShopDao {

    List<Shop> listAll();

    Shop get(@Param("id") int id);

    void add(Shop shop);

    int findCountByName(Shop shop);

    int findCountByIdAndName(Shop shop);

    void update(Shop shop);

    void softDelete(@Param("ids") List<Integer> ids);

}
