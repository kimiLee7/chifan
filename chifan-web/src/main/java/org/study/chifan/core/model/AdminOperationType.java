package org.study.chifan.core.model;

public enum AdminOperationType {
    READ("READ"),
    WRITE("WRITE");

    private String code;

    AdminOperationType(String code) {
        this.code = code;
    }

    public String getCode() {
        return code;
    }

    public static AdminOperationType getAdminOperationType(String code) {
        for (AdminOperationType type : AdminOperationType.values()) {
            if (type.getCode() == code) {
                return type;
            }
        }
        return null;
    }
}
