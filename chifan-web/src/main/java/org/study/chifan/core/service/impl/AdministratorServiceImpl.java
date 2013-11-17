package org.study.chifan.core.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import org.study.chifan.core.dao.AdministratorDao;
import org.study.chifan.core.dao.DomainDao;
import org.study.chifan.core.entity.Administrator;
import org.study.chifan.core.entity.Domain;
import org.study.chifan.core.model.PagedCollection;
import org.study.chifan.core.entity.query.AdministratorQuery;
import org.study.chifan.core.exception.AdminException;
import org.study.chifan.core.service.AdministratorService;
import org.study.chifan.core.service.DomainService;
import org.study.chifan.core.service.TokenGenerator;
import org.study.chifan.core.utils.Encoder;

@Service
public class AdministratorServiceImpl implements AdministratorService {

    @Autowired
    private AdministratorDao administratorDao;

    @Autowired
    private DomainDao domainDao;

    @Autowired
    private DomainService domainService;

    @Autowired
    private TokenGenerator tokenGenerator;

    public List<Administrator> retrieveAdministrators(int domainId) {
        return administratorDao.queryByDomainId(domainId);
    }

    @Transactional
    public void addAdminAccount(Administrator administrator) {
        final String passwordSha1 = Encoder.encodeToString("SHA1",
                administrator.getPassword());
        administrator.setPassword(passwordSha1);
        administratorDao.add(administrator);
    }

    public PagedCollection<Administrator> retrieve(AdministratorQuery query) {
        int count = administratorDao.queryCountByDomainId(query);
        final List<Administrator> administrators = administratorDao
                .queryByDomainIdInOrder(query);

        return new PagedCollection<Administrator>(query.getLength(),
                query.getPageNumber(), count, administrators);
    }

    @Transactional
    public boolean deleteAccount(List<Long> idList) {
        // //todo:
        administratorDao.deleteAccounts(idList);
        return false;
    }

    public boolean ifAdminIdAvailable(int domainId, long id, String adminId) {
        //
        boolean isAvailableInCurrrentDomain = ifAvailable(domainId, id, adminId);
        if (!isAvailableInCurrrentDomain) {
            return false;
        }

        return isAvaliableInParentDomain(domainId, adminId);

    }

    private boolean ifAvailable(int domainId, long id, String adminId) {

        Administrator admin = new Administrator();
        admin.setDomainId(domainId);
        admin.setAdminId(adminId);

        if (id > -1) {
            admin.setId(id);
            final int adminCount = administratorDao
                    .findCountByIdAndAdminId(admin);
            if (adminCount <= 1) {
                return true;
            }
        } else {
            final int adminCount = administratorDao.findCountByAdminId(admin);
            if (adminCount <= 0) {
                return true;
            }
        }
        return false;

    }

    private boolean isAvaliableInParentDomain(int domainId, String adminId) {

        if (domainId == 0) {
            return true;
        }
        Domain domain = domainDao.get(domainId);
        int parentId = domain.getParentId();

        boolean isAvailable = ifAvailable(parentId, -1, adminId);
        if (!isAvailable) {
            return false;
        } else {
            return isAvaliableInParentDomain(parentId, adminId);
        }

    }

    public Administrator details(long id) {
        return administratorDao.get(id);
    }

    @Transactional
    public void edit(Administrator administrator) {
        administratorDao.update(administrator);
    }

    @Transactional
    public void resetPassword(Administrator administrator) {
        Administrator admin1 = administratorDao.get(administrator.getId());
        final String passwordSha1 = Encoder.encodeToString("SHA1",
                administrator.getPassword());
        administrator.setPassword(passwordSha1);
        administrator.setAdminId(admin1.getAdminId());
        administrator.setDomainId(admin1.getDomainId());
        administrator.setEmail(admin1.getEmail());
        administrator.setPhone(admin1.getPhone());
        administrator.setPermission(admin1.getPermission());
        administrator.setToken(admin1.getToken());
        administratorDao.resetPassword(administrator);
    }

    @Transactional
    public boolean resetPasswordByToken(Administrator administrator,
                                        String token) {

        Administrator admin = findByAdminId(administrator.getAdminId());
        if (admin == null) {
            return false;
        }
        if (StringUtils.isBlank(admin.getToken())) {
            return false;
        }
        if (!admin.getToken().equalsIgnoreCase(token)) {
            return false;
        }

        final String passwordSha1 = Encoder.encodeToString("SHA1",
                administrator.getPassword());
        administrator.setPassword(passwordSha1);
        administrator.setId(admin.getId());
        administratorDao.resetPassword(administrator);
        administratorDao.setToken(admin.getId(), "");
        return true;
    }

    public Administrator login(String username, String password) {
        if (StringUtils.isBlank(password)) {
            throw new AdminException(
                    org.study.chifan.core.exception.ErrorCode.PASSWORD_INVALID.getCode() + "", "Password is invalidate.");
        }

        final Administrator admin = administratorDao.findByAdminId(username);
        if (admin == null) {
            throw new AdminException(
                    org.study.chifan.core.exception.ErrorCode.USER_NOT_EXIST.getCode() + "", "Username does not exist.");
        }
        final String passwordDb = admin.getPassword();
        if (StringUtils.isBlank(passwordDb)) {
            throw new AdminException(
                    org.study.chifan.core.exception.ErrorCode.PASSWORD_INVALID.getCode() + "", "Password is not correct.");
        }

        boolean result = passwordDb.equals(Encoder.encodeToString("SHA1",
                password));

        if (!result) {
            throw new AdminException(
                    org.study.chifan.core.exception.ErrorCode.PASSWORD_INVALID.getCode() + "", "Password is not correct.");
        }
        admin.setPassword(null);

        return admin;
    }

    public Administrator findByAdminId(String adminId) {
        return administratorDao.findByAdminId(adminId);
    }

    public Domain getDomainInfo(String adminId) {
        Administrator admin = administratorDao.findByAdminId(adminId);
        if (admin == null) {
            return null;
        }
        return domainDao.get(admin.getDomainId());
    }

    @Transactional
    public String generateToken(String email) {
        Administrator admin = administratorDao.findByAdminId(email);
        if (admin == null) {
            return null;// todo: here should throws out Exception.
        }

        final String token = tokenGenerator.generate();

        administratorDao.setToken(admin.getId(), token);

        return token;
    }

    @Override
    public List<Administrator> listAdminByIds(List<Map<String, Object>> ids) {

        List<Administrator> adminList = new ArrayList<Administrator>();
        for (Map id : ids) {
            long adminId = Long.valueOf((String) id.get("id"));

            Administrator admin = this.details(adminId);
            adminList.add(admin);

        }
        return adminList;
    }

}
