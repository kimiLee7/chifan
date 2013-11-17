/**
 * Copyright (c) 2012 Conversant Solutions. All rights reserved.
 *
 * Created on 12/7/12.
 */
package org.study.chifan.core.service.exception;

@SuppressWarnings("serial")
public class BaseRuntimeException extends RuntimeException {
    /**
     * status code
     */
    private int statusCode;


    /**
     * constructor with status code and object
     *
     * @param statusCode
     */
    public BaseRuntimeException(int statusCode) {
        super();
    }

    public BaseRuntimeException(ErrorCode err) {
        super(err.getMessage());
        this.statusCode = err.getStatusCode();
    }

    public BaseRuntimeException(ErrorCode err, Throwable t) {
        super(err.getMessage(), t);
        this.statusCode = err.getStatusCode();
    }

    /**
     * constructor with fileds statusCode and message
     *
     * @param statusCode
     *            status code
     * @param message
     *            message
     */
    public BaseRuntimeException(int statusCode, String message) {
        super(message);
        this.statusCode = statusCode;
    }

    /**
     * constructor with fileds statusCode and message
     *
     * @param  error
     */
    public BaseRuntimeException(AuthErrorCode error) {
        super(error.getMessage());
        this.statusCode = error.getStatusCode();
    }

    /**
     * constructor with fileds statusCode and message
     *
     * @param statusCode
     *            status code
     * @param message
     *            message
     */
    public BaseRuntimeException(int statusCode, String message, Throwable t) {
        super(message, t);
        this.statusCode = statusCode;
    }

    /**
     * constructor with status code and object
     *
     * @param statusCode
     *            status code
     * @param object
     *            Object
     */
    public BaseRuntimeException(int statusCode, Throwable object) {
        super(object);
        this.statusCode = statusCode;
    }

    /**
     * get status code
     *
     * @return status code
     */
    public int getStatusCode() {
        return statusCode;
    }
}
