<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@page contentType="text/html;charset=UTF-8" %>
<%@page pageEncoding="UTF-8" %>
<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <title><fmt:message key="welcome.title"/></title>
  <link rel="stylesheet" href="<c:url value="/resources/blueprint/screen.css" />" type="text/css"
        media="screen, projection"/>
  <link rel="stylesheet" href="<c:url value="/resources/blueprint/print.css" />" type="text/css" media="print"/>
  <!--[if lt IE 8]>
  <link rel="stylesheet"
        href="<c:url value="/resources/blueprint/ie.css" />" type="text/css" media="screen, projection"/>
  <![endif]-->
</head>
<body>
<div class="container">
  <h1>
    <fmt:message key="welcome.title"/>
  </h1>

  <p>
    Locale = ${pageContext.response.locale}
  </p>
  <hr>
  <ul>
    <li><a href="?locale=en_us">us</a> | <a href="?locale=en_gb">gb</a> | <a href="?locale=es_es">es</a> | <a
        href="?locale=de_de">de</a></li>
  </ul>
  <ul>
    <li><a href="/account">Ajax @Controller Example</a></li>
    <br/>

    <BR>

    <%
      //创建一个List对象
      List<String> a = new ArrayList<String>();
      a.add("hello");
      a.add("world");
      a.add("java");
      //将List对象放入page范围内
      pageContext.setAttribute("a", a);
    %>
    <table border="1" bgcolor="aaaadd" width="300">
      <!-- 使用迭代器标签，对a集合进行迭代 -->

    </table>

    <br>
    <br>

    <c:out value='<%=request.getSession().getAttribute("currentAdmin")%>'/>

    <br>
    <br>
    <a href="administrator/list" id="retrieveAdministrators" onclick="">retrieveAdministrators</a>
  </ul>
</div>
</body>
<script type="text/javascript" src="<c:url value="/resources/jquery-1.4.min.js" /> "></script>
<script type="text/javascript">
  function retrieveAdministrators(){
    alert("retrieveAdministrators---begin.");
  }

  /*jQuery(document).ready(function() {
    $("#retrieveAdministrators").bind("click", retrieveAdministrators);
  });*/

</script>

</html>