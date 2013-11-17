<%@page contentType="text/html;charset=UTF-8" %>
<%@page pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>
<%--<%@ page session="false" %>--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.swiftsync.org/security-taglib" prefix="permission" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<link rel="stylesheet" href="resources/js/jquery-ui/css/custom-theme/jquery-ui-1.8.14.custom.css"/>

<div class="pt20b bor2 overflow">
    <h2 class="h2_style">End Users</h2>
    <permission:show_button resource="USER" operation="CREATE">
        <span id="add_user_button" class="red_btn fr">Add a User</span>
    </permission:show_button>
</div>

<%--<div class="tabs_ul mt20">
    <ul class="clear">
        <li class="selected" id="user_li"></li>
        <li id="user_log_li" style="display:none"></li>
    </ul>
</div>--%>
<div class="tabs_div">
    <div id="first">
        <div class="screen_bar mt10">
            <select id="user_pageSize" onchange="userPageSizeChanged();">
                <%--<option <c:if test="${pagedRecords.pageSize ==1}">selected</c:if> value="1">1</option>--%>
                <%--<option <c:if test="${pagedRecords.pageSize ==2}">selected</c:if> value="2">2</option>--%>
                <option
                        <c:if test="${pagedRecords.pageSize ==10}">selected</c:if> value="10">10
                </option>
                <option
                        <c:if test="${pagedRecords.pageSize ==25}">selected</c:if> value="25">25
                </option>
                <option
                        <c:if test="${pagedRecords.pageSize ==50}">selected</c:if> value="50">50
                </option>
                <option
                        <c:if test="${pagedRecords.pageSize ==100}">selected</c:if> value="100">100
                </option>
            </select>
            <span class="pl5 pr10">records per page</span>
            <span class="pl10 pr10">By Status:</span>
            <select class="u149" id="filterByStatus" onchange="statusFilterChanged();">
                <option
                        <c:if test="${filterItems.status ==-1}">selected</c:if> value="-1" selected="">ALL
                </option>
                <option
                        <c:if test="${filterItems.status ==0}">selected</c:if> value="0">Enabled
                </option>
                <option
                        <c:if test="${filterItems.status ==1}">selected</c:if> value="1">Disabled
                </option>
                <option
                        <c:if test="${filterItems.status ==9}">selected</c:if> value="9">Deleted
                </option>
            </select>
            <span class="pl10 pr10">By Quota:</span>
            <select class="u150" id="filterByQuota" onchange="quotaFilterChanged();">
                <option value="-1" selected="">ALL</option>
                <c:forEach items="${allQuotas}" var="quota">
                    <option
                            <c:if test="${filterItems.quotaId == quota.id}">selected</c:if>
                            value="${quota.id}">${quota.name}</option>
                </c:forEach>
            </select>
                <span class="pl10 search_area fr"><input type="text" class="span2" placeholder="Search Key..."
                                                         id="filterByKeyword" size="16" value="${filterItems.keyword}"
                                                         onkeypress="searchByKeywordEnter(event);">
                	<button title="Click for Searching " class="btn" type="button" id="clear_tree_search"
                            onclick="searchByKeyword();"><i class="icon-search"></i></button>
                </span>
        </div>
        <!--screen_bar_end-->
        <hr class="bor2 mt10"/>
        <div class="operation_bar mt10">

            <c:if test="${filterItems.status !=9}">
                <permission:show_button resource="USER" operation="MODIFY">
  <span class="pr10"><button title="Delete" class="btn" type="button" id="Delete" disabled="disabled"
                             onclick="showDialogForBatchDeleteUser();"><i class="icon-trash"></i> Delete
  </button></span>
  <span class="pr10"><button title="Enable" class="btn" type="button" id="Enable" disabled="disabled"
                             onclick="showDialogForBatchEnableUser();"><i class="icon-Enable"></i> Enable
  </button></span>
  <span class="pr10"><button title="Disable" class="btn" type="button" id="Disable" disabled="disabled"
                             onclick="showDialogForBatchDisableUser();"><i class="icon-Disable"></i> Disable
  </button></span>
  <span class=""><button title="Modify Quota" class="btn" type="button" id="Modify_Quota" disabled="disabled"
                         onclick="showDialogForBatchModifyUserQuota();"><i class="icon-Modify"></i> Modify Quota
  </button></span>
                </permission:show_button>
            </c:if>
            <c:if test="${filterItems.status ==9}">
                <permission:show_button resource="USER" operation="MODIFY">
    <span class=""><button title="Restore" class="btn" type="button" id="Restore" disabled="disabled"
                           onclick="showDialogForBatchRestoreUser();"><i class="icon-Restore"></i> Restore
    </button></span>
                </permission:show_button>
            </c:if>


        </div>
        <!--operation_bar_end-->

        <div class="page_style mt20">
  <span style="display: none;" id="current_page_number_user"
        current_page_number="${pagedRecords.currentPageNumber}"></span>

            <jsp:include page="../pagingNavigator.jsp"/>
        </div>
        <!--page_style_end-->

        <hr class="bor2 mt5"/>
        <div class="table_sytle2">

            <table cellpadding="0" cellspacing="0">
                <colgroup width="25px"></colgroup>
                <colgroup width="320px"></colgroup>
                <colgroup width="80px"></colgroup>
                <colgroup width="200px"></colgroup>
                <colgroup width="50px"></colgroup>
                <colgroup width="90px"></colgroup>
                <thead>
                <tr>
                    <th align="center"><input id="checkAll" type="checkbox"/></th>
                    <th
                            <c:if test="${sorting.sortColumn == 'user_name'}">class="sorting_${sorting.sortType}"</c:if>
                            <c:if test="${sorting.sortColumn != 'user_name'}">class="sorting"</c:if>
                            sort_column_name="user_name" onclick="sortUserBy($(this));">User Name
                    </th>
                    <%--<th>Nick Name</th>--%>
                    <th>Quota (GB)</th>
                    <!--  <th>Storage <br/>used(%)</th> -->
                    <%--<th
                        <c:if test="${sorting.sortColumn == 'email'}">class="sorting_${sorting.sortType}"</c:if>
                        <c:if test="${sorting.sortColumn != 'email'}">class="sorting"</c:if>
                        sort_column_name="email" onclick="sortUserBy($(this));">Email
                    </th>--%>
                    <th
                            <c:if test="${sorting.sortColumn == 'create_time'}">class="sorting_${sorting.sortType}"</c:if>
                            <c:if test="${sorting.sortColumn != 'create_time'}">class="sorting"</c:if>
                            sort_column_name="create_time" onclick="sortUserBy($(this));">Create Time
                    </th>
                    <th>Status</th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${pagedRecords.records}" var="recordContent">
                    <tr>
                        <td align="center">
                            <input ref="user_record_checkbox" name="subBox" type="checkbox"
                                   record_id="${recordContent.id}"/></td>
                        <td><span class="username">${recordContent.userName}</span></td>

                        <td><span> <c:choose> <c:when test="${recordContent.quota.maxLimit<0}">Unlimited
                        </c:when> <c:otherwise> <fmt:formatNumber type="number"
                                                                  maxFractionDigits="2"
                                                                  value="${recordContent.quota.maxLimit/1024}"/>
                        </c:otherwise>
                        </c:choose>
       </span></td>

                        <td><span>
                            <%--<c:if test="${filterItems.status !=9}">${recordContent.createTimeFormatted}</c:if>
                            <c:if test="${filterItems.status ==9}">${recordContent.modifiedTimeFormatted}</c:if>--%>
                            ${recordContent.createTimeFormatted}
                        </span></td>
                        <td><span>${recordContent.statusDisplay}</span></td>
                        <td>
                            <div class="btn-group op-group">
                                <c:if test="${filterItems.status ==9}">
                                    <permission:show_button resource="USER" operation="MODIFY">
                                     <span onclick='showDialogForRestoreSingleUser(${recordContent.id},"${recordContent.userName}");'><i
                                             class="icon-Restore" id="title_Restore" title="Restore"></i></span>
                                    </permission:show_button>
                                </c:if>

                                <c:if test="${filterItems.status !=9}">
                                    <permission:show_button resource="USER" operation="GET">
                                    <span record_id="${recordContent.id}" class="log_button"><i class="icon-log"
                                                                                                id="title_logs"
                                                                                                title="Event Logs"></i></span>
                                    </permission:show_button>

                                    <permission:show_button resource="USER" operation="MODIFY">
                                        <permission:show_button resource="USER" operation="DELETE">
                                        <span onclick='showDialogForDeleteSingleUser(${recordContent.id},"${recordContent.userName}");'><i
                                                class="icon-trash" id="title_Trash" title="Delete "></i></span>
                                        </permission:show_button>
                                        <permission:show_button resource="USER" operation="RESET_PASSWORD">
                                        <span onclick='showDialogForResetUserPassword(${recordContent.id},"${recordContent.userName}");'><i
                                                class="icon-Reset" id="title_Rest"
                                                title="Reset User Password"></i></span>
                                        </permission:show_button>
                                        <permission:show_button resource="USER" operation="MODIFY">
                                        <span onclick="User(${recordContent.id});"><i class="icon-Logs" id="title_Edit"
                                                                                      title="Edit "></i></span>
                                        </permission:show_button>
                                    </permission:show_button>
                                </c:if>
                            </div>
                            <!--op-group_end-->
                        </td>
                    </tr>
                </c:forEach>

                </tbody>
            </table>
        </div>
        <hr class="bor2"/>
        <!--table_sytle2_end-->

        <div class="page_style mt10">
            <jsp:include page="../pagingNavigator.jsp"/>
        </div>

    </div>
    <div id="user_log_div" style="display:none">
    </div>

