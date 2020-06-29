<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<s:text id="title" name="'编号规则定义列表'"></s:text>
		<title><s:property value="#title" />编号规则定义列表</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>  
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<%--		<STYLE type="text/css">
			.datagrid-row {
			  	height: 30px;
			}
			.datagrid-cell {
				height:10%;
				padding:1px;
			}
		</STYLE>--%>
	</head>
	<body class="easyui-layout">
	<div region="center" >
		<table id="its"></table>
	</div>
		
	<script type="text/javascript">
		function setUp(id, tableName, fieldName){
			var isReadOnlyType = false;
			if ((tableName == 'WorkPlanDetail') && (fieldName == 'w_plan_name')){
				isReadOnlyType = true;
			}
			window.location.href='${contextPath}/code/ruledetail/codeRuleDetail/list.action?isTZS=false&isReadOnlyType='+isReadOnlyType+'&id='+id+'&rule_id='+id;
		}
		$(function(){
			// 初始化生成表格
			$('#its').datagrid({
				url : "<%=request.getContextPath()%>/code/rule/codeRule/listYear.action?querySource=grid",
				method:'post',
				showFooter:false,
				rownumbers:true,
				/* pagination:true, */
				striped:true,
				autoRowHeight:false,
				fit: true,
				pageSize: 20,
				fitColumns: true,
				idField:'id',	
				border:false,
				singleSelect:true,
				remoteSort: false,
				toolbar:[{
					id:'setup',
					text:'设置',
					iconCls:'icon-config',
					handler:function() {
						var rows = $('#its').datagrid('getSelections');
						if(rows.length > 0) {
							var row = rows[0];
							setUp(row.id, row.rule_table_name, row.rule_field_name);
						} else {
							showMessage1("请选择1条数据！");
						}
					}
				}],
				frozenColumns:[[
				       			{field:'rule_table_desc',title:'业务表名',width:'100px',halign:'center',align:'left',sortable:true},
				       			{field:'rule_field_desc',title:'业务字段描述',width:'200px',sortable:true,halign:'center',align:'left'}
				    		]],
				columns:[[  
					{field:'rule_field_name',
							title:'字段名',
							width:150,
							halign:'center',
							align:'left', 
							sortable:true
					},
					{field:'rule_field_type',
						title:'字段类型',
						width:80,
						halign:'center',
						sortable:true, 
						align:'center'
					},
					{field:'rule_field_length',
						 title:'字段宽度',
						 width:100,
						 halign:'center', 
						 align:'center', 
						 sortable:true
					},
					{field:'rule_formula',
						 title:'公式',
						 width:250,
						 halign:'center', 
						 align:'left',
						 sortable:true
					}/*,
					{field:'operate',
						 title:'操作',
						 width:100, 
						 halign:'center',
						 align:'center', 
						 sortable:false,
						 formatter:function(value,row,index){
						 //	 return "<a href='<%=request.getContextPath()%>/code/ruledetail/codeRuleDetail/list.action?id='+row.id+'&rule_id='+row.id+''>设置</a>";
						 //	 return '<a href="${contextPath}/code/ruledetail/codeRuleDetail/list.action?id='+row.id+'&rule_id='+row.id+'" >设置</a>';
						 	var param = [row.id, row.rule_table_name, row.rule_field_name];
							var btn2 = "设置,setUp,"+param.join(',');
							return ganerateBtn(btn2);
						 }
					}*/
				]]   
			}); 
		});
	</script>	
	</body>
</html>
