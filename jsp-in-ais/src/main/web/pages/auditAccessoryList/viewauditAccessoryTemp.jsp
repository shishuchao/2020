<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.opensymphony.xwork2.ActionContext"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>被审计单位资料模板查看</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
	<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
	<script type="text/javascript" src="${contextPath}/scripts/ufaudTextLengthValidator.js"></script>
	<STYLE type="text/css">
			.datagrid-row {
			  	height: 30px;
			}
			.datagrid-cell {
				height:10%;
				padding:5px 4px;
			}
		</STYLE>
    <script type="text/javascript">
     var datagrid;
	 $(function(){
		    //$(document).bind("contextmenu",function(e){return false;});//禁用右键菜单
			// 初始化生成表格
			datagrid = $('#aatList').datagrid({
				url : "<%=request.getContextPath()%>/auditAccessoryList/viewauditAccessoryTemplate.action?querySource=grid",
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit: true,
				pageSize: 20,
				fitColumns:true,
				idField:'id',	
				border:false,
				singleSelect:true,
				remoteSort: false,
				columns:[[  
					{field:'templatename',
							title:'模板名称',
							width:150,
							halign:'center',
							align:'left', 
							sortable:true,
							formatter:function(value,row,index){
							 	return '<a href="${contextPath}/auditAccessoryList/viewauditAccessoryTempList.action?checkOption=edit&view=View&auditUuid='+row.id+'">'+row.templatename+'</a>';
							}
					},
					{field:'pro_type_name',
						title:'适用项目类别',
						width:150,
						halign:'center',
						sortable:true, 
						align:'left'
					},
					{field:'createName',
						 title:'创建人',
						 width:100,
						 halign:'center', 
						 align:'left', 
						 sortable:true
					},
					{field:'createTime',
						 title:'创建时间',
						 width:80,
						 halign: 'center',
						 align:'center', 
						 sortable:true
					}/* ,
					{field:'operate',
						 title:'操作',
						 halign: 'center',
						 align:'center', 
						 sortable:false,
						 formatter:function(value,row,index){
							 var param = [row.id];
								var btn2 = "查看,view,"+param.join(',');
								return ganerateBtn(btn2);
						 }
					} */
				]]   
			}); 
	 });
	 function view(id){
	 	window.location.href="${contextPath}/auditAccessoryList/viewauditAccessoryTempList.action?checkOption=edit&view=View&auditUuid="+id;
	 }
    </script>
</head>
<body class="easyui-layout">
	<div region="center" >
		<table id="aatList"></table>
	</div>
</body>
</html>