</div>

<!--page_style_end-->

<br/>
<br class="clear"/>


<div id="create_user_div" class="SwiftSync_box" style="display: none;">
    <form id="create_user_form" action="">
        <input type="hidden" id="user_id"/>

        <div class="box-header bor2"><h3><span id="title_create_user">Add a </span>&nbsp;User</h3></div>
        <div class="box-content">

            <div class="box-line">
                <label for="user_name">User Name *</label>
                <input type="text" id="user_name" name="user_name" maxlength="50" class="input_help_tips"/>

                <div class="login_tips hide">
                    <h4>User Name</h4>

                    <p>This field is required. It can't contain any of the following characters: \ / : * ? " < > | </p>
                    <span class="caret_login"><small class="caret_login_in"></small></span>
                </div>
            </div>


            <div id="quota_in_add_user" class="box-line">
                <label for="user_quota">Quota *</label>
                <select id="user_quota" name="user_quota">
                    <option selected value="10">10</option>
                    <option value="20">20</option>
                </select>
                <%--<input class="number" min="1" type="text" id="user_quota" name="user_quota" value="1000" maxlength="10"/>--%>
            </div>
            <div class="box-line" id="user_password_div">
                <label for="user_password">Password *</label>
                <input type="password" class="input_help_tips required" minlength="6" id="user_password"
                       name="user_password"
                       maxlength="20"/>

                <div class="login_tips hide">
                    <h4>Password</h4>

                    <p>This field is required. It must be at least six characters long.</p>
                    <span class="caret_login"><small class="caret_login_in"></small></span>
                </div>
            </div>
            <div class="box-line" id="user_password_confirm_div">
                <label for="user_password_confirm">Confirm password *</label>
                <input type="password" class="input_help_tips required" minlength="6" equalTo="#user_password"
                       id="user_password_confirm"
                       name="user_password_confirm" maxlength="20"/>

                <div class="login_tips hide">
                    <h4>Confirm password</h4>

                    <p>This field is required. It must be at least six characters long. Confirmed password must match
                        the
                        Password.</p>
                    <span class="caret_login"><small class="caret_login_in"></small></span>
                </div>
            </div>

            <div class="box-line">
                <label for="user_type">Type</label>
                <select id="user_type" name="user_type">
                    <option selected value="SWIFTSYNC">SwiftSync</option>
                    <%--<option value="IDEAS">IDEAS</option>--%>
                </select>
                <%--<input type="text" id="user_type" name="user_type"/>--%>
            </div>

            <div class="box-line bg2">
                <button id="advanced" onclick="$('#advance_div').toggle();return false;">Advanced</button>
            </div>


            <div class="" id="advance_div" style="display: none">

                <div class="box-line">
                    <label for="nick_name">Gender:</label>
                    <input id="male_radio" type="radio" style="width:auto;height:auto" name="gender" value="0" checked>
                    Male
                    <input id="female_radio" type="radio" style="width:auto;height:auto" name=gender value="1"> Female
                </div>
                <div class="box-line">
                    <label>Profile:</label>

                    <div id="account_img_div" style="display:inline-block; cursor:pointer"><img id="account_img"
                                                                                                src="resources/images/account/male.png"/>
                    </div>
                    <input type="hidden" id="portrait" name="portrait" value="">

                    <div class="hide account-list">
                        <ul>
                            <%--<li><img id="male.png" src="user/profile?profile=male.png" /></li>--%>
                            <%--<li><img id="female.png" src="user/profile?profile=female.png" /></li>--%>
                            <li><img id="p1.png" src="user/profile?profile=p1.png"/></li>
                            <li><img id="p2.png" src="user/profile?profile=p2.png"/></li>
                        </ul>
                    </div>
                </div>

                <div class="box-line">
                    <label for="nick_name">Nick Name</label>
                    <input type="text" id="nick_name" name="nick_name" maxlength="50"/>
                </div>
                <div class="box-line" id="birthday_div">
                    <label for="birthday">Birthday</label>
                    <input size="10" type="text" name="birthday" id="birthday"/>

                    <div class="login_tips hide">
                        <h4>Birthday</h4>

                        <p>yyyy-MM-dd.</p>
                        <span class="caret_login"><small class="caret_login_in"></small></span>
                    </div>
                </div>
                <div class="box-line">
                    <label for="user_email">Email</label>
                    <input type="text" id="user_email" name="user_email" maxlength="50"/>
                </div>
                <div class="box-line">
                    <label for="user_mobile">Mobile</label>
                    <input type="text" class="input_help_tips digits" id="user_mobile" name="user_mobile"
                           maxlength="16"/>

                    <div class="login_tips hide">
                        <h4>Mobile</h4>

                        <p>It must contain just digits.</p>
                        <span class="caret_login"><small class="caret_login_in"></small></span>
                    </div>
                </div>

            </div>
        </div>
        <div class="box-footer">
            <button id="create_user_cancel" class="gray_btn"
                    onclick="$('#create_user_div').hide();$.fancybox.close();return false;">Cancel
            </button>
            <%--<button id="create_user_save" class="red_btn">Save</button>--%>
            <input id="create_user_save" type="submit" class="red_btn" value="Save">
        </div>
    </form>
