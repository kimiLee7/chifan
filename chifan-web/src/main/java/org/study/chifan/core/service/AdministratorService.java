package org.study.chifan.core.service;

import java.util.List;
import java.util.Map;

import org.study.chifan.core.entity.Administrator;
import org.study.chifan.core.entity.Domain;
import org.study.chifan.core.model.PagedCollection;
import org.study.chifan.core.entity.query.AdministratorQuery;

/**
 * @author Bruce
 *         Created on 12/25/12.
 */
public interface AdministratorService {
    List<Administrator> retrieveAdministrators(int domainId);

    PagedCollection<Administrator> retrieve(AdministratorQuery query);



    void addAdminAccount(Administrator administrator);

    boolean deleteAccount(List<Long> idList);

    boolean ifAdminIdAvailable(int domainId, long id, String adminId);

    Administrator details(long id);

    void edit(Administrator administrator);

    void resetPassword(Administrator administrator);

    boolean resetPasswordByToken(Administrator administrator, String token);

    Administrator login(String username, String password);

    Administrator findByAdminId(String adminId);

    Domain getDomainInfo(String adminId);

    String generateToken(String email);

    /**
     * list administrator
     * @param ids
     * @return
     */
    List<Administrator> listAdminByIds(List<Map<String, Object>> ids);
}
