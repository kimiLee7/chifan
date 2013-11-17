<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div id="content" class="show clearfix">
    <form id="uploadForm" action="upload.php" method="post" enctype="multipart/form-data">
        <input type="hidden" id="parent_id" name="parent_id" value="${parent_id}">
        <%--<input type="hidden" id="left_space" value="{{left_space}}">--%>
        <div class="upload_box">
            <div class="upload_main">
                <div class="upload_choose">
                    <h3>Upload Files</h3>
                    <div class="upload_text"><span></span></div>
                    <h4 class="mt5"><strong>Note: Must select and upload image file. &nbsp;&nbsp;<label id="path_show_div"></label></strong></h4>
                    <!--<span id="fileDragArea" class="upload_drag_area"></span>-->
                    <div class="">
                        <span>Please select files directly by drag and drop into below area,or click "Browse..." to add files</span>
                        <span class="choose_files"><input class="" id="fileImage" size="30" name="fileselect[]" multiple="" type="file"></span>
                    </div>

                </div>
                <div id="fileDragArea" class="upload_preview">Drag and Drop Files into This Area<span id="uploadProgress_0" class="upload_progress"></span><span id="uploadProgress_1" class="upload_progress"></span><span id="uploadProgress_2" class="upload_progress"></span><span id="uploadProgress_3" class="upload_progress"></span><span id="uploadProgress_4" class="upload_progress"></span></div>
            </div>
            <div class="upload_submit btnArea">
                <div class="message_tip fl textright">* Large files or Internet issues may stall the upload temporarily. Please click "Upload" again to continue the upload process. Refer to
                    <a href="http://info.singtel.com/personal/communication/securitysolutions/store-and-share" target="_parent">Online Support</a> for more help.</div>
                <button style="display: none;" type="button" id="fileSubmit" class="green_btn">Upload</button>
                <input type="button" onclick="$.fancybox.close();cleanup()" value="Cancel"  class="gray_btn">
            </div>
            <div id="uploadInf" class="upload_inf"></div>
        </div>
    </form>
</div>

<script>
//$('#path_show_div').html(decodeURIComponent(path_helper.getPathAsString()));
var uploadUrl = '${uploadUrl}';
var uploadFileFor = '${upload_file_for}';
var currentDomainId = $('#current_domain').attr("currentDomainId");
uploadUrl = 'entity/file/upload/?uploadFileFor=' + uploadFileFor + '&domainId=' + currentDomainId + '&_ts='+new Date().getTime();

