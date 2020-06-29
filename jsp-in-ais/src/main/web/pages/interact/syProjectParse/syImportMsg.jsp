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
	if(msg){		
		// 调用父页面的函数显示提示信息；
		top.$.messager.alert('提示信息', msg, '${resultType}', function(){  
			
		});
	}
	var topWin = "${topWin}";
	//alert("topWin="+topWin)
	var parentTabId = "${parentTabId}";
	//alert('parentTabId='+parentTabId)
	var parentWin = parentTabId && topWin && topWin == 'true' ? aud$getTabIframByTabId(parentTabId) : parent;
	//alert('parentWin='+parentWin)
	//alert('parentWin.aud$ImportExcelCallbackFn='+parentWin.aud$ImportExcelCallbackFn)
	if(parentWin.aud$ImportExcelCallbackFn){
		parentWin.aud$ImportExcelCallbackFn("${resultType}");
	}
}

// 根据tabId获得对应页面的iframe对象
function aud$getTabIframByTabId(tabId){
	try{
		if(tabId){
			if(tabId.substr(0, 4) != 'tab_'){
				tabId = 'tab_' + tabId;
			}
			var t = top.Addtabs.options.obj.children(".tab-content");
        	var tabIfm = t.find('#'+tabId).find('.iframeClass');
        	var ifmWin = tabIfm.get(0).contentWindow;
        	return ifmWin;
		}
	}catch(e){
		alert('aud$getTabIframByTabId:'+e.message);
	}
} 
</script>
</head>
<body  onload='showMyMsg()'>
</body>
</html>