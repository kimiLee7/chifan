package org.study.chifan.core.entity.query;

import org.junit.Test;

import junit.framework.Assert;

/**
 * @author Bruce
 *         Created on 12/27/12.
 */
public class BaseQueryTest {
    private BaseQuery baseQuery = new BaseQuery();

    @Test
    public void testSetPageInfo() throws Exception {
        baseQuery.setLength(10);
        baseQuery.setPageNumber(1);
        Assert.assertTrue(baseQuery.getOffset() == 0);

        baseQuery.setPageNumber(2);
        Assert.assertTrue(baseQuery.getOffset() == 10);
    }
}
