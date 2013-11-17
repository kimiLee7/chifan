/*
 * Copyright (c) 2012 Conversant Solutions. All rights reserved.
 *
 * Created on Dec 13, 2012 4:24:14 PM
 */
package org.study.chifan.core.entity;

import java.io.Serializable;
import java.util.Date;

import org.apache.commons.lang3.StringUtils;
import org.codehaus.jackson.annotate.JsonIgnore;

import com.alibaba.fastjson.JSON;

public class Token implements Serializable {

    /**
     * unique id
     */
    private transient long id;

    /**
     *
     */
    private static final long serialVersionUID = 7385452962424713426L;

    /**
     * token used for identified user with userId has login
     */
    private String token;

    private long userId;

    // TODO delete
    private transient Date createdTime = new Date();

    private Date lastUpdateTime;

    private String clientType;

    /**
     *
     */
    private transient User user;

    @JsonIgnore
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    @JsonIgnore
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.userId = user.getId();
        this.user = user;
    }

    public void setUserId(long userId) {
        this.userId = userId;
    }

    @JsonIgnore
    public long getUserId() {
        return userId;
    }

    @JsonIgnore
    public Date getCreatedTime() {
        return createdTime;
    }

    public void setCreatedTime(Date createdTime) {
        this.createdTime = createdTime;
    }

    public Date getLastUpdateTime() {
        return lastUpdateTime;
    }

    public void setLastUpdateTime(Date lastUpdateTime) {
        this.lastUpdateTime = lastUpdateTime;
    }

    public String getClientType() {
        return clientType;
    }

    public void setClientType(String clientType) {
        this.clientType = clientType;
    }

    @JsonIgnore
    public boolean isWeb() {
        return StringUtils.isNotEmpty(clientType) && clientType.startsWith("WEB");
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder("Token{");
        sb.append("[token," + this.getToken() + "]");
        sb.append("}");

        return sb.toString();
    }

    public String serialize() {
        return JSON.toJSONString(this);
    }

    public static Token deserialize(String jsonString) {
        return JSON.parseObject(jsonString, Token.class);
    }

}
