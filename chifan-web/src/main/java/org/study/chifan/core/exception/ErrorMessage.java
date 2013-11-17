package org.study.chifan.core.exception;

public enum ErrorMessage {
    QUOTA_IN_USED(10010),
    PARAMETER_REQUIRED(10011),
    SYSTEM_ERROR(99999);

    private int code;

    ErrorMessage(int code) {
        this.code = code;
    }

    public int getCode() {
        return code;
    }

    public static String getMessage(int code) {
        for (ErrorMessage errorCode : ErrorMessage.values()) {
            if (errorCode.getCode() == code) {
                return errorCode.name();
            }
        }
        return null;
    }
}