</div>
<!--create_user_div end-->

<div id="modify_user_quota_div" class="SwiftSync_box" style="display: none;">
    <form id="modify_user_quota_form" action="">
        <div class="box-header bor2"><h3>Modify User Quota</h3></div>
        <div class="box-content">
            <div id="quota_list_modify_user" class="box-line">
                <label for="user_quota">Quota *</label>
                <select id="user_quota_none" name="user_quota_list">
                    <option value="-1">None</option>
                </select>
            </div>
        </div>
        <div class="box-footer">
            <button class="gray_btn" onclick="$('#modify_user_quota_div').hide();$.fancybox.close();return false">Cancel
            </button>
            <button class="red_btn" onclick="batchModifyUserQuotaSave();return false">Save</button>
            <%--<input type="submit" class="red_btn" value="Save">--%>
        </div>
    </form>
</div>
<!--modify_user_quota_div end-->

<div id="delete_user_div" class="SwiftSync_box" style="display: none;">
    <div class="box-header bor2"><h3><span id="batch_operation_title">Delete</span> User</h3> <span
            class="fr close">X</span></div>
    <div class="box-content">
        <div class="box-line clear">
            <span class="q_icon"></span>
      <span id="delete_user_message" class="line-text">
        You want to <span id="batch_operation_type">delete</span> <span id="delete_user_number"></span>.
        Are you sure?
      </span>
        </div>
    </div>
    <div class="box-footer">
    <span class="pr10"><button class="gray_btn" onclick="$('#delete_user_div').hide();$.fancybox.close();">Cancel
    </button></span>
        <span><button class="red_btn" id="submit_delete_user">Submit</button> </span>
    </div>
</div>
<!--delete_user_div end-->

<div id="delete_single_user_div" class="SwiftSync_box" style="display: none;">
    <div class="box-header bor2"><h3>Delete User</h3> <span class="fr close">X</span></div>
    <div class="box-content">
        <form action="">
            <input type="hidden" id="id_delete_single_user"/>
        </form>
        <div class="box-line">
            <span class="q_icon"></span>
      <span class="line-text">You want to delete user "<span id="delete_user_name"></span>". Are you sure?
       </span>
        </div>
    </div>
    <div class="box-footer">
    <span class="pr10"><button class="gray_btn" onclick='$("#delete_single_user_div").hide();$.fancybox.close();'>Cancel
    </button></span>
        <span><button class="red_btn" onclick="deleteSingleUser();">Submit</button> </span>
    </div>
</div>
<!--delete_single_user_div end-->

<div id="restore_single_user_div" class="SwiftSync_box" style="display: none;">
    <div class="box-header bor2"><h3>Restore User</h3> <span class="fr close">X</span></div>
    <div class="box-content">
        <form action="">
            <input type="hidden" id="id_restore_single_user"/>
        </form>
        <div class="box-line clear">
            <span class="q_icon"></span>
      <span class="line-text">You want to restore user "<span id="restore_user_name"></span>". Are you sure?
       </span>
        </div>
    </div>
    <div class="box-footer">
    <span class="pr10"><button class="gray_btn" onclick='$("#restore_single_user_div").hide();$.fancybox.close();'>
        Cancel
    </button></span>
        <span><button class="red_btn" onclick="restoreSingleUser();">Submit</button> </span>
    </div>
