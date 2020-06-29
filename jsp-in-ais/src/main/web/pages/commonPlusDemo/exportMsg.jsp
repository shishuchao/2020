<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html>
<head>
<script type="text/javascript">
function showMyMsg(){
	if(parent.$ && parent.$('#importExcelSuccess').length){
		parent.$('#importExcelSuccess').val('${importExcelSuccess}');
	}
	
	// 关闭进度条
   window.pbarInterval ? clearInterval(window.pbarInterval) : null;
   parent.$('#qpwin').window('close');
   
	var msg = '${returnMsg}';
	if(!msg){
		msg = "请求失败，程序发生错误!";
	}
	// 调用父页面的函数显示提示信息；
	top.$.messager.alert('提示信息',msg,'info',function(){  
		
	});
	var topWin = "${topWin}";
	//alert("topWin="+topWin)
	var parentTabId = "${parentTabId}";
	//alert('parentTabId='+parentTabId)
	var parentWin = parentTabId && topWin && topWin == 'true' ? aud$getTabIframByTabId(parentTabId) : parent;
	//alert('parentWin='+parentWin)
	//alert('parentWin.aud$ImportExcelCallbackFn='+parentWin.aud$ImportExcelCallbackFn)
	if(parentWin.aud$ImportExcelCallbackFn){
		parentWin.aud$ImportExcelCallbackFn('${importExcelSuccess}', '${plugId}');
	}
}

// 根据tabId获得对应页面的iframe对象
function aud$getTabIframByTabId(targetId){
    try{
 	   if(top.aud$loadClose){
 		  top.aud$loadClose();
 	   }
    }catch(e){}
	
	var targetWin = null;
	//alert('1.targetWin='+targetWin)
	try{
		if(targetId){
			var tabId = targetId;
			if(targetId.substr(0, 4) != 'tab_'){
				tabId = 'tab_' + tabId;
			}
			var t = top.Addtabs.options.obj.children(".tab-content");
        	var tabIfm = t.find('#'+tabId).find('.iframeClass');
        	targetWin = tabIfm.get(0).contentWindow;
		}
		
	}catch(e){
		//alert('aud$getTabIframByTabId:'+e.message);
	}
	if(!targetWin){
		try{
			//alert(parent.$('#topDialogId_1543222148883').length+"\n"+top.$('#topDialogId_1543222148883').get(0).outerHTML)
			//alert("topDialogObj.length:"+top.$('#'+tabId).length+"\n"+tabId)
			var topIfrm = parent.$('#'+targetId).find('iframe');
			//alert("topIfrm.length:"+topIfrm.length)
			if(topIfrm && topIfrm.length){
				targetWin = topIfrm.get(0).contentWindow;
			}
		}catch(e){
			//alert(e.message)
		}
	}	
	//alert('2.targetWin='+targetWin)
	return targetWin;
} 
</script>
</head>
<body  onload='showMyMsg()'>
</body>
</html>