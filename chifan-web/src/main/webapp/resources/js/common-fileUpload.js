function upload_file(uploadFileFor) {

    if (window.File && window.FileReader && window.FileList && window.Blob) {
//        var url = 'entity/drag_upload/?_ts=' + (new Date()).valueOf();
        var url = 'entity/drag_upload?upload_file_for=' + uploadFileFor;
        $.fancybox({
            href:url,
            type:'ajax',
            autoDimensions:false,
            width:800,
            height:420,
            onClosed:function () {
                reloadEntityLogo();
                reloadEntityAdvert();
            }
        });

    }
}
