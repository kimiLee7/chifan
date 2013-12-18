package org.study.chifan.core.entity;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;

import org.study.chifan.core.model.PagedCollection;
import junit.framework.Assert;

/**
 * @author Bruce
 *         Created on 12/27/12.
 */
public class PagedCollectionTest {

//    @Test
    public void testCalculatePageInfo() throws Exception {
//        pagedCollection.setTotal(10);
//        pagedCollection.setPageSize(5);
//        pagedCollection.setCurrentPageNumber(2);
        PagedCollection<Shop> pagedCollection = new PagedCollection(5, 2, 10, new ArrayList<Shop>());
        pagedCollection.calculatePageInfo();

        final int startIndex = pagedCollection.getStartIndex();
        final long endIndex = pagedCollection.getEndIndex();
        final List<Integer> pageNumbers = pagedCollection.getPageNumbers();
        Assert.assertTrue(startIndex == 6);
        Assert.assertTrue(endIndex == 10);
        Assert.assertTrue(pageNumbers.size() == 2);
    }

//    @Test
    public void testCalculatePageInfo2() throws Exception {
//        pagedCollection2.setTotal(10);
//        pagedCollection2.setPageSize(4);
//        pagedCollection2.setCurrentPageNumber(1);
        PagedCollection<Shop> pagedCollection2 = new PagedCollection<Shop>(4, 1, 10, new ArrayList<Shop>());
        pagedCollection2.calculatePageInfo();

        final int startIndex = pagedCollection2.getStartIndex();
        final long endIndex = pagedCollection2.getEndIndex();
        final List<Integer> pageNumbers = pagedCollection2.getPageNumbers();
        Assert.assertTrue(startIndex == 1);
        Assert.assertTrue(endIndex == 4);
        Assert.assertTrue(pageNumbers.size() == 3);
    }

//    @Test
    public void testCalculatePageInfo3() throws Exception {
//        pagedCollection3.setTotal(17);
//        pagedCollection3.setPageSize(50);
//        pagedCollection3.setCurrentPageNumber(1);
        PagedCollection<Shop> pagedCollection3 = new PagedCollection<Shop>(50, 1, 17, new ArrayList<Shop>());
        pagedCollection3.calculatePageInfo();

        final int startIndex = pagedCollection3.getStartIndex();
        final long endIndex = pagedCollection3.getEndIndex();
        final List<Integer> pageNumbers = pagedCollection3.getPageNumbers();
        Assert.assertTrue(startIndex == 1);
        Assert.assertTrue(endIndex == 17);
        Assert.assertTrue(pageNumbers.size() == 1);
    }

//    @Test
    public void testCalculatePageInfo4() throws Exception {
//        pagedCollection4.setTotal(4);
//        pagedCollection4.setPageSize(3);
//        pagedCollection4.setCurrentPageNumber(2);
        PagedCollection<Shop> pagedCollection4 = new PagedCollection<Shop>(3, 2, 4, new ArrayList<Shop>());
        pagedCollection4.calculatePageInfo();

        final int startIndex = pagedCollection4.getStartIndex();
        final long endIndex = pagedCollection4.getEndIndex();
        final List<Integer> pageNumbers = pagedCollection4.getPageNumbers();
        Assert.assertTrue(startIndex == 4);
        Assert.assertTrue(endIndex == 4);
        Assert.assertTrue(pageNumbers.size() == 2);
        Assert.assertTrue(pagedCollection4.getHasPre() == 1);
        Assert.assertTrue(pagedCollection4.getHasNext() == 0);
    }

//    @Test
    public void testCalculatePageInfoZero() throws Exception {
//        pagedCollectionZero.setTotal(0);
//        pagedCollectionZero.setPageSize(5);
//        pagedCollectionZero.setCurrentPageNumber(1);
        PagedCollection<Shop> pagedCollectionZero = new PagedCollection<Shop>(5, 1, 0, new ArrayList<Shop>());
        pagedCollectionZero.calculatePageInfo();

        final int startIndex = pagedCollectionZero.getStartIndex();
        final long endIndex = pagedCollectionZero.getEndIndex();
        final List<Integer> pageNumbers = pagedCollectionZero.getPageNumbers();
        Assert.assertTrue(startIndex == 0);
        Assert.assertTrue(endIndex == 0);
        Assert.assertTrue(pageNumbers.size() == 0);
        Assert.assertTrue(pagedCollectionZero.getHasPre() == 0);
        Assert.assertTrue(pagedCollectionZero.getHasNext() == 0);
    }

//    @Test
    public void testCalculatePageNumbers() {
        PagedCollection<Shop> pagedCollection = new PagedCollection<Shop>(2, 1, 14, new ArrayList<Shop>());
        pagedCollection.calculatePageInfo();

        final int startIndex = pagedCollection.getStartIndex();
        final long endIndex = pagedCollection.getEndIndex();
        final List<Integer> pageNumbers = pagedCollection.getPageNumbers();
        Assert.assertTrue(startIndex == 1);
        Assert.assertTrue(endIndex == 2);
        Assert.assertTrue(pageNumbers.size() == 7);
        Assert.assertTrue(pageNumbers.get(0) ==1);
        Assert.assertTrue(pageNumbers.get(1) ==2);
        Assert.assertTrue(pageNumbers.get(6) ==7);
        for (Integer index : pageNumbers) {
            System.out.println("index=" + index);
        }
    }

//    @Test
    public void testCalculatePageNumbers2() {
        PagedCollection<Shop> pagedCollection = new PagedCollection<Shop>(2, 1, 16, new ArrayList<Shop>());
        pagedCollection.calculatePageInfo();

        final int startIndex = pagedCollection.getStartIndex();
        final long endIndex = pagedCollection.getEndIndex();
        final List<Integer> pageNumbers = pagedCollection.getPageNumbers();
        for (Integer index : pageNumbers) {
            System.out.println("index=" + index);
        }
        Assert.assertTrue(startIndex == 1);
        Assert.assertTrue(endIndex == 2);
        Assert.assertTrue(pageNumbers.size() == 5);
        Assert.assertTrue(pageNumbers.get(0) ==2);
        Assert.assertTrue(pagedCollection.getHasEllipsisLeft() == 0);
        Assert.assertTrue(pagedCollection.getHasEllipsisRight() == 1);

    }

    @Test
    public void testCalculatePageNumbers3() {
        PagedCollection<Shop> pagedCollection = new PagedCollection<Shop>(2, 1, 5, new ArrayList<Shop>());
        pagedCollection.calculatePageInfo();

        final int startIndex = pagedCollection.getStartIndex();
        final long endIndex = pagedCollection.getEndIndex();
        final List<Integer> pageNumbers = pagedCollection.getPageNumbers();
        for (Integer index : pageNumbers) {
            System.out.println("index=" + index);
        }
        System.out.println("left ...="+pagedCollection.getHasEllipsisLeft());
        System.out.println("right ...="+pagedCollection.getHasEllipsisRight());

//        Assert.assertTrue(startIndex == 15);
//        Assert.assertTrue(endIndex == 16);
//        Assert.assertTrue(pageNumbers.size() == 5);
//        Assert.assertTrue(pageNumbers.get(0) ==2);
//        Assert.assertTrue(pagedCollection.getHasEllipsisLeft() == 0);
//        Assert.assertTrue(pagedCollection.getHasEllipsisRight() == 1);

    }
}
