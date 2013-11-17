/**
 * Copyright (c) 2012 Conversant Solutions. All rights reserved.
 *
 * Created on 12/20/12.
 */
package org.study.chifan.core.utils.paging;

import java.util.List;

/**
 * Implementation of paging array list
 *
 * @author robin.ye
 */
public class PagingArrayList<E> implements PagingList<E>, java.io.Serializable {
    /**
     *
     */
    private static final long serialVersionUID = 1L;


    /**
     * total Count
     */
    private int totalCount;


    /**
     * pageSize
     */
    private int pageSize;

    /**
     * begin index
     */
    private int startIndex;
    /**
     * end index
     */
    private long endIndex;

    /**
     * current Page Number
     */
    private int currentPageNumber;
    /**
     * total page number
     */
    private int totalPageNumber;
    /**
     * has preview page
     */
    private boolean hasPre;

    /**
     * has next page
     */
    private boolean hasNext;


    /**
     * pageing recorders
     */
    private List<E> list;


    /**
     * default constructor
     *
     * @param totalCount total count
     * @param list       list
     */
    public PagingArrayList(int pageNumber, int pageSize, int totalCount,
                           List<E> list) {
        this.startIndex = (currentPageNumber - 1) * pageSize + 1;
        this.endIndex = startIndex + list.size();
        this.currentPageNumber = pageNumber;
        this.pageSize = pageSize;
        this.totalCount = totalCount;
        this.list = list;

        calculatePageInfo(pageSize);
    }

    private void calculatePageInfo(int pageSize) {
        // if not paging,pageSize should be less than 0
        if (pageSize <= 0) {
            return;
        }

        if (totalCount == 0) {
            this.totalPageNumber = 0;
        } else {
            long left = totalCount % pageSize;
            this.totalPageNumber = (totalCount / pageSize) + (left > 0 ? 1 : 0);
        }

        // calculate start index and end index
        if (totalPageNumber == 0) {
            this.startIndex = 0;
            this.endIndex = 0;
        } else if (pageSize > totalCount) {
            this.startIndex = 1;
            this.endIndex = totalCount;
        } else {
            this.startIndex = (currentPageNumber - 1) * pageSize + 1;
            this.endIndex = currentPageNumber < totalPageNumber ? (startIndex
                    + pageSize - 1) : totalCount;
        }

        // calculate has pre or has next
        if (currentPageNumber == 1) {
            hasPre = false;
        } else {
            hasPre = true;
        }
        if (totalCount == 0) {
            hasNext = false;
        } else if (currentPageNumber == totalPageNumber) {
            hasNext = false;
        } else {
            hasNext = true;
        }
    }

    /**
     * get total account of list
     *
     * @return total account of list
     */
    @Override
    public int getTotalCount() {
        return totalCount;
    }

    /**
     * set total account of list
     */
    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
    }

    @Override
    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getStartIndex() {
        return startIndex;
    }

    public void setStartIndex(int startIndex) {
        this.startIndex = startIndex;
    }

    public long getEndIndex() {
        return endIndex;
    }

    public void setEndIndex(long endIndex) {
        this.endIndex = endIndex;
    }

    public int getCurrentPageNumber() {
        return currentPageNumber;
    }

    public void setCurrentPageNumber(int currentPageNumber) {
        this.currentPageNumber = currentPageNumber;
    }

    public int getTotalPageNumber() {
        return totalPageNumber;
    }

    public void setTotalPageNumber(int totalPageNumber) {
        this.totalPageNumber = totalPageNumber;
    }

    public boolean isHasPre() {
        return hasPre;
    }

    public void setHasPre(boolean hasPre) {
        this.hasPre = hasPre;
    }

    public boolean isHasNext() {
        return hasNext;
    }

    public void setHasNext(boolean hasNext) {
        this.hasNext = hasNext;
    }

    @Override
    public List<E> getList() {
        return list;
    }

    public void setList(List<E> list) {
        this.list = list;
    }

    /**
     * Overwrite toString
     */
    @Override
    public String toString() {
        StringBuilder strBuf = new StringBuilder();
        strBuf.append("[");
        strBuf.append(" totalCount=").append(totalCount);
        strBuf.append(" list=").append(list);
        strBuf.append(" pageSize=").append(pageSize);
        strBuf.append(" startIndex=").append(startIndex);
        strBuf.append(" endIndex=").append(endIndex);
        strBuf.append(" currentPageNumber=").append(currentPageNumber);
        strBuf.append(" totalPageNumber=").append(totalPageNumber);
        strBuf.append(" hasPre=").append(hasPre);
        strBuf.append(" hasNext=").append(hasNext);
        strBuf.append(" size=").append(this.size());
        strBuf.append("]");
        return strBuf.toString();
    }

    @Override
    public int size() {
        if (this.list == null) return 0;
        else return this.getList().size();
    }


}