<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>项目台账查询子页面</title>
	 <meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<%-- <script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>   
	<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" /> 
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script> --%>
</head>
<body  style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	<div region="center" >
		<table id="listStandingTable"></table>
	</div>
	<SCRIPT>
		$(function(){
			$('#listStandingTable').datagrid({
				url : "<%=request.getContextPath()%>/standingBook/standingBook!StandingBookQuerySub.action?querySource=grid&projectStartObject.formId=${projectStartObject.formId}",
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit:true,
				pagination:false,
			//	pageSize: 20,
				fitColumns:false,
				border:false,
				singleSelect:true,
				remoteSort: false,
				frozenColumns:[[
				       			{field:'task_name',title:'审计事项',width:'200px',align:'left',sortable:true},
				       			{field:'problem_name',title:'问题点',width:'150px',sortable:true,align:'left'}
				    		]],
				columns:[[  
					{field:'problem_grade_name',
							title:'审计发现类型',
							width:200,
							align:'left', 
							sortable:true,
							formatter:function(value,row,rowIndex){
								return row.problem_grade_name;
					}},
					{field:'manuscript_code',
						title:'底稿编号',
						width:200,
						sortable:true, 
						align:'left',
						formatter:function(value,row,rowIndex){
								return row.manuscript_code;
					}},
					/* {field:'audit_start_time',
						 title:'审计期间开始',
						 align:'right', 
						 sortable:true,
						 formatter:function(value,row,rowIndedx){
							if(value!=null){
								return value.substring(0,10);
							}
						 }
					},
					{field:'audit_end_time',
						 title:'审计期间结束',
						 align:'right', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
							if(value!=null){
								return value.substring(0,10);
							}
						 }
					}, */
					{field:'problem_money',
						 title:'涉及金额',
						 align:'right', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
							return row.problem_money;
						 }
					},
					{field:'creater_name',
						 title:'审计人员',
						 align:'right', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
						 	return row.creater_name;
						 }
					},
					/* {field:'pro_teamleader',
						 title:'复核人员',
						 align:'left', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
								return row.pro_teamleader;
					}
					},	 */
					{field:'pro_teamleader_name',
						 title:'审计组长',
						 align:'right', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
								return row.pro_teamleader_name;
					}},
					{field:'manuscript_date',
						 title:'底稿生成时间',
						 align:'right', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
								if(value!=null){
									return value.substring(0,10);
								}
							 }
					},
					{field:'caozuo',
						 title:'备注',
						 align:'center', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
								return '';
					}}
					
				]]
			});
		});
	</SCRIPT>
</body>
</html>