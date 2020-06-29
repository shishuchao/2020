<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@page import="com.opensymphony.xwork2.ActionContext"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>风险评估任务结果审核列表</title>
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
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/tlInteractive/tlInteractiveCommon.js"></script>
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
			<table id="waitTable"></table>
		</div>
		<script type="text/javascript">
		var editFlag = undefined;
			
			/*
				确认审核
			*/
			function riskEvaluateSure(id){
				window.location.href="/ais/riskManagement/management/riskEvaluate/riskEvaluateSureTaskDetail.action?id="+id;
			}
			
			$(function(){
				var bodyW = $('body').width();
				var riskEvaluateWaitId = '${riskEvaluateWaitId}';
			    // 初始化生成表格
				$('#waitTable').datagrid({
					url : "<%=request.getContextPath()%>/riskManagement/management/riskEvaluate/listRiskWaitSureDetail.action?querySource=grid&riskEvaluateWaitId="+riskEvaluateWaitId,
					method:'post',
					showFooter:true,
					rownumbers:true,
					pagination:false,
					striped:true,
					autoRowHeight:false,
					fit: true,
					//pageSize: 20,
    				fitColumns:false,
					idField:'id',	
					border:false,
					singleSelect:true,
					remoteSort: false,
					toolbar:[
					   <s:if test="isView != 'Y'">
					   {  
						text: '保存',
						iconCls: 'icon-save',
						handler: function () {  
							$("#waitTable").datagrid('endEdit', editFlag);  
							//使用JSON序列化datarow对象，发送到后台。  
							var rows = $("#waitTable").datagrid('getChanges');
							var rowstr = JSON.stringify(rows);  
							$.ajax({
								url:'${contextPath}/riskManagement/management/riskEvaluate/saveRiskEvaluateDetail.action',
								async:false,
								type:'POST',
								data:{'rowstr':rowstr},
								success:function(data) {
									if(data == '1') {
										showMessage1('保存成功！');
										$('#waitTable').datagrid('reload');
									}
								}
							});
						} 
					},'-',
					{  
						text: '确认',
						iconCls: 'icon-ok',
						handler: function () {  
							$("#waitTable").datagrid('endEdit', editFlag);  
							//使用JSON序列化datarow对象，发送到后台。  
							var rows = $("#waitTable").datagrid('getRows');
							var rowstr = JSON.stringify(rows);  
							$.ajax({
								url:'${contextPath}/riskManagement/management/riskEvaluate/submitRiskEvaluateDetail.action?rrs_id=${rrs_id}',
								async:false,
								type:'POST',
								data:{'rowstr':rowstr},
								success:function(data) {
									if(data == '1') {
										showMessage1('确认成功！');
										parent.closeWindow();
									}
								}
							});
						} 
					}
					</s:if>
					] ,
					frozenColumns:[[
					    ]],
					columns:[[
						{field:'id', title:'选择',rowspan:2, checkbox:true, align:'center', show:'false', hidden:true}, 
						{field:'company', title:'评估单位',rowspan:2, align:'center', show:'true'}, 
						{field:'department', title:'评估部门',rowspan:2, width:bodyW*0.08 + 'px', align:'center', show:'true'},
						{field:'evaluatePersonName', title:'评估人',rowspan:2, width:bodyW*0.08 + 'px', align:'center', show:'true'},
						{field:'evaluateDate', title:'评估时间',rowspan:2, width:bodyW*0.08 + 'px', align:'center', sortable:true, show:'true', oper:'eq',
                            formatter:function(value,row,rowIndex){
                                if(row.evaluateDate!=null){
                                    return row.evaluateDate.substring(0, 10);
                                }
                            }
						},
						{title:'原始得分',colspan:3},
						{title:'最终得分（如需调整，请直接调整）',colspan:3},
						{field:'evaluatePersonModulus', title:'权重',rowspan:2, width:bodyW*0.05 + 'px', align:'center', sortable:true, show:'true', oper:'eq'},
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
							{field:'sureSumScore', title:'综合得分',rowspan:1, width:bodyW*0.08 + 'px', align:'center', show:'true'}
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
				});

				//单元格tooltip提示
				$('#resultList').datagrid('doCellTip', {
					position : 'bottom',
					maxWidth : '200px',
					tipStyler : {
						'backgroundColor' : '#EFF5FF',
						borderColor : '#95B8E7',
						boxShadow : '1px 1px 3px #292929'
					}
				});
			});
		</script>
	</body>
</html>