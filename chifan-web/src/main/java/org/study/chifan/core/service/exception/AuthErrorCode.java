
/*
 * Copyright (c) 2012 Conversant Solutions. All rights reserved.
 *
 * Created on Dec 18, 2012 11:28:42 AM
 */
package org.study.chifan.core.service.exception;

public enum AuthErrorCode {
    INVALID_AUTH_PARAMETER(101101,"invalid auth parameter"),
    INVALID_ATUHORIZATION_FORMAT(101102,"invalid authorization format"),
    INVALID_AUTH_TOKEN(101103,"access token is invalid "),
    EXCEPTION_VISIT_REDIS(101104,"access redis exception");

	  private int statusCode;

	    private String message;

	    private AuthErrorCode(int statusCode, String message) {
	        this.statusCode = statusCode;
	        this.message = message;
	    }

	    public int getStatusCode() {
	        return statusCode;
	    }

	    public String getMessage() {
	        return this.message;
	    }
}

