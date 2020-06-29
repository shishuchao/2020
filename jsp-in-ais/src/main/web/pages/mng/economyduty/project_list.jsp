<!DOCTYPE HTML>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<title>在审项目信息</title>
		<script type="text/javascript">
			$(function(){
				// 初始化生成表格
				$('#its').datagrid({
					url : "<%=request.getContextPath()%>/mng/economyduty/economyDutyAction!toProject.action?querySource=grid&id=${id}",
					method:'post',
					showFooter:false,
					rownumbers:true,
					pagination:true,
					striped:true,
					autoRowHeight:false,
					fit: true,
					fitColumns:true,
					border:false,
					singleSelect:true,
					pageSize:20,
					remoteSort: false,
					columns:[[
			       		{field:'plan_code',title:'计划编号',sortable:true,width:300,halign:'center',align:'left'},
			       		{field:'project_name',title:'计划名称',sortable:true,width:300,halign:'center',align:'left'},
						{field:'pro_starttime',
							title:'审计开始日期',
							width:120,
							halign:'center',
							align:'right',
							sortable:true,
							formatter:function(value,row,index){
								if(value!=null){
									return value.substring(0,10);
								}
							}
						},
						{field:'pro_endtime',
							title:'审计结束日期',
							width:120,
							sortable:true, 
							halign:'center',
							align:'right',
							formatter:function(value,row,index){
								if(value!=null){
									return value.substring(0,10);
								}
							}
						},
						{field:'audit_dept_name',
							 title:'审计单位',
							 width:200,
							 halign:'center',
							 align:'left', 
							 sortable:true
						},
						{field:'pro_teamleader_name',
							 title:'项目负责人',
							 width:150,
							 halign:'center',
							 align:'left', 
							 sortable:true
						},
						{field:'audit_object_name',
							 title:'被审计单位',
							 width:200,
							 halign:'center',
							 align:'left', 
							 sortable:true
						}
					]]   
				}); 
			});
		</script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<div region="center">
			<table  id="its"></table>
		</div>
	</body>
</html>
