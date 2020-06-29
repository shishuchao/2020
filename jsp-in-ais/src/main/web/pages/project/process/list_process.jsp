<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>进度历史更新记录</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	<div region="center">
		<table id="processList"></table>
	</div>

	<script>
		var datagrid;
		$(function () {

			datagrid=$('#processList').datagrid({
				url : "<%=request.getContextPath()%>/project/process/getProcessList.action?querySource=grid&projectId=${param.projectId}",
				method:'post',
				showFooter:true,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit:true,
				pageSize: 20,
				border:false,
				singleSelect:true,
				remoteSort: false,
				frozenColumns:[[
					{field:'processName',
						title:'项目阶段',
						width:'10%',
						halign:'center',
						align:'left',
						sortable:true
					}
				]],
				columns:[[
					{field:'remarks',
						title:'项目进度说明',
						width:'60%',
						halign:'center',
						align:'center',
						sortable:true
					},
					{field:'creator',
						title:'录入人',
						width:'10%',
						halign:'center',
						align:'center',
						sortable:true
					},
					{field:'createTime',
						title:'录入时间',
						width:'10%',
						halign:'center',
						align:'center',
						sortable:true
					}
				]]
			});
			//单元格tooltip提示
			$('#processList').datagrid('doCellTip', {
				position : 'bottom',
				maxWidth : '1000px',
				onlyShowInterrupt:true,
				tipStyler : {
					'backgroundColor' : '#EFF5FF',
					borderColor : '#95B8E7',
					boxShadow : '1px 1px 3px #292929'
				}
			});
		})
	</script>
</body>
</html>
