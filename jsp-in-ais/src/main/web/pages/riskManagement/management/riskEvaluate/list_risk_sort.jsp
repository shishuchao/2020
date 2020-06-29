<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML>
<html>
	<title>风险管理--风险评估--风险排序列表</title>
	<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<link href="<%=request.getContextPath()%>/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>  
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script> 
	<script type="text/javascript">
		var editFlag = undefined;
		var g1;
		$(function(){
			var bodyW = $('body').width();    
			var currentYear = '${currentYear}';
			//var riskevaluate_id = "${riskevaluate_id}";
			var evaluateCompany = "${evaluateCompany}";
			frloadOpen();
			g1 = new createQDatagrid({
				// 表格dom对象，必填
				gridObject:$('#sortTable')[0],
				// 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
				boName:'RiskEvaluateWait',
				// 对象主键,删除数据时使用-默认为“id”；必填
				pkName:'id',
				whereSql: 'riskEvaluateTaskId in (select formId from RiskEvaluateTask where status=\'3\') and evaluateYear=\''+ currentYear +'\'',
				winWidth:800,
				winHeight:250,
				order:'desc',
				sort:'sumScore',
				gridJson:{    
					checkOnSelect:true,
					selectOnCheck:false,
					singleSelect:false,
					//pageSize:20,
					onLoadSuccess:frloadClose,
					/* toolbar:[{   
						text:'设置应对策略',
					    iconCls:'icon-edit2',
					    handler:function(a){
					    }
					}] , */
					frozenColumns:[[{field:'id', title:'选择', hidden:true, align:'center', show:'false'}, 
									{field:'evaluateSerialNum', title:'编号', align:'center', show:'true'}, 
									{field:'evaluateYear', title:'年度', align:'center', show:'true'},
									{field:'evaluateCompanyName', title:'所属单位', width:bodyW*0.1 + 'px', align:'left',halign:'center', sortable:true, show:'true' ,oper:'eq'},
									{field:'responsibilityDepName', title:'责任部门', width:bodyW*0.1 + 'px', align:'left',halign:'center', sortable:true, show:'true', oper:'eq'},
									{field:'riskFatherSortName', title:'风险大类', hidden:true, width:bodyW*0.06 + 'px', align:'center', show:'false'},
									{field:'riskSonSortName', title:'风险子类', hidden:true, width:bodyW*0.06 + 'px', align:'center', show:'false'},
									{field:'riskItemName', title:'风险事项', width:bodyW*0.1 + 'px', align:'left', halign:'center',sortable:true, show:'true', oper:'eq',
				            	    	formatter: function(value, rowData, rowIndex) {
				            		    	url = '${contextPath}/riskManagement/management/riskSort/viewRiskEvaluateSort.action?id=' + rowData.id + '&riskEvaluateTaskId='+rowData.riskEvaluateTaskId;
			            			    	return '<a style=\'cursor:pointer;color:blue;\' href=\'#\' onclick="viewBasicInfo(\'' + url + '\')">'+rowData.riskItemName+'</a>';
			            		   
				            	    	}
									}]],
					columns:[[
						{field:'sumScore', title:'综合得分', width:bodyW*0.08 + 'px', align:'center', sortable:true, show:'false', oper:'eq'},
						{field:'riskLevel', title:'风险等级', width:bodyW*0.08 + 'px', align:'center', sortable:true, show:'true', oper:'eq',
							formatter:function(value,rowData,rowIndex){
								if(rowData.riskLevel == '0') {
									return "无风险";
								} else if(rowData.riskLevel == '1'){
									return "低风险";
								} else if(rowData.riskLevel == '2'){
									return "中风险";
								} else if(rowData.riskLevel == '3'){
									return "高风险";
								}
							}  
						},
						{field:'possibleScore', title:'可能性得分', width:bodyW*0.08 + 'px', align:'center', sortable:true, show:'false', oper:'eq'},
						{field:'affectScore', title:'影响程度得分', width:bodyW*0.08 + 'px', align:'center', sortable:true, show:'false', oper:'eq'},
						{field:'answerPlotName', title:'应对策略', width:bodyW*0.1 + 'px', align:'center', sortable:true, show:'true', oper:'eq'},
						{field:'prioritySort', title:'优先顺序', align:'center', sortable:true, show:'true', oper:'eq',
							formatter:function(value,rowData,rowIndex){
								if(rowData.prioritySort == '0') {
									return "低";
								} else if(rowData.prioritySort == '1'){
									return "中";
								} else if(rowData.prioritySort == '2'){
									return "高";
								} 
							}  
						},
						{field:'operation',width:bodyW*0.075 + 'px',title:'操作', align:'center', sortable:false, show:'false', oper:'eq',
			            	   formatter: function(value, rowData, rowIndex) {
			            		   var url = '${contextPath}/riskManagement/management/riskSort/editRiskSort.action?id=' + rowData.id;
			            		   if(rowData.status == '2')
		            			  	 	return '<a href=\'#\' onclick="edit(\'' + url + '\')">设置应对策略</a>';
		            			   else{
		            				   url += '&view=Y';
		            				   return '<a href=\'#\' onclick="edit(\'' + url + '\')">查看应对策略</a>';
		            			  }
			            	   }
			               }
					]],
				}
			});	
			g1.batchSetBtn([
				{'index':1, 'display':false},  
				{'index':2, 'display':true}, 
				{'index':3, 'display':false}, //导出到excel
				{'index':4, 'display':false}, //查询
				{'index':5, 'display':false},
				{'index':6, 'display':false}, 
				{'index':7, 'display':false},
				{'index':8, 'display':false}  //刷新
			]);
			
			//单元格tooltip提示
			$('#sortTable').datagrid('doCellTip', {
				position : 'bottom',
				maxWidth : '200px',
				tipStyler : {
					'backgroundColor' : '#EFF5FF',
					borderColor : '#95B8E7',
					boxShadow : '1px 1px 3px #292929'
				}
			});
		});

		function edit(url) {
			aud$openNewTab('设置应对策略',url,true);
		}
		
		function viewBasicInfo(url) {
			aud$openNewTab('风险基本信息',url,true);
		}
		
		function refresh() {
			$('#sortTable').datagrid('reload');
		}

	</script>
	</head>
	<body>
		<div id="container" class='easyui-layout' fit='true'>	
			<div region="center">   	 	
				<table id='sortTable'></table>
			</div>
		</div>
		<!-- 自定义查询条件  -->
		<select id="query_year" name="query_year" style='width:130px; display:none;'></select>
		<select id="query_tradePlate" name="query_tradePlate" style='width:130px; display:none;'></select>
		<!-- ajax请求前后提示 -->
		<jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
	</body>
</html>
