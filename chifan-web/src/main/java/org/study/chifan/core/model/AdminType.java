package org.study.chifan.core.model;

public enum AdminType {
    ADMIN("ADMIN"),
    READ_ONLY("READ ONLY");

    private String code;

    AdminType(String code) {
        this.code = code;
    }

    public String getCode() {
        return code;
    }

    public static AdminType getPermissionType(String code) {
        for (AdminType type : AdminType.values()) {
            if (type.getCode() == code) {
                return type;
            }
        }
        return null;
    }
}
