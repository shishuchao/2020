<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML>
<html>
	<title>风险评估任务下发--待评估风险列表</title>
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
			var serial_num = "${serial_num}";
			frloadOpen();
			var g1 = new createQDatagrid({
				// 表格dom对象，必填
				gridObject:$('#waitTable')[0],
				// 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
				boName:'RiskEvaluateWait',
				// 对象主键,删除数据时使用-默认为“id”；必填
				pkName:'id',
				whereSql: 'evaluateSerialNum = \''+serial_num+'\'',
				winWidth:800,
				winHeight:250,
				gridJson:{    
					checkOnSelect:true,
					selectOnCheck:false,
					singleSelect:false,
					onLoadSuccess:frloadClose,
					toolbar:[{            	
                     	text:'选择风险事项',
                    	iconCls:'icon-add',
                    	handler:function () {
                    		var id = $("#risk_type_selected" ,window.parent.document).val();
                    		var riskevaluate_id = $("#id" ,window.parent.document).val();
                    		//var url='${contextPath}/riskManagement/management/riskCollect/editRiskCollectTask.action';
                    		//2017-03-24 14:45版本
                    		//var url = "${contextPath}/riskManagement/management/riskEvaluate/main.action?templateId="+id+"&riskevaluate_id="+riskevaluate_id;
                    		var url = "${contextPath}/riskManagement/management/riskEvaluate/riskEvaluateTaskFrame.action?templateId="+id+"&riskevaluate_id="+riskevaluate_id;
                    		aud$openNewTab('选择风险事项',url);
                    	}
					}] ,
					columns:[[
						{field:'id', title:'选择', checkbox:true, align:'center', show:'false'}, 
						{field:'evaluateSerialNum', title:'评估任务编号', width:bodyW*0.1 + 'px', align:'center', show:'true'}, 
						{field:'riskFatherSortName', title:'风险大类', width:bodyW*0.16 + 'px', align:'center', show:'true'},
						{field:'riskSonSortName', title:'风险子类', width:bodyW*0.16 + 'px', align:'center', show:'true'},
						{field:'riskItemName', title:'风险事项', width:bodyW*0.16 + 'px', align:'center', sortable:true, show:'true', oper:'eq'},
						{field:'riskDescription', title:'风险描述', width:bodyW*0.16 + 'px', align:'center', sortable:true, show:'true', oper:'eq'},
						{field:'responsibilityDepName', title:'责任部门', width:bodyW*0.16 + 'px', align:'center', sortable:true, show:'true', oper:'eq'}
					]],
				}
			});	
			g1.batchSetBtn([
				{'index':1, 'display':true},
				{'index':2, 'display':true},
				{'index':3, 'display':false},
				{'index':4, 'display':false},
				{'index':5, 'display':false},
				{'index':6, 'display':false},
				{'index':7, 'display':false},
				{'index':8, 'display':false}
			]);
			
			window.waitTable = g1;
		});

		function evaluate(id) {
			var url = "${contextPath}/riskManagement/knowledgeBase/riskTemplate/main.action?templateId="+id;
        	window.parent.parent.addTab('tabs','修改风险库','editWin',url,true);
        	return false;
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
