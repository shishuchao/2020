<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML>
<html>
	<title>风险评估结果确认审核--待评估风险列表--确认审核列表</title>
	<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
	<link href="<%=request.getContextPath()%>/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>  
	<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/common.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script> 
	<style type="text/css">
        .subtotal { font-weight: bold; }/*合计单元格样式*/
    </style>
	<script type="text/javascript">
		var editFlag = undefined;
		$(function(){
			var bodyW = $('body').width();    
			//var riskevaluate_id = "${riskevaluate_id}";
			//var riskEvaluate = "${riskEvaluate}";
			var riskEvaluateWaitId = "${riskEvaluateWaitId}";
			//frloadOpen();
			var g1 = new createQDatagrid({
				// 表格dom对象，必填
				gridObject:$('#waitTable')[0],
				// 要进行检索的表对象(hibernate bean)名称， 进行拼接hql时使用; 必填
				boName:'RiskEvaluateDetail',
				// 对象主键,删除数据时使用-默认为“id”；必填
				pkName:'id',
				whereSql: 'riskEvaluateWaitId = \''+riskEvaluateWaitId+'\'',
				winWidth:800,
				winHeight:250,
				gridJson:{    
					checkOnSelect:false,
					selectOnCheck:false,
					singleSelect:false,
					fitColumns: true, //自适应列宽
					showFooter:true,
					pagination:false,
					//onLoadSuccess:frloadClose,
					toolbar:[{  
								text: '确认',
								iconCls: 'icon-ok',
								handler: function () {  
									$("#waitTable").datagrid('endEdit', editFlag);  
									//使用JSON序列化datarow对象，发送到后台。  
									var rows = $("#waitTable").datagrid('getChanges');
									var rowstr = JSON.stringify(rows);  
									$.ajax({
										url:'${contextPath}/riskManagement/management/riskEvaluate/saveRiskModulus.action',
										async:false,
										type:'POST',
										data:{'rowstr':rowstr},
										success:function(data) {
											if(data == '1') {
												showMessage1('保存成功！');
											}
										}
									});
								} 
							}] ,
					columns:[[
						/* {field:'id', title:'选择',rowspan:2, checkbox:true, align:'center', show:'false'}, */ 
						{field:'company', title:'评估单位',rowspan:2, align:'center', show:'true'}, 
						{field:'department', title:'评估部门',rowspan:2, width:bodyW*0.08 + 'px', align:'center', show:'true'},
						{field:'evaluatePersonName', title:'评估人',rowspan:2, width:bodyW*0.08 + 'px', align:'center', show:'true'},
						{field:'evaluateDate', title:'评估时间',rowspan:2, width:bodyW*0.08 + 'px', align:'center', sortable:true, show:'true', oper:'eq'},
						{title:'原始得分',colspan:3},
						{title:'最终得分（如需调整，请直接调整）',colspan:3},
						{field:'evaluatePersonModulus', title:'权重',rowspan:2, width:bodyW*0.08 + 'px', align:'center', sortable:true, show:'true', oper:'eq'},
						{field:'riskLevel', title:'风险等级',rowspan:2, width:bodyW*0.08 + 'px', align:'center', sortable:true, show:'true', oper:'eq',
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
						}],
						[
							{field:'possibleScore', title:'可能性得分',rowspan:1, width:bodyW*0.08 + 'px', align:'center', show:'true'},
							{field:'affectScore', title:'影响程度得分',rowspan:1, width:bodyW*0.08 + 'px', align:'center', show:'true'},
							{field:'sumScore', title:'综合得分',rowspan:1, width:bodyW*0.08 + 'px', align:'center', show:'true'},
							{field:'surePossibleScore', title:'可能性得分',rowspan:1, width:bodyW*0.08 + 'px', align:'center', show:'true',
								editor: {//设置其为可编辑
									type: 'text',
									options:{ required : true}
								}
							},
							{field:'sureAffectScore', title:'影响程度得分',rowspan:1, width:bodyW*0.08 + 'px', align:'center', show:'true',
								editor: {//设置其为可编辑
									type: 'text',
									options:{ required : true}
								}
							},
							{field:'sureSumScore', title:'综合得分',rowspan:1, width:bodyW*0.08 + 'px', align:'center', show:'true',
								editor: {//设置其为可编辑
									type: 'text',
									options:{ required : true}
								}
							},
						]
					],
					onAfterEdit: function (rowIndex, rowData, changes) {//在添加完毕endEdit，保存时触发
						editFlag = undefined;//重置
					}, 
					onDblClickCell: function (rowIndex, field, value) {//双击该行修改内容
						if (editFlag != undefined) {
							$("#waitTable").datagrid('endEdit', editFlag);//结束编辑，传入之前编辑的行
						}
						if (editFlag == undefined) {
							$("#waitTable").datagrid('beginEdit', rowIndex);//开启编辑并传入要编辑的行
							editFlag = rowIndex;
						}
					}
					/* onLoadSuccess: function () {
			        	//添加“合计”列
			      		$('#waitTable').datagrid('appendRow', {
			      			company: '',
			      			department: '加权得分',
			      			evaluatePersonName: '',
			      			evaluateDate: '',
			      			possibleScore: ' +compute("possibleScore","evaluatePersonModulus")+ ',  //可能性
			      			affectScore: ' +compute("affectScore","evaluatePersonModulus")+ ',    //影响程度
			      			sumScore: '',       //综合
			      			surePossibleScore: ' +compute("surePossibleScore","evaluatePersonModulus")+ ', //确认可能性
			      			sureAffectScore: ' +compute("sureAffectScore","evaluatePersonModulus")+ ',   //确认影响程度
			      			sureSumScore: '',     //确认综合
			      			evaluatePersonModulus: '',
			      			riskLevel: '0',						
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
			      		});
				    } */
				}
			});	
			g1.batchSetBtn([
				{'index':1, 'display':true},
				{'index':2, 'display':false},
				{'index':3, 'display':false},
				{'index':4, 'display':false},
				{'index':5, 'display':false},
				{'index':6, 'display':false},
				{'index':7, 'display':false},
				{'index':8, 'display':false}
			]);
		});
		
	    //指定列求和
	    function compute(colName1,colName2) {
	    	var rows = $('#waitTable').datagrid('getRows');
	        var total = 0;
	        for (var i = 0; i < rows.length; i++) {
	        	total += parseLong((rows[i][colName1])*(rows[i][colName2]));
	      	}
	      	return total;
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
