<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head><meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>  
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/csswin/subModal.css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/csswin/subModal.js"></script>	
<script language="javascript">
$(function(){
	var wurl = window.location.href;
	var urlArr = wurl.split('&'); // menuView
	var menuView = 'view';
	var projectid = '${projectid}';
	for(var i=0; i<urlArr.length; i++){
		var p = urlArr[i];
		var arr = p.split('=');
		if(arr[0] == 'menuView'){
			menuView = arr[arr.length-1];
			//alert(menuView+"1");
		}
		if(arr[0] == 'projectid'){
			projectid = arr[arr.length-1];
			//alert(projectid+"2");
		}
	}
	//alert(projectid+"2.1");
    // 加载政策法规树
    $('#zcfgTreeSelect').tree({   
		url:'<%=request.getContextPath()%>/adl/getZcfgTree.action?mCodeType=${mCodeType}&menuView='+menuView+'&projectId='+projectid,
		lines:true,
        onClick:function(node){
        	// 根节点不能单击
        	if(node.id == 3){
        		var url = "<%=request.getContextPath()%>/pages/assist/suport/lawsLib/listByTypeKey.action?mCodeType=${mCodeType}&nodeid=";
        		if(menuView == 'view'){// 查询界面
        			url = "<%=request.getContextPath()%>/pages/assist/suport/lawsLib/search.action?m_view=view&mCodeType=${mCodeType}&nodeid=";
        		}  
        		childBasefrm.location.href = url;
        		return;
        	};

        	var menuType = "";
        	var sjson =  node.attributes;
        	//alert(sjson+"3");
        	if(sjson){
        		var tmp = (new Function("return " + sjson))();
        		menuType = tmp.menuType;
        		$('#menuType').val(menuType);
        		//alert(menuType+"4");
        	}
        	//alert(node.id+' '+node.text);
        	if(childBasefrm){
        		// 编辑维护界面
        		var url = "<%=request.getContextPath()%>/pages/assist/suport/lawsLib/listByTypeKey.action?mCodeType=${mCodeType}&nodeid=";
        		if(menuView == 'view'){// 查询界面
        			url = "<%=request.getContextPath()%>/pages/assist/suport/lawsLib/search.action?m_view=view&mCodeType=${mCodeType}&nodeid=";
        		}  
        		//alert(url+"5");
        		url = url+node.id+"&menuType="+menuType;
        		var url2 = url.replace("&","*");
        		//alert(url + "&backUrl="+url2);
        		childBasefrm.location.href = url + "&backUrl="+url2;
        	}
        }
	});
});

/*
*  打开或关闭查询面板
*/
/*
function triggerSearchTable(){
try{
	var isDisplay = childBasefrm.document.getElementById('searchTable').style.display;
	if(isDisplay==''){
		childBasefrm.document.getElementById('searchTable').style.display='none';
	}else{
		childBasefrm.document.getElementById('searchTable').style.display='';
	}
}catch(e){
	
}	
}
*/
</script>
</head>
 <body style="margin: 0;padding: 0;" class="easyui-layout" fit="true" border="0">
  <div id="content" region="west" border="0" split="true" style="width: 300px;padding:5px;" title="分类">
     <ul id='zcfgTreeSelect' class="easyui-tree"></ul>
  </div>	
  <div id="sidebar" region="center" style="overflow-y:hidden" border="0">
	 <iframe name="childBasefrm" id='childBasefrm' width="100%" frameborder="0" height="100%" src="search.action?mCodeType=${mCodeType}&nodeid=-1&m_view=view" ></iframe>
  </div>
  </body>
</html>