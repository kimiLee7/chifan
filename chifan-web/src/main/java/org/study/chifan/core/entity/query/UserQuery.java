package org.study.chifan.core.entity.query;

import java.io.Serializable;

public class UserQuery extends BaseQuery implements Serializable {

    private int status = -1;
    private long quotaId = -1;
    private String searchItem = null;

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public long getQuotaId() {
        return quotaId;
    }

    public void setQuotaId(long quotaId) {
        this.quotaId = quotaId;
    }

    public String getSearchItem() {
        return searchItem;
    }

    public void setSearchItem(String searchItem) {
        this.searchItem = searchItem;
    }
}
