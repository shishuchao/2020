<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>授权结果查看tree</title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript">
		$(function(){
			$('#zcfgTreeSelect').tree({   
				url:'<%=request.getContextPath()%>/admin/asyUorg4User.action?querySource=tree',
				checkbox:false,
				animate:false,
				lines:true,
				dnd:false,
				onClick:function(node){
					var id=node.id;
					var src='<%=request.getContextPath()%>/system/authRoleAction!showSelfRoles.action?companyId='+id;
					parent.childBasefrm.location.href=src;
				},
				onLoadSuccess:function(node, data){
					var rootNode = $("#zcfgTreeSelect").tree('getRoot');
					$("#zcfgTreeSelect").tree('expand',rootNode.target);
				}
			});
		});
	</script>
	</head>
	<body class="easyui-layout">
		<div region='west'>
			<br>
		    <ul id='zcfgTreeSelect' class='easyui-tree' ></ul>
		    <br>
		</div>
	</body>
</html>