/**
 * Copyright (c) 2012 Conversant Solutions. All rights reserved.
 *
 * Created on 12/5/12.
 */
package org.study.chifan.core.entity;

import org.codehaus.jackson.annotate.JsonIgnore;
import org.study.chifan.core.model.UserStatusEnum;

import java.io.Serializable;
import java.util.Date;
import java.util.Map;

public class User implements Serializable {

    /**
     *
     */
    private static final long serialVersionUID = -5233170594292185270L;
    /**
     * unique id
     */
    private long id;
    /**
     * name used to login
     */
    private String userName;
    /**
     * firstName
     */
    private String firstName;

    /**
     * lastName
     */
    private String lastName;
    /**
     * password
     */
    private String password = "";
    /**
     * 0->male 1->female
     */
    private int gender = 0;
    /**
     * birthday yyyy-MM-dd
     */
    private String birthday;

    /**
     * user's head portrait
     */
    private String portrait;

    /**
     * email
     */
    private String email = "";
    /**
     * mobile
     */
    private String mobile = "";
    /**
     * nickName
     */
    private String nickName = "";
    /**
     * nationNumber should be associated with mobile
     */
    private String nationNumber = "";

    private int status = UserStatusEnum.ENABLE.getStatus();

    /**
     *
     */
    private String statusDisplay;

    /**
     * createTime
     */
    private Date createTime = new Date(System.currentTimeMillis());

    /**
     * Domain Object id
     */
    private long domainId = 0;

    /**
     * modified Time
     */
    private Date modifiedTime;


    /**
     * get user's token
     */
    private Token token;

    /**
     * device identifier
     */
    private String deviceIdentifier;

    /**
     * userAgent
     */
    private String userAgent;


    /**
     * used file space / quota file space
     */
    private double threshold;

    /**
     * msso reuqestId
     */
    private String mssoRequestID;
    /**
     *
     */
    private String mssOTAC;

    private String mssoAccessToken;


    /**
     * for those customized params
     */
    private Map<String, String> customizedParams;


    public long getDomainId() {
        return domainId;
    }

    public void setDomainId(long domainId) {
        this.domainId = domainId;
    }

    public long getId() {
        return id;
    }

    public String getUserName() {
        return userName;
    }

    public String getPassword() {
        return password;
    }

    public String getEmail() {
        return email;
    }

    public String getMobile() {
        return mobile;
    }

    public String getNickName() {
        return nickName;
    }

    public String getNationNumber() {
        return nationNumber;
    }

    public int getStatus() {
        return status;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setId(long id) {
        this.id = id;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public void setNationNumber(String nationNumber) {
        this.nationNumber = nationNumber;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }


    public Token getToken() {
        return token;
    }

    public void setToken(Token token) {
        this.token = token;
    }

    public String getDeviceIdentifier() {
        return deviceIdentifier;
    }

    public void setDeviceIdentifier(String deviceIdentifier) {
        this.deviceIdentifier = deviceIdentifier;
    }

    public Map<String, String> getCustomizedParams() {
        return customizedParams;
    }

    public void setCustomizedParams(Map<String, String> customizedParams) {
        this.customizedParams = customizedParams;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public double getThreshold() {
        return threshold;
    }

    public void setThreshold(double threshold) {
        this.threshold = threshold;
    }

    public String getStatusDisplay() {
        return statusDisplay;
    }

    public void setStatusDisplay(String statusDisplay) {
        this.statusDisplay = statusDisplay;
    }

    public String getMssoRequestID() {
        return mssoRequestID;
    }

    public void setMssoRequestID(String mssoRequestID) {
        this.mssoRequestID = mssoRequestID;
    }

    public String getMssOTAC() {
        return mssOTAC;
    }

    public void setMssOTAC(String mssOTAC) {
        this.mssOTAC = mssOTAC;
    }

    public String getMssoAccessToken() {
        return mssoAccessToken;
    }

    public void setMssoAccessToken(String mssoAccessToken) {
        this.mssoAccessToken = mssoAccessToken;
    }

    public String getUserAgent() {
        return userAgent;
    }

    public void setUserAgent(String userAgent) {
        this.userAgent = userAgent;
    }


    @JsonIgnore
    public boolean isInvalid() {
        if (this.getId() <= 0 || this.getStatus() != UserStatusEnum.ENABLE.getStatus()) {
            return true;
        }

        return false;
    }


    @Override
    public String toString() {

        StringBuilder sb = new StringBuilder("User[");
        sb.append("id").append(":").append(this.getId()).append(",");
        sb.append("userName").append(":").append(this.getUserName()).append(",");
        /*
         * sb.append("password").append(":").append(this.getPassword()) .append(";");
         */
        sb.append("email").append(":").append(this.getEmail()).append(",");
        sb.append("mobile").append(":").append(this.getMobile()).append(",");
        sb.append("nickName").append(":").append(this.getNickName()).append(",");
        sb.append("nationNumber").append(":").append(this.getNationNumber()).append(",");

        sb.append("domainId").append(":").append(this.getDomainId()).append(",");
        sb.append("status").append(":").append(this.getStatus()).append(",");
        sb.append("createTime").append(":").append(this.getCreateTime()).append(",");
        sb.append("mssoRequestId").append(":").append(this.getMssoRequestID()).append(",");
        sb.append("mssOTAC").append(":").append(this.getMssOTAC()).append(",");
        sb.append("mssoAccessToken").append(":").append(this.getMssoAccessToken()).append(",");
        sb.append("deviceIdentifier").append(":").append(this.getDeviceIdentifier()).append(",");
        sb.append("userAgent").append(":").append(this.getUserAgent()).append(",");
        sb.append("modifiedTime").append(":").append(this.getModifiedTime()).append("];");

        return sb.toString();

    }

    public Date getModifiedTime() {
        return modifiedTime;
    }

    public void setModifiedTime(Date modifiedTime) {
        this.modifiedTime = modifiedTime;
    }

    public int getGender() {
        return gender;
    }

    public void setGender(int gender) {
        this.gender = gender;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getPortrait() {
        return portrait;
    }

    public void setPortrait(String portrait) {
        this.portrait = portrait;
    }


}