</div>
<!--restore_single_user_div end-->

<div id="reset_password_user_div" class="SwiftSync_box" style="display: none;">
    <form id="reset_password_user_form" action="">
        <div class="box-header bor2"><h3>Reset User Password</h3></div>
        <input type="hidden" id="user_id_reset_password"/>

        <h5 class="second-title">
            <label>User Name: </label>
            <span id="user_id_reset"></span>
        </h5>

        <div class="box-content">
            <div class="box-line">
                <label for="user_password_reset">New Password *</label>
                <input type="password" id="user_password_reset" name="user_password_reset"
                       class="input_help_tips required"
                       minlength="6" maxlength="20"/>

                <div class="login_tips hide">
                    <h4>New password</h4>

                    <p>This field is required. It must be at least six characters long.</p>
                    <span class="caret_login"><small class="caret_login_in"></small></span>
                </div>
            </div>
            <div class="box-line">
                <label for="user_password_reset_confirm">Confirm new Password *</label>
                <input type="password" id="user_password_reset_confirm" name="user_password_reset_confirm"
                       equalTo="#user_password_reset" class="input_help_tips required" minlength="6" maxlength="20"/>

                <div class="login_tips hide">
                    <h4>Confirm new password</h4>

                    <p>This field is required. It must be at least six characters long. Confirmed password must match
                        the
                        Password</p>
                    <span class="caret_login"><small class="caret_login_in"></small></span>
                </div>
            </div>
        </div>
        <div class="box-footer">
            <button class="gray_btn" onclick="$('#reset_password_user_div').hide();$.fancybox.close();return false;">
                Cancel
            </button>
            <input type="submit" class="red_btn" value="Save">
        </div>
    </form>
</div>


<!--reset_password_user_div end-->

<script src="<c:url value='/resources/js/admin.js' /> "></script>
<script src="<c:url value='/resources/js/common.js' />"></script>
<script src="<c:url value='/resources/js/jquery-ui/jquery-ui-1.8.14.custom.min.js' />"></script>
<script src="resources/js/jquery-formatDate.js"></script>

<script type="text/javascript">

function userPageSizeChanged() {
    refreshUserList($('#user_pageSize').val(), 1, 'create_time', 'desc')
}

function changePageNumber(pageNumber) {
    if (pageNumber < 1) {
        return;
    }
    refreshUserList($('#user_pageSize').val(), pageNumber, 'create_time', 'desc')
}

function refreshUserList(pageSize, pageNumber, sortColumn, sortType) {
    var currentDomainId = $('#current_domain').attr("currentDomainId");
    var quotaId = $('#filterByQuota').val();
    var status = $('#filterByStatus').val();
    var keyword = $('#filterByKeyword').val();

    $.ajax({
        type:"GET",
        url:'user/list?domainId=' + currentDomainId
                + '&pageSize=' + pageSize
                + '&pageNumber=' + pageNumber
                + '&sortColumn=' + sortColumn
                + '&sortType=' + sortType
                + '&quotaId=' + quotaId
                + '&status=' + status
                + '&keyword=' + keyword,
        success:function (data) {
            $('#sub_content_div').html(data)
        },
        error:function (data) {
            handleError(data);
        }
    });
}

function User(id) {
    var currentDomainId = $('#current_domain').attr("currentDomainId");
    $("#title_create_user").html("Edit");
    $("#user_id").val(id);

    $('label.error').remove();

    $.ajax({
        type:"GET",
        async:false,
        url:'quota/retrieve',
//      contentType: 'application/json; charset=utf-8',
//      dataType: 'json',
        data:{ domainId:currentDomainId},
        success:function (data) {
            var selectTag = getSelect(data, 'user_quota');
            $("#quota_in_add_user").html(selectTag);
        },
        error:function (data) {
            handleError(data);
        }
    });

    $.ajax({
        type:"GET",
        async:false,
        url:'user',
//      contentType: 'application/json; charset=utf-8',
//      dataType: 'json',
        data:{ id:id},
        success:function (data) {
            if (data.userDetails == null) {
                return;
            }
            $("#user_id").val(data.userDetails.id);
            $("#user_name").val(data.userDetails.userName);
            $("#nick_name").val(data.userDetails.nickName);
            $("#user_email").val(data.userDetails.email);
            $("#user_mobile").val(data.userDetails.mobile);
            $("#user_type").val(data.userDetails.type);
            $("#user_password").val("empty-password");
            $("#user_password_confirm").val("empty-password");
            $("#user_password_div").hide();
            $("#user_password_confirm_div").hide();

            $("#birthday").val(data.userDetails.birthday);

            $("#account_img").attr("src", "${download_server_url}2/admin/user/profile?width=64&height=64&userId=" + data.userDetails.id + "&_ts=" + (new Date()).valueOf());

            $('#advance_div').show();

            var gender = data.userDetails.gender;

            if (gender == 0) {
                $("#male_radio").attr('checked', true);
                $("#female_radio").attr('checked', false);
            } else {
                $("#male_radio").attr('checked', false);
                $("#female_radio").attr('checked', true);
            }

            if (data.userDetails.quota != null) {
                $("#user_quota").val(data.userDetails.quota.id);
            } else {
                $("#user_quota").val("");
            }
            $("#create_user_div").show();

            $.fancybox({
                href:'#create_user_div',
                onClosed:function () {
                    $("#create_user_div").hide();
                }
            });
        },
        error:function (data) {
            handleError(data);
        },
        beforeSend:function () {
        }
    });
}


