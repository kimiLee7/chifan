package org.study.chifan.core.entity.query;

import org.study.chifan.core.entity.Order;
import org.study.chifan.core.entity.User;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * Collection of Orders.
 */
public class BigOrder implements Serializable {
    private List<Order> orderList;
    private User owner;
    private Date createDate;

    public List<Order> getOrderList() {
        return orderList;
    }

    public void setOrderList(List<Order> orderList) {
        this.orderList = orderList;
    }

    public User getOwner() {
        return owner;
    }

    public void setOwner(User owner) {
        this.owner = owner;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }
}
