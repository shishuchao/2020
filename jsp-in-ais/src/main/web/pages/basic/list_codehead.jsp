<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
<head>
	<title>基础信息</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
</head>
<body>
		<div class="easyui-panel"  fit=true style="overflow: visibility ;" >
			<table id="list"></table>	
		</div>
		<script type="text/javascript">
			$('#list').datagrid({
				url : "<%=request.getContextPath()%>/basic/codename/list2.action?codeHead.pid=${codeHead.pid}&querySource=grid",
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				//width:'100%',
				//height:'78%',
				fit: true,
				fitColumns:true,
				idField:'id',	
				border:false,
				singleSelect:false,
				remoteSort: false,
				frozenColumns:[[
				       			{field:'formId',width:'5%', hidden:true, align:'center'}
				]],
				columns:[[ 
				       			{field:'code',title:'类别码',width:'45%',align:'center',sortable:true},
				       			{field:'name',title:'名称',width:'50%',sortable:true,align:'center'}
				]]   
			}); 
		</script>
</body>
</html>
