package org.study.chifan.core.dao;

import org.apache.ibatis.annotations.Param;
import org.study.chifan.core.annotation.DataAccessRepository;
import org.study.chifan.core.entity.Shop;

import java.util.List;

@DataAccessRepository
public interface ShopDao {
    void add(Shop shop);

    List<Shop> listAll();

    Shop getDetails(@Param("id") int id);

    int findCountByName(Shop shop);

    int findCountByIdAndName(Shop shop);

    Shop get(@Param("id") int id);

    void update(Shop shop);

    void softDelete(@Param("ids") List<Integer> ids);

}