var params = {
    fileInput: $("#fileImage").get(0),
    dragDrop: $("#fileDragArea").get(0),
    upButton: $("#fileSubmit").get(0),
    url: uploadUrl,
    //sessionid:$.cookie('sessionid'),
    //auth_token:"<%=session.getAttribute("auth_token")%>",
    filter: function(files) {
        var arrFiles = [];
                for (var i = 0, file; file = files[i]; i++) {
                  if(file.type.indexOf("image") >= 0){
                    arrFiles.push(file);
                  }else{
                    alert("Only image file can be uploaded.");
                  }
                }

        return arrFiles;
    },
    onSelect: function(files) {
        var html = '', i = 0;
//        $("#fileDragArea").html('<div class="upload_loading"></div>');
      var funAppendImage = function() {
          file = files[i];
            if (file) {
                $("#fileSubmit").attr('disabled',false);
                var img_src = "";
                if(file.type.indexOf("video") >= 0 || file.name.substr(file.name.length-4).toLocaleLowerCase() == '.flv'){
                    img_src = "resources/images/HTML5_icons/fic_video.png";
                }
                else if(file.type.indexOf("audio") >= 0 || file.name.substr(file.name.length-4).toLocaleLowerCase() == '.ac3' || file.name.substr(file.name.length-4).toLocaleLowerCase() == '.amr'){
                    img_src = "resources/images/HTML5_icons/fic_audio.png";
                }
                else if(file.type == "text/plain"){
                    img_src = "resources/images/HTML5_icons/fic_txt.png";
                }
                else if(file.type == "text/html"){
                    img_src = "resources/images/HTML5_icons/fic_html.png";
                }
                else if(file.type == "text/css"){
                    img_src = "resources/images/HTML5_icons/fic_css.png";
                }
                else if(file.type == "text/xml"){
                    img_src = "resources/images/HTML5_icons/fic_xml.jpg";
                }
                else if(file.type.indexOf("application/octet-stream") >= 0){
                    img_src = "resources/images/HTML5_icons/fic_exe.png";
                }
                else if(file.type.indexOf("application/msword") >= 0){
                    img_src = "resources/images/HTML5_icons/fic_doc.png";
                }
                else if(file.type.indexOf("wordprocessingml.document") >= 0){
                    img_src = "resources/images/HTML5_icons/fic_doc.png";
                }
                else if(file.type == "application/pdf"){
                    img_src = "resources/images/HTML5_icons/fic_pdf.png";
                }
                else if(file.type == "application/postscript"){
                    img_src = "resources/images/HTML5_icons/fic_ai.png";
                }
                else if(file.name.substr(file.name.length-4).toLocaleLowerCase() == '.zip' || file.name.substr(file.name.length-4).toLocaleLowerCase() == '.rar' || file.name.substr(file.name.length-3).toLocaleLowerCase() == '.7z'){
                    img_src = "resources/images/HTML5_icons/fic_archive.png";
                }
                else if(file.type == "application/vnd.visio"){
                    img_src = "resources/images/HTML5_icons/fic_vsd.png";
                }
                else if(file.type.indexOf("application/vnd.ms-powerpoint") >= 0){
                    img_src = "resources/images/HTML5_icons/fic_ppt.png";
                }
                else if(file.type.indexOf("presentationml") >= 0){
                    img_src = "resources/images/HTML5_icons/fic_ppt.png";
                }
                else if(file.type.indexOf("application/vnd.ms-excel") >= 0){
                    img_src = "resources/images/HTML5_icons/fic_xls.png";
                }
                else if(file.type.indexOf("spreadsheetml.sheet") >= 0){
                    img_src = "resources/images/HTML5_icons/fic_xls.png";
                }
                else if(file.type == "application/x-msdownload"){
                    img_src = "resources/images/HTML5_icons/fic_exe.png";
                }
                else if(file.type.indexOf("image") >= 0){
                    img_src = "resources/images/HTML5_icons/fic_image.png";
                }
                else if(file.type.indexOf("application/x-shockwave-flash") >= 0){
                    img_src = "resources/images/HTML5_icons/fic_swf.png";
                }
                else if (file.name.substr(file.name.length-4).toLocaleLowerCase() == '.cdr'){
                    img_src = "resources/images/HTML5_icons/fic_cdr.png";
                }
                else if (file.name.substr(file.name.length-4).toLocaleLowerCase() == '.mpp'){
                    img_src = "resources/images/HTML5_icons/fic_mpp.png";
                }
                else if (file.name.substr(file.name.length-4).toLocaleLowerCase() == '.psd'){
                    img_src = "resources/images/HTML5_icons/fic_psd.png";
                }
                else if (file.name.substr(file.name.length-4).toLocaleLowerCase() == '.dwg'){
                    img_src = "resources/images/HTML5_icons/fic_dwg.jpg";
                }
                else if (file.name.substr(file.name.length-4).toLocaleLowerCase() == '.vsd'){
                    img_src = "resources/images/HTML5_icons/fic_vsd.png";
                }
                else{
                    img_src = "resources/images/HTML5_icons/fic_generic.png";
                }
                html = html + '<div id="uploadList_'+ i +'" class="upload_append_list"><p class="img_box">'+
                    '<img id="uploadImage_' + i + '" src="'+img_src+'" class="upload_image" /></p>'+
                    '<div class="filename">' + file.name + '</div>' +
                    '<span class="filesize">'+ size_format(file.size) +' </span>' +
                    '<a href="javascript:" class="upload_delete" title="Delete" data-index="'+ i +'">Delete</a>' +
                    '<span id="uploadProgress_' + i + '" class="upload_progress"></span>' +
                    '</div>';

                i++;
                funAppendImage();
            }
            else {
                $("#fileDragArea").html(html);
                if (html) {
                    $(".upload_delete").click(function() {
                        Html5FILE.funDeleteFile(files[parseInt($(this).attr("data-index"))]);
                        return false;
                    });
                    
                   
                    $("#fileSubmit").show();
                } else {
                    $("#fileSubmit").attr('disabled',true);
                    // $("#fileSubmit").hide();
                }
            }
        };
        funAppendImage();
    },
    onDelete: function(file) {
        $("#uploadList_" + file.index).fadeOut();
    },
    onDragOver: function() {
        $(this).addClass("upload_drag_hover");
    },
    onDragLeave: function() {
        $(this).removeClass("upload_drag_hover");
    },
    onProgress: function(file, loaded, total) {
        var eleProgress = $("#uploadProgress_" + file.index), percent = (loaded / total * 100).toFixed(2) + '%';
        eleProgress.show().html(percent);
    },
    onSuccess: function(file, response) {
        $("#uploadInf").append("<p>Successful, Url" + response + "</p>");
    },
    onFailure: function(file) {
        // $("#uploadInf").append("<p>File" + file.name + "Failure!</p>");
        // $("#uploadImage_" + file.index).css("opacity", 0.2);
        var eleProgress = $("uploadProgress_" + file.index);
        eleProgress.show().html("Failure");
    },
    onComplete: function() {
        $("#fileSubmit").hide();
        $("#fileImage").val("");
        $("#uploadInf").append("<p>The current file upload all over, can continue to add upload.</p>");
    }
};
Html5FILE = $.extend(Html5FILE, params);
Html5FILE.init();
Html5FILE.cleanup();

function cleanup(){
    Html5FILE.cleanup();
}

/*
$('#fileSubmit').click(function(){
    $('.message_tip').show();
    $(".message_tip").css("color","");
    $(".message_tip").html('* Large files or Internet issues may stall the upload temporarily. Please click "Upload" again to continue the upload process. Refer to <a href="http://info.singtel.com/personal/communication/securitysolutions/store-and-share" target="_parent">Online Support</a> for more help.');
})
*/

function size_format(size){
    if (size >= (1024*1024*1024)){
        return Math.round(size*10/1024/1024/1024)/10 + 'GB';
    }
    if (size >= (1024*1024)){
        return Math.round(size*10/1024/1024)/10 + 'MB';
    }
    if (size >= (1024)){
        return Math.round(size*10/1024)/10 + 'KB';
    }
    return size + 'Bytes'
}
</script>