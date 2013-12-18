package org.study.chifan.core.model.response;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import org.study.chifan.core.entity.Shop;

import java.io.Serializable;
import java.util.List;

public class ShopListResponse implements Serializable {
    @Expose
    @SerializedName("totalCount")
    private long totalCount;

    @Expose
    @SerializedName("list")
    private List<Shop> list;

    public long getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(long totalCount) {
        this.totalCount = totalCount;
    }

    public List<Shop> getList() {
        return list;
    }

    public void setList(List<Shop> list) {
        this.list = list;
    }
}
