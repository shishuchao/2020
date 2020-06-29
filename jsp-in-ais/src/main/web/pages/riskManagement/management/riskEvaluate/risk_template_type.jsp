<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>		   
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>风险维护事项概要信息修改</title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
	<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/easyui/contextmenu.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/autosize.js"></script>
	<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
</head>
<body class="easyui-layout" border="0">
	<div region="north" border="0" style="height:180px; overflow:auto;">
		<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
			<tr>
				<td class="EditHead" style="width: 20%">
					编号
				</td>
				<td class="editTd" colspan="3">
					<s:textfield cssClass="noborder" name="riskTaskTemplate.taskCode" id="riskTaskTemplate.taskCode"/>
				</td>
			</tr>
			<tr>
				<td class="EditHead">
					<font color="red">*</font>&nbsp;名称
				</td>
				<td class="editTd" colspan=3>
					<s:textfield cssClass="noborder" name="riskTaskTemplate.taskName" id="riskTaskTemplate.taskName"/>
				</td>
			</tr>
			<tr style='display:none;'>
				<td class="EditHead">
					<font color="red">*</font>&nbsp;事项序号
				</td>
				<td class="editTd" colspan="4">
					<s:textfield name="riskTaskTemplate.taskOrder" cssClass="noborder" maxlength="10" cssStyle='width:150px;'/>
				</td>
			</tr>
			<tr>
				<td class="EditHead">
					描述
				</td>
				<td class="editTd" colspan="4">
					<s:textarea cssClass="noborder" name="riskTaskTemplate.riskDescription" cssStyle="width:100%;overflow-y:hidden"/>
				</td>
			</tr>
		</table>
		<s:hidden name="riskTaskTemplate.taskId" />
		<s:hidden name="riskTaskTemplate.templateId" />
		<s:hidden name="riskTaskTemplate.taskPid" />
		<s:hidden name="riskTaskTemplate.taskPcode" />
		<s:hidden name="riskTaskTemplate.template_type" value="1" />
		<s:hidden name="templateId" />
		<s:hidden name="taskId" />
		<s:hidden name="type" />
		<s:hidden name="pro_id" />
		<s:hidden name="path" />
		<s:hidden name="node" />
		<s:hidden id="riskevaluate_id" value="${riskevaluate_id}"></s:hidden>
	</div>
	<div region="center" border="0">
		<table id="listTaskDiv" ></table>
	</div>
	<div id="addType_div" ></div>
	<div id="addLeaf_div" ></div>
</body>
	<script>
	 	$(function(){
/* 	 		 var parentTabId = '${parentTabId}';
	 		 var curTabId = aud$getActiveTabId(); */
			// 初始化生成表格
			$('#listTaskDiv').datagrid({
				url : "<%=request.getContextPath()%>/riskManagement/management/riskEvaluate/showContentTypeViewByUi.action?taskId=${taskId}&riskevaluate_id=${riskevaluate_id}",
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination: false,
				striped:true,
				autoRowHeight:false,
				fit: true,
				fitColumns: false,
				idField:'taskId',	
				border:false,
				remoteSort: false,
				singleSelect:false,
		    	checkOnSelect:true,
		    	selectOnCheck:true,
		    	toolbar:[{
					 text:'保存',
					 iconCls:'icon-save',
					 handler:function() {
						 saveRiskWait();
					 }
				 }/* ,'-',{
					 text:'关闭',
					 iconCls:'icon-cancel',
					 handler:function() {
						 var frameWin = aud$getTabIframByTabId(parentTabId);
						 var winIframe = frameWin.$('#gridRisk').get(0).contentWindow;
						 winIframe.waitTable.refresh();
						 aud$closeTab(curTabId, parentTabId);
					 }
				 } */],
				 frozenColumns:[[
									{field:'taskId',
										checkbox:true, 
										width:'120',
										halign:'center', 
										align:'center', 
										sortable:true
									},
									{field:'riskDivision',
										title:'风险大类',
										width:'15%',
										halign:'center',
										align:'center', 
										sortable:true
									}, 
									{field:'riskClass',
										title:'风险子类',
										width:'15%',
										sortable:true, 
										align:'center'
									},
									{field:'taskName',
										title:'风险事项',
										width:'15%', 
										align:'center', 
										sortable:true
										}
								]],
								columns:[[  
									
									{field:'affiliatedDeptName',
										title:'所属单位',
										width:'20%', 
										align:'left', 
										sortable:true
									},
									{field:'majorDutyDeptName',
										title:'主责部门',
										width:'20%', 
										align:'left', 
										sortable:false
									},
									{field:'riskDescription',
										title:'风险描述',
										width:'20%', 
										align:'left', 
										sortable:false
									}
								]] 
  
			}); 
		});
	 	
	 	var isSelected = true;
	    // 保存风险事项到待评估风险表
	    function saveRiskWait(){
	    	
	   	 	var parentTabId = '${parentTabId}';
		 	var curTabId = aud$getActiveTabId();
	    	var rows = $('#listTaskDiv').datagrid('getChecked');
	        if (rows && rows.length > 0){
		    	top.$.messager.confirm('提示信息','确定选择这些风险事项吗？',function(isSelected){
		    		if(isSelected){
		    			var riskIdArr = [];
		    			var riskevaluate_id = $('#riskevaluate_id').val();
		                $.each(rows, function(i, row){
		                	riskIdArr.push(row.taskId);
		                });
		                $.ajax({
		                    dataType:'json',
		                    url : "<%=request.getContextPath()%>/riskManagement/management/riskEvaluate/batchSaveRiskWait.action",
		                    data: {ids:riskIdArr.join(","),riskevaluate_id:riskevaluate_id},
		                    type: "post",
		                    success: function(data){
		                        showMessage1(data.msg);	
								var frameWin = aud$getTabIframByTabId(parentTabId);
								var winIframe = frameWin.$('#gridRisk').get(0).contentWindow;
								winIframe.waitTable.refresh();
								aud$closeTab(curTabId, parentTabId);					
		                    },
		                    error:function(data){
		                        showMessage1('请求失败,请检查网络是否通畅或者与管理员联系！');
		                    }
		                });
		    		}
		    	});
		    }else{
	            showMessage1('请选择要添加的记录！');
	        }
	    }
	</script>
</html>
