/**
 * Copyright (c) 2012 Conversant Solutions. All rights reserved.
 *
 * Created on 12-12-16.
 */
package org.study.chifan.core.dao;

import java.util.List;

import org.study.chifan.core.annotation.DataAccessRepository;
import org.apache.ibatis.annotations.Param;


import org.study.chifan.core.entity.Administrator;
import org.study.chifan.core.entity.query.AdministratorQuery;


@DataAccessRepository
public interface AdministratorDao {

    void add(Administrator administrator);

    List<Administrator> queryByDomainId(@Param("domainId") int domainId);

    List<Administrator> queryByDomainIdInOrder(AdministratorQuery query);

    int queryCountByDomainId(AdministratorQuery query);

    void deleteAccounts(@Param("ids") List<Long> idList);

    int findCountByIdAndAdminId(Administrator admin);

    int findCountByAdminId(Administrator admin);

    Administrator get(@Param("id") long id);

    void update(Administrator admin);

    void resetPassword(Administrator admin);

    Administrator findByAdminId(@Param("adminId") String username);

    void setToken(@Param("id")long id, @Param("token")String token);
}
