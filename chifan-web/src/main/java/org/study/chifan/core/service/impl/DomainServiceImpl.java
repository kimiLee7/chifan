package org.study.chifan.core.service.impl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.study.chifan.core.dao.DomainDao;
import org.study.chifan.core.entity.Domain;
import org.study.chifan.core.entity.DomainVO;
import org.study.chifan.core.service.DomainService;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;


@Service
public class DomainServiceImpl implements DomainService {

    private static final Logger logger = LoggerFactory.getLogger(DomainServiceImpl.class);

    private static final int DEFAULT_RECYCLE_PERIOD = 30;

    @Autowired
    private DomainDao domainDao;

    @Transactional
    public void addDomain(Domain domain) {
        String domainCode = "";
        domain.setDomainCode(domainCode);
        domainDao.addDomain(domain);

        Domain parentDomain = domainDao.getDetails(domain.getParentId());

        domainCode = parentDomain.getDomainCode() + "." + domain.getId();
        domain.setDomainCode(domainCode);
        domainDao.update(domain);

    }

    public String getDomainTree(Domain rootDomain) {
        final Domain root = getTreeFromDB(rootDomain);
        StringBuilder mockTree = new StringBuilder("");
        treeToList(mockTree, root);
        return mockTree.toString();
    }

    public DomainVO get(int id) {
        final DomainVO domain = domainDao.getDetails(id);
        if (domain == null) {
            final DomainVO nullDomain = new DomainVO();
            nullDomain.setId(-1);
            nullDomain.setName("Empty-Entity");
            return nullDomain;
        }

        final DomainVO parentDomain = domainDao.getDetails(domain.getParentId());

        if (parentDomain != null) {
            domain.setParentName(parentDomain.getName());
        }
        return domain;
    }

    public boolean ifDomainNameAvailable(int id, String domainName, int currentDomainId) {
        Domain domain = new Domain();
        domain.setName(domainName);
        domain.setParentId(currentDomainId);

        if (id > 0) {
            domain.setId(id);
            final int quotaCount = domainDao.findCountByIdAndName(domain);
            if (quotaCount <= 1) {
                return true;
            }
        } else {
            final int userCount = domainDao.findCountByName(domain);
            if (userCount <= 0) {
                return true;
            }
        }
        return false;
    }

    @Override
    public boolean isQuotaLessThanParent(long quota, int domainId, int isNew) {
        Boolean ifLessThanParentDomain = false;
        int parentDomainId;
        long quotaPreview = 0;
        Domain domain = domainDao.get(domainId);
        if (domain != null) {
            quotaPreview = domain.getQuota();
        }

        if (isNew == 1) {
            parentDomainId = domainId;
        } else {
            if (domain == null) {
                return true;
            }
            parentDomainId = domain.getParentId();
        }

        if (parentDomainId <= 0) {
            return true;
        }
        DomainVO parentDomain = new DomainVO();
        parentDomain.setId(parentDomainId);
        if (quota <= parentDomain.getAllocatableQuota() + quotaPreview) {
            ifLessThanParentDomain = true;
        }

        return ifLessThanParentDomain;

    }

    @Override
    public boolean isQuotaLargerThanSubEntities(long quota, int domainId, int isNew) {
        if (isNew == 1) {
            return true;
        }

        return quota >= domainDao.sumQuotaOfSubDomain(domainId);
    }

    public Domain details(int id) {
        final Domain domain = domainDao.get(id);
        return domain;
    }

    @Transactional
    public void edit(Domain domain) {


        domainDao.update(domain);
    }

    @Transactional
    public void delete(List<Integer> ids) {
        domainDao.softDelete(ids);
    }


    private Domain getTreeFromDB(int rootId) {
        final Domain root = new Domain();
        root.setId(rootId);
        addChild(root, domainDao.queryDomainByParentId(rootId));
        return root;
    }

    private Domain getTreeFromDB(Domain rootDomain) {
        addChild(rootDomain, domainDao.queryDomainByParentId(rootDomain.getId()));
        return rootDomain;
    }

    private void addChild(Domain node, List<Domain> children) {
        if (children.size() > 0) {
            for (Domain child : children) {
                node.getChildren().add(child);
                addChild(child, domainDao.queryDomainByParentId(child.getId()));
            }
        } else {
            return;
        }
    }

    private void treeToList(StringBuilder mockTree, Domain root) {
        addNode(mockTree, root);
    }


    private void addNode(StringBuilder mockTree, Domain treeNode) {
        final String displayTagStart = treeNode.getDisplayTagStart();

        if (logger.isDebugEnabled()) {
            logger.debug(treeNode.getDisplayTagStart());
        }

        mockTree.append(displayTagStart);

        if (treeNode.getChildren().size() > 0) {
            for (Domain node : treeNode.getChildren()) {
                addNode(mockTree, node);
            }
        } else {
            return;
        }
        if (logger.isDebugEnabled()) {
            logger.debug(treeNode.getDisplayTagEnd());
        }

        mockTree.append(treeNode.getDisplayTagEnd());
    }

    @Override
    public List<Domain> listDomainByIds(List<Map<String, Object>> ids) {
        List<Domain> domainList = new ArrayList<Domain>();
        for (Map id : ids) {
            int domainId = Integer.valueOf((String) id.get("id"));

            Domain domain = this.details(domainId);
            domainList.add(domain);

        }
        return domainList;
    }

    @Override
    public List<Domain> listAllDomain() {
        List<Domain> domainList = domainDao.listAllDomain();
        return domainList;
    }

    @Override
    public boolean canDeleteDomain(int currentDomainId) {
        logger.debug(String.format("canDeleteDomain. currentDomainId=%1$s", currentDomainId));

        if (domainDao.findCountByParentId(currentDomainId) > 0) {
            return false;
        }

        if (domainDao.findUserCountByDomainId(currentDomainId) > 0) {
            return false;
        }

        return true;
    }


}
