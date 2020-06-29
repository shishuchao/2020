<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML> 
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
<title>法律法规树</title>
<script type="text/javascript">
$(function(){	
	var wurl = window.location.href;
	var urlArr = wurl.split('&'); // menuView
	var menuView = '';
	var projectid = '';
	for(var i=0; i<urlArr.length; i++){
		var p = urlArr[i];
		var arr = p.split('=');
		if(arr[0] == 'menuView'){
			menuView = arr[arr.length-1];
			alert(menuView+"1");
		}
		if(arr[0] == 'projectid'){
			projectid = arr[arr.length-1];
			alert(projectid+"2");
		}
	}
	alert(projectid+"2.1");
    // 加载政策法规树
    $('#zcfgTreeSelect').tree({   
		url:'<%=request.getContextPath()%>/adl/getZcfgTree.action?menuView='+menuView+'&projectId='+projectid,
		lines:true,
        onClick:function(node){
        	// 根节点不能单击
        	if(node.id == 3) return;
        	var menuType = "";
        	var sjson =  node.attributes;
        	alert(sjson+"3");
        	if(sjson){
        		var tmp = (new Function("return " + sjson))();
        		menuType = tmp.menuType;
        		$('#menuType').val(menuType);
        		alert(menuType+"4");
        	}
        	//alert(node.id+' '+node.text);
        	if(parent.childBasefrm){
        		// 编辑维护界面
        		var url = "<%=request.getContextPath()%>/pages/assist/suport/lawsLib/listByTypeKey.action?mCodeType=flfg&nodeid=";
        		if(menuView == 'view'){// 查询界面
        			url = "<%=request.getContextPath()%>/pages/assist/suport/lawsLib/search.action?m_view=view&mCodeType=flfg&nodeid=";
        		}  
        		alert(url+"5");
        		url = url+node.id+"&menuType="+menuType;
        		var url2 = url.replace("&","*");
        		alert(url + "&backUrl="+url2);
        		parent.childBasefrm.location.href = url + "&backUrl="+url2;
        	}
        }
	});
});

</script>
</head>
<body>
<input id='menuType' name='menuType' value="" type='hidden'/>
<div style="height: 500px;width: 300px;">
	<ul id='zcfgTreeSelect' class='easyui-tree' ></ul>
</div>
<body>
</html>