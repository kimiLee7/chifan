<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=UTF-8" %>
<%@page pageEncoding="UTF-8" %>
<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.swiftsync.org/security-taglib" prefix="permission" %>
<%
    String sid=request.getSession().getId();
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>SwiftSync Portal</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/base.css' />"/>
    <link rel="stylesheet" href="<c:url value='/resources/css/common.css' />"/>
    <link rel="stylesheet" href="<c:url value='/resources/fancybox/jquery.fancybox-1.3.4.css' />"/>
    <link rel="stylesheet" href="<c:url value='/resources/css/calendar-green.css' />"/>
    <link rel="SHORTCUT ICON" href="<c:url value='/resources/images/product_icon.ico' />">
</head>

<body>
<div class="topbar">
    <div class="w1100">
        <a href="index.jsp"><h1 class="logo fl">Swiftsync</h1></a>

        <div class="fr account_menu">
            <i class="icon-account"></i>
            <span>Hi,<span id="currentAdminId" adminId="${currentAdmin.adminId}">${currentAdmin.adminId}</span></span> |
            <span><a href="#" onclick="showMySettings(null);return false">My Settings</a></span> |
            <span class="red fbold"><a href="#" onclick="logout();">Sign Out</a></span>
        </div>
    </div>
</div>

<!--topbar_end-->
<div class="x_bold_line mb20"></div>

<div class="main_container">
    <div class="side_left">
        <div class="search_area">
            <input type="text" class="span2" placeholder="Search tree" id="search" size="16">
            <button data-original-title="Clear Search Input" data-info-type="tooltip" class="btn" type="button"
                    id="clear_tree_search" onclick="deleteSearchContent();return false"><i class="icon-remove"></i>
            </button>
        </div>
        <!--search_area_end-->
        <div id="domain_operations" class="btn-group">
            <permission:show_button resource="DOMAIN" operation="GET">
                <a title="Refresh" id="domain_tree_refresh" onclick="refreshDomainTree(-1);" rel="refresh" href="#"
                   class="btn refresh"><i class="icon-refresh"></i></a>
            </permission:show_button>

            <permission:show_button resource="DOMAIN" operation="CREATE">
                <a rel="create" href="#" title="Create an Entity" id="create_entity_link"
                   onclick="showDialogForCreateDomain();"
                   class="dropdown-toggle btn action">Create</a>
            </permission:show_button>

            <permission:show_button resource="DOMAIN" operation="DELETE">
                <a title="Delete the selected item" data-info-type="tooltip" id="delete" href="#"
                   class="btn action disabled"
                   onclick="showDialogForDeleteDomain();"><i class="icon-trash"></i>Delete</a>
            </permission:show_button>
        </div>
        <!--btn-group_end-->
        <div id="domain_tree_div" class="tree_main">
            <ul id="domain_tree">
                <%--<li><a href="javascript:void(0);">-------</a></li>--%>
            </ul>
            <!--files_end-->
        </div>
        <!--tree——end-->
    </div>
    <!--side_left-end-->

    <div class="side_right">
        <div class="nav">
            <a class="visible-desktop" id="switchtree"><i class="icon-white icon-chevron-left"></i></a>

            <div class="menu">
                <div class="pull-left" id="tree-dropdown-btn">
                    <button class="btn" data-toggle="show-tree"><i class="icon-list"></i> Tree <span
                            class="caret"></span>
                    </button>
                </div>
        <span id="current_domain" parentDomainId="-1" currentDomainId="0" currentDomainName=""
              class="index-url"> </span>
                <%--<form action="#">
                  <input type="hidden" id="current_domain_id" value="0"/>
                </form>--%>
                <ul class="menu_bar">
                    <li><a id="domain_detail_menu" href="#">Info</a></li>
                    <li><a id="user_menu" href="#">End Users</a></li>
                    <li><a id="quota_menu" href="#">Storage Plans</a></li>
                    <li><a id="reporting_menu" href="#">Reporting</a></li>
                    <li><a id="administrator_menu" href="#">Administrators</a></li>
                    <li><a id="admin_log_menu" href="#">Admin Logs</a></li>
                    <li><a id="media_menu" href="#">Media</a></li>
                    <li class="more js_more"><strong><a href="javascript:void(0)">...</a></strong>
                        <ul class="menu_more">
                            <li><a id="domain_setting_menu" href="#">Domain Setting</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
        <!--nav_end-->
        <div id="sub_content_div" class="sub_content">

        </div>
        <!--sub_content_end-->

    </div>
    <!--side_right-end-->
