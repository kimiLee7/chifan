package org.study.chifan.core.exception;

public enum ErrorCode {
    SYSTEM_ERROR(99999, "System error."),
    QUOTA_IN_USED(10010, ""),
    PARAMETER_REQUIRED(10011, ""),
    PASSWORD_INVALID(10012, ""),

    USERNAME_INVALID(10013, ""),
    USER_NOT_EXIST(10014, ""),

    SESSION_EXPIRED(90001, ""),

    UNKNOWN(-00001,"Unknown error."),
    ;

    private int code;
    private String message;

    ErrorCode(int code, String message) {
        this.code = code;
        this.message = message;
    }

    public int getCode() {
        return code;
    }

    public String getMessage() {
        return message;
    }

    public static String getName(int code) {
        for (ErrorCode errorCode : ErrorCode.values()) {
            if (errorCode.getCode() == code) {
                return errorCode.name();
            }
        }
        return UNKNOWN.name();
    }

    public static ErrorCode getErrorCode(int code) {
        for (ErrorCode errorCode : ErrorCode.values()) {
            if (errorCode.getCode() == code) {
                return errorCode;
            }
        }
        return UNKNOWN;
    }

    public static String getMessage(int code) {
        for (ErrorCode errorCode : ErrorCode.values()) {
            if (errorCode.getCode() == code) {
                return errorCode.getMessage();
            }
        }
        return UNKNOWN.getMessage();
    }


}
