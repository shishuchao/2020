<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<%--		<STYLE type="text/css">
			.datagrid-row {
			  	height: 30px;
			}
			.datagrid-cell {
				position:relative;
				bottom:2px;
				height:19px;
			}
		</STYLE>--%>
		<script type="text/javascript">
			function doUpdate(id){
				window.location.href='${request.contextPath}/sysparam/sysParamAction!paramEdit.action?fid='+id;
				return true;
			}
			function doDel(id){
				$.messager.confirm('提示信息','删除参数会影响业务的正常运行，确定要删除吗？',function(isDel){
					if(isDel){
						window.location.href='${request.contextPath}/sysparam/sysParamAction!paramDel.action?fid='+id;
						showMessage1('删除成功！');
						return true;
					}
				});
				return false;
			}
			function doAdd(){
				window.location.href='${request.contextPath}/sysparam/sysParamAction!paramEdit.action?code=${code}';
			}
		</script>
	</head>
	<body class="easyui-layout" style="overflow:hidden;">
	
	<div region="center" >
		<table id="its"></table>
	</div>
		
		<script type="text/javascript">
		$(function(){
			// 初始化生成表格
			$('#its').datagrid({
				url : "<%=request.getContextPath()%>/sysparam/sysParamAction!paramList.action?code=${code}&querySource=grid",
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit: true,
				pageSize:20,
				fitColumns: true,
				idField:'id',	
				border:false,
				singleSelect:false,
				remoteSort: false,
				toolbar:[{
						id:'add',
						text:'增加',
						iconCls:'icon-add',
						handler:function(){
							 doAdd();
						}
					}
				],
				columns:[[  
	       			{field:'fpcode',title:'编码',width:150,halign:'center',align:'left',sortable:true},
	       			{field:'fpname',title:'名称',width:200,halign:'center',sortable:true,align:'left'},
					{field:'frealvalue',
							title:'参数值',
							width:100,
							halign:'center',
							align:'center', 
							sortable:true
					},
					{field:'fnote',
						title:'备注',
						width:150,
						halign:'center',
						sortable:true, 
						align:'left'
					},
					{field:'option',
						 title:'操作',
						 width:100, 
						 halign:'center', 
						 align:'center', 
						 sortable:true,
						 formatter:function(value,rowData,rowIndex){
							 var param = [rowData.fid];
						 	 var btn2 = "修改,doUpdate,"+param.join(',')+"-btnrule-删除,doDel,"+param.join(',');
							 return ganerateBtn(btn2);
						 }
					}
				]]   
			}); 
		});
	</script>	
	
	</body>
</html>