package org.study.chifan.core.utils;

import org.junit.Test;

import junit.framework.Assert;

/**
 * @author Bruce
 *         Created on 13-4-11.
 */
public class PercentUtilTest {
    @Test
    public void testCalculatePercent1() throws Exception {
        final String percent = PercentUtil.calculatePercent(10, 100);
        System.out.println(percent);
        Assert.assertTrue("10.00%".equals(percent));
    }

    @Test
    public void testCalculatePercent2() throws Exception {
        final String percent = PercentUtil.calculatePercent(1, 3);
        System.out.println(percent);
        Assert.assertTrue("33.33%".equals(percent));
    }

    @Test
    public void testCalculatePercentZeroDividend() throws Exception {
        final String percent = PercentUtil.calculatePercent(1, 0);
        System.out.println(percent);
        Assert.assertTrue("0%".equals(percent));
    }

    @Test
    public void testCalculatePercentZeroDivisor() throws Exception {
        final String percent = PercentUtil.calculatePercent(0, 10);
        System.out.println(percent);
        Assert.assertTrue("0%".equals(percent));
    }

    @Test
    public void testCalculatePercentFull() throws Exception {
        final String percent = PercentUtil.calculatePercent(10, 10);
        System.out.println(percent);
        Assert.assertTrue("100%".equals(percent));
    }
}
