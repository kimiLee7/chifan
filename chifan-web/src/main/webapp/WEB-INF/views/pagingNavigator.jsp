<%@page contentType="text/html;charset=UTF-8" %>
<%@page pageEncoding="UTF-8" %>
<%--<%@ page session="false" %>--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<span>Showing
  <span class="red">${pagedRecords.startIndex} to ${pagedRecords.endIndex} of ${pagedRecords.total}</span>
  records
</span>

<span class="fr">
  <span class="pr5"
        <c:if test="${pagedRecords.currentPageNumber > 1}">onclick="changePageNumber(1);"</c:if>>
    <i class="icon-last <c:if test="${pagedRecords.currentPageNumber == 1}">page_gray</c:if>"></i>
  </span>

    <span class="pr5"
          <c:if test="${pagedRecords.hasPre == 1}">onclick="changePageNumber(${pagedRecords.currentPageNumber} -1);"</c:if>>
      <i class="icon-previous <c:if test="${pagedRecords.hasPre == 0}">page_gray</c:if>"></i>
    </span>

    <span>
      <c:if test="${pagedRecords.pageNumTotal >= 1}">
          <a <c:if test="${1 == pagedRecords.currentPageNumber}">class="page_current"</c:if>
             onclick="changePageNumber('1');">1</a>
      </c:if>

      <c:if test="${pagedRecords.hasEllipsisLeft == 1}">
          ...
      </c:if>
    </span>

    <span>
      <c:forEach items="${pagedRecords.pageNumbers}" var="pageNumber">
          <a <c:if test="${pageNumber == pagedRecords.currentPageNumber}">class="page_current"</c:if>
             onclick="changePageNumber('${pageNumber}');">${pageNumber}</a>

      </c:forEach>
    </span>

    <span>
      <c:if test="${pagedRecords.hasEllipsisRight == 1}">
          ...
      </c:if>

      <c:if test="${pagedRecords.pageNumTotal > 1}">
          <a <c:if test="${pagedRecords.pageNumTotal == pagedRecords.currentPageNumber}">class="page_current"</c:if>
             onclick="changePageNumber('${pagedRecords.pageNumTotal}');">${pagedRecords.pageNumTotal}</a>
      </c:if>
    </span>

    <span class="pl5"
          <c:if test="${pagedRecords.hasNext == 1}">onclick="changePageNumber(${pagedRecords.currentPageNumber} + 1);"</c:if>>
      <i class="icon-next <c:if test="${pagedRecords.hasNext == 0}">page_gray</c:if>"></i>
    </span>

    <span class="pr5"
          <c:if test="${pagedRecords.currentPageNumber < pagedRecords.pageNumTotal}">onclick="changePageNumber(${pagedRecords.pageNumTotal});"</c:if>>
      <i class="icon-front <c:if test="${pagedRecords.currentPageNumber >= pagedRecords.pageNumTotal}">page_gray</c:if>"></i>
    </span>
</span>
