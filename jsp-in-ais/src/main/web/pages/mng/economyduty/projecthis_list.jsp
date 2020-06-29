<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
		<title>历史项目信息</title>
		<script type="text/javascript">
		$(function(){
			// 初始化生成表格
			$('#its').datagrid({
				url : "${contextPath}/mng/economyduty/economyDutyAction!toHisProject.action?querySource=grid&id=${id}",
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit:true,
				fitColumns: true,
				border:false,
				singleSelect:true,
				pageSize:20,
				remoteSort: false,
				columns:[[  
	       			{field:'plan_code',title:'计划编号',width:100,sortable:true,halign:'center',align:'left'},
	       			{field:'project_name',title:'计划名称',width:180,sortable:true,halign:'center',align:'left'},
					{field:'pro_starttime',
						title:'审计开始日期',
						width:120,
						halign:'center',
						align:'center',
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
						align:'center',
						formatter:function(value,row,index){
							if(value!=null){
								return value.substring(0,10);
							}
						}
					},
					{field:'audit_dept_name',
						 title:'审计单位',
						 width:180,
						 halign:'center',
						 align:'left', 
						 sortable:true
					},
					{field:'pro_teamleader_name',
						 title:'项目负责人',
						 width:100,
						 halign:'center',
						 align:'left', 
						 sortable:true
					},
					{field:'audit_object_name',
						 title:'被审计单位',
						 width:180,
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
