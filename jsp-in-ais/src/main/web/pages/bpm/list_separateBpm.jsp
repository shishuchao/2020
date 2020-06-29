<!DOCTYPE HTML>
<jsp:directive.page
	import="org.springframework.web.context.WebApplicationContext" />
<jsp:directive.page
	import="org.springframework.web.context.support.WebApplicationContextUtils" />
<jsp:directive.page import="ais.system.service.ISystemService" />
<jsp:directive.page import="ais.framework.acegi.SecurityContextUtil" />
<jsp:directive.page import="ais.bpm.model.AudTaskInstance" />
<jsp:directive.page import="java.net.URLEncoder" />
<%@page import="ais.bpm.model.FormInfo"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!-- 流程回收 -->

<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
		<title><s:property value="#title" /></title>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	<div region="center" >
		<table id="infoList"></table>
	</div>
<script type="text/javascript">
String.prototype.startwith=function(str){
	return this.slice(0,1)===str;
}
$(function(){
	// 初始化生成表格
	$('#infoList').datagrid({
		url : "<%=request.getContextPath()%>/bpm/taskinstance/listSeparatedBpm.action?querySource=grid",
		method:'post',
		showFooter:false,
		rownumbers:true, 
	 	pagination:true, 
		striped:true,
		autoRowHeight:false,
		fit: true,
		pageSize: 20,
		fitColumns:false,
		idField:'id',	
		border:false,
		singleSelect:true,
		remoteSort: false,
		selectOnCheck: false,
		frozenColumns:[[
		       			{field:'id',width:'50px', hidden:true, align:'center'}
		 ]],      			
		columns:[[  
			{field:'processName',
					title:'流程名称',
					width:200,
					halign:'center',
					align:'left', 
					sortable:true
			},
			{field:'formName',
				title:'表单名称',
				width:200,
				sortable:true, 
				halign:'center',
				align:'left'
			},
			{field:'nodeState',
				 title:'任务名称',
				 width:200, 
				 halign:'center',
				 align:'center', 
				 sortable:true
			},
			{field:'',
				 title:'操作',
				 width:100, 
				 halign:'center',
				 align:'center', 
				 sortable:true,
				 formatter:function(value,row,index){
						 if(row.resetLink.startwith("?")||row.resetLink.startwith("&&")){
								//return "<a href=\"${pageContext.request.contextPath}/bpm/taskinstance/separateBpm.action?crudId="+row.formId+"\" onclick=\"return confirm("+dw+");\">回收</a>";
								return '<a href=\"javascript:void(0)\" onclick=\"confirmOne(\''+row.formId+'\');\">回收</a>';
							}else{
								//urlc="<a href=\"${contextPath}"+row.resetLink+"\" onclick=\"return confirm("+dw+");\">回收</a>";
								return '<a href=\"javascript:void(0)\" onclick=\"confirmTwo(\''+row.resetLink+'\');\">回收</a>';
							}
						}
					}
				]]   
			}); 
		});
		function confirmOne (formId){
			$.messager.confirm('提示信息', '确认此操作吗？', function(flag){
				if(flag){
					var url="${pageContext.request.contextPath}/bpm/taskinstance/separateBpm.action?crudId="+formId;
					window.location = url;
				}
			});
		}
		function confirmTwo(formId){
			$.messager.confirm('提示信息', '确认此操作吗？', function(flag){
				if(flag){
					var url="${contextPath}"+formId;
					window.location = url;
				}
			});
		}
</script>
</body>
</html>