</div>
<!--main_container-->

<div id="create_domain_div" class="SwiftSync_box" style="display: none;">
    <form id="create_domain_form" action="">
        <input type="hidden" id="parent_domain_id"/>
        <input type="hidden" id="domain_code"/>
        <input type="hidden" id="domain_id_edit"/>
        <span id="domain_edit_flag" edit_flag="0" style="display: none;"></span>

        <div class="box-header bor2"><h3><span id="domain_title_name">Create</span> Entity</h3> <span
                class="fr close">X</span></div>
        <div class="box-content">
            <div class="box-line">
                <label for="domain_name">Entity Name *</label>
                <input type="text" id="domain_name" name="domain_name" class="required" maxlength="30"/>
            </div>
            <div class="box-line">
                <label for="domain_full_name">Full Name</label>
                <input type="text" id="domain_full_name" maxlength="30"/>
            </div>
            <div class="box-line">
                <label for="domain_quota">Quota(GB) *</label>
                <input type="text" id="domain_quota" name="domain_quota" class="required digits" maxlength="11"/>
            </div>
            <div class="box-line">
                <label for="domain_description" class="vertical-top">Description</label>
                <textarea id="domain_description" maxlength="50" style="resize:none;"></textarea>
            </div>
        </div>
        <div class="box-footer">
            <%--<button class="red_btn">Cancel</button>--%>
            <%--<button id="create_domain_save" class="red_btn">Save</button>--%>
            <input type="button" class="gray_btn" value="Cancel"
                   onclick="$('#create_domain_div').hide();$.fancybox.close();return false">
            <input id="create_domain_save" type="submit" class="red_btn" value="Save">
        </div>
    </form>
</div>

<div id="delete_domain_div" class="SwiftSync_box" style="display: none;">
    <div class="box-header bor2"><h3>Delete Entity</h3> <span class="fr close">X</span></div>
    <div class="box-content">
        <form action="">
            <input type="hidden" id="id_delete_domain"/>
            <input type="hidden" id="id_parent_domain"/>
        </form>
        <div class="box-line">
            <span class="q_icon"></span>
            <span id="notification_delete_domain" class="line-text"></span>
            <%--<span class="line-text">You want to Delete Entity "
                <span id="delete_domain_name"></span>".<p/>
                <span class="line-text">Are you sure? </span>
            </span>--%>
        </div>
    </div>
    <div class="box-footer">
        <span id="delete_domain_action_bar">
            <span class="pr10">
                <button class="gray_btn" onclick='$("#delete_domain_div").hide();$.fancybox.close();return false'>Cancel</button>
            </span>
            <span><button class="red_btn" id="submit_delete_domain" onclick="deleteDomain();">Submit</button> </span>
        </span>
    </div>

</div>

<div id="hidden_element" style="display: none;">
    <form id="logout_form" action="logout" method="post">
        <input type="hidden" id="logout_admin_id" name="adminId"/>
    </form>
    <form id="login_form" action="/index" method="get">
    </form>
</div>

<div id="hidden_element" style="display: none;">
    <span id="default_page_size" page_size='10'></span>
</div>

<%--<script src="<c:url value='/resources/js/jquery-1.3.2.min.js' /> "></script>--%>

