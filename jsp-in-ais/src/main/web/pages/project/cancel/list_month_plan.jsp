<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>月度计划列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>  
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<STYLE type="text/css">
			.datagrid-row {
			  	height: 30px;
			}
			.datagrid-cell {
				height:10%;
				padding:1px;
			}
		</STYLE>
	</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	<div region="center" >
		<table id="monthPlanList"></table>
	</div>
	<script type="text/javascript">
		$(function(){
			showWin('dlgSearch');
			$('#monthPlanList').datagrid({
				url : "<%=request.getContextPath()%>/project/cancel/listMonthPlan.action?querySource=grid",
				method:'post',
				showFooter:true,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit:true,
				pageSize: 20,
				idField:'formId',
				border:false,
				fitColumns: true,
				singleSelect:false,
				remoteSort: false,
				toolbar:[{
					id:'newYear',
					text:'删除月度计划',
					iconCls:'icon-delete',
					handler:function(){
						deleteMonthPlan();
					}
				}],
				frozenColumns:[[
	       			{field:'formId',width:'50px', checkbox:true,halign:'center',align:'center'},
	       			{field:'status_name',title:'计划状态',width:80,halign:'center',align:'left'},
	       			{field:'w_plan_name', title:'月度计划名称',width:200,halign:'center',align:'left',sortable:true}
	    		]],
	    		columns:[[
  					{field:'w_plan_year',
  						 title:'计划年度',
  						 width:80,
  						 halign:'center',
  						 align:'right',
  						 sortable:true
  					},
  					{field:'w_plan_month',
  						 title:'计划月度',
  						 width:80,
  						 halign:'center',
  						 align:'right', 
  						 sortable:true
  					},
  					{field:'w_plan_code',
	  					title:'计划编号',
	  					width:80,
	  					sortable:true,
	  					halign:'center',
	  					align:'left'
  					},
  					{field:'audit_dept_name',
						 title:'实施单位',
						 width: 200,
						 halign:'center',
						 align:'left', 
						 sortable:true
					},
					{field:'w_charge_person_name',
						 title:'负责人',
						 halign:'center',
						 align:'left', 
						 sortable:true
					}
				]]   
			}); 
		});
		</script>
		<script type="text/javascript">
			/*删除选中的单条计划*/
			function deleteMonthPlan(id){
				var ids = $('#monthPlanList').datagrid('getSelections');
				if (ids.length == 0) {
					showMessage1('请选择要删除的数据！');
					return false;
				}
				var idString = '';
				for(var i=0;i<ids.length;i++){
					idString = idString + ',' + ids[i].formId;
				}
				if(idString != '' ){
					$.messager.confirm('确认','确定要删除选中的月度计划吗?一旦删除将永远不可恢复，程序开发者不承担任何法律责任!', function(flag){
						if (flag) {
							window.location.href="/ais/project/cancel/deleteMonthPlan.action?crudId="+idString;
						}
					});
				}
			}
		</script>
	</body>
</html>