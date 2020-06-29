<%@ page language="java" contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %> 
<html>
<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="${contextPath}/scripts/ext/ext-base.js"></script>
		<script type="text/javascript"
			src="${contextPath}/scripts/ext/ext-all.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>	
		<script type="text/javascript" src="${contextPath}/pages/ccr/template/basicInfoTree.js"></script>
		<link href="${contextPath}/styles/ext/ext-all.css" rel="stylesheet" type="text/css">
		<link href="${contextPath}/styles/main/main.css" rel="stylesheet" type="text/css">
		<link rel="stylesheet" type="text/css" href="${contextPath}/resources/csswin/subModal.css">
		<link href="<%=request.getContextPath()%>/styles/portal/ext-all.css" rel="stylesheet" type="text/css">
<style type="text/css">
	.x-tree-node .x-tree-selected{background-color:#ffffff;}
	.ListTable
		{
			BACKGROUND-COLOR:#7CA4E9;
			VERTICAL-ALIGN:center;
			FONT-SIZE: 12px;
			COLOR:#000000;
			margin: 20px;
		}	
</style>
	
</head>
<body >
<center>
<table id="tableTitle" width="90%" border=0 cellPadding=0 cellSpacing=1 bgcolor="#409cce" class=ListTable >
				<tr class="listtablehead">
					<td align="left" class="edithead">
							系统基础参数
					</td>
				</tr>
			</table>
			</center>
<div id="tree"
			style="height: auto; width: 100%; margin-top: 15; margin-left: 25" ></div>
</body>
</html>