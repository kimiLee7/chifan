<%--<% response.sendRedirect("/views/index.jsp"); %>--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@page contentType="text/html;charset=UTF-8" %>
<%@page pageEncoding="UTF-8" %>
<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>SwiftSync Portal</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/base.css' />"/>
    <link rel="stylesheet" href="<c:url value='/resources/css/common.css' />"/>
    <link rel="stylesheet" href="<c:url value='/resources/fancybox/jquery.fancybox-1.3.4.css' />"/>
    <link rel="SHORTCUT ICON" href="<c:url value='/resources/images/product_icon.ico' />">
</head>

<body class="login">
<div class="login_container">
    <form id="login_form" action="administrator/login" method="post">
        <div class="overflow p10">
            <h1 class="logo"></h1>

            <div class="login_title">Admin
                <small>Portal</small>
            </div>
        </div>
        <h2>User
            <small> Login</small>
            <small><span style="display:none" class="error" id="errorMsg"></span></small>
        </h2>
        <div class="login_body">
            <div class="input-prepend mt20">
                <span class="add-on"><i class="icon-user"></i></span>
                <input type="text" name="username" id="username" placeholder="AdminId">

                <div class="login_tips hide">
                    <h4>AdminId</h4>

                    <p>Enter your identity here</p>
                    <span class="caret_login"><small class="caret_login_in"></small></span>
                </div>
            </div>
            <div class="input-prepend mt20">
                <span class="add-on"><i class="icon-lock"></i></span>
                <input type="password" name="password" id="password" placeholder="Password">

                <div class="login_tips hide">
                    <h4>Password</h4>

                    <p>Enter your password here</p>
                    <span class="caret_login"><small class="caret_login_in"></small></span>
                </div>
            </div>
            <div class="mt10 blue"><a href="#" target="_self" onclick="forgotPassword();">Click here to reset your
                password.</a></div>
        </div>
        <div class="box-footer">

            <input type="submit" class="red_btn" value="Login">
        </div>
    </form>
</div>
<!--login_container_end-->

<div id="hidden_element" style="display: none;">
    <form id="forgot_password_form" action="forgotPassword" method="get">
    </form>
</div>

<script src="<c:url value='/resources/jquery-1.7.2.min.js' /> "></script>
<script src="<c:url value='/resources/js/tooltip.js' />"></script>
<script src="<c:url value='/resources/js/jquery.tree.js' />"></script>
<script src="<c:url value='/resources/js/common.js' />"></script>


<script src="<c:url value='/resources/fancybox/jquery.fancybox-1.3.4.js' /> "></script>
<script src="<c:url value='/resources/fancybox/jquery.mousewheel-3.0.4.pack.js' /> "></script>
<script src="<c:url value='/resources/js/jquery.validate.pack.js' />"></script>

<script type="text/javascript">

    function forgotPassword() {
        $('#forgot_password_form').submit();
    }

    function login() {
        $('#login_form').submit();
    }


    function loginSubmit() {
        var adminId = $("#username").val();
        var password = $("#password").val();

        var admin = {"username": adminId, "password": password};

        $.ajax({
            type: "POST",
            url: 'administrator/login?_ts=' + (new Date()).valueOf(),
            // contentType: 'application/json',
            dataType: 'json',
            data: admin,
            success: function (data) {

                $('#errorMsg').hide();

                if (data.result == 'true') {
                    window.location = "index";
                } else {
                    if (data.message != null) {
                        $('#errorMsg').text(data.message);
                        $('#errorMsg').show();
                    }
                }
            },
            error: function (data) {
                $('#errorMsg').text($.parseJSON(data.responseText)['message']);
                $('#errorMsg').show();
            }
        });
    }

</script>
<script type="text/javascript">
    $(function () {
        $('#errorMsg').hide();

        $("#login_form").validate(
                {
                    errorClass: "error",
                    submitHandler: function (form) {
//            login();
                        loginSubmit();
                    },
                    rules: {
                        username: { required: true, email: true},
                        password: { required: true}
                    }
                });

    });//End of $(function(){.
</script>
</body>
</html>