function showDialogForAddUser() {
    var currentDomainId = $('#current_domain').attr("currentDomainId");

    $('label.error').remove();

    $("#user_id").val("-1");
    $("#user_name").val("");
    $("#nick_name").val("");
    $("#user_email").val("");
    $("#user_mobile").val("");
    $("#user_quota").val(0);
    $("#user_type").val("");
    $("#user_password").val("");
    $("#user_password_confirm").val("");
    $("#user_password_div").show();
    $("#user_password_confirm_div").show();
    $("#title_create_user").html("Add a");

    $('#advance_div').hide();

    $.ajax({
        type:"GET",
        async:false,
        url:'quota/retrieve',
//      contentType: 'application/json; charset=utf-8',
//      dataType: 'json',
        data:{ domainId:currentDomainId},
        success:function (data) {
            if (data.length == 0) {
                fancyAlert("Please add storage first.");
                return;
            }
            var selectTag = getSelect(data, 'user_quota');
            $("#quota_in_add_user").html(selectTag);
            $("#create_user_div").show();

            $.fancybox({
                href:'#create_user_div',
                onClosed:function () {
                    $("#create_user_div").hide();
                }
            });
        },
        error:function (data) {
            handleError(data);
        }
    });
}//End of showDialogForAddUser.

function showDialogForBatchModifyUserQuota() {
    var length = $($("input[name='subBox']:checked")).length;
    if (length == 0) {
        fancyAlert("No user was selected.");
        return;
    }

    var currentDomainId = $('#current_domain').attr("currentDomainId");
    $.ajax({
        type:"GET",
        async:false,
        url:'quota/retrieve',
        data:{ domainId:currentDomainId},
        success:function (data) {
            var selectTag = getSelect(data, 'user_quota_modify');
            $("#quota_list_modify_user").html(selectTag);

            $("#modify_user_quota_div").show();
            $.fancybox({
                href:'#modify_user_quota_div',
                onClosed:function () {
                    $("#modify_user_quota_div").hide();
                }
            });
        },
        error:function (data) {
            handleError(data);
        }
    });
}//End of showDialogForBatchModifyUserQuota.

function getSelect(quotaList, selectTagId) {
    var labelTag = '<label for="user_quota">Quota *</label>';
    var selectStartTag = '<select id="' + selectTagId + '" name="user_quota">';
    var optionTagTemp = '';
    var optionTag = '';
    for (var m = 0; m < quotaList.length; m++) {
        optionTagTemp = '<option value="' + quotaList[m].id + '">' + quotaList[m].name + '</option>';
        optionTag = optionTag + optionTagTemp;
    }
    var selectEndTag = '</select>';
    var quotaTag = labelTag + selectStartTag + optionTag + selectEndTag;
    return quotaTag;
}
function createUserSave() {
    var currentDomainId = $('#current_domain').attr("currentDomainId");
    if (currentDomainId < 0) {
        return;
    }
    var userName = $("#user_name").val();
    var email = $("#user_email").val();
    var password = $("#user_password").val();
    var confirmPassword = $("#user_password_confirm").val();
//    var status = $("#user_status").val();
    var mobile = $("#user_mobile").val();
    var type = $("#user_type").val();
    var nickName = $("#nick_name").val();
    var quotaId = $("#user_quota").val();
    var profile = $("#portrait").val();
    var birthday = $("#birthday").val();
    var gender = $("input[name='gender']:checked").val();


    var user = {"userName":userName, "email":email, "password":password, "confirmPassword":confirmPassword, "domainId":currentDomainId, "mobile":mobile, "type":type,
        "nickName":nickName, "quotaId":quotaId, "portrait":profile, "gender":gender, "birthday":birthday};

    $.ajax({
        type:"POST",
        url:'user',
        contentType:'application/json; charset=utf-8',
        dataType:'json',
        data:JSON.stringify(user),
        success:function (data) {
            $("#create_user_div").hide();
            $.fancybox.close();
            refreshUserList($('#user_pageSize').val(), 1, 'create_time', 'desc');
        },
        error:function (data) {
            handleError(data);
            $("#create_user_div").hide();
            $.fancybox.close();
        }
    });
}

function editUserSave() {
    var currentDomainId = $('#current_domain').attr("currentDomainId");
    if (currentDomainId < 0) {
        return;
    }
    var userId = $("#user_id").val();
    var userName = $("#user_name").val();
    var email = $("#user_email").val();
//  var password = $("#user_password").val();

//  var confirmPassword = $("#user_password_confirm").val();
    var mobile = $("#user_mobile").val();
    var type = $("#user_type").val();
    var nickName = $("#nick_name").val();
    var quotaId = $("#user_quota").val();

    var profile = $("#portrait").val();
    var birthday = $("#birthday").val();
    var gender = $("input[name='gender']:checked").val();

    var user = {"id":userId, "userName":userName, "email":email, "mobile":mobile, "type":type, "nickName":nickName,
        "quotaId":quotaId, "portrait":profile, "gender":gender, "birthday":birthday};

    var currentPageNumber = $("#current_page_number_user").attr("current_page_number");

    $.ajax({
        type:"POST",
        url:'user/edit',
        contentType:'application/json; charset=utf-8',
        dataType:'json',
        data:JSON.stringify(user),
        success:function (data) {
            $("#create_user_div").hide();
            $.fancybox.close();
            refreshUserList($('#user_pageSize').val(), currentPageNumber, 'create_time', 'desc');
        },
        error:function (data) {
            handleError(data);
            $("#create_user_div").hide();
            $.fancybox.close();
        }
    });
}

function checkUserAvailability() {
    var currentDomainId = $('#current_domain').attr("currentDomainId");
    var userName = $('#user_name').val();
    var id = $('#user_id').val();
    var result = true;
    $.ajax({
        type:"GET",
        async:false,
        url:'user/availability',
//      contentType: 'application/json; charset=utf-8',
//      dataType: 'json',
        data:{ id:id, userName:userName, domainId:currentDomainId},
        success:function (data) {
//        alert("data.available = "+ data.available);
            if (data.available) {
                result = true;
            } else {
                result = false;
            }
        },
        error:function (data) {
            handleError(data);
        }
    });
    return result;
}

