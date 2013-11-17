package org.study.chifan.core.model.response;

import org.study.chifan.core.model.User;
import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

import java.io.Serializable;
import java.util.List;

public class UserListResponse implements Serializable {
    @Expose
    @SerializedName("totalCount")
    private long totalCount;

    @Expose
    @SerializedName("list")
    private List<User> list;

    public long getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(long totalCount) {
        this.totalCount = totalCount;
    }

    public List<User> getList() {
        return list;
    }

    public void setList(List<User> list) {
        this.list = list;
    }
}
