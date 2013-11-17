package org.study.chifan.core.entity.query;

import java.io.Serializable;

public class BaseQuery implements Serializable {

    private int domainId;

    private String sortType = SortTypeEnum.ASC.getSortType();
    private String sortColumn;
    private int offset;
    private int length = 100;  //it can be -1

    private int pageNumber;

    public int getDomainId() {
        return domainId;
    }

    public void setDomainId(int domainId) {
        this.domainId = domainId;
    }

    public String getSortType() {
        return sortType;
    }

    public void setSortType(String sortType) {
        this.sortType = sortType;
    }

    public String getSortColumn() {
        return sortColumn;
    }

    public void setSortColumn(String sortColumn) {
        this.sortColumn = sortColumn;
    }

    public int getOffset() {
        return (pageNumber - 1) * length;
//        return offset;
    }

    /*public void setOffset(int offset) {
        this.offset = offset;
    }*/

    public int getLength() {
        return length;
    }

    public void setLength(int length) {
        /*if(length < 1) {
            return;
        }*/
        this.length = length;
    }

    public int getPageNumber() {
        return pageNumber;
    }

    public void setPageNumber(int pageNumber) {
        if (pageNumber < 1) {
            return;
        }
        this.pageNumber = pageNumber;
        offset = (pageNumber - 1) * length;
    }

    public static void main(String[] args) {

    }
}
