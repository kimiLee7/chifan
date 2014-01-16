<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!doctype html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>订餐网-在怎么忙也要吃饭</title>

    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/bootstrap.css' />"/>
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/bootstrap-theme.css' />"/>
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/common.css?_ts=20140101901' />"/>

</head>

<body>
<div class="topbar">
    <div class="container">
        <div class="row">
            <div class="col-md-1"></div>
            <div class="col-md-10">
                <span class="logo navbar-left"></span>
                <nav>
                    <ul class="nav navbar-nav navbar-left">
                        <li><a href="shop.html">我要点餐</a></li>
                        <li><a href="order.html">该谁订餐</a></li>
                    </ul>
                    <!--end navbar-nav-->
                </nav>
                <ul class="navbar-right nav navbar-nav">
                    <li class="dropdown">
                        <a data-toggle="dropdown" class="dropdown-toggle" href="#">Bruce 您好<b class="caret"></b></a>
                        <ul role="menu" class="dropdown-menu">
                            <li><a href="pay.html">我要付款</a></li>
                            <li><a href="menu-history.html">我的历史菜单</a></li>
                            <li><a href="shop-list.html">餐馆列表</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
            <!--end col-md-8-->
            <div class="col-md-1"></div>
        </div>
        <!--end cow-->
    </div>
</div>
<!--end topbar-->

<div class="container mt15">
    <div class="row">
        <div class="col-md-1"></div>
        <div class="col-md-10">
            <ol style="margin-bottom: 5px;" class="breadcrumb">
                <li><a href="#">Home</a></li>
                <li class="active"><a href="#">Shop List</a></li>
            </ol>
        </div>
    </div>
    <!--end row-->
</div>
<!--end container-->

<div id="sub_content_div"></div>

<script src="<c:url value='/resources/js/bootstrap.js' /> "></script>
<script src="https://code.jquery.com/jquery-1.10.2.min.js" type="text/javascript"></script>

<script type="text/javascript">
     function getShopList() {
        $.ajax({
            type: "GET",
            url: 'shop/list',
            success: function (data) {
                $('#sub_content_div').html(data)
            },
            error: function (data) {
                alert(data);
            }
        });
    }

    $(function () {
        getShopList();
    });
</script>
</body>
</html>
