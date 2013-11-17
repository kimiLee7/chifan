package org.study.chifan.core.dao;

import java.util.List;

import org.study.chifan.core.annotation.DataAccessRepository;
import org.apache.ibatis.annotations.Param;


import org.study.chifan.core.entity.Domain;
import org.study.chifan.core.entity.DomainVO;

@DataAccessRepository
public interface DomainDao {
    void addDomain(Domain domain);

    List<Domain> listAllDomain();

    List<Domain> queryDomainByParentId(@Param("parentId") int parentId);

    DomainVO getDetails(@Param("domainId") int id);

    int findCountByName(Domain domain);

    int findCountByIdAndName(Domain domain);

    Domain get(@Param("domainId") int id);

    void update(Domain domain);

    void softDelete(@Param("ids") List<Integer> ids);

    long sumQuotaOfUser(@Param("domainId") int domainId);

    long sumQuotaOfSubDomain(@Param("domainId") int domainId);

    int findCountByParentId(@Param("parentId") int parentId);

    int findUserCountByDomainId(@Param("domainId") int domainId);//todo: should move to UserService.

}
