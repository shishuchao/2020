<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/ais/styles/main/ais.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="/ais/resources/csswin/subModal.css">

<link rel="stylesheet" href="<%=request.getContextPath()%>/pages/introcontrol/util/zTreeStyle/zTreeStyle.css" type="text/css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/icon.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery.ztree.all-3.4.min.js"></script>

<script type="text/javascript">
$(function(){
	
	var msg = $('#importMsg').val();
	if(msg){
		parent.$.messager.alert('提示信息',msg, 'info', function(){ 
			parent.$('#importSjsxLbBtn').attr('disabled',false);
			// 导入成功后，重新加载树形
			parent.loadSjsxLbTree();
		});
	}
})
</script>
</head>
<body >
<input id='importMsg' value='${ importMsg }'/>
</body>
</html>