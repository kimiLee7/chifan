<%@page contentType="text/html;charset=UTF-8" %>
<%@page pageEncoding="UTF-8" %>
<%--<%@ page session="false" %>--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div class="pt20b bor2 h30 overflow" style="display:none">

    <h2 class="h2_style">User Logs</h2>
    <!--  <span id="add_quota_button" class="red_btn fr"></span> -->
</div>
<div class="screen_bar mt10">
    <select id="userLogPageSize" onchange="userLogPageSizeChanged();">
        <option <c:if test="${pagedRecords.pageSize ==10}">selected</c:if> value="10">10</option>
        <option <c:if test="${pagedRecords.pageSize ==25}">selected</c:if> value="25">25</option>
        <option <c:if test="${pagedRecords.pageSize ==50}">selected</c:if> value="50">50</option>
        <option <c:if test="${pagedRecords.pageSize ==100}">selected</c:if> value="100">100</option>
    </select>

    <span class="pl5 pr10">records per page</span>

    <span id="begin_date_span" class="pl10 pr10">Start Time:</span>
    <input size="10" type="text" name="date" id="begin_date" class="dateinput" value="${filterItems.beginDate}"/>

    <span id="end_date_span" class="pl10 pr10">End Time:</span>
    <input size="10" type="text" name="date" id="end_date" class="dateinput" value="${filterItems.endDate}"/>

    <button title="searchByDate" class="red_btn s" type="button" id="searchByDate"
            onclick="searchByDate();return false;">OK</button>

	<span class="pl10 search_area fr">
        <input type="text" class="span2" placeholder="Search Key..." id="searchItem" size="16" value="${filterItems.searchItem}">
		<button title="Click for Searching " class="btn" type="button"
                id="clear_tree_search" onclick="searchByKeyword();"><i class="icon-search"></i></button>
    </span>

</div>

<!--screen_bar_end-->
<hr class="bor2 mt10"/>

<!--operation_bar_end-->
<div class="page_style mt20">
    <jsp:include page="../userLogPagingNavigator.jsp"/>
</div>
<!--page_style_end-->
<hr class="bor2 mt5"/>
<div class="table_sytle3">
    <span id="currentUserId" userId="${filterItems.userId}" style="display:none"></span>
    <table cellpadding="0" cellspacing="0">
        <colgroup width="130px"></colgroup>
        <colgroup width="80px"></colgroup>
        <colgroup width="100px"></colgroup>
        <colgroup width="50px"></colgroup>
        <colgroup width="40px"></colgroup>
        <colgroup width="50px"></colgroup>
        <thead>
        <tr>
            <th>Operation Time</th>
<%--            <th>Operator</th>--%>
            <th>Type</th>
            <th>Client</th>
            <th>Operation</th>
            <th>Result</th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${pagedRecords.records}" var="record">
            <tr>
                <td><span class="Datetime"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${record.date}"/></span>
                </td>
                <%--<td><span class="AdminName" title="${record.operator}">${record.operator}</span></td>--%>
                <td><span class="ModuleName">${record.type}</span></td>
                <td><span class="ModuleName">${record.client}</span></td>
                <td><span class="OperationName">${record.operation}</span></td>
                <%--<td><span class="OperationParam">${record.operationParam}</span></td>--%>
                <td><span class="AdminResult">${record.result}</span></td>
                <%--<td><span class="AdminFaildesec">${record.failDesc}</span></td>--%>
                <td class="AdminDetail">
                    <div class="btn-group op-group">
                        <span onclick="showDialogForDetailUserLog(${record.id});">
                            <i class="icon-log" id="title_logs" title="Event Logs"></i></span>
                    </div>
                </td>
            </tr>
        </c:forEach>

        </tbody>
    </table>
</div>
<hr class="bor2"/>
<!--table_sytle2_end-->
<div class="page_style mt10">
    <jsp:include page="../userLogPagingNavigator.jsp"/>
</div>
<!--page_style_end-->
<br/>
<br class="clear"/>


<div id="user_log_detail_div" class="SwiftSync_box" style="display: none;">

    <div class="box-header bor2">
        <h3>
            <span id="quota_title_name">Detail</span> User Log
        </h3>
    </div>
    <div class="box-content">
        <div class="box-line">
            <label for="date">Operation Time: </label>
            <input type="text" id="date" name="date" maxlength="30" readonly/>
        </div>
        <div class="box-line">
            <label for="operator">Operator: </label>
            <input type="text" id="operator" name="operator" maxlength="30" readonly/>
        </div>
        <div class="box-line">
            <label for="type">Type:</label>
            <input type="text" id="type" name="type" readonly/>
        </div>

        <div class="box-line">
            <label for="client">Client:</label>
            <input type="text" id="client" name="client" readonly/>
        </div>

        <div class="box-line">
            <label for="operation_name">Operation:</label>
            <input type="text" id="operation_name" name="operation_name" readonly/>
        </div>

        <div class="box-line">
            <label for="operation_param">OperationParam:</label>
            <textarea rows="5" cols="10" id="operation_param" style="resize:none;" readonly></textarea>
        </div>

        <div class="box-line">
            <label for="result"> Result:</label>
            <input type="text" id="result" name="result" readonly/>
        </div>

        <div class="box-line">
            <label for="fail_desc">Fail Desc:</label>
            <textarea rows="3" cols="10" id="fail_desc" style="resize:none;" readonly></textarea>
        </div>
    </div>
    <div class="box-footer">
        <button id="cancel_button" class="gray_btn"
                onclick="$('#user_log_detail_div').hide();$.fancybox.close();return false;">Cancel
        </button>
    </div>

