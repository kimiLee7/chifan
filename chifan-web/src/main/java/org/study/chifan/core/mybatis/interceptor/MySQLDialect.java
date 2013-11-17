/*
 * Copyright (c) 2012 Conversant Solutions. All rights reserved.
 *
 * Created on Dec 25, 2012 4:00:33 PM
 */
package org.study.chifan.core.mybatis.interceptor;

public class MySQLDialect implements Dialect {

	@Override
	public boolean supportsLimit() {
		return true;
	}

	@Override
	public String getLimitString(String sql, int offset, int limit) {
		if (offset > 0) {
			return sql + " limit " + offset + "," + limit;
		} else {
			return sql + " limit " + limit;
		}
	}

}