<script src="<c:url value='/resources/js/admin.js' /> "></script>
<script src="<c:url value='/resources/jquery-1.7.2.min.js' /> "></script>
<script src="<c:url value='/resources/js/jquery.tree.js' />"></script>
<script src="<c:url value='/resources/js/tooltip.js' />"></script>
<script src="<c:url value='/resources/js/jquery.validate.js' />"></script>
<script src="<c:url value='/resources/js/common.js' />"></script>

<script src="<c:url value='/resources/fancybox/jquery.fancybox-1.3.4.js' /> "></script>
<script src="<c:url value='/resources/fancybox/jquery.mousewheel-3.0.4.pack.js' /> "></script>
<script src="<c:url value='/resources/js/calendar.js' />"></script>
<script src="<c:url value='/resources/js/calendar-en.js' />"></script>
<script src="<c:url value='/resources/js/calendar-setup.js' />"></script>
<script src="<c:url value='/resources/js/common.js' />"></script>

<%--<script src="<c:url value='/resources/js/jquery-ui/jquery-ui-1.8.14.custom.min.js' />" ></script>--%>

<script type="text/javascript">
function retrieveCurrentDomainDetail() {
    var currentDomainId = $('#current_domain').attr("currentDomainId");
    retrieveDomainDetail(currentDomainId);
}

function retrieveCurrentDomainSetting() {
    var currentDomainId = $('#current_domain').attr("currentDomainId");
    retrieveDomainSetting(currentDomainId);
}

function retrieveCurrentDomainMedia(){
    var currentDomainId = $('#current_domain').attr("currentDomainId");
    retrieveDomainMedia(currentDomainId);
}

function retrieveDomainDetail(domainId) {
    if (!domainId > 0) {
        return;
    }
    $.ajax({
        type: "GET",
        url: 'entity/' + domainId,
        success: function (data) {
            $('#sub_content_div').html(data)
        },
        error: function (data) {
            handleError(data);
        }
    });
}

function retrieveDomainSetting(domainId){
    if (!domainId > 0) {
        return;
    }
    $.ajax({
        type: "GET",
        url: 'setting/' + domainId,
        success: function (data) {
            $('#sub_content_div').html(data)
        },
        error: function (data) {
            handleError(data);
        }
    });
}

function retrieveDomainMedia(domainId){
    if (!domainId > 0) {
        return;
    }
    $.ajax({
        type: "GET",
        url: 'media/' + domainId,
        success: function (data) {
            $('#sub_content_div').html(data)
        },
        error: function (data) {
            handleError(data);
        }
    });
}

//call in the jquery.tree.js click.click event
function viewDomainInfo(domainId, parentId, domainName) {
    var domainName1 = subString(domainName, 12, true);
    $('#current_domain').html(domainName1)
    $('#current_domain').attr("currentDomainId", domainId);
    $('#current_domain').attr("currentDomainName", domainName);
    $('#current_domain').attr("parentDomainId", parentId);

    var report_url = "${report_server}/login?sid=<%=sid%>&current_domain_id="+domainId;
    $("#reporting_menu").attr("href",report_url);
    retrieveDomainDetail(domainId);
}

function initDomainInfo() {
    $.ajax({
        type: "GET",
        url: 'administrator/entity',
        success: function (data) {
            if (data.entity != null) {
                viewDomainInfo(data.entity.id, data.entity.parent_id, data.entity.name)
            }
        },
        error: function (data) {
            handleError(data);
        }
    });
}


function initDomainInfoByDomainId(domainId) {
    $.ajax({
        type: "GET",
        data: { id: domainId},
        url: '/entity',
        success: function (data) {
            if (data.domainDetails != null) {
                viewDomainInfo(data.domainDetails.id, data.domainDetails.parent_id, data.domainDetails.name)
            }
        },
        error: function (data) {
            handleError(data);
        }
    });
}

