$(document).ready(function () {
    //所有的Input同意添加tooltip
    //$("input").showTip();
    //$("#create").showTip({flagInfo:"自定义提示信息"});
    //$("#domain_tree_refresh,#create_entity_link,#delete,#create,#Refresh,#title_logs,#title_Trash,#title_Rest,#title_Edit").showTip();
    //$("#q").showTip({isAnimate:true});
});
//导航点击三角形切换效果

$(document).ready(function () {
    $('.menu_bar li').click(function () {
        $(this).addClass('current')
            .siblings().removeClass('current')
    });
//	$('.menu_bar li:first').addClass('current');
});
//table_style2
$(document).ready(function () {
    $('.dropdown-right').click(function () {
        $(this).parent().parent().parent().toggleClass('open')
            .siblings().removeClass('open')
    });

    $(document).bind("click", function (e) {
        var target = $(e.target);
        if (target.closest(".table_sytle2 tr").length == 0) {
            $(".table_sytle2 tr").removeClass('open');
        }
    })

//	$('.sorting_asc').toggle(function(){
//		$(this).attr('class','sorting_desc')
//		$('.sorting_asc').attr('class','sorting')
//		$(this).nextAll('.sorting_desc').attr('class','sorting')
//			},function(){
//		$(this).attr('class','sorting_asc')
//		$('.sorting_desc').attr('class','sorting')
//		$(this).nextAll('.sorting_asc').attr('class','sorting')
//			});

//	$('.sorting').toggle(function(){
//		$(this).attr('class','sorting_asc')
//		$('.sorting_desc').attr('class','sorting')
//		$(this).nextAll('.sorting_asc').attr('class','sorting')
//		$(this).prevAll('.sorting_asc').attr('class','sorting')
//	 },function(){
//		$(this).attr('class','sorting_desc')
//		$('.sorting_asc').attr('class','sorting')
//		$(this).nextAll('.sorting_desc').attr('class','sorting')
//		$(this).prevAll('.sorting_desc').attr('class','sorting');
//		})


    $('.table_sytle2 th').click(function () {
        if ($(this).hasClass('sorting_asc')) {
            $(this).attr('class', 'sorting_desc')
            $(this).nextAll('.sorting_asc').attr('class', 'sorting')
            $(this).prevAll('.sorting_asc').attr('class', 'sorting')
        }
        else {
            if ($(this).hasClass('sorting_desc')) {
                $(this).attr('class', 'sorting_asc')
                $(this).nextAll('.sorting_desc').attr('class', 'sorting')
                $(this).prevAll('.sorting_desc').attr('class', 'sorting')
            }
        }
    })
    $('.table_sytle2 th').click(function () {
        if ($(this).hasClass('sorting')) {
            $(this).attr('class', 'sorting_asc')
            $(this).nextAll('.sorting_asc').attr('class', 'sorting')
            $(this).prevAll('.sorting_asc').attr('class', 'sorting')
            $(this).nextAll('.sorting_desc').attr('class', 'sorting')
            $(this).prevAll('.sorting_desc').attr('class', 'sorting')
        }
    })

    $('.table_sytle2  tr:odd').addClass('tr_odd_style');


});


//login
$(document).ready(function () {
    $('#username, #password,#user_name').focus(function () {
        $(this).parent().addClass('block');
    });
    $('#username, #password,#user_name').blur(function () {
        $(this).parent().removeClass('block');
    });
    $('.input_help_tips').focus(function () {
        $(this).parent().addClass('block');
    });
    $('.input_help_tips').blur(function () {
        $(this).parent().removeClass('block');
    });
});
//tabs
$(document).ready(function () {
    $('.tabs_ul li').click(function () {
        $(this).addClass('selected')
            .siblings().removeClass('selected')
        var index = $('.tabs_ul li').index(this);
        $('div.tabs_div > div')
            .eq(index).show()
            .siblings().hide();
    });
});

$(document).ready(function () {
    $(".js_more").toggle(function () {
        $(this).addClass("open");
    }, function () {
        $(this).removeClass("open");
    })
});

function fancyAlert(msg) {
    $.fancybox({
        // 'modal' : true,
        'content': "<div class='tips'><div class='box-header bor2'><h3><span id='title_create_user'>Alert</h3></div><div class='clear p10'><span class='q_icon'></span><span class='q_text'>" + msg + "</span></div><div class='box-footer'><input class='red_btn' type='button' onclick='$.fancybox.close();' value='OK'> <span class='Alert_img'></span> </div></div>"
    });
}





