function subString(str, len, hasDot) {

    if (str == null || str == 'undefined') return str;
    var newLength = 0;
    var newStr = "";
    var chineseRegex = /[^\x00-\xff]/g;
    var singleChar = "";
    var strLength = str.replace(chineseRegex, "**").length;
    for (var i = 0; i < strLength; i++) {
        singleChar = str.charAt(i).toString();
        if (singleChar.match(chineseRegex) != null) {
            newLength += 2;
        }
        else {
            newLength++;
        }
        if (newLength > len) {
            break;
        }
        newStr += singleChar;
    }
    if (hasDot && strLength > len) {
        newStr += "...";
    }
    return newStr;
}

function handleError(data) {
    if (data.responseText != undefined) {
        var error_code = $.parseJSON(data.responseText)['code'];
        if (parseInt(error_code) == 90001) {
            window.location.href = "login";
        }
        else {
            var error_message = $.parseJSON(data.responseText)['message'];
            fancyAlert(error_message);
        }
    }
    else {
        fancyAlert("Error happen!");
    }
}