package org.study.chifan.core.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Order implements Serializable {

    private long id;

    private User user;

    private Date createDate;

    private Shop shop;

    private List<Product> productList = new ArrayList<>();

    private int status;

    private int deleted;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Shop getShop() {
        return shop;
    }

    public void setShop(Shop shop) {
        this.shop = shop;
    }

    public List<Product> getProductList() {
        return productList;
    }

    public void setProductList(List<Product> productList) {
        this.productList = productList;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getDeleted() {
        return deleted;
    }

    public void setDeleted(int deleted) {
        this.deleted = deleted;
    }

    @Override
    public String toString() {
        return "Order{" +
                "id=" + id +
                ", createDate='" + createDate + '\'' +
                ", shop='" + shop + '\'' +
                ", status='" + status + '\'' +
                ", deleted='" + deleted + '\'' +
                ", productList='" + productList.size() + '\'' +
                '}';
    }
}
