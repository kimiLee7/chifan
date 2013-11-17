function removeTrCommand(obj){
    jQuery(obj).parent().parent().remove();
}

function prevMoveTrCommand(obj, table_self_id, td_self_id){
 var $jqFirstTr = jQuery("#"+table_self_id+" tr:first-child");   //获得第一个tr的对象
 var firstTrVal = $jqFirstTr.find("."+td_self_id+" input:nth-child(1)").val();   //获得第一个tr里的input的value的序号
 var objVal = jQuery(obj).parent().parent().find("."+td_self_id+" input:nth-child(1)").val();  //获得本身tr的序号
 
 if(objVal == firstTrVal){  //判断是否在把第一行向上移
  return;
 }else{
  prevMoveTrOpra(obj, td_self_id);   //调用上移操作方法
 }
}
//上移操作3
function prevMoveTrOpra(obj, td_self_id){
 var $jqObj = jQuery(obj).parent().parent().clone();  //获得并复制本身tr的信息
 var $jqSublObj = jQuery(obj).parent().parent().prev();   //获得上一个tr的信息

 $jqSublObj.find("."+td_self_id+" input:nth-child(1)").val(Number($jqSublObj.find("."+td_self_id+" input:nth-child(1)").val())+1);    //把上一个tr序号加1
 jQuery(obj).parent().parent().html("").append($jqSublObj.html());   //把本身tr清空并插入上一个信息
 
 $jqObj.find("."+td_self_id+" input:nth-child(1)").val(Number($jqObj.find("."+td_self_id+" input:nth-child(1)").val())-1);    //把本身tr序号减1
 $jqSublObj.html("").append($jqObj.html());   //把上一个tr清空并插入临时保存的tr信息

 $jqObj.remove();   //删除复制的多余jQuery对象
}

//下移指令3
function nextMoveTrCommand(obj, table_self_id, td_self_id){
 var $jqLastTr = jQuery("#"+table_self_id+" tr:last-child");   //获得最后一个tr的对象
 var lastTrVal = $jqLastTr.find("."+td_self_id+" input:nth-child(1)").val();   //获得最后一个tr的序号
 var objVal = jQuery(obj).parent().parent().find("."+td_self_id+" input:nth-child(1)").val();  //获得本身tr的序号

 if(objVal == lastTrVal){  //判断是否想把最后一行往下移
  return;
 }else{
  nextMoveTrOpra(obj, td_self_id);    //调用下移操作方法
 }
}
//下移操作3

function nextMoveTrOpra(obj, td_self_id){
 var $jqObj = jQuery(obj).parent().parent().clone();  //获得并复制本身tr的信息
 var $jqSiblObj = jQuery(obj).parent().parent().next();   //获得下一个tr的信息
 
 $jqSiblObj.find("."+td_self_id+" input:nth-child(1)").val(Number($jqSiblObj.find("."+td_self_id+" input:nth-child(1)").val())-1);    //把下一个tr序号减1
 jQuery(obj).parent().parent().html("").append($jqSiblObj.html());   //把本身tr清空并插入下一个tr信息

 $jqObj.find("."+td_self_id+" input:nth-child(1)").val(Number($jqObj.find("."+td_self_id+" input:nth-child(1)").val())+1);    //把本身tr序号加1
 $jqSiblObj.html("").append($jqObj.html());   //把下一个tr清空并插入临时保存的tr信息

 $jqObj.remove();    //删除复制的多余jQuery对象
}