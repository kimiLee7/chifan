<%@page contentType="text/html;charset=UTF-8" %>
<%@page pageEncoding="UTF-8" %>
<%--<%@ page session="false" %>--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.swiftsync.org/security-taglib" prefix="permission" %>

<div class="pt20b bor2 overflow">
    <h2 class="h2_style">Administrator</h2>
    <permission:show_button resource="ADMIN" operation="CREATE">
        <span id="add_administrator_button" class="red_btn fr">Add an Administrator</span>
    </permission:show_button>
</div>

<div class="screen_bar mt10">
    <select id="admin_pageSize" onchange="adminPageSizeChanged();">

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


</div>
<!--screen_bar_end-->
<hr class="bor2 mt10"/>
<div class="operation_bar mt10" style="display: none;">
  <span class="pr10"><button title="Delete" class="btn" type="button" id="Delete"><i class="icon-trash"></i> Delete
  </button></span>
  <span class="pr10"><button title="Disable" class="btn" type="button" id="Disable"><i class="icon-Disable"></i> Disable
  </button></span>
  <span class=""><button title="Modify Quota" class="btn" type="button" id="Modify_Quota"><i class="icon-Modify"></i>
      Modify Quota
  </button></span>
</div>
<!--operation_bar_end-->

<div class="page_style mt20">
    <span style="display: none;" id="current_page_number"
          current_page_number="${pagedRecords.currentPageNumber}"></span>
    <jsp:include page="../pagingNavigator.jsp"/>
</div>
<!--page_style_end-->

<hr class="bor2 mt5"/>
<div class="table_sytle2">
    <table cellpadding="0" cellspacing="0">
        <thead>
        <tr>
            <%--<th><input type="checkbox" /></th>--%>
            <th>Admin ID</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Permissions</th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${pagedRecords.records}" var="administrator">
            <tr>
                <td><span class="adminId">${administrator.adminId}</span></td>
                <td><span class="emailId">${administrator.email}</span></td>
                <td><span>${administrator.phone}</span></td>
                <td><span>${administrator.permission}</span></td>
                    <%--<td>${operations}</td>--%>
                <td>
                    <div class="btn-group op-group">
                        <permission:show_button resource="ADMIN" operation="MODIFY">
                            <span onclick="showDialogForEdit(${administrator.id});"><i class="icon-Logs" id="title_Edit"
                                                                                       title="Edit "></i></span>
                        </permission:show_button>

                        <permission:show_button resource="ADMIN" operation="DELETE">
                            <permission:show_button resource="ADMIN" operation="DELETE">
                                <span onclick="showDialogForDeleteAdmin(${administrator.id},'${administrator.adminId}');"><i
                                        class="icon-trash" id="title_Trash" title="Delete "></i></span>
                            </permission:show_button>
                            <permission:show_button resource="ADMIN" operation="RESET_PASSWORD">
                                <span onclick="showDialogForResetPassword(${administrator.id},'${administrator.adminId}');"><i
                                        class="icon-Reset" id="title_Rest" title="Reset Password"></i></span>
                            </permission:show_button>
                        </permission:show_button>
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
<!--page_style_end-->
<br/>
<br class="clear"/>

