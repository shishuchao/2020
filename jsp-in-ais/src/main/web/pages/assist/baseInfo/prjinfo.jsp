<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
<head>
<title>在审项目信息</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
</head>
<body class="easyui-layout" border="0">
	<div region="center" border="0">
		<table id="list"></table>
	</div>
	<input type="hidden" id="orgId" value="${deptInfo.orgId}" />
<script type="text/javascript">
	var orgId=document.getElementById("orgId");
	$(function(){
		// 初始化生成表格
		$('#list').datagrid({
			url : '<%=request.getContextPath()%>/assist/baseInfo/baseInfoAction!prjinfo.action?querySource=grid&deptInfo.orgId='+orgId.value,
			method:'post',
			showFooter:false,
			rownumbers:true,
			pagination:true,
			striped:true,
			autoRowHeight:false,
			fit: true,
			fitColumns:false,
			border:false,
			singleSelect:true,
			pageSize:20,
			remoteSort: false,
			frozenColumns:[[
       			{field:'project_name',title:'项目名称',sortable:true,width:'300px',halign:'center',align:'left'}
    		]],
			columns:[[
				{field:'project_code',title:'项目编号',sortable:true,halign:'center',width:200,align:'left'},
				{field:'plan_type_name',
					title:'计划类别',
					width:100,
					align:'center', 
					sortable:true
				},
				{field:'pro_type_name',
					title:'项目类别',
					width:100,
					sortable:true, 
					halign:'center',
					align:'left'
				},
				{field:'real_start_time',
					 title:'启动时间',
					 halign:'center',
					  width:80, 
					 align:'center', 
					 sortable:true,
					 formatter:function(value,row,index){
					 	if(value!=null){
					 		return value.substring(0,10);
					 	}
					 }
				},
				{field:'real_closed_time',
					 title:'关闭时间',
					 width:80, 
					 halign:'center',
					 align:'right', 
					 sortable:true,
					 formatter:function(value,row,index){
					 	if(value!=null){
					 		return value.substring(0,10);
					 	}
					 }
				},
				{field:'audit_dept_name',
					 title:'审计单位',
					 width:250,
					 halign:'center',
					 align:'left', 
					 sortable:true
				},
				{field:'audit_object_name',
					 title:'被审单位',
					 width:150,
					 halign:'center',
					 align:'left', 
					 sortable:true
				},
				{field:'pro_teamleader_name',
					 title:'项目组长',
					 width:100,
					 halign:'center',
					 align:'left', 
					 sortable:true
				},
				{field:'pro_auditleader_name',
					 title:'项目主审',
					 width:100,
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