function refreshDomainTree(parentDomainId) {
    $.ajax({
        type: "GET",
        url: 'entity/tree',
//      contentType: 'application/json',
//      dataType: 'json',
//      dataType: 'application/json',
//      data:JSON.stringify(rootDomainId),
        success: function (data) {
            if (data.result == "error") {
                if (data.message == "sessionInvalid") {
                    login();
                }
            } else {
                $('#domain_tree_div').html("");
                $('#domain_tree_div').html(data);
                treeStyle();

                if (parentDomainId > 0) {
                    initDomainInfoByDomainId(parentDomainId);
                    initTree();
                    expandParentTreeNode(parentDomainId);
                } else {
                    initDomainInfo();
                    initTree();

                }
            }
        },
        error: function (data) {
            handleError(data);
            $('#current_domain').html("----")
            $('#current_domain').attr("currentDomainId", "-1");
            $('#current_domain').attr("currentDomainName", "");
        }
    });

    $('.menu_bar li:first').addClass('current');
}

function showDialogForCreateDomain() {
    $("#domain_edit_flag").attr("edit_flag", 0);
    $("#domain_id_edit").val(0);
    $("#domain_title_name").html("Create");
    $('label.error').remove();
    $("#domain_name").val("");
    $("#domain_full_name").val("");
    $("#domain_quota").val("");
    $("#domain_description").val("");
    $("#create_domain_div").show();

    $.fancybox({
//      width:700,
        href: '#create_domain_div',
        onClosed: function () {
            $("#create_domain_div").hide();
        }
    });
}

function showDialogForEditDomain() {
    var currentDomainId = $('#current_domain').attr("currentDomainId");

    $('label.error').remove();

    $.ajax({
        type: "GET",
        url: 'entity',
        data: { id: currentDomainId},
        success: function (data) {
            if (data.domainDetails == null) {
                return;
            }
            $("#domain_edit_flag").attr("edit_flag", 1);
            $("#domain_title_name").html("Edit");
            $("#domain_id_edit").val(data.domainDetails.id);
            $("#domain_name").val(data.domainDetails.name);
            $("#domain_full_name").val(data.domainDetails.fullName);
            $("#domain_quota").val(data.domainDetails.quota);
            $("#domain_description").val(data.domainDetails.description);
            $("#parent_domain_id").val(data.domainDetails.parentId);
            $("#domain_code").val(data.domainDetails.domainCode);

            $("#create_domain_div").show();
            $.fancybox({
                href: '#create_domain_div',
                onClosed: function () {
                    $("#create_domain_div").hide();
                }
            });
        },
        error: function (data) {
            handleError(data);
        }
    });
}

function saveDomain() {
    var ifDomainEdit = $("#domain_edit_flag").attr("edit_flag");
    if (ifDomainEdit == 0) {
        createDomainSubmit();
    } else {
        editDomainSave();
    }
}

function createDomainSubmit() {
    var name = $("#domain_name").val();
    var fullName = $("#domain_full_name").val();
    var quota = $("#domain_quota").val();
    var description = $("#domain_description").val();
    var currentDomainId = $('#current_domain').attr("currentDomainId");

    var domain = {"name": name, "fullName": fullName, "quota": quota, "description": description, "parentId": currentDomainId};

    $.ajax({
        type: "POST",
        url: 'entity',
        contentType: 'application/json',
        dataType: 'json',
        data: JSON.stringify(domain),
        success: function (data) {
            $("#create_domain_div").hide();
            $.fancybox.close();

            if (data.entity != null) {
                refreshDomainTree(data.entity.id);
                viewDomainInfo(data.entity.id, data.entity.parent_id, data.entity.name);
            }
        },
        error: function (data) {
            handleError(data);
            $("#create_domain_div").hide();
            $.fancybox.close();
        }
    });
}

