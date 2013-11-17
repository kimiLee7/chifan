package org.study.chifan.core.model;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;


public class PagedCollection<T> {
    private int pageSize = 5;
    private int startIndex = 1;
    private long endIndex = 5;
    private long total;
    private List<Integer> pageNumbers = new ArrayList<Integer>();
    private int middlePageIndexLength = 5;
    private int currentPageNumber;
    private Collection<T> records;

    private int pageNumTotal;
    private int hasPre;
    private int hasNext;

    private int hasEllipsisLeft;
    private int hasEllipsisRight;

    public PagedCollection() {
    }

    public PagedCollection(int pageSize, int currentPageNumber, long total, Collection<T> records) {
        this.pageSize = pageSize;
        this.currentPageNumber = currentPageNumber;
        this.total = total;
        this.records = records;

        calculatePageInfo();
    }

    public void calculatePageInfo() {
//        pagedCollection.setTotal(10);
//        pagedCollection.setPageSize(5);
//        pagedCollection.setCurrentPageNumber(2);

        if (total == 0) {
            this.pageNumTotal = 0;
        } else {
            long left = total % pageSize;
            this.pageNumTotal = (int) (total - left) / pageSize + (left > 0 ? 1 : 0);
        }

//        this.setStartIndex(6);
//        this.setEndIndex(10);

        //计算当前页显示的记录的开始数和结束数
        if (total == 0) {
            this.startIndex = 0;
            this.endIndex = 0;
        } else if (pageSize > total) {
            this.startIndex = 1;
            this.endIndex = total;
        } else {
            this.startIndex = pageSize * (currentPageNumber - 1) + 1;
//        this.endIndex = total > pageSize ?(startIndex + pageSize - 1): (int) total;
            this.endIndex = currentPageNumber < pageNumTotal ? (startIndex + pageSize - 1) : total;
        }

        /*List<Integer> pageNumbersList = new ArrayList<Integer>();
        for (int i = 1; i <= pageNumTotal; i++) {
            pageNumbersList.add(i);
        }
        this.setPageNumbers(pageNumbersList);*/
        this.setPageNumbers(calculatePageNumbers(pageNumTotal, currentPageNumber));

        // 计算是否显示前一页、后一页
        if (currentPageNumber == 1) {
            hasPre = 0;
        } else {
            hasPre = 1;
        }

        if (total == 0) {
            hasNext = 0;
        } else if (currentPageNumber == pageNumTotal) {
            hasNext = 0;
        } else {
            hasNext = 1;
        }
    }

    public List<Integer> calculatePageNumbers(int pageNumTotal, int currentPageNumber) {
        List<Integer> pageNumbers = new ArrayList<Integer>();
        int offset = middlePageIndexLength / 2;
        int leftMiddle = currentPageNumber - 2;
        int rightMiddle = pageNumTotal - 1 - currentPageNumber;
        int left = 0;
        int right = 0;
        int emptyIndexLength = middlePageIndexLength;
        if (leftMiddle > offset) {
            left = offset;
        } else if (leftMiddle > 0) {
            left = leftMiddle;
        }

        if (rightMiddle >= offset) {
            right = offset;
        } else if (rightMiddle > 0) {
            right = rightMiddle;
        }

        if (leftMiddle > offset && rightMiddle > offset) {

        } else if (leftMiddle < offset && rightMiddle > offset) {
            if (currentPageNumber == 1) {
                right = right + (offset - left) + 1;
            } else {
                right = right + (offset - left);
            }
        } else if (leftMiddle > offset && rightMiddle < offset) {
            if (currentPageNumber == pageNumTotal) {
                left = left + (offset - right) + 1;
            } else {
                left = left + (offset - right);
            }
        }

        if (left > 0) {
            for (int i = left; i > 0; i--) {
                final int indexLeft = currentPageNumber - i;
                if (indexLeft > 1 && emptyIndexLength > 0) {

                    pageNumbers.add(indexLeft);
                    emptyIndexLength--;
                }
            }
        }
        if (!pageNumbers.contains(currentPageNumber) && currentPageNumber != 1 && currentPageNumber != pageNumTotal) {
            pageNumbers.add(currentPageNumber);
        }
        if (rightMiddle > 0) {
            for (int i = 1; i <= right; i++) {
                final int indexRight = currentPageNumber + i;
                if (indexRight < pageNumTotal && emptyIndexLength > 0) {

                    pageNumbers.add(indexRight);
                    emptyIndexLength--;
                }
            }
        }

        if (pageNumbers.size() > 0) {
            final Integer firstIndexDisplay = pageNumbers.get(0);
            if ((firstIndexDisplay - 1 > 1) && currentPageNumber > firstIndexDisplay) {
                hasEllipsisLeft = 1;
            }

            final Integer lastIndexDisplay = pageNumbers.get(pageNumbers.size() - 1);
            if (lastIndexDisplay + 1 < pageNumTotal && currentPageNumber < lastIndexDisplay) {
                hasEllipsisRight = 1;
            }
        }

        return pageNumbers;
    }

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

    public long getTotal() {
        return total;
    }

    public void setTotal(long total) {
        this.total = total;
    }

    public List<Integer> getPageNumbers() {
        return pageNumbers;
    }

    public void setPageNumbers(List<Integer> pageNumbers) {
        this.pageNumbers = pageNumbers;
    }

    public int getCurrentPageNumber() {
        return currentPageNumber;
    }

    public void setCurrentPageNumber(int currentPageNumber) {
        this.currentPageNumber = currentPageNumber;
    }

    public Collection<T> getRecords() {
        return records;
    }

    public void setRecords(Collection<T> records) {
        this.records = records;
    }

    public int getPageNumTotal() {
        return pageNumTotal;
    }

    public void setPageNumTotal(int pageNumTotal) {
        this.pageNumTotal = pageNumTotal;
    }

    public int getHasPre() {
        return hasPre;
    }

    public void setHasPre(int hasPre) {
        this.hasPre = hasPre;
    }

    public int getHasNext() {
        return hasNext;
    }

    public void setHasNext(int hasNext) {
        this.hasNext = hasNext;
    }

    public int getMiddlePageIndexLength() {
        return middlePageIndexLength;
    }

    public void setMiddlePageIndexLength(int middlePageIndexLength) {
        this.middlePageIndexLength = middlePageIndexLength;
    }

    public int getHasEllipsisLeft() {
        return hasEllipsisLeft;
    }

    public void setHasEllipsisLeft(int hasEllipsisLeft) {
        this.hasEllipsisLeft = hasEllipsisLeft;
    }

    public int getHasEllipsisRight() {
        return hasEllipsisRight;
    }

    public void setHasEllipsisRight(int hasEllipsisRight) {
        this.hasEllipsisRight = hasEllipsisRight;
    }
}
