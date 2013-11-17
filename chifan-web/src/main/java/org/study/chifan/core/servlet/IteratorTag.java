package org.study.chifan.core.servlet;

import java.io.IOException;
import java.util.Map;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class IteratorTag extends SimpleTagSupport
{
    protected Logger log = LoggerFactory.getLogger(getClass());

    //标签属性，用于指定需要被迭代的集合
    private String collection;
    //标签属性，指定迭代集合元素，为集合元素指定的名称
    private String item;
    private String display;

    public void doTag() throws JspException, IOException
    {
        //从page scope中获取属性名为collection的集合
        boolean canAccess = false;
        Map itemMap = (Map) getJspContext().getAttribute(collection);
        if(itemMap ==  null){
            getJspBody().invoke(null);
            return;
        }

        final Object permission = itemMap.get(item);
        if(permission == null){
            getJspBody().invoke(null);
            return;
        }

        log.debug(StringUtils.join("resource=",item," || permission=",permission) );
        if(permission.equals("1")) {
            canAccess = true;
            log.debug(StringUtils.join(item," can accessed.") );
        }
        if(canAccess) {
            getJspContext().setAttribute(item, "inline-block");
        }else{
            getJspContext().setAttribute(item, "none" );
        }

        getJspBody().invoke(null);


    }

    public void setCollection(String collection)
    {
        this.collection = collection;
    }
    public String getCollection()
    {
        return this.collection;
    }
    public void setItem(String item)
    {
        this.item = item;
    }
    public String getItem()
    {
        return this.item;
    }

    public String getDisplay() {
        return display;
    }

    public void setDisplay(String display) {
        this.display = display;
    }

}

