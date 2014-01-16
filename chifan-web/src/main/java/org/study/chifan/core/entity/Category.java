package org.study.chifan.core.entity;

import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Category implements Serializable {

    private long id;

    @NotNull
    private String name;

    private List<Product> products = new ArrayList();

    private int deleted;

    public Category() {
    }

    public Category(String name) {
        this.name = name;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<Product> getProducts() {
        return products;
    }

    public void setProducts(List<Product> products) {
        this.products = products;
    }

    public int getDeleted() {
        return deleted;
    }

    public void setDeleted(int deleted) {
        this.deleted = deleted;
    }

    @Override
    public String toString() {
        return "Category{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", products='" + products + '\'' +
                ", deleted='" + deleted + '\'' +
                '}';
    }

    public Category putInProduct(Product product) {
        if (product == null) {
            return this;
        }
        this.getProducts().add(product);
        return this;
    }
}