</div>
<!--SwiftSync_box_end-->

<script src="<c:url value='/resources/js/admin.js' /> "></script>
<script src="<c:url value='/resources/js/common.js' />"></script>


<script type="text/javascript">
    function userLogPageSizeChanged() {
        var sortColumns = new Array();
        sortColumns.push('date');
        refreshUserLogs($('#userLogPageSize').val(), 1, sortColumns, 'DESC');
    }

    function changePagesForUserLog(pageNumber) {
        if (pageNumber < 1) {
            return;
        }
        var sortColumns = new Array();
        sortColumns.push('date');
        refreshUserLogs($('#userLogPageSize').val(), pageNumber, sortColumns, 'DESC');
    }

    /*function changePage(pageNumber) {
        var sortColumns = new Array();
        sortColumns.push('date');
        refreshUserLogs($('#userLogPageSize').val(), pageNumber, sortColumns, 'DESC');
    }*/

    function nextPage(pageNumber) {
        var sortColumns = new Array();
        sortColumns.push('date');
        refreshUserLogs($('#userLogPageSize').val(), pageNumber + 1, sortColumns, 'DESC');
    }

    function prePage(pageNumber) {
        if (pageNumber < 2) {
            return;
        }

        var sortColumns = new Array();
        sortColumns.push('date');
        refreshUserLogs($('#userLogPageSize').val(), pageNumber - 1, sortColumns, 'DESC');
    }

    function searchByKeyword() {
        var sortColumns = new Array();
        sortColumns.push('date');
        refreshUserLogs($('#userLogPageSize').val(), 1, sortColumns, 'DESC');
    }

    function searchByDate() {
        var sortColumns = new Array();
        sortColumns.push('date');
        refreshUserLogs($('#userLogPageSize').val(), 1, sortColumns, 'DESC');
    }

    function showDialogForDetailUserLog(id) {
        $.ajax({
            type: "POST",
            async: false,
            url: 'user/detailUserLog',
            data: {logId: id},
            success: function (data) {

                $("#date").val(data.date);
                $("#operator").val(data.operator);

                $("#type").val(data.type);
                $("#client").val(data.client);

                $("#operation_name").val(data.operation);

                $("#operation_param").val(data.operationParam);

                $("#result").val(data.result);

                $("#fail_desc").val(data.failDesc);

                $("#user_log_detail_div").show();
                $.fancybox({
                    href: '#user_log_detail_div',
                    onClosed: function () {
                        $("#user_log_detail_div").hide();
                    }
                });
            },
            error: function (data) {
                handleError(data);
            },
            beforeSend: function () {

            }
        });
    }

    function refreshUserLogs(pageSize, pageNumber, sortColumns, sortType) {
        var beginDate = $("#begin_date").val();
        var endDate = $("#end_date").val();
        var searchItem = $("#searchItem").val();
        var currentUserId = $('#currentUserId').attr("userId");
        var sortColumns2 = '';
        for (var i = 0; i < sortColumns.length; i++) {
            sortColumns2 += '&sortColumn=' + sortColumns[i]
        }

        $.ajax({
            type: "GET",
            url: 'user/log?userId=' + currentUserId
                    + '&pageSize=' + pageSize
                    + '&pageNumber=' + pageNumber
                    + '&sortType=' + sortType
                    + '&beginDate=' + beginDate
                    + '&endDate=' + endDate
                    + '&searchItem=' + searchItem
                    + sortColumns2,
            success: function (data) {
                $('#user_log_div').html(data);
                $('#user_log_li').addClass("selected");
                $('#user_li').removeClass("selected");
                $('#user_log_div').show();
                $('#user_log_li').show();
            },
            error: function (data) {
                handleError(data);
            }
        });
    }

    var sortColumns1 = new Array();
    sortColumns1.push('date');

    Calendar.setup({
        inputField: "begin_date",   // id of the input field
        ifFormat: "%Y-%m-%d",      // format of the input field
        align: "BR",
        displayArea: "begin_date"
    });
    Calendar.setup({
        inputField: "end_date",
        ifFormat: "%Y-%m-%d",
        align: "BR",
        displayArea: "end_date"
    });

</script>



