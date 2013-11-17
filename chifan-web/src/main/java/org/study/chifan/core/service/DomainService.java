package org.study.chifan.core.service;

import java.util.List;
import java.util.Map;

import org.study.chifan.core.entity.Domain;
import org.study.chifan.core.entity.DomainVO;

/**
 * @author Bruce
 *         Created on 12/25/12.
 */
public interface DomainService {

    void addDomain(Domain domain);

    String getDomainTree(Domain rootDomain);

    DomainVO get(int id);

    boolean ifDomainNameAvailable(int id, String domainName, int currentDomainId);

    boolean isQuotaLessThanParent(long quota, int domainId, int isNew);

    boolean isQuotaLargerThanSubEntities(long quota, int domainId, int isNew);

    Domain details(int id);

    void edit(Domain domain);

    void delete(List<Integer> ids);

    List<Domain> listDomainByIds(List<Map<String, Object>> ids);

    List<Domain> listAllDomain();

    boolean canDeleteDomain(int currentDomainId);

}
