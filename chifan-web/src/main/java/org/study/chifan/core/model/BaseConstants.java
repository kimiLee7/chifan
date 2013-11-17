/**
 * Copyright (c) 2012 Conversant Solutions. All rights reserved.
 *
 * Created on 12/7/12.
 */
package org.study.chifan.core.model;

public interface BaseConstants {
	/**
	 * Basic
	 */
	public static final String AUTH_MAGICS = "Basic";

	/**
	 * http token header
	 */
	public static final String HTTP_TOKEN_HEADER = "X-Hydra-Token";

	/**
	 * http user agent
	 */
	public static final String HTTP_USER_AGETN_HEADER = "User-Agent";

    public static final String X_USER_AGENT_HERDER = "X-User-Agent";

    // TODO need to delete later
    public static final String HTTP_DEVICE_IDENTIFER="Device-Identifier";

	/**
	 * device identifier
	 */
	public static final String X_DEVICE_IDENTIFER ="X-Device-Identifier";
	/**
	 * date format
	 */
	public static final String DATE_FORMAT = "yyyy-MM-dd HH:mm:ss";

	/**
	 * file header
	 */
	public static final String APPLICATION = "application";

	/**
	 * CONTENT_DISPOSITION
	 */
	public static final String CONTENT_DISPOSITION = "Content-Disposition";
	/**
	 * http connection
	 */
	public static final String HTTP_CONNECTION = "Connection";
	/**
	 * http cache control
	 */
	public static final String HTTP_CACHE_CONTROL = "Cache-Control";

	/**
	 * http referer
	 */
	public static final String HTTP_REFERER="Referer";

	/**
	 * http referer
	 */
	public static final String HTTP_HOST_HEADER="Host";


    public static final int UNLIMIT_USAGE_QUOATA = -1;

    public static final String FILE_DATA_ENCRYPTION_PHASE = "E";
    /**
     * file_upload
     */
    public static final String HTTP_FILE_UPLOAD="file_upload";
}
