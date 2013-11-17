/*
 * Copyright (c) 2012 Conversant Solutions. All rights reserved.
 *
 * Created on Dec 19, 2012 5:33:58 PM
 */
package org.study.chifan.core.model;


public enum UserStatusEnum {

    ENABLE(0, "Enable"), DISABLE(1, "Disable"), DELETED(9, "Mark Delete"), DELETED_FROM_DISABLE(10, "Mark Delete");
    private int status;
    private String name;

    private UserStatusEnum(int status, String name) {
        this.status = status;
        this.name = name;
    }

    public int getStatus() {
        return this.status;
    }

    public String getName() {
        return name;
    }

    public static String getStatusName(int status) {
        for (UserStatusEnum type : values()) {
            if (type.getStatus() == status) {
                return type.getName();
            }
        }
        return "Unknown";
    }

}
