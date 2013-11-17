
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@page contentType="text/html;charset=UTF-8" %>
<%@page pageEncoding="UTF-8" %>
<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<ul id="domain_tree">
  <input type="hidden"  id="current_domain_id" name="current_domain_id" />
  <input type="hidden"  id="current_domain_name" name="current_domain_name" />
  ${domainTreeView}
  <%--<li><a href="#">------</a>
    <ul>
    &lt;%&ndash;<c:forEach items="${administrators}" var="administrators">&ndash;%&gt;

    &lt;%&ndash;</c:forEach>&ndash;%&gt;
    </ul>
  </li>--%>
</ul><!--files_end-->

