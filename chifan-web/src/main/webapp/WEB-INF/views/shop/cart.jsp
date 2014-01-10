<!doctype html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>订餐网-在怎么忙也要吃饭</title>
<link href="resources/css/bootstrap.css" rel="stylesheet" type="text/css">
<link href="resources/css/bootstrap-theme.css" rel="stylesheet" type="text/css">
<link href="resources/css/common.css" rel="stylesheet" type="text/css">
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
                      </ul><!--end navbar-nav-->
                  </nav>
                  <ul class="navbar-right nav navbar-nav">
                        <li class="dropdown">
                          <a data-toggle="dropdown" class="dropdown-toggle" href="#">xx 你好<b class="caret"></b></a>
                          <ul role="menu" class="dropdown-menu">
                            <li><a href="pay.html">我要付款</a></li>
                            <li><a href="menu-history.html">我的历史菜单</a></li>
                            <li><a href="shop-list.html">餐馆列表</a></li>
                          </ul>
                        </li>
                  </ul>
             </div><!--end col-md-8-->
             <div class="col-md-1"></div>
         </div><!--end cow-->
    </div>
</div><!--end topbar-->
 
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
	</div><!--end row-->
</div><!--end container-->


<div class="container mt15">
	<div class="row">
    	<div class="col-md-1"></div>
    	<div class="col-md-10">            
           <div class="media bg_w p10">
                <a href="#" class="pull-left">
                  <img alt="64x64" data-src="holder.js/64x64" class="media-object" style="width: 84px; height: 84px;" src="resources/img/14.jpg">
                </a>
                <div class="media-body">
                  <h4 class="media-heading">小长安</h4>
                  <p class="pull-right"><b class="btn btn-danger">电话：1300000000</b></p>
                  <p>小长安是一家以面食为主的饭店，味道比较正宗；不过，饭店里的盖浇饭也不错哦！</p>
                  <p><label class="label label-warning">西北口味</label> <label class="label label-warning">偏咸</label></p>
                </div>
            </div> 
            <br>

            <div id="menu-info"></div>

            <div class="panel-group menu-list">
               <article class="panel panel-default bg_w">
                    <header class="panel-heading">
                        <h4 class="panel-title">
                          <a href="#collapseOne" data-parent="#accordion" data-toggle="collapse" class="collapsed">
                            菜单列表
                          </a>
                        </h4>
                    </header>
                    <table class="table bg_w">
                      <tbody>
                        <tr >
                          <th>Yanping Qin</th>
                          <td>辣子鸡丁</td>
                          <td class="red">16</td>
                        </tr>
                       
                        <tr>
                          <th>Bruce</th>
                          <td>辣子鸡丁</td>
                          <td class="red">15</td>
                        </tr>
                        <tr>
                          <th>Pingliu</th>
                          <td>特色羊肉炒面</td>
                          <td class="red">16</td>
                        </tr>
                        <tr>
                          <td colspan="5" class="text-center">
                            <button id="Submit-menu" class="btn btn-primary" type="button">提交菜单 </button> 
                             <a href="shop-detail.html"><button class="btn btn-warning" type="button">修改菜单 </button></a>                               
                          </td>
                        </tr>
                      </tbody>
                   </table>   
             </article>
           </div>
        </div><!--end col-md-10-->
       <div class="col-md-1"></div>
   </div><!--end row-->
</div><!--end container-->
<script src="https://code.jquery.com/jquery-1.10.2.min.js" type="text/javascript"></script>
<script src="resources/js/jquery-1.js" type="text/javascript"></script>
<script src="resources/js/bootstrap.js" type="text/javascript"></script>
<script type="text/javascript">
  $("#Submit-menu").click(function(){
    $("#menu-info").append("<div class='alert alert-warning fade in'><!--<button aria-hidden='true' data-dismiss='alert' class='close' type='button'>×</button>-->您点了<b class='red'>5</b>份葱香脆蛋，<b class='red'>3</b>份桂林小炒肉，<b class='red'>2</b>份番茄炒蛋，共计：<b class='red'>190元</b></div>");
    $(this).attr("disabled","disabled");
    $(this).parents(".table").attr("disabled","disabled")
  })
</script>                  
</body>
</html>
