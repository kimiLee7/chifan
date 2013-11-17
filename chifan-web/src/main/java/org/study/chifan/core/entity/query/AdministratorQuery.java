package org.study.chifan.core.entity.query;

import java.io.Serializable;

public class AdministratorQuery extends BaseQuery implements Serializable {

    private Long adminId;

    public Long getAdminId() {
        return adminId;
    }

    public void setAdminId(Long adminId) {
        this.adminId = adminId;
    }


}
