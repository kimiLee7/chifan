package org.study.chifan.core.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.NumberFormat;

public class Domain implements Serializable {
    private int id;

    @NotNull
    @NumberFormat(style = NumberFormat.Style.NUMBER)
    private int parentId;

    @NotNull
    private String name;


    private String fullName;

    @NotNull
    @NumberFormat(style = NumberFormat.Style.NUMBER)
    private long quota;

    @Size(min = 1, max = 100)
    private String description;

    private List<Domain> children = new ArrayList<Domain>();

    public boolean isLeaf = true;


    private String domainCode;

    private String displayEndTag = "";
    private String displayStartTag = "<li><ins class=\"jstree-icon\"></ins><a href=\"#\" domain_id=\""
            + this.getId() +
            "\" parent_id=\"1\" domain_name=\"Singtel\" >Singtel</a>";

    public String getDisplayTagEnd() {
        if (!isLeaf()) {
            return "</ul></li>";
        } else {
            return "";
        }
    }

    public String getDisplayTagStart() {

        String name = this.getName();
        if (name.length() > 15) {
            name = name.substring(0, 13) + "...";
        }
        if (!isLeaf()) {
            return "<li><ins class=\"jstree-icon\"></ins><a href=\"#\" domain_id=\""
                    + this.getId() +
                    "\" parent_id=\""
                    + this.getParentId() +
                    "\" domain_name=\""
                    + this.getName() +
                    "\" title=\""
                    + this.getName() +
                    "\">"
                    + name +
                    "</a><ul>";
        } else {
            return "<li><ins class=\"jstree-icon_1\"></ins><a href=\"#\" domain_id=\""
                    + this.getId() +
                    "\" parent_id=\""
                    + this.getParentId() +
                    "\" domain_name=\""
                    + this.getName() +
                    "\" title=\""
                    + this.getName() +
                    "\">"
                    + name +
                    "</a></li>";
        }

    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getParentId() {
        return parentId;
    }

    public void setParentId(int parentId) {
        this.parentId = parentId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getDomainCode() {
        return domainCode;
    }

    public void setDomainCode(String domainCode) {
        this.domainCode = domainCode;
    }


    public long getQuota() {
        return quota;
    }

    public void setQuota(long quota) {
        this.quota = quota;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<Domain> getChildren() {
        return children;
    }

    public void setChildren(List<Domain> children) {
        this.children = children;
    }

    public boolean isLeaf() {
        return children.size() == 0;
    }

    @Override
    public String toString() {
        return "Domain{" +
                "id=" + id +
                ", parentId=" + parentId +
                ", name='" + name + '\'' +
                ", fullName='" + fullName + '\'' +
                ", quota='" + quota + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
}
