/**
 * Copyright (c) 2012 Conversant Solutions. All rights reserved.
 *
 * Created on 12/20/12.
 */
package org.study.chifan.core.utils.paging;

import java.util.List;

import org.codehaus.jackson.annotate.JsonIgnore;

/**
 * List for paging
 *
 * @author robin.ye
 */

public interface PagingList<E> {
	/**
	 * get total account of list
	 *
	 * @return total account of list
	 */

	public int getTotalCount();

	public int getPageSize();

	@JsonIgnore
	public int getStartIndex();

	@JsonIgnore
	public long getEndIndex();

	@JsonIgnore
	public int getCurrentPageNumber();

	public int getTotalPageNumber();

	@JsonIgnore
	public boolean isHasPre();

	public boolean isHasNext();


	public List<E> getList();


	public int size();



}