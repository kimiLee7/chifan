package org.study.chifan.core.exception;

public class AdminException extends RuntimeException{
    private String code;
    private String errorMessage;

    public AdminException(String code) {
        super();
        this.code = code;
    }

    public AdminException(String code,String message) {
        super(message);
        this.code = code;
        this.errorMessage = message;
    }

    public AdminException(String message, Throwable cause, String code) {
        super(message, cause);
        this.code = code;
    }

    public AdminException(Throwable cause, String code) {
        super(cause);
        this.code = code;
    }


    public AdminException(ErrorCode errorCode){
    	this(String.valueOf(errorCode.getCode()),errorCode.name().toLowerCase());
    }



    public AdminException(String code, String message, Object... args) {
        super(String.format(message, args));
        this.code = code;
    }

    public AdminException(String code, Throwable cause, String message, Object... args) {
        super(String.format(message, args), cause);
        this.code = code;
    }

    public String getCode() {
        return code;
    }

    public String getErrorMessage() {
        return errorMessage;
    }
}
