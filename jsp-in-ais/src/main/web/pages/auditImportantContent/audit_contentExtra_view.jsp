<!DOCTYPE HTML>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
	<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<meta http-equiv="expires" content="0">
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
	</head>
	<body class="easyui-layout">	
	<table id="extraList"  style='overflow:hidden;'></table>
	<script type="text/javascript">	
	
		$(function(){
			// 初始化生成表格
			$('#extraList').datagrid({
				url : '<%=request.getContextPath()%>/auditImportantContent/listExtra.action?importantContentId=${param.importantContentId}&querySource=grid',
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit: true,
				fitColumns:true,
				idField:'id',
				border:false,
				singleSelect:true,
				remoteSort: false,				
				columns:[[
				       			{field:'importantContentExtraName',title:'名称',width:'520',sortable:true,align:'center'}
				]],				   
			}); 
		});
			
		
	</script>	
	</body>
</html>