function showDialogForBatchDeleteUser() {
    var length = $($("input[name='subBox']:checked")).length;
    if (length == 0) {
        fancyAlert("No user was selected.");
        return;
    }

    $("#batch_operation_title").html("Delete");
    $("#batch_operation_type").html("delete");

    if (length == 1) {
        $("#delete_user_number").html(length + " user");
    } else {
        $("#delete_user_number").html(length + " users");
    }

    $("#submit_delete_user").attr("onclick", "");
    $("#submit_delete_user").attr("onclick", "multipleDelete();");
    $("#delete_user_div").show();

    $.fancybox({
        href:'#delete_user_div',
        onClosed:function () {
            $("#delete_user_div").hide();
        }
    });
}

function showDialogForBatchRestoreUser() {
    var length = $($("input[name='subBox']:checked")).length;
    if (length == 0) {
        fancyAlert("No user was selected.");
        return;
    }

    $("#batch_operation_title").html("Restore");
    $("#batch_operation_type").html("restore");

    if (length == 1) {
        $("#delete_user_number").html(length + " user");
    } else {
        $("#delete_user_number").html(length + " users");
    }

    $("#submit_delete_user").attr("onclick", "");
    $("#submit_delete_user").attr("onclick", "multipleRestore();");
    $("#delete_user_div").show();

    $.fancybox({
        href:'#delete_user_div',
        onClosed:function () {
            $("#delete_user_div").hide();
        }
    });
}

function showDialogForBatchDisableUser() {
    var length = $($("input[name='subBox']:checked")).length;
    if (length == 0) {
        fancyAlert("No user was selected.");
        return;
    }

    $("#batch_operation_title").html("Disable");
    $("#batch_operation_type").html("disable");

    if (length == 1) {
        $("#delete_user_number").html(length + " user");
    } else {
        $("#delete_user_number").html(length + " users");
    }

    $("#submit_delete_user").attr("onclick", "");
    $("#submit_delete_user").attr("onclick", "multipleDisable();");
    $("#delete_user_div").show();

    $.fancybox({
        href:'#delete_user_div',
        onClosed:function () {
            $("#delete_user_div").hide();
        }
    });
}

function showDialogForDeleteSingleUser(id, userName) {

    $("#delete_user_name").html(userName);
    $("#id_delete_single_user").val(id);
    $("#delete_single_user_div").show();

    $.fancybox({
        href:'#delete_single_user_div',
        onClosed:function () {
            $("#delete_single_user_div").hide();
        }
    });
}

function showDialogForBatchEnableUser() {
    var length = $($("input[name='subBox']:checked")).length;
    if (length == 0) {
        fancyAlert("No user was selected.");
        return;
    }

    $("#batch_operation_title").html("Enable");
    $("#batch_operation_type").html("enable");

    if (length == 1) {
        $("#delete_user_number").html(length + " user");
    } else {
        $("#delete_user_number").html(length + " users");
    }

    $("#submit_delete_user").attr("onclick", "");
    $("#submit_delete_user").attr("onclick", "multipleEnable();");
    $("#delete_user_div").show();

    $.fancybox({
        href:'#delete_user_div',
        onClosed:function () {
            $("#delete_user_div").hide();
        }
    });
}

function showDialogForResetUserPassword(id, userName) {
    $("#user_id_reset").html(userName);
    $("#user_id_reset_password").val(id);
    $("#user_password_reset").val("");
    $("#user_password_reset_confirm").val("");
    $("#reset_password_user_div").show();

    $.fancybox({
        href:'#reset_password_user_div',
        onClosed:function () {
            $("#reset_password_user_div").hide();
        }
    });
}//End of showDialogForResetUserPassword.

function showDialogForRestoreSingleUser(id, userName) {
    $("#restore_user_name").html(userName);
    $("#id_restore_single_user").val(id);
    $("#restore_single_user_div").show();

    $.fancybox({
        href:'#restore_single_user_div',
        onClosed:function () {
            $("#restore_single_user_div").hide();
        }
    });
}//End of showDialogForRestoreSingleUser.

function deleteSingleUser() {
    var userId = $("#id_delete_single_user").val()
    var targets = new Array();
    if (userId <= 0) {
        return;
    }

    var id = {"id":userId};
    targets.push(id);

    // var ids = {"ids":targets};

    $.ajax({
        type:"POST",
        url:'user/delete',
        contentType:'application/json; charset=utf-8',
        dataType:'json',
        data:JSON.stringify(targets),
        success:function (data) {
            $("#delete_single_user_div").hide();
            $.fancybox.close();
            refreshUserList($('#user_pageSize').val(), 1, 'create_time', 'desc');
        },
        error:function (data) {
            handleError(data);
            $("#delete_single_user_div").hide();
            $.fancybox.close();
        }
    });
}

function restoreSingleUser() {
    var userId = $("#id_restore_single_user").val()
    var targets = new Array();
    if (userId <= 0) {
        return;
    }

    var id = {"id":userId};
    targets.push(id);

    // var ids = {"ids":targets};

    $.ajax({
        type:"POST",
        url:'user/restore',
        contentType:'application/json; charset=utf-8',
        dataType:'json',
        data:JSON.stringify(targets),
        success:function (data) {
            $("#restore_single_user_div").hide();
            $.fancybox.close();
            refreshUserList($('#user_pageSize').val(), 1, 'create_time', 'desc');
        },
        error:function (data) {
            handleError(data);
            $("#restore_single_user_div").hide();
            $.fancybox.close();
        }
    });
}

function multipleDelete() {
    var checkedRecords = $("input[name='subBox']:checked");
    var length = $(checkedRecords).length;
    var targets = new Array();
    if (length == 0) {
        return;
    }
//    alert("number=" + length);
    $.each(checkedRecords, function (index, checkedRecord) {
//      alert(index + ': ' + $(checkedRecord).attr("record_id"));
        var id = {"id":$(checkedRecord).attr("record_id")};
        targets.push(id);
    });

    var ids = {"ids":targets};

    $.ajax({
        type:"POST",
        url:'user/delete',
        contentType:'application/json; charset=utf-8',
        dataType:'json',
        data:JSON.stringify(targets),
        success:function (data) {
            $("#delete_user_div").hide();
            $.fancybox.close();
            refreshUserList($('#user_pageSize').val(), 1, 'create_time', 'desc');
        },
        error:function (data) {
            handleError(data);
            $("#delete_user_div").hide();
            $.fancybox.close();
        }
    });

}

