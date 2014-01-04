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

    <script src="<c:url value='/resources/js/bootstrap.js' /> "></script>
    <%--<script src="resources/js/bootstrap.js" type="text/javascript"></script>--%>
    <script src="https://code.jquery.com/jquery-1.10.2.min.js" type="text/javascript"></script>
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
                <li><a href="#">Library</a></li>
                <li class="active">Data</li>
            </ol>
        </div>
    </div>
    <!--end row-->
</div>
<!--end container-->

<div class="container mt15">
    <div class="row">
        <div class="col-md-1"></div>
        <div class="col-md-10  ">
            <div class="media bg_w p10">

                <a href="shop-detail.html" class="pull-left">
                    <img alt="64x64" data-src="holder.js/64x64" class="media-object" style="width: 84px; height: 84px;"
                         src="<c:url value='/resources/img/shop_logo_default.jpg'/>">
                </a>

                <div class="media-body">
                    <h4 class="media-heading"><a href="shop-detail.html">小长安</a></h4>
                    <span class="pull-right"><button class="btn btn-warning" type="button">集体点餐</button></span>

                    <p>
                    <address>地址:静安区武定路1089号 <span class="tel blue">52832263</span></address>
                    </p>
                    <p>
                        <small class="label label-warning">本帮菜</small>
                        <span class="label label-warning">清淡</span> <span class="label label-warning">干净</span></p>
                </div>
            </div>
            <div class="media bg_w p10">
                <a href="shop-detail.html" class="pull-left">
                    <img alt="64x64" data-src="holder.js/64x64" class="media-object" style="width: 84px; height: 84px;"
                         src="<c:url value='/resources/img/shop_logo_default.jpg'/>">
                </a>

                <div class="media-body">
                    <h4 class="media-heading"><a href="shop-detail.html">小长安</a></h4>
                    <span class="pull-right"><button class="btn btn-warning" type="button">集体点餐</button></span>

                    <p>
                    <address>地址:静安区武定路1089号 <span class="tel blue">52832263</span></address>
                    </p>
                    <p>
                        <small class="label label-warning">本帮菜</small>
                        <span class="label label-warning">清淡</span> <span class="label label-warning">干净</span></p>
                </div>
            </div>
        </div>
        <!--end col-md-10-->
        <div class="col-md-1"></div>
    </div>
    <!--end row-->
</div>
<!--end container-->

</body>
</html>
