<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE HTML>
<s:text id="title" name="'已发布流程定义'"></s:text>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title><s:property value="#title" /></title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script> 
		<SCRIPT type="text/javascript">
		function refresh()
		{
			//流程发布时，可以同步刷新已发布流程的页签---LIHAIFENG 2007-11-28
			//window.parent.frames['unusedflow'].location.reload();
			parent.refreshUnusedflow();
		}
		</SCRIPT>
	</head>
	<body class="easyui-layout" onload="refresh();">
		<div region="center" border="false">
			<table id="noBpmDefinitionList"></table>
		</div>
		<script type="text/javascript">
		$(function(){
			$('#noBpmDefinitionList').datagrid({
				url : "<%=request.getContextPath()%>/bpm/definition/nobpm/list.action?querySource=grid",
				method:'post',
				showFooter:true,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit: true,
				pageSize:20,
				fitColumns:true,
				idField:'id',	
				border:false,
				singleSelect:true,
				remoteSort: false,
				toolbar:[/* {
					id:'add',
					text:'新增',
					iconCls:'icon-add',
					handler:function(){
				        window.location.href="${contextPath}/bpm/definition/nobpm/edit.action";
					}
				}, */{
							text:'刷新',
							iconCls:'icon-reload',
							handler:function(){
								$('#noBpmDefinitionList').datagrid('reload');
							}
						}
					],
				columns:[[  
	       			{field:'name',title:'表单名称',width:100,sortable:true,halign:'center',align:'left'},
	       			{field:'table_name',title:'业务对象',width:100,sortable:true,halign:'center',align:'left'},
					{field:'form_name',
							title:'表单类型',
							width:150,
							halign:'center',
							align:'left', 
							sortable:true
					},
					<s:if test="${view ne 'view'}">
					{field:'operate',
						 title:'操作',
						 halign:'center', 
						 align:'center',
						 width:150,
						 sortable:false,
						 formatter:function(value,row,Index){
							return '<a href="${contextPath}/bpm/definition/nobpm/editController.action?noBpmDefinition.id='+row.id+'"   target="_self">设置表单校验</a>';
						 }
					}
					</s:if>
				]]   
			}); 
		});
		</script>
	</body>
</html>
