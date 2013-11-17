package org.study.chifan.core.service.impl;

import org.junit.Test;

import org.study.chifan.core.entity.Domain;

/**
 * @author Bruce
 *         Created on 12/27/12.
 */
public class DomainServiceImplTest {

    private DomainServiceImpl domainService = new DomainServiceImpl();

    @Test
    public void testAddDomainWithConstrain() {
        Domain domain = new Domain();
        domainService.addDomain(domain);
    }

    @Test
    public void testGetDomainTree() throws Exception {
//        domainServiceImpl.getDomainTree();
    }
}
