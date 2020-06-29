<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>日志备份列表</title>	
			<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
			<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
			<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
			<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
			<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
			<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
			<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
			<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
			<%--<STYLE type="text/css">
				.datagrid-row {
				  	height: 30px;
				}
				.datagrid-cell {
					height:20px;
					padding:1px;
				}
			</STYLE>--%>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<!-- <table style="padding: 0;border-spacing: 0;border-collapse: 0;width:96%;"> -->
		<div  data-options="split:false">
		<!-- 列表FORM -->
			<s:form namespace="/log" action="" method="post" theme="simple">
			</s:form>
		</div>
		
		<div region="center" >
			<table id="its"></table>
		</div>
		
		
		
		
				
		<script type="text/javascript">
		$(function(){
			// 初始化生成表格
			$('#its').datagrid({
				url : "<%=request.getContextPath()%>/log/listBackUpLog.action?querySource=grid",
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit: true,
				pageSize:20,
				fitColumns:true,
				idField:'id',	
				border:false,
				singleSelect:false,
				remoteSort: false,
				frozenColumns:[[
				       			{field:'formId',width:50, hidden:true,halign:'center',align:'center'}
				    		]],
				columns:[[  
					{field:'fileName',title:'备份文件',width:100,halign:'center',align:'left'},
	       			{field:'recordNum',title:'记录数',width:80,sortable:true,halign:'center',align:'center'},
					{field:'option',
							title:'操作',
							width:50,
							halign:'center',
							align:'center', 
							sortable:true,
							formatter:function(value,rowData,rowIndex){
								var param = [rowData.fileName];
								var btn2 = "下载,dowLoadFile,"+param.join(',');
								return ganerateBtn(btn2);
						}
							
					}
				]]   
			}); 
			
		});
	</script>
	<script type="text/javascript">
		function dowLoadFile(fileName){
			window.location.href="<%=request.getContextPath()%>/log/outBackUpLog.action?fileName="+fileName;
		}
	</script>
	</body>
</html>