function multipleRestore() {
    var checkedRecords = $("input[name='subBox']:checked");
    var length = $(checkedRecords).length;
    var targets = new Array();
    if (length == 0) {
        return;
    }
//    alert("number=" + length);
    $.each(checkedRecords, function (index, checkedRecord) {
//      alert(index + ': ' + $(checkedRecord).attr("record_id"));
        var id = {"id":$(checkedRecord).attr("record_id")};
        targets.push(id);
    });

    var ids = {"ids":targets};

    $.ajax({
        type:"POST",
        url:'user/restore',
        contentType:'application/json; charset=utf-8',
        dataType:'json',
        data:JSON.stringify(targets),
        success:function (data) {
            $("#delete_user_div").hide();
            $.fancybox.close();
            refreshUserList($('#user_pageSize').val(), 1, 'create_time', 'desc');
        },
        error:function (data) {
            handleError(data);
            $("#delete_user_div").hide();
            $.fancybox.close();
        }
    });

}

function multipleDisable() {
    var checkedRecords = $("input[name='subBox']:checked");
    var length = $(checkedRecords).length;
    var targets = new Array();
    if (length == 0) {
        return;
    }
    $.each(checkedRecords, function (index, checkedRecord) {
        var id = {"id":$(checkedRecord).attr("record_id")};
        targets.push(id);
    });

    var ids = {"ids":targets};

    $.ajax({
        type:"POST",
        url:'user/disable',
        contentType:'application/json; charset=utf-8',
        dataType:'json',
        data:JSON.stringify(targets),
        success:function (data) {
            $("#delete_user_div").hide();
            $.fancybox.close();
            refreshUserList($('#user_pageSize').val(), 1, 'create_time', 'desc');
        },
        error:function (data) {
            handleError(data);
            $("#delete_user_div").hide();
            $.fancybox.close();
        }
    });
}

function multipleEnable() {
    var checkedRecords = $("input[name='subBox']:checked");
    var length = $(checkedRecords).length;
    var targets = new Array();
    if (length == 0) {
        return;
    }
    $.each(checkedRecords, function (index, checkedRecord) {
        var id = {"id":$(checkedRecord).attr("record_id")};
        targets.push(id);
    });

    var ids = {"ids":targets};

    $.ajax({
        type:"POST",
        url:'user/enable',
        contentType:'application/json; charset=utf-8',
        dataType:'json',
        data:JSON.stringify(targets),
        success:function (data) {
            $("#delete_user_div").hide();
            $.fancybox.close();
            refreshUserList($('#user_pageSize').val(), 1, 'create_time', 'desc');
        },
        error:function (data) {
            handleError(data);
            $("#delete_user_div").hide();
            $.fancybox.close();
        }
    });
}

function quotaFilterChanged() {
    refreshUserList($('#user_pageSize').val(), 1, 'create_time', 'desc');
}

function statusFilterChanged() {
    refreshUserList($('#user_pageSize').val(), 1, 'create_time', 'desc');
}

function searchByKeywordEnter(event) {
    var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
    if(keyCode==13){
        searchByKeyword();
    }
}

function searchByKeyword() {
    refreshUserList($('#user_pageSize').val(), 1, 'create_time', 'desc');
}

function resetUserPasswordSave() {
    var id = $("#user_id_reset_password").val();
    var password = $("#user_password_reset").val();

    var user = {"id":id, "password":password};

    $.ajax({
        type:"POST",
        url:'user/password/reset',
        contentType:'application/json',
        dataType:'json',
        data:JSON.stringify(user),
        success:function (data) {
            $("#reset_password_user_div").hide();
            $.fancybox.close();
        },
        error:function (data) {
            handleError(data);
            $("#reset_password_user_div").hide();
            $.fancybox.close();
        }
    });
}

function batchModifyUserQuotaSave() {
    var checkedRecords = $("input[name='subBox']:checked");
    var length = $(checkedRecords).length;
    var targets = new Array();
    if (length == 0) {
        return;
    }
    $.each(checkedRecords, function (index, checkedRecord) {
        var id = {"id":$(checkedRecord).attr("record_id")};
//    targets.push(id);
        targets.push($(checkedRecord).attr("record_id"));
    });

    var quotaId = $('#user_quota_modify').val();
    var ids = {"ids":targets, "quotaId":quotaId};

    $.ajax({
        type:"POST",
        url:'user/quota/modify',
        contentType:'application/json; charset=utf-8',
        dataType:'json',
        data:JSON.stringify(ids),
        success:function (data) {
            $("#modify_user_quota_div").hide();
            $.fancybox.close();
            refreshUserList($('#user_pageSize').val(), 1, 'create_time', 'desc');
//      refreshUserList($('#user_pageSize').val(),$('#current_page_number_user').attr("current_page_number"), 'user_name', 'ASC');
        },
        error:function (data) {
            handleError(data);
            $("#modify_user_quota_div").hide();
            $.fancybox.close();
        }
    });
}

function saveUser() {
    var id = $("#user_id").val();
    if (id == "-1") {
        createUserSave();
    } else {
        editUserSave();
    }
}

function sortUserBy(column) {
    var sortByBefore = column.attr("class");
    var sortColumnName = column.attr("sort_column_name");
    var sortByNow = 'asc';
    if (sortByBefore.toLowerCase().indexOf('sorting_desc') >= 0) {
        sortByNow = 'asc';
    } else if (sortByBefore.toLowerCase().indexOf('sorting_asc') >= 0) {
        sortByNow = 'desc';
    } else {
        sortByNow = 'asc';
    }

    refreshUserList($('#user_pageSize').val(), 1, sortColumnName, sortByNow);
}


