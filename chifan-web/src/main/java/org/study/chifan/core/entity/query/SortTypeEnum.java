package org.study.chifan.core.entity.query;

public enum SortTypeEnum {
    ASC("ASC"), DESC("DESC");

    private String sortType;

    private SortTypeEnum(String sortType) {
        this.sortType = sortType;
    }

    public String getSortType() {
        return this.sortType;
    }

    public static SortTypeEnum getSortTypeEnum(String code) {
        for (SortTypeEnum type : SortTypeEnum.values()) {
            if (type.getSortType().equals(code)) {
                return type;
            }
        }
        return null;
    }

}