<div id="create_admin_div" class="SwiftSync_box" style="display: none;">
    <form id="create_admin_form" action="">
        <div class="box-header bor2"><h3><span id="admin_title_name">Add</span> Administrator</h3></div>
        <input type="hidden" id="admin_record_id"/>

        <div class="box-content">
            <div class="box-line">
                <label for="admin_id">Admin ID *</label>
                <input type="text" id="admin_id" name="admin_id" class="input_help_tips required email" maxlength="50"/>

                <div class="login_tips hide">
                    <h4>Admin ID</h4>

                    <p>This field is required. It must be an email format. </p>
                    <span class="caret_login"><small class="caret_login_in"></small></span>
                </div>
            </div>
            <div class="box-line">
                <label for="admin_email">Email</label>
                <input type="text" id="admin_email" name="admin_email" maxlength="50" class="email" maxlength="50"/>
            </div>
            <div class="box-line" id="admin_password_div">
                <label for="admin_password">Password *</label>
                <input type="password" id="admin_password" name="admin_password" class="input_help_tips required"
                       minlenght="6"
                       maxlength="30"/>

                <div class="login_tips hide">
                    <h4>Password</h4>

                    <p>This field is required. It must be at least six characters long.</p>
                    <span class="caret_login"><small class="caret_login_in"></small></span>
                </div>
            </div>
            <div class="box-line" id="admin_password_confirm_div">
                <label for="admin_password_confirm">Confirm password *</label>
                <input type="password" id="admin_password_confirm" name="admin_password_confirm"
                       equalTo="#admin_password"
                       class="input_help_tips required" minlenght="6" maxlength="30"/>

                <div class="login_tips hide">
                    <h4>Confirm Password</h4>

                    <p>This field is required. It must be at least six characters long. Confirmed password must match
                        the
                        Password</p>
                    <span class="caret_login"><small class="caret_login_in"></small></span>
                </div>
            </div>
            <div class="box-line">
                <label for="admin_permission">Permission *</label>
                <select id="admin_permission" name="admin_permission">
                    <option value="ADMIN" selected>Admin</option>
                    <option value="Read Only">Read Only</option>
                </select>
                <%--<input type="text" id="admin_permission" name="admin_permission"/>--%>
            </div>
            <div class="box-line">
                <label for="admin_phone">Mobile</label>
                <input type="text" id="admin_phone" name="admin_phone" class="input_help_tips digits" maxlength="16"/>

                <div class="login_tips hide">
                    <h4>Mobile</h4>

                    <p>It must contain just digits.</p>
                    <span class="caret_login"><small class="caret_login_in"></small></span>
                </div>
            </div>
        </div>
        <div class="box-footer">
            <button id="create_admin_cancel" class="gray_btn"
                    onclick="$('#create_admin_div').hide();$.fancybox.close();return false;">Cancel
            </button>
            <%--<button id="create_admin_save" class="red_btn">Save</button>--%>
            <input id="create_admin_save" type="submit" class="red_btn" value="Save">
        </div>
    </form>
</div>
<!--SwiftSync_box_end-->

<div id="delete_admin_div" class="SwiftSync_box" style="display: none;">
    <div class="box-header bor2"><h3>Delete Administrator</h3> <span class="fr close">X</span></div>
    <div class="box-content">
        <form action="">
            <input type="hidden" id="id_delete_input"/>
        </form>
        <div class="box-line">
            <span class="q_icon"></span>
      <span id="delete_admin_message" class="line-text">You want to Delete administrator "<span
              id="delete_admin_name"></span>".<p/><span class="line-text">Are you sure? </span></span>

        </div>
    </div>
    <div class="box-footer">
        <button class="gray_btn" onclick='$("#delete_admin_div").hide();$.fancybox.close();'>Cancel</button>
        <button class="red_btn" id="submit_delete_admin" onclick="deleteAdmin();">Submit</button>
    </div>

</div>


<div id="reset_password_admin_div" class="SwiftSync_box" style="display: none;">
    <form id="reset_password_admin_form" action="">
        <div class="box-header bor2"><h3>Reset Admin Password</h3></div>
        <input type="hidden" id="admin_record_id_reset"/>
        <h5 class="second-title">
            <span>Admin ID:  </span>
            <span id="admin_id_reset"></span>
        </h5>

        <div class="box-content">
            <div class="box-line">
                <label for="admin_password_reset">New Password *</label>
                <input type="password" id="admin_password_reset" name="admin_password_reset"
                       class="input_help_tips required"
                       minlenght="6" maxlength="20"/>

                <div class="login_tips hide">
                    <h4>New Password</h4>

                    <p>This field is required. It must be at least six characters long.</p>
                    <span class="caret_login"><small class="caret_login_in"></small></span>
                </div>
            </div>
            <div class="box-line">
                <label for="admin_password_confirm">Confirm new Password *</label>
                <input type="password" id="admin_password_confirm_reset" name="admin_password_confirm_reset"
                       equalTo="#admin_password_reset" class="input_help_tips required" minlenght="6" maxlength="20"/>

                <div class="login_tips hide">
                    <h4>Confirm new Password</h4>

                    <p>This field is required. It must be at least six characters long. Confirmed password must match
                        the
                        Password</p>
                    <span class="caret_login"><small class="caret_login_in"></small></span>
                </div>
            </div>
        </div>
        <div class="box-footer">
            <button class="gray_btn" onclick="$('#reset_password_admin_div').hide();$.fancybox.close();return false;">
                Cancel
            </button>
            <%--<button id="create_admin_save" class="red_btn">Save</button>--%>
            <input type="submit" class="red_btn" value="Save">
        </div>
    </form>
</div>
<!--SwiftSync_box_end-->