function displayUserLog(data, target, user_log_tr, isOpen, isSelfOpen) {
    if (target == undefined) {
        /*$('#user_log_li').addClass('selected');
         $('#user_li').removeClass('selected');
         $('#user_li').html('Users');
         $('#user_log_li').html('Available Logs');
         $('#user_log_div').html(data);
         $('#first').hide();
         $('#user_log_div').show();
         $('#user_log_li').show();*/
    } else {
        var newTr = "<tr class='user_log'><td colspan='6'><div id='user_log_div'>" + data + "</div></td></tr>";

        if (isOpen == 0) {
            target.after(newTr);
        } else {
            if (isSelfOpen == 1) {
                user_log_tr.remove();
                //todo:The data should be refresh or just the log div jsut be closed when click again?
            } else {
                user_log_tr.remove();
                target.after(newTr);
            }
        }

    }

}

function showDialogForUserLog(userId, target, user_log_tr, isOpen, isSelfOpen) {
    var pageSize = parseInt($('#default_page_size').attr('page_size'));

    $.ajax({
        type:"GET",
        url:'user/log?userId=' + userId + '&pageSize=10&pageNumber=1&sortColumn=date&sortType=desc',
        success:function (data) {
            displayUserLog(data, target, user_log_tr, isOpen, isSelfOpen);
        },
        error:function (data) {
            handleError(data);
        }
    });

}


</script>

<script type="text/javascript">

    function buttonActions() {
        if ($("input[name='subBox']:checked").length > 0) {
            $("#Delete").attr('disabled', false);
            $("#Enable").attr('disabled', false);
            $("#Disable").attr('disabled', false);
            $("#Modify_Quota").attr('disabled', false);
            $("#Restore").attr('disabled', false);
        } else {
            $("#Delete").attr('disabled', true);
            $("#Enable").attr('disabled', true);
            $("#Disable").attr('disabled', true);
            $("#Modify_Quota").attr('disabled', true);
            $("#Restore").attr('disabled', true);
        }
    }
    $(function () {


        $("#checkAll").click(function () {
            $('input[name="subBox"]').attr("checked", this.checked);
            buttonActions();

        });
        var $subBox = $("input[name='subBox']");
        $subBox.click(function () {
            $("#checkAll").attr("checked", $subBox.length == $("input[name='subBox']:checked").length ? true : false);
            buttonActions();
        });


        $("#add_user_button").bind("click", showDialogForAddUser);
//    $("#create_user_save").bind("click", createUserSave);

        $.validator.addMethod("uniqueRecord",
                function (value, element) {
                    if (value) {
                        return checkUserAvailability();
                    } else {
                        return true;
                    }
                },
                "The name is not available.");

        if ("${emailUserSupported}" == "true") {
            $("#create_user_form").validate(
                    {
                        errorClass:"error",
                        submitHandler:function (form) {
                            saveUser();
                        },
                        rules:{
                            user_name:{ required:true, safeCharacters:true, uniqueRecord:true, email:true},
                            user_email:{ email:true},
                            user_quota:{ required:true}
                        },
                        messages:{
                            user_password_confirm:{equalTo:"Confirmed password must match the Password"}
                        }
                    });
        } else {
            $("#create_user_form").validate(
                    {
                        errorClass:"error",
                        submitHandler:function (form) {
                            saveUser();
                        },
                        rules:{
                            user_name:{ required:true, safeCharacters:true, uniqueRecord:true},
                            user_email:{ email:true},
                            user_quota:{ required:true}
                        },
                        messages:{
                            user_password_confirm:{equalTo:"Confirmed password must match the Password"}
                        }
                    });
        }


        $("#reset_password_user_form").validate(
                {
                    errorClass:"error",
                    submitHandler:function (form) {
                        resetUserPasswordSave();
                    },
                    messages:{
                        user_password_reset_confirm:{equalTo:"Confirmed password must match the Password"}
                    }
                });


        $("#account_img_div").click(function (event) {
            var e = window.event || event;
            if (e.stopPropagation) {
                e.stopPropagation();
            } else {
                e.cancelBubble = true;
            }
            $(".account-list").toggle();
        });

        $(".account-list").click(function (event) {
            var e = window.event || event;
            if (e.stopPropagation) {
                e.stopPropagation();
            } else {
                e.cancelBubble = true;
            }
        });
        document.onclick = function () {
            $(".account-list").hide();
        };
        $(".account-list li").click(function () {
            $(this).addClass("current")
                    .siblings().removeClass("current");
            var currentSrc = $('img', this).attr('src');
            var currentId = $('img', this).attr('id');
            $("#account_img").attr("src", currentSrc);
            $("#portrait").val(currentId);
            $(this).parent(".account-list").hide();
            // $(".hide").toggleClass("block");


        });

        $("#birthday").datepicker({
            dateFormat:"yy-mm-dd", changeMonth:true, changeYear:true, constrainInput:true,
            maxDate:"+0y 0m 0d", minDate:"-50y"});
    });

    //    $(".table_sytle2 tr:odd").addClass("tr_odd_style");

    $(".log_button").click(function () {
        var target = $(this).parent().parent().parent();
        var user_log_tr = $(".user_log");
        var ifUserLogOpen = $(this).parents("tr").next("tr");
        var status = 0;

        var isOpen = 0;
        if (user_log_tr.length > 0) {
            isOpen = 1;
        }

        var isSelfOpen = 0;
        if (ifUserLogOpen.hasClass("user_log")) {
            isSelfOpen = 1;
        }

        showDialogForUserLog($(this).attr("record_id"), target, user_log_tr, isOpen, isSelfOpen);

        $('.table_sytle2>  tr:odd').addClass('tr_odd_style');
        $('.table_sytle3  tr:odd').addClass('tr_odd_style');
    })

    /*$(".log_div").toggle(function () {
     var userId = $(this).attr("record_id");
     var target = $(this).parent().parent().parent();
     var data = showDialogForUserLog(userId, target);

     }, function () {
     $(this).parent().parent().parent().next().remove();

     })*/

</script>
