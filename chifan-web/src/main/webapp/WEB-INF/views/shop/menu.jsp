<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="container mt15">
    <div class="row">
        <div class="col-md-1"></div>
        <div class="col-md-10">
            <div class="row">
                <div class="col-md-9">
                    <div class="media bg_w p10">
                        <a href="#" class="pull-left">
                            <img alt="64x64" data-src="holder.js/64x64" class="media-object"
                                 style="width: 84px; height: 84px;"
                                 src="<c:url value='/resources/img/shop_logo_default.jpg'/>">
                        </a>

                        <div class="media-body">
                            <h4 class="media-heading">${shop.name}</h4>

                            <p><b class="blue">电话：${shop.phone}</b></p>

                            <p><label class="label label-warning">西北口味</label> <label
                                    class="label label-warning">偏咸</label></p>
                        </div>
                    </div>
                    <br>

                    <div class="panel-group menu-list" id="accordion">

                        <c:forEach items="${categories}" var="category">

                            <article class="panel panel-default bg_w">
                                <header class="panel-heading">
                                    <h4 class="panel-title">
                                        <a href="#collapse${category.id}" data-parent="#accordion" data-toggle="collapse"
                                           class="collapsed">
                                                ${category.name}
                                        </a>
                                    </h4>
                                </header>
                                <div class="panel-collapse collapse in" id="collapse${category.id}">
                                    <ul class="panel-body row">
                                        <c:forEach items="${category.products}" var="product">
                                            <li class="col-md-6">${product.name} <span
                                                    class="label pull-right label-primary">订购</span> <span
                                                    class="price pull-right pr10">￥${product.price /100}</span></li>
                                        </c:forEach>
                                    </ul>

                                </div>
                            </article>

                        </c:forEach>

                    </div>
                </div>

                <!--end col-md-9-->
                <div class="col-md-3">
                    <div class="list-group row bg_w">
                        <ul class="car_menu">
                            <li class="list-group-item">
                                <span class="pull-left"><input type="checkbox"> </span>
                                <span class="menu-name">(招牌)红烧狮子头2只+炒时蔬+菜饭</span>
                                <span class="pull-right"><em class="decrease">-</em><input type="number"
                                                                                           class="form-control form_num"
                                                                                           value="1"><em
                                        class="increase">+</em></span>
                            </li>
                            <li class="list-group-item">
                                <span class="pull-left"> <input type="checkbox"> </span>
                                <span class="menu-name">(招牌)红烧狮子头2只+炒时蔬+菜饭</span>
                                <span class="pull-right"><em class="decrease">-</em><input type="number"
                                                                                           class="form-control form_num"
                                                                                           value="1"><em
                                        class="increase">+</em></span>
                            </li>
                            <li class="list-group-item active text-center">
                                <h4 class="list-group-item-heading">总价：<strong>100</strong></h4>

                                <p class="list-group-item-text"><a href="shop-car.html">
                                    <button class="btn btn-primary">提交订单</button>
                                </a></p>
                            </li>
                        </ul>
                    </div>
                </div>
                <!--end col-md-3-->
            </div>
            <!--end row-->
        </div>
        <!--end col-md-10-->
        <div class="col-md-1"></div>
    </div>
    <!--end row-->
</div>
<!--end container-->

<script src="<c:url value='/resources/js/bootstrap.js' /> "></script>
<script src="https://code.jquery.com/jquery-1.10.2.min.js" type="text/javascript"></script>