<%--<script src="<c:url value='/resources/js/admin.js' /> "></script>--%>
<script src="<c:url value='/resources/js/common.js' />"></script>

<script type="text/javascript">
function adminPageSizeChanged() {
    var currentDomainId = $('#current_domain').attr("currentDomainId");
    refreshAdminList(currentDomainId, $('#admin_pageSize').val(), 1, 'admin_id', 'ASC')
}

function changePageNumber(pageNumber) {
    if (pageNumber < 1) {
        return;
    }
    var currentDomainId = $('#current_domain').attr("currentDomainId");
    refreshAdminList(currentDomainId, $('#admin_pageSize').val(), pageNumber, 'admin_id', 'ASC')
}

function refreshAdminList(domainId, pageSize, pageNumber, sortColumn, sortType) {
    $.ajax({
        type: "GET",
        url: 'administrator/list?domainId=' + domainId
                + '&pageSize=' + pageSize
                + '&pageNumber=' + pageNumber
                + '&sortColumn=' + sortColumn
                + '&sortType=' + sortType,
        success: function (data) {
            $('#sub_content_div').html(data)
        },
        error: function (data) {
            handleError(data);
        }
    });
}

function showDialogForAddAdmin() {
    $("#admin_title_name").html("Add");
    $("#admin_record_id").val("-1");
    $("#admin_id").val("");
    $("#admin_email").val("");
    $("#admin_permission").val("");
    $("#admin_phone").val("");
    $("#admin_password").val("");
    $("#admin_password_confirm").val("");
    $("#admin_password_div").show();
    $("#admin_password_confirm_div").show();

    $('label.error').remove();

    $("#create_admin_div").show();

    $.fancybox({
        href: '#create_admin_div',
        onClosed: function () {
            $("#create_admin_div").hide();
        }
    });
}

function showDialogForEdit(id) {

    $("#admin_title_name").html("Edit");
    $("#admin_record_id").val(id);

    $('label.error').remove();

    $.ajax({
        type: "GET",
        async: false,
        url: 'administrator/details',
//      contentType: 'application/json; charset=utf-8',
//      dataType: 'json',
        data: { id0: id},
        success: function (data) {
            $("#admin_id").val(data.adminDetails.adminId);
            $("#admin_email").val(data.adminDetails.email);
            $("#admin_permission").val(data.adminDetails.permission);
            $("#admin_phone").val(data.adminDetails.phone);
            $("#admin_password").val("empty");
            $("#admin_password_confirm").val("empty");
            $("#admin_password_div").hide();
            $("#admin_password_confirm_div").hide();

            $("#create_admin_div").show();

            $.fancybox({
                href: '#create_admin_div',
                onClosed: function () {
                    $("#create_admin_div").hide();
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

function showDialogForResetPassword(id, adminId) {
    $("#admin_id_reset").html(adminId);
    $("#admin_record_id_reset").val(id);
    $("#admin_password_reset").val("");
    $("#admin_password_confirm_reset").val("");
    $("#reset_password_admin_div").show();

    $.fancybox({
        href: '#reset_password_admin_div',
        onClosed: function () {
            $("#reset_password_admin_div").hide();
        }
    });

}

function save() {
    var id = $("#admin_record_id").val();
    if (id == "-1") {
        createAdminSave();
    } else {
        editAdminSave();
    }
}

function createAdminSave() {
    var adminId = $("#admin_id").val();
    var email = $("#admin_email").val();
    var password = $("#admin_password").val();
    var confirmPassword = $("#admin_password_confirm").val();
    var permission = $("#admin_permission").val();
    var phone = $("#admin_phone").val();
    var currentDomainId = $('#current_domain').attr("currentDomainId");

    var admin = {"adminId": adminId, "email": email, "password": password, "confirmPassword": confirmPassword, "domainId": currentDomainId, "permission": permission, "phone": phone};

    $.ajax({
        type: "POST",
        url: 'administrator/create',
        contentType: 'application/json',
        dataType: 'json',
        data: JSON.stringify(admin),
        success: function (data) {
            $("#create_admin_div").hide();
            $.fancybox.close();
            refreshAdminList(currentDomainId, $('#admin_pageSize').val(), 1, 'admin_id', 'ASC');
        },
        error: function (data) {
            handleError(data);
            $("#create_admin_div").hide();
            $.fancybox.close();
        }
    });
}

function editAdminSave() {
    var id = $("#admin_record_id").val();
    var adminId = $("#admin_id").val();
    var email = $("#admin_email").val();
    var permission = $("#admin_permission").val();
    var phone = $("#admin_phone").val();
    var currentDomainId = $('#current_domain').attr("currentDomainId");

    var admin = {"id": id, "adminId": adminId, "email": email, "domainId": currentDomainId, "permission": permission, "phone": phone};

    var currentPageNumber = $("#current_page_number").attr("current_page_number");

    $.ajax({
        type: "POST",
        url: 'administrator/edit',
        contentType: 'application/json',
        dataType: 'json',
        data: JSON.stringify(admin),
        success: function (data) {
            $("#create_admin_div").hide();
            $.fancybox.close();
            refreshAdminList(currentDomainId, $('#admin_pageSize').val(), currentPageNumber, 'admin_id', 'ASC');
        },
        error: function (data) {
            handleError(data);
            $("#create_admin_div").hide();
            $.fancybox.close();
        }
    });
}

function showDialogForDeleteAdmin(id, adminId) {

    $("#delete_admin_name").html(adminId);
    $("#id_delete_input").val(id);
    $("#delete_admin_div").show();

    $.fancybox({
        href: '#delete_admin_div',
        onClosed: function () {
            $("#delete_admin_div").hide();
        }
    });
}

function deleteAdmin() {
//    var checkedRecords = $("input[name='subBox']:checked");
//    var length = $(checkedRecords).length;
    var adminId = $("#id_delete_input").val()
    var targets = new Array();
    if (adminId <= 0) {
        return;
    }

    var currentDomainId = $('#current_domain').attr("currentDomainId");
//    if(currentDomainId <= 0){
//      return;
//    }

    var id = {"id": adminId};
    targets.push(id);

    $.ajax({
        type: "POST",
        url: 'administrator/delete',
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        data: JSON.stringify(targets),
        success: function (data) {
            $("#delete_admin_div").hide();
            $.fancybox.close();
            refreshAdminList(currentDomainId, $('#admin_pageSize').val(), 1, 'admin_id', 'ASC');
        },
        error: function (data) {
            handleError(data);
            $("#delete_admin_div").hide();
            $.fancybox.close();
        }
    });

}

function checkAdminIdAvailability() {
    var currentDomainId = $('#current_domain').attr("currentDomainId");
    var adminId = $('#admin_id').val();
    var id = $('#admin_record_id').val();
    var result = true;

    $.ajax({
        type: "GET",
        async: false,
        url: 'administrator/availability',
//      contentType: 'application/json; charset=utf-8',
//      dataType: 'json',
        data: { id: id, adminId: adminId, domainId: currentDomainId},
        success: function (data) {
            if (data.available) {
                result = true;
            } else {
                result = false;
            }
        },
        error: function (data) {
            handleError(data);
            result = false;
        }
    });

    return result;
}

function resetPasswordSave() {
    var id = $("#admin_record_id_reset").val();
    var password = $("#admin_password_reset").val();

    var admin = {"id": id, "password": password};

    $.ajax({
        type: "POST",
        url: 'administrator/password/reset',
        contentType: 'application/json',
        dataType: 'json',
        data: JSON.stringify(admin),
        success: function (data) {
            $("#reset_password_admin_div").hide();
            $.fancybox.close();
        },
        error: function (data) {
            handleError(data);
            $("#reset_password_admin_div").hide();
            $.fancybox.close();
        }
    });
}


</script>
<script type="text/javascript">
    $(function () {

        $("#add_administrator_button").bind("click", showDialogForAddAdmin);
//    $("#create_admin_save").bind("click", createAdminSave);

        $.validator.addMethod("uniqueAdminID",
                function (value, element) {
                    if (value) {
                        return checkAdminIdAvailability();
                    } else {
                        return true;
                    }
                },
                "The Admin ID is not available.");

        $("#create_admin_form").validate(
                {
                    errorClass: "error",
                    submitHandler: function (form) {
                        save();
                    },
                    rules: {
                        admin_id: { required: true, safeCharacters: true, uniqueAdminID: true },
                        admin_email: { safeCharacters: true}
                    },
                    messages: {
                        admin_password_confirm: {equalTo: "Confirmed password must match the Password"}
                    }
                });

        $("#reset_password_admin_form").validate(
                {
                    errorClass: "error",
                    submitHandler: function (form) {
                        resetPasswordSave();
                    },
                    messages: {
                        admin_password_confirm_reset: {equalTo: "Confirmed password must match the Password"}
                    }
                });

    });//End of $(function(){ here
</script>
