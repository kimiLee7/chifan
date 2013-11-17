package org.study.chifan.core.servlet;

//import org.apache.commons.logging.Log;
//import org.apache.commons.logging.LogFactory;

import org.springframework.util.StringUtils;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;
import java.io.IOException;

/**
 * @author Bruce
 *         Created on 12/24/12.
 */
public class SelectRegionTag extends TagSupport {
//    private static final Log logger = LogFactory.getLog(SelectRegionTag.class);

    private String id;
    private String name;
    private String value;
    private Integer size = 1;
    private Boolean multiple = Boolean.FALSE;
    private Boolean allowEmpty = Boolean.TRUE;

    @Override
    public int doStartTag() throws JspException {
        StringBuilder buf = new StringBuilder();

        buf.append("<select ");

        if (StringUtils.hasText(id)) {
            buf.append("id=\"");
            buf.append(id);
//            buf.append(ExpressionEvaluationUtils.evaluate("id", id, pageContext));
            buf.append("\" ");
        }

        if (StringUtils.hasText(name)) {
            buf.append("name=\"");
            buf.append(name);
//            buf.append(ExpressionEvaluationUtils.evaluate("name", name, pageContext));
            buf.append("\" ");
        }

        buf.append("size=\"").append(size).append("\" ");

        if (multiple) {
            buf.append("multiple=\"multiple\" ");
        }

        buf.append(">");

        int level = 0;
        long selectedRegion = 0;
        try {
            selectedRegion = Long.parseLong(value);
        } catch (Exception e) {
            // ignore
        }
        if (!multiple && allowEmpty) {
            buf.append("<option value=\"0\"");
            if (selectedRegion == 0) {
                buf.append(" selected=\"selected\"");
            }
            buf.append(">All</option>");
        }

        buf.append("</select>");

        try {
            pageContext.getOut().write(buf.toString());
        } catch (IOException e) {
//            logger.error(e.getMessage(), e);

            throw new JspException(e.getMessage());
        }

        return EVAL_BODY_INCLUDE;
    }

    private void addRegionOption() {
    }

    private void indent(StringBuilder buf, int level) {
        for (int i = 0; i < level; i++) {
            buf.append("&nbsp;&nbsp;");
        }
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public void setSize(Integer size) {
        this.size = size;
    }

    public void setMultiple(Boolean multiple) {
        this.multiple = multiple;
    }

    public void setAllowEmpty(Boolean allowEmpty) {
        this.allowEmpty = allowEmpty;
    }
}
