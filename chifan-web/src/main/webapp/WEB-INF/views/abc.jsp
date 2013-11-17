<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=UTF-8" %>
<%@page pageEncoding="UTF-8" %>
<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<head>
	<meta charset="utf-8" />
	<title>Respond JS Test Page</title>
	<link rel="stylesheet" href="<c:url value='/resources/css/test.css' />"/>

	<link href="<c:url value='/resources/css/test2.css' />" media="screen and (min-width: 37.5em)" rel="stylesheet"/> <!-- 37.5em = 600px @ 16px -->   
   <script src="<c:url value='/resources/js/respond.src.js' />"></script>
</head> 
<body>
	<p>This is just a visual test file, and an ugly one at that! For unit tests, visit the <a href="unit/"> Respond.js unit test suite</a></p>

<p>The media queries in the included CSS file simply change the body's background color depending on the browser width. If you see any colors aside from black, then the media queries are working in your browser. You can resize your browser window to see it change on the fly.</p>

<p>For a realistic use case for media queries: read up on <a href="http://www.alistapart.com/articles/responsive-web-design/">Responsive Web Design</a></p>

	<p id="attribute-test">Media-attributes are working too! This should be visible above 37.5em.</p>

</body>
</html>