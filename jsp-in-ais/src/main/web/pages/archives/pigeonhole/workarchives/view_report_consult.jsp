<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML >
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>审计报告查阅</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="<%=request.getContextPath()%>/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<link href="<%=request.getContextPath()%>/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>  
		<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script> 
		<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<link href="<%=request.getContextPath()%>/styles/jquery.multiSelect.css" rel="stylesheet" type="text/css">
		<script type='text/javascript' src='<%=request.getContextPath()%>/scripts/jquery.multiSelect.js'></script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<div region="center" >
			<table id="resultList"></table>
		</div>
		<script type="text/javascript">
		$(function(){
			var projdetailid = '${projdetailid}';
			$('#resultList').datagrid({
				url : "<%=request.getContextPath()%>/archives/workprogram/pigeonhole/viewReportAuthority.action?querySource=grid&projdetailid="+projdetailid,
	            method:'post',
	            showFooter:false,
	            rownumbers:true,
	            pagination:true,
	            striped:true,
	            autoRowHeight:true,
	            fit: true,
	            pageSize: 20,
	            fitColumns:true,
	            idField:'id',
	            singleSelect:true,
	            border:false,
			    onLoadSuccess:function(){
				  doCellTipShow('resultList');
			    },
				columns:[[
					{field:'authorizedName',title:'授予用户',halign:'center',width:'15%',align:'left',sortable:true			
					},
				 	{field:'limit',
						 title:'查看期限',
						 width:'25%', 
						 halign:'center',
						 align:'left', 
						 sortable:true
					}, 
 					{field:'fileIdsString',
						 title:'授权文件',
						 width:'20%', 
						 halign:'center',
						 align:'left', 
						 sortable:true

					}, 
 					{field:'authorizerName',
						 title:'授权人',
						 width:'15%', 
						 halign:'center',
						 align:'left', 
						 sortable:true
					}, 
 					{field:'createTime',
						 title:'授权时间',
						 width:'15%', 
						 halign:'center',
						 align:'left', 
						 sortable:true
					}
				]]   
			}); 
			 
		});
		</script>	
	</body>
</html>
