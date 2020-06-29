<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@page import="com.opensymphony.xwork2.ActionContext"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>风险评估任务实施列表</title>
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
		<div id="dlgSearch" class="easyui-dialog" title="查询条件" modal="true" closed="true" draggable="true"  style="width:700px;height:300px;overflow:hidden">
			<div class="panel layout-panel layout-panel-center" style="width: 686px; left: 6px; top: 30px;">
			<div region="center" title="" class="panel-body panel-body-noheader layout-body" style="width: 684px; height: 234px;">
				<s:form id="selectForm" name="selectForm" action="listRiskEvaluatesImplement" namespace="/riskManagement/management/riskImplement">
				<table id="planTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr >
						<td class="EditHead">
							任务名称
						</td>
						<td class="editTd" >
							<s:textfield cssClass="noborder" name="riskEvaluateTask.taskName" cssStyle="width:80%"  maxlength="50" />
						</td>
						<td class="EditHead" style="width:15%">
							任务编号
						</td>
						<td class="editTd" style="width:35%">
							<s:textfield cssClass="noborder" name="riskEvaluateTask.serial_num" cssStyle="width:80%" maxlength="50"   />
						</td>
					</tr>
					<tr class="listtablehead" height="23">
						<td class="EditHead">
							任务年度
						</td>
						<td class="editTd">
						    <select class="easyui-combobox" name="riskEvaluateTask.evaluateYear" id="pro_year" style="width:150px;"  editable="false">
					        	<option value="">请选择</option>
					        	<s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,5)" id="entry">
					        		<option value="<s:property value="key"/>"><s:property value="value"/></option>
					    		</s:iterator>
					    	</select>
						</td>
						<td class="EditHead" style="width:15%">
							评估单位
						</td>
						<td class="editTd" style="width:35%">
							<s:textfield cssClass="noborder" name="riskEvaluateTask.evaluateCompanyName" cssStyle="width:80%" maxlength="50"   />
						</td>
					</tr>
					<tr height="23">
						<td class="EditHead" style="width:15%">
							评估部门
						</td>
						<td class="editTd" style="width:35%">
							<s:textfield cssClass="noborder" name="riskEvaluateTask.evaluateDepartmentName" cssStyle="width:80%" maxlength="50"   />
						</td>
						<td class="EditHead" style="width:15%">
							评估状态
						</td>
						<%-- <td class="editTd" style="width:35%">
						    <select class="easyui-combobox" name="riskEvaluate.status" style="width:80%" editable="false">
						       <option value="">&nbsp;</option>
						       <s:iterator value="@ais.riskEvaluate.constants.riskEvaluateState@riskEvaluateStateCodeNameMap" id="entry">
						         <option value="<s:property value="key"/>"><s:property value="value"/></option>
						       </s:iterator>
						    </select>
						</td> --%>
						<td class="editTd" style="width:35%">
						    <select class="easyui-combobox" name="riskEvaluateTask.status" style="width:80%" editable="false">
						       <option value="">&nbsp;</option>
						       <option value="0">待评估</option>
						       <option value="1">评估中</option>
						       <option value="2">已评估</option>
						    </select>
						</td>
					</tr>
					<tr class="listtablehead" height="23">
						<td class="EditHead">
							评估开始时间
						</td>
						<td class="editTd" >
							<input type="text" Class="easyui-datebox noborder" name="riskEvaluateTask.evaluateStartTime" title="单击选择日期"  Style="width:160px;" editable="false" >
						</td>
						<td class="EditHead">
							评估截止时间
						</td>
						<td class="editTd">
							<input type="text" Class="easyui-datebox noborder" name="riskEvaluateTask.evaluateEndTime" title="单击选择日期"  Style="width:160px;" editable="false" >
						</td>
					</tr>
				</table>
			</s:form>
			</div>
			</div>
			<div class="panel layout-panel layout-panel-south" style="width: 686px; left: 6px; top: 266px;">
			<div region="south" border="false" style="text-align: right; padding-right: 20px; width: 666px; height: 26px;" title="" class="panel-body panel-body-noheader panel-body-noborder layout-body">
				<div style="display: inline;" align="right">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
				</div>
			</div>
			</div>
	    </div>
	    <div region="center" >
			<table id="resultList"></table>
		</div>
		<!-- <div id="planName" title="项目信息" style="overflow:hidden;padding:0px">
			<iframe id="showPlanName" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
		</div> -->

		<script type="text/javascript">
	       
			function freshGrid(){
				$('#dlgSearch').dialog('open');
			}
			/*
			* 查询
			*/
			function doSearch(){
	        	$('#resultList').datagrid({
	    			queryParams:form2Json('selectForm')
	    		});
				$('#dlgSearch').dialog('close');
	        }
	        /*
			* 取消
			*/
			function doCancel(){
				$('#dlgSearch').dialog('close');
			}
			/**
				重置
			*/	
			function restal(){
				resetForm('selectForm');
				//doSearch();
			}
			
			/*
				评估任务
			*/
			function riskEvaluate(id){
				var url ="${contextPath}/riskManagement/management/riskImplement/riskEvaluateTaskDetail.action?id="+id;
				aud$openNewTab('评估任务执行', url);
			}
			
			function viewRiskEvaluate(id){
				var url ="${contextPath}/riskManagement/management/riskImplement/riskEvaluateTaskDetail.action?view=Y&id="+id;
				aud$openNewTab('评估任务查看', url);
			}
		
			/* function planName(id){
				var viewUrl = "${contextPath}/plan/detail/view.action?crudId="+id;
				$('#showPlanName').attr("src",viewUrl);
				$('#planName').window('open');
			}
			$('#planName').window({
				width:950, 
				height:450,  
				modal:true,
				collapsible:false,
				maximizable:true,
				minimizable:false,
				closed:true    
			}); */
			
			$(function(){
			    // 初始化生成表格
				$('#resultList').datagrid({
					url : "<%=request.getContextPath()%>/riskManagement/management/riskImplement/listRiskEvaluatesImplement.action?querySource=grid",
					method:'post',
					showFooter:false,
					rownumbers:true,
					pagination:true,
					striped:true,
					autoRowHeight:false,
					fit: true,
					pageSize: 20,
    				fitColumns:false,
					idField:'id',	
					border:false,
					singleSelect:true,
					remoteSort: false,
					toolbar:[{
							id:'search',
							text:'查询',
							iconCls:'icon-search',
							handler:function(){
								freshGrid();
							}
						}
					],
					frozenColumns:[[
					       			{field:'serial_num',title:'编号',width:'150px',sortable:true,halign:'center',align:'center'},
					       			{field:'evaluateYear',title:'年度',width:'100px',sortable:true,halign:'center',align:'center'}
					    		]],
					columns:[[  
						{field:'taskName',
								title:'评估任务名称',
								width:250,
								halign:'center',
								align:'left', 
								sortable:true
						},
						{field:'evaluateCompanyName',
							title:'评估单位',
							width:'150px',
							sortable:true,
							align:'left',
							halign:'center'
						},
						{field:'evaluateDepartmentName',
							title:'评估部门',
							width:'250px',
							sortable:true,
							align:'left',
							halign:'center'
						},
						{field:'evaluateStartTime',
							title:'评估开始时间',
							width:'150px',
							sortable:true, 
							align:'center',
							hidden:true
						},
						{field:'evaluateEndTime',
							title:'评估截止时间',
							width:'150px',
							sortable:true,
							align:'center',
							hidden:true
						},
						{field:'status',
							 title:'评估状态',
							 width:'100px', 
							 align:'center', 
							 sortable:true,
							 formatter:function (value,row,rowIndex){
							 	var status =row.status;
								if(status == 0){
									return '待评估';
								}else if(status == 1){
									return '评估中';
								}else if(status == 2){
									return '已评估';
								}else{
									return '已确认';
								}
							}
						},
						{field:'operate',
							 title:'操作',
							 align:'center', 
							 width:'150px',
							 sortable:false,
							 formatter:function(value,row,index){
								 if(row.status == '1') {
									 var evaluated;
									 $.ajax({
										url:'${contextPath}/riskManagement/management/riskImplement/isEvaluated.action',
										type:'POST',
										async:false,
										data:{'formId':row.formId,'single':'Y'},
										success:function(data) {
											evaluated = data;
										}
									 });
									 if(evaluated == '1')
										 return '<a href=\"javascript:void(0)\" onclick=\"viewRiskEvaluate(\''+row.formId+'\',\''+row.status+'\');\">查看</a>';
									 else
									     return '<a href=\"javascript:void(0)\" onclick=\"riskEvaluate(\''+row.formId+'\',\''+row.status+'\');\">评估</a>';
								 } else
									return '<a href=\"javascript:void(0)\" onclick=\"viewRiskEvaluate(\''+row.formId+'\',\''+row.status+'\');\">查看</a>';
							 }
						}
					]]   
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