function editDomainSave() {
    var id = $("#domain_id_edit").val();
    var name = $("#domain_name").val();
    var fullName = $("#domain_full_name").val();
    var quota = $("#domain_quota").val();
    var description = $("#domain_description").val();
    var parentDomainId = $('#parent_domain_id').val();
    var   domainCode=$("#domain_code").val();

    var domain = {"id": id, "name": name, "fullName": fullName, "quota": quota, "description": description, "parentId": parentDomainId,"domainCode":domainCode};

    $.ajax({
        type: "POST",
        url: 'entity/edit',
        contentType: 'application/json',
        dataType: 'json',
        data: JSON.stringify(domain),
        success: function (data) {
            $("#create_domain_div").hide();
            $.fancybox.close();
            refreshDomainTree(id);
            viewDomainInfo(id, parentDomainId, name);
        },
        error: function (data) {
            handleError(data);
            $("#create_domain_div").hide();
            $.fancybox.close();
        }
    });
}

var retrieveAdminList = function (e) {
    var pageSize = parseInt($('#default_page_size').attr('page_size'));
    var currentDomainId = $('#current_domain').attr("currentDomainId");
    $.ajax({
        type: "GET",
        url: 'administrator/list?domainId=' + currentDomainId
                + '&pageSize=10'
                + '&pageNumber=1'
                + '&sortColumn=admin_id'
                + '&sortType=asc',
        success: function (data) {
            $('#sub_content_div').html(data)
        },
        error: function (data) {
            handleError(data);
        }
    });
}


function showMySettings(adminId) {

    $.ajax({
        type: "GET",
        url: 'mysettings',
        success: function (data) {
            $('#sub_content_div').html(data);
            if (adminId != null) {
                $('#currentAdminId').text(adminId);
                $('#currentAdminId').attr('adminId', adminId);
            }

        },
        error: function (data) {
            handleError(data);
        }
    });
}


function retrieveUserList() {
    var pageSize = parseInt($('#default_page_size').attr('page_size'));
    var currentDomainId = $('#current_domain').attr("currentDomainId");
    $.ajax({
        type: "GET",
        url: 'user/list?domainId=' + currentDomainId
                + '&pageSize=10&pageNumber=1&sortColumn=create_time&sortType=desc',
        success: function (data) {
            $('#sub_content_div').html(data)
        },
        error: function (data) {
            handleError(data);
        }
    });
}

function retrieveReportingMain() {
    var currentDomainId = $('#current_domain').attr("currentDomainId");
    $.ajax({
        type: "GET",
        url: 'reporting/login?currentDomainId=' + currentDomainId,
        success: function (data) {
            alert(data.url);
            window.open(data.url+"/report/login?sid=","new_win","height=250,width=250,toolbar=no,scrollbars="+scroll+",menubar=no");
        },
        error: function (data) {
            handleError(data);
        }
    });
}

function retrieveQuotaList() {
    var pageSize = parseInt($('#default_page_size').attr('page_size'));
    var currentDomainId = $('#current_domain').attr("currentDomainId");
    $.ajax({
        type: "GET",
        url: 'quota/list?domainId=' + currentDomainId
                + '&pageSize=10&pageNumber=1&sortColumn=name&sortType=asc',
        success: function (data) {
            $('#sub_content_div').html(data)
        },
        error: function (data) {
            handleError(data);
        }
    });
}

function retrieveAdminLogs() {
    var pageSize = parseInt($('#default_page_size').attr('page_size'));
    var currentDomainId = $('#current_domain').attr("currentDomainId");
    $.ajax({
        type: "GET",
        url: 'adminLog/list?domainId=' + currentDomainId
                + '&pageSize=10&pageNumber=1&sortColumn=operation_time&sortType=desc',
        success: function (data) {
            $('#sub_content_div').html(data)
        },
        error: function (data) {
            handleError(data);
        }
    });
}

function checkDomainNameAvailability() {
    var currentDomainId = $('#current_domain').attr("currentDomainId");
    var domainName = $('#domain_name').val();
    var result = true;

    $.ajax({
        type: "GET",
        async: false,
        url: 'entity/availability',
        data: { id: 0, domainName: domainName, currentDomainId: currentDomainId},
        success: function (data) {
            if (data.available) {
                result = true;
            } else {
                result = false;
            }
        },
        error: function (data) {
            handleError(data);
        }
    });

    return result;
}//checkDomainNameAvailability()---end.

function canDeleteDomain() {
    var currentDomainId = $('#current_domain').attr("currentDomainId");
    var result = false;

    $.ajax({
        type: "GET",
        async: false,
        url: 'entity/can_delete',
        data: {currentDomainId: currentDomainId},
        success: function (data) {
            if (data.available) {
                result = true;
            } else {
                result = false;
            }
        },
        error: function (data) {
            handleError(data);
        }
    });

    return result;
}
//canDeleteShop()---end.

function checkQuotaLargerThanSubs() {
    var currentDomainId = $('#current_domain').attr("currentDomainId");
    var domainQuota = $('#domain_quota').val();
    var ifNew = 0;
    var result = true;

    var ifDomainEdit = $("#domain_edit_flag").attr("edit_flag");
    if (ifDomainEdit == 0) {
        ifNew = 1;
    }

    $.ajax({
        type: "GET",
        async: false,
        url: 'entity/quota_larger_than_subs',
        data: { quota: domainQuota, ifNew: ifNew, domainId: currentDomainId},
        success: function (data) {
            if (data.available) {
                result = true;
            } else {
                result = false;
            }
        },
        error: function (data) {
            handleError(data);
        }
    });

    return result;
}//checkQuotaLargerThanSubs()---end.

function checkQuotaLessThanParent() {
    var currentDomainId = $('#current_domain').attr("currentDomainId");
    var domainQuota = $('#domain_quota').val();
    var ifNew = 0;
    var result = true;

    var ifDomainEdit = $("#domain_edit_flag").attr("edit_flag");
    if (ifDomainEdit == 0) {
        ifNew = 1;
    }

    $.ajax({
        type: "GET",
        async: false,
        url: 'entity/quota_less_than_parent',
        data: { quota: domainQuota, ifNew: ifNew, domainId: currentDomainId},
        success: function (data) {
            if (data.available) {
                result = true;
            } else {
                result = false;
            }
        },
        error: function (data) {
            handleError(data);
        }
    });

    return result;
}//checkQuotaLessThanParent()---end.

function showDialogForDeleteDomain() {
    if(canDeleteDomain()){
        var currentDomainId = $('#current_domain').attr("currentDomainId");
        var currentDomainName = $('#current_domain').attr("currentDomainName");
        var parentDomainId=$('#current_domain').attr("parentDomainId");

        var message  = 'You want to Delete Entity "' + currentDomainName + '". <p/>Are you sure?';
        $("#notification_delete_domain").html(message);
//        $("#delete_domain_name").html(currentDomainName);

        $("#id_delete_domain").val(currentDomainId);
        $("#delete_domain_action_bar").show();
        $("#delete_domain_div").show();

        $.fancybox({
            href: '#delete_domain_div',
            onClosed: function () {
                $("#delete_domain_div").hide();
                refreshDomainTree(parentDomainId);

            }
        });
    }else{
//        alert("can not delete domain.");
        var currentDomainId = $('#current_domain').attr("currentDomainId");
        var currentDomainName = $('#current_domain').attr("currentDomainName");

        var message  = 'The entity "' + currentDomainName + '" is in use.' + '<p>'
                + 'Please ensure there is no user and sub-entity before you delete this entity.';
        $("#notification_delete_domain").html(message);
//        $("#delete_domain_name").html(currentDomainName);

        $("#delete_domain_action_bar").hide();
        $("#id_delete_domain").val(currentDomainId);
        $("#delete_domain_div").show();

        $.fancybox({
            href: '#delete_domain_div',
            onClosed: function () {
                $("#delete_domain_div").hide();
            }
        });
    }
}

