/*
 * Copyright (c) 2012 Conversant Solutions. All rights reserved.
 *
 * Created on Dec 25, 2012 4:06:24 PM
 */
package org.study.chifan.core.mybatis.interceptor;

public interface Dialect {

	/**
	 * database supports limit if true then return true else return false
	 *
	 * @return true：
	 */
	public boolean supportsLimit();

	/**
	 * change sql into limit sql by Dialect
	 *
	 * @param sql
	 *            SQL
	 * @param offset
	 *
	 * @param limit
	 *
	 * @return paging sql
	 */
	public String getLimitString(String sql, int offset, int limit);
}
