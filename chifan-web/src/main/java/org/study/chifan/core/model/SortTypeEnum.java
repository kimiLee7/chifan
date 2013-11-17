/**
 * Copyright (c) 2012 Conversant Solutions. All rights reserved.
 *
 * Created on 12/13/12.
 */
package org.study.chifan.core.model;

import org.apache.commons.lang3.StringUtils;

public enum SortTypeEnum {

    ASC, DESC;

    public String getSortType() {
        return this.name();
    }

    public static SortTypeEnum getSortTypeEnum(String sortType) {
        if (StringUtils.isBlank(sortType)) {
            return ASC;
        }
        sortType = sortType.toUpperCase();
        switch (sortType) {
            case "ASC":
                return ASC;
            case "DESC":
                return DESC;
            default:
                return ASC;
        }
    }

}
