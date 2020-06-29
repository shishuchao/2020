<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML>
<html>
	<title>风险排序-风险策略-评估风险列表</title>
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
		$(function(){
			var bodyW = $('body').width();    
			var riskevaluate_id = "${riskevaluate_id}";
			var riskEvaluate = "${riskEvaluate}";
			frloadOpen();
			var g1 = new createQDatagrid({
				// 表格dom对象，必填
				gridObject:$('#waitTable')[0],
				// 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
				boName:'RiskEvaluateWait',
				// 对象主键,删除数据时使用-默认为“id”；必填
				pkName:'id',
				whereSql: 'riskEvaluateTaskId = \''+riskevaluate_id+'\'',
				winWidth:800,
				winHeight:250,
				gridJson:{    
					checkOnSelect:false,
					selectOnCheck:false,
					singleSelect:false,
					onLoadSuccess:frloadClose,
					toolbar:[] ,
					columns:[[
						/* {field:'id', title:'选择', checkbox:true, align:'center', show:'false'},  */
						{field:'evaluateSerialNum', title:'评估任务编号', align:'center', show:'true'}, 
						{field:'riskFatherSortName', title:'风险大类', width:bodyW*0.08 + 'px', align:'center', show:'true'},
						{field:'riskSonSortName', title:'风险子类', width:bodyW*0.08 + 'px', align:'center', show:'true'},
						{field:'riskItemName', title:'风险事项', width:bodyW*0.08 + 'px', align:'center', sortable:true, show:'true', oper:'eq'},
						{field:'riskDescription', title:'风险描述', width:bodyW*0.16 + 'px', align:'center', sortable:true, show:'true', oper:'eq'},
						{field:'responsibilityDepName', title:'责任部门', width:bodyW*0.1 + 'px', align:'center', sortable:true, show:'true', oper:'eq'},
						{field:'possibleScore', title:'可能性得分', width:bodyW*0.08 + 'px', align:'center', sortable:true, show:'true', oper:'eq'},
						{field:'affectScore', title:'影响程度得分', width:bodyW*0.08 + 'px', align:'center', sortable:true, show:'true', oper:'eq'},
						{field:'sumScore', title:'综合得分', width:bodyW*0.08 + 'px', align:'center', sortable:true, show:'true', oper:'eq'},
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
						{field:'operation', title:'操作', width:bodyW*0.1 + 'px', align:'center', sortable:false, show:'false',
							formatter:function(value,rowData,rowIndex){
								if(rowData.id != '') {
									//return "<a href='#' onclick=\"evaluate('" + riskEvaluate + "')\">评估</a>";
									//return "<a href='#' onclick=\"evaluateSure(\'"+rowData.id+"\',\'"+riskEvaluate+"\')\">确认审核</a>";
									var url = '${contextPath}/riskManagement/management/riskSort/viewListRiskSortDetail.action?riskEvaluateWaitId='+rowData.id;
				            	    return '<a href=\'#\' onclick="viewRiskEvaluateSort(\'' + url + '\')">查看</a>';
								} else {
									return '';
								}
							}   
						}
					]],
				}
			});	
			g1.batchSetBtn([
				{'index':1, 'display':false},
				{'index':2, 'display':false},
				{'index':3, 'display':true},
				{'index':4, 'display':false},
				{'index':5, 'display':true},
				{'index':6, 'display':false},
				{'index':7, 'display':false},
				{'index':8, 'display':false}
			]);
		});

		//确认审核
		/* function evaluateSure(riskWaitId,riskEvaluate) {
			
			var url = "${contextPath}/riskManagement/management/riskEvaluate/editRiskEvaluateSure.action?riskEvaluate="+riskEvaluate+"&riskWaitId="+riskWaitId;
        	window.parent.parent.addTab('tabs','确认审核','editWin',url,true);
        	return false;
		} */
		
		function viewRiskEvaluateSort(url) {
			aud$openNewTab('评估结果明细',url,true);
		}

	</script>
	</head>
	<body>
		<div id="container" class='easyui-layout' fit='true'>	
			<div region="center">   	 	
				<table id='waitTable'></table>
			</div>
		</div>
		<!-- 自定义查询条件  -->
		<select id="query_year" name="query_year" style='width:130px; display:none;'></select>
		<select id="query_tradePlate" name="query_tradePlate" style='width:130px; display:none;'></select>
		<!-- ajax请求前后提示 -->
		<jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
	</body>
</html>
