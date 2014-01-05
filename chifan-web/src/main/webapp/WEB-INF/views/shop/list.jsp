<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page session="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="container mt15">
    <div class="row">
        <div class="col-md-1"></div>
        <div class="col-md-10  ">

            <c:forEach items="${records}" var="record">
                <div class="media bg_w p10">

                    <a href="shop-detail.html" class="pull-left">
                        <img alt="64x64" data-src="holder.js/64x64" class="media-object" style="width: 84px; height: 84px;"
                             src="<c:url value='/resources/img/shop_logo_default.jpg'/>">
                    </a>

                    <div class="media-body">
                        <h4 class="media-heading"><a onclick="getShopMenu('${record.id}')">${record.name}</a></h4>
                        <span class="pull-right"><button class="btn btn-warning" type="button">集体点餐</button></span>

                        <p>
                        <address>地址: ${record.address} <span class="tel blue">${record.phone}</span></address>
                        </p>
                        <p>
                            <small class="label label-warning">本帮菜</small>
                            <span class="label label-warning">清淡</span> <span class="label label-warning">干净</span></p>
                    </div>
                </div>
            </c:forEach>

        </div>
        <!--end col-md-10-->
        <div class="col-md-1"></div>
    </div>
    <!--end row-->
</div>
<!--end container-->

<div id="create_shop_div" style="display: none;">
    <form id="create_form" action="">
        <div><h3><span>Add</span> Shop</h3></div>
        <input type="hidden" id="shop_id"/>

        <div>
            <div class="box-line">
                <label for="name">Name *</label>
                <input type="text" id="name" name="name"/>
            </div>
            <div>
                <label for="address">Address</label>
                <input type="text" id="address" name="address"/>
            </div>

            <div>
                <label for="address">Phone</label>
                <input type="text" id="phone" name="phone"/>
            </div>

        </div>
        <div>
            <button id="create_admin_cancel"
                    onclick="$('#create_form').hide();$.fancybox.close();return false;">Cancel
            </button>
            <button id="create_save">Save</button>
        </div>
    </form>
</div>

<script type="text/javascript">
    function getShopMenu(shopId) {
        $.ajax({
            type: "GET",
            url: 'shop/'+ shopId + '/menu',
            success: function (data) {
                $('#sub_content_div').html(data)
            },
            error: function (data) {
                alert(data);
            }
        });
    }

</script>