function deleteSearchContent() {
    $("#search").val('');
    $('#domain_tree').find('a').attr('tabindex', '-1').removeClass('tree-item-active');
    //$(".tree_main a:first").addClass('tree-item-active');
    //initTree();

}
function initTree() {
    $('#domain_tree').find('li').show();
    $('#domain_tree').tree({
        expanded: 'li:first'
    });
}

function searchEntity(tval) {

    if (tval == null || tval == "") {
        initTree();
        return false;
    }

    var search_regex = new RegExp(tval, 'i');
// $('#domain_tree').find('li:not(:first)').hide();
    var currentNodes = $('#domain_tree').find("a").filter(function () {
        return search_regex.test($(this).attr("title"));
    });

    // $('#domain_tree').find('a').attr('tabindex','-1').removeClass('tree-item-active');
    //$('#domain_tree').find('li').attr('aria-expanded', 'false');
    //$('#domain_tree').find('li:first').attr('aria-expanded', 'true');

    currentNodes.each(function (index) {
        var currentNode = $(this);
        expand(currentNode);
    });

    // var domainId = currentNode.eq(0).attr("domain_id"); //Bruce-conversant
    //var domainName = currentNode.eq(0).attr("domain_name"); //Bruce-conversant
    // var parentId = currentNode.eq(0).attr("parent_id"); //Bruce-conversant
    //viewDomainInfo(domainId,parentId,domainName);
}

function expandParentTreeNode(id) {

    var currentNode = $('#domain_tree').find("a[domain_id='" + id + "']");
    $('#domain_tree').find('[tabindex=0]').attr('tabindex', '-1').removeClass('tree-item-active');
    $('#domain_tree').find('li').attr('aria-expanded', 'false');
    $('#domain_tree').find('li:first').attr('aria-expanded', 'true');
    expand(currentNode);

}

function expand(currentNode) {
    if (currentNode != null) {
        var rootDomainId = $('#domain_tree').find('li:first').find("a").eq(0).attr("domain_id");

        if (currentNode.attr("domain_id") == rootDomainId) {
            currentNode.attr('tabindex', '0').addClass('tree-item-active');
            return;
        }

        var parentLi = currentNode;
        var parentNode = null;
        var parentNodeList = new Array();
        while ((parentLi = parentLi.parent()) != null) {
            if (!parentLi.is('li')) {
                continue;
            }
            parentNode = parentLi.find('a').eq(0);
            var parentId = parentNode.attr("domain_id");
            if (parentId != null) {
                parentNodeList.push(parentNode);
                if (parentId == rootDomainId) {
                    break;
                }
            }
        }
        var reverseArray = parentNodeList.slice().reverse();
        for (var i = 0; i < reverseArray.length; i++) {
            var pList = reverseArray[i];
            pList.parent().show();
            pList.trigger('expand');
        }

        currentNode.attr('tabindex', '0').addClass('tree-item-active');
    }
}


function deleteDomain() {
    var domainId = $("#id_delete_domain").val()
    var targets = new Array();
    var currentDomainId = $('#current_domain').attr("currentDomainId");
    var parentId = $('#current_domain').attr("parentDomainId");

    if (domainId != currentDomainId) {
        return;
    }

    var id = {"id": domainId};
    targets.push(id);

    $.ajax({
        type: "POST",
        url: 'entity/delete',
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        data: JSON.stringify(targets),
        success: function (data) {
            $("#delete_domain_div").hide();
            $.fancybox.close();
            refreshDomainTree(parentId);
            viewDomainInfo(parentId,-1,'');
        },
        error: function (data) {
            handleError(data);
            $("#delete_domain_div").hide();
            $.fancybox.close();
        }
    });
}

function logout2() {
    $.ajax({
        type: "POST",
        url: 'logout2',
        contentType: 'application/json; charset=utf-8',
//    dataType:'json',
//    data:JSON.stringify(targets),
        success: function (data) {
            fancyAlert("logout OK");
        },
        error: function (data) {
            handleError(data);
        }
    });
}

function logout() {
    var adminId = $('#currentAdminId').attr('adminId');
    $('#logout_admin_id').val(adminId);
    $('#logout_form').submit();
}//End of logout().

function login() {
    $('#login_form').submit();
}

function notSupportNow() {
    fancyAlert("Not Supported Now. To be Developed...");
}
function treeStyle() {

    $(".tree_main ul li:last-child").addClass('last_li'); //LiuPing
    $(".tree_main ul:last").addClass('last_ul');
    $(".tree_main a:first").addClass('tree-item-active');
}
</script>

<script type="text/javascript">

    $(function () {
        refreshDomainTree(-1);
        $("#search").keyup(function (e) {
            var valueToSearch = $("#search").val();
            $('#domain_tree').find('a').attr('tabindex', '-1').removeClass('tree-item-active');
            //$(".tree_main a:first").addClass('tree-item-active');
            searchEntity(valueToSearch);
        });

        $("#user_menu").bind("click", retrieveUserList);
        $("#administrator_menu").bind("click", retrieveAdminList);
        $("#quota_menu").bind("click", retrieveQuotaList);
        $("#domain_detail_menu").bind("click", retrieveCurrentDomainDetail);
        //$("#reporting_menu").bind("click", retrieveReportingMain);
        $("#admin_log_menu").bind("click", retrieveAdminLogs);
        $("#domain_setting_menu").bind("click", retrieveCurrentDomainSetting);
        $("#media_menu").bind("click", retrieveCurrentDomainMedia);

//    $("#domain_tree_refresh").bind("click", refreshDomainTree);
//    $("#create_entity_link").bind("click", showDialogForCreateDomain);
//    $("#create_domain_save").bind("click", createDomainSubmit);

        $.validator.addMethod("safeCharacters",
                function (value, element) {
                    var specialChar = /[\\\/\:\*\?\"\<\>\|]/;
                    if (this.optional(element)) {
                        return true;
                    }
                    ;
                    if (specialChar.test(value)) {
                        return false;
                    } else {
                        return true;
                    }
                    ;
                    // return specialChar.test(value);
                },
                "A name can't contain any of the following characters:  \\ / : * ? \" < > | ");

        $.validator.addMethod("uniqueDomainName",
                function (value, element) {
                    if (value) {
                        return checkDomainNameAvailability();
                    } else {
                        return true;
                    }
                },
                "The name is not available.");

        $.validator.addMethod("quotaLessThanParent",
                function (value, element) {
                    if (value) {
                        return checkQuotaLessThanParent();
                    } else {
                        return true;
                    }
                },
                "There aren't enough quota allocatable.");

        $.validator.addMethod("quotaLargerThanSubs",
                function (value, element) {
                    if (value) {
                        return checkQuotaLargerThanSubs();
                    } else {
                        return true;
                    }
                },
                "Quota can't be less than the quota sum of the sub-entities.");

        $("#create_domain_form").validate(
                {
                    errorClass: "error",
                    submitHandler: function (form) {
//            alert("submit");
                        saveDomain();
                    },
                    rules: {
                        domain_name: { safeCharacters: true, uniqueDomainName: true},
                        domain_quota: { quotaLargerThanSubs: true, quotaLessThanParent: true}
                    }
                });
    });

    $(document).ready(function () {
        $('#switchtree').click(function () {
            if ($(this).hasClass('switchtreeright')) {
                $(this).removeClass('switchtreeright');
                $('.side_left').removeClass('hide');
                $('.side_left').removeClass('side_left_b');
                $('.side_right').removeClass('side_right_w');
                $('.pull-left').removeClass('block');
            }
            else {
                $(this).addClass('switchtreeright')
                $('.side_left').addClass('hide');
                $('.side_right').addClass('side_right_w');
                $('.pull-left').addClass('block');
            }

        });

        ;
        $('#tree-dropdown-btn').click(function () {
            $('.side_left').toggleClass('side_left_b');
        });
    });
</script>

</body>
</html>
