package org.study.chifan.core.entity;

/**
 * @author Bruce
 *         Created on 12/26/12.
 */
public class DomainVO extends Domain {
    private String parentName;

    //about Storage Usage
    private long currentEntityTotalQuota;

    private long allocatedCurrentEntityQuota;
    private String allocatedCurrentEntityQuotaPercent;

    private long allocatedSubEntitiesQuota;
    private String allocatedSubEntitiesQuotaPercent;

    private long allocatableQuota;
    private String allocatableQuotaPercent;

    //about End User Development
    private long totalUsers;

    private long currentEntityUsers;
    private String currentEntityUsersPercent;

    private long subEntitiesUsers;
    private String subEntitiesUsersPercent;

    public String getParentName() {
        return parentName;
    }

    public void setParentName(String parentName) {
        this.parentName = parentName;
    }

    public long getCurrentEntityTotalQuota() {
        return currentEntityTotalQuota;
    }

    public void setCurrentEntityTotalQuota(long currentEntityTotalQuota) {
        this.currentEntityTotalQuota = currentEntityTotalQuota;
    }

    public long getAllocatedCurrentEntityQuota() {
        return allocatedCurrentEntityQuota;
    }

    public void setAllocatedCurrentEntityQuota(long allocatedCurrentEntityQuota) {
        this.allocatedCurrentEntityQuota = allocatedCurrentEntityQuota;
    }

    public String getAllocatedCurrentEntityQuotaPercent() {
        return allocatedCurrentEntityQuotaPercent;
    }

    public void setAllocatedCurrentEntityQuotaPercent(String allocatedCurrentEntityQuotaPercent) {
        this.allocatedCurrentEntityQuotaPercent = allocatedCurrentEntityQuotaPercent;
    }

    public long getAllocatedSubEntitiesQuota() {
        return allocatedSubEntitiesQuota;
    }

    public void setAllocatedSubEntitiesQuota(long allocatedSubEntitiesQuota) {
        this.allocatedSubEntitiesQuota = allocatedSubEntitiesQuota;
    }

    public String getAllocatedSubEntitiesQuotaPercent() {
        return allocatedSubEntitiesQuotaPercent;
    }

    public void setAllocatedSubEntitiesQuotaPercent(String allocatedSubEntitiesQuotaPercent) {
        this.allocatedSubEntitiesQuotaPercent = allocatedSubEntitiesQuotaPercent;
    }

    public long getAllocatableQuota() {
        return allocatableQuota;
    }

    public void setAllocatableQuota(long allocatableQuota) {
        this.allocatableQuota = allocatableQuota;
    }

    public String getAllocatableQuotaPercent() {
        return allocatableQuotaPercent;
    }

    public void setAllocatableQuotaPercent(String allocatableQuotaPercent) {
        this.allocatableQuotaPercent = allocatableQuotaPercent;
    }

    public long getTotalUsers() {
        return totalUsers;
    }

    public void setTotalUsers(long totalUsers) {
        this.totalUsers = totalUsers;
    }

    public long getCurrentEntityUsers() {
        return currentEntityUsers;
    }

    public void setCurrentEntityUsers(long currentEntityUsers) {
        this.currentEntityUsers = currentEntityUsers;
    }

    public String getCurrentEntityUsersPercent() {
        return currentEntityUsersPercent;
    }

    public void setCurrentEntityUsersPercent(String currentEntityUsersPercent) {
        this.currentEntityUsersPercent = currentEntityUsersPercent;
    }

    public long getSubEntitiesUsers() {
        return subEntitiesUsers;
    }

    public void setSubEntitiesUsers(long subEntitiesUsers) {
        this.subEntitiesUsers = subEntitiesUsers;
    }

    public String getSubEntitiesUsersPercent() {
        return subEntitiesUsersPercent;
    }

    public void setSubEntitiesUsersPercent(String subEntitiesUsersPercent) {
        this.subEntitiesUsersPercent = subEntitiesUsersPercent;
    }
}
