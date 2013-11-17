<%--<% response.sendRedirect("/views/index.jsp"); %>--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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

</head>

<body class="login">

<div class="reset_container">
  <div class="overflow p10"><h1 class="logo"></h1>

    <div class="login_title">Admin
      <small>Portal</small>
    </div>
  </div>
  <h2>Reset
    <small> Password</small>
  </h2>
  <div class="login_body">

    <div class="bg1 p10 bor-r5 font11">
      <p>If you don't already have a token use the first form in <strong>step 1</strong> to generate one which will be
         sent to your registered email address. </p>

      <p>Once you have a token enter it into the Reset Password form in <strong>step 2 </strong>with your email address
         and new password. Once your password is reset you will be-able to
        <span class="red"><a href="login.html">login here</a></span></p>

    </div>
   <hr class="bor2 mt10"/>
    <div class="input-prepend mt10 prel">
      <div class="mt10"><strong>step 1. Generate Token</strong></div>
      <div class="box-line">
        <form id="get_token_form">
          <label for="admin_email">Email *</label>
          <input type="text" name="admin_email" id="admin_email" placeholder="Email">

          <div class="mt5 textright pr15">
            <%--<button class="btn" onclick="getToken();">Send Reset Token</button>--%>
            <input type="submit" class="btn" value="Get Token for Reset Password">
            <div id="admin_token_temp"></div>
          </div>
        </form>
      </div>
    </div>
    <hr class="mt10 bor2"/>
    <div class="input-prepend mt10 prel">
      <form id="reset_password_self_form">
        <div class="mt10"><strong>Step 2. Reset Password</strong></div>
        <div class="box-line">
          <label for="admin_id">Account ID *</label>
          <input type="text" id="admin_id" name="admin_id" class="required email" maxlength="50" placeholder="Account ID"/>
        </div>
        <div class="box-line">
          <label for="token">Token *</label>
          <input type="text" name="token" id="token" class="required" placeholder="Token for Reset Password"/>
        </div>
        <div class="box-line">
          <label for="new_password">New Password *</label>
          <input type="password" id="new_password" name="new_password" class="required" minlength="6" maxlength="20" placeholder="New Password"/>
        </div>
        <div class="box-line">
          <label for="new_password_confirm">Confirm Password *</label>
          <input type="password" id="new_password_confirm" name="new_password_confirm" class="required" minlength="6" maxlength="20" equalTo="#new_password" placeholder="New Password"/>

          <div class="pr15 mt5 textright">
            <%--<button class="btn">Reset Password</button>--%>
            <input type="submit" class="btn" value="Reset Password">
              <div id="reset_password_result"></div>
          </div>
        </div>
      </form>
    </div>
  </div>
</div>
<!--reset_container end-->

<script src="<c:url value='/resources/js/admin.js' /> "></script>
<script src="<c:url value='/resources/jquery-1.7.2.min.js' /> "></script>
<script src="<c:url value='/resources/js/tooltip.js' />"></script>
<script src="<c:url value='/resources/js/jquery.tree.js' />"></script>
<script src="<c:url value='/resources/js/common.js' />"></script>


<script src="<c:url value='/resources/fancybox/jquery.fancybox-1.3.4.js' /> "></script>
<script src="<c:url value='/resources/fancybox/jquery.mousewheel-3.0.4.pack.js' /> "></script>
<script src="<c:url value='/resources/js/jquery.validate.pack.js' />"></script>

<script type="text/javascript">
  function getToken() {
    var email = $("#admin_email").val();

    /*$.ajax({
     type:"GET",
     async: false,
     url:'administrator/availability',
     //      contentType: 'application/json; charset=utf-8',
     //      dataType: 'json',
     data:{ id: id ,adminId: adminId ,domainId: currentDomainId},*/

    var adminEmail = {"email":email};

    $.ajax({
      type:"POST",
      url:'administrator/password/forgot',
      contentType:'application/json',
      dataType:'json',
      data:JSON.stringify(adminEmail),
      success:function (data) {
        if(data.result == "ok"){
          $("#admin_token_temp").html("Token had been Sent successfully.").fadeIn(1000);
  		  $("#admin_token_temp").fadeOut(5000);
        }else{
          $("#admin_token_temp").html("Fail to send token.").fadeIn(1000);
		  $("#admin_token_temp").fadeOut(5000);
        }
      },
      error:function (data) {
          handleError(data);
      }
    });

  }

  function resetSelfPasswordSave(){
    var adminId = $("#admin_id").val();
    var token = $("#token").val();
    var newPassword = $("#new_password").val();

    var admin = {"adminId":adminId,"token":token,"password":newPassword};

    $.ajax({
      type:"POST",
      url:'administrator/password/reset_by_token',
      contentType: 'application/json',
      dataType: 'json',
      data:JSON.stringify(admin),
      success:function (data) {
//        $("#reset_password_result").html(data.result);
        if(data.result == "ok"){
          $("#reset_password_result").html("Reset password successfully.").fadeIn(1000);
   		  $("#reset_password_result").fadeOut(5000);
        }else{
          $("#reset_password_result").html("Fail to reset password.").fadeIn(1000);
  		  $("#reset_password_result").fadeOut(5000);
        }
      },
      error:function (data) {
          handleError(data);
      }
    });
  }

</script>
<script type="text/javascript">
  $(function () {
    $("#get_token_form").validate(
        {
          errorClass:"error",
          submitHandler:function (form) {
            getToken();
          },
          rules:{
            admin_email:{ required:true, email:true}
          }/*,
          messages:{
            admin_email:{required:"Please input admin email."}
          }*/
        });

    $("#reset_password_self_form").validate(
        {
          errorClass:"error",
          submitHandler:function (form) {
            resetSelfPasswordSave();
          }
        });

  });//End of $(function(){.
</script>
</body>
</html>
