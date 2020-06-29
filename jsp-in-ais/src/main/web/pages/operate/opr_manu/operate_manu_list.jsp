<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>审计底稿列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<div region="north" title="查询条件" data-options="split:false,collapsed:true" style="height:180px;overflow:hidden;">
			<s:form id="searchForm" name="searchForm" action="listAll" namespace="/plan/year" method="post">
				<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr >
						<td class="EditHead">计划状态</td>
						<td class="editTd">
						    <select class="easyui-combobox" name="crudObject.status" style="width:150px;"  editable="false">
						       <option value="">&nbsp;</option>
						       <s:iterator value="@ais.plan.constants.PlanState@planStateCodeNameMap" id="entry">
						         <option value="<s:property value="key"/>"><s:property value="value"/></option>
						       </s:iterator>
						    </select>
						</td>
						<td class="EditHead">计划编号</td>
						<td class="editTd"><s:textfield cssClass="noborder" name="crudObject.w_plan_code" maxlength="50" /></td>
					</tr>
					<tr>
						<td class="EditHead">计划年度</td>
						<td class="editTd">
					        <select id="w_plan_year" class="easyui-combobox" name="crudObject.w_plan_year" style="width:150px;" editable="false">
						       <option value="">&nbsp;</option>
						       <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,5)" id="entry">
					             <option value="<s:property value='key'/>"><s:property value='value'/></option>
						       </s:iterator>
						    </select> 
					    </td>
						<td class="EditHead">计划名称</td>
						<td class="editTd"><s:textfield cssClass="noborder" name="crudObject.w_plan_name" maxlength="50" /><s:hidden name="ifFirstQuery" value="no"/></td>
					</tr>
					<tr>
						<td class="EditHead">审计单位</td>
						<td class="editTd">
							<s:buttonText2 cssClass="noborder" id="crudObject.audit_dept_name" readonly="true" name="crudObject.audit_dept_name" hiddenName="crudObject.audit_dept" hiddenId="crudObject.audit_dept" doubleOnclick="showSysTree(this,
										{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action?p_item=1&orgtype=1',
										  title:'请选择审计单位'
										})" doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png" doubleCssStyle="cursor:pointer;border:0" maxlength="50" />
						</td>
						<td class="EditHead">计划管理员</td>
						<td class="editTd">
							 <s:buttonText2 cssClass="noborder" id="w_charge_person_name"
										name="crudObject.w_charge_person_name" 
										hiddenId="w_charge_person" hiddenName="crudObject.w_charge_person"
										doubleOnclick="showSysTree(this,
										{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action?org=local',
		                                  title:'请选择计划管理员',
		                                  type:'treeAndUser',
		                                  defaultDeptId:'${user.fdepid}',
		                                  defaultUserId:'${user.fname}'
										})"
										doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
										doubleCssStyle="cursor:pointer;border:0"
										readonly="true"
										display="${varMap['w_charge_personRead']}"
										doubleDisabled="!(varMap['w_charge_personWrite']==null?true:varMap['w_charge_personWrite'])" /> 
						</td>
					</tr>
				</table>
			</s:form>
			<div style="text-align:right;padding-right:20px;">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>
			</div>
		</div>
		<div region="center">
			<table id="yearList"></table>
		</div>
		<script type="text/javascript">
		alert('<%=request.getParameter("project_id")%>');
			function doSearch(){
	        	$('#yearList').datagrid({
	    			queryParams:form2Json('searchForm')
	    		});
	        }
	
			function enterExportPlan(flag){
				var row = $('#yearList').datagrid('getSelected');
				if(row!=null){
					 var yearPlanId = row.formId;
					 window.open("${contextPath}/plan/year/exportPlan.action?year_plan_id="+yearPlanId+"&plan_flag="+flag);
				}else{
					$.messager.alert('错误',"请先选择需要导出的记录！",'error');
				}
			}
			
			function enterExportWord(){
				var row = $('#yearList').datagrid('getSelected');
				if(row!=null){
					 var yearPlanId = row.formId;
					 window.open("${contextPath}/plan/year/exportPlan!exportWord.action?yearPlanId="+yearPlanId);
				}else{
					$.messager.alert('错误',"请先选择需要导出的记录！",'error');
				}
			   
			}
			//重置查询条件
			function restal(){
				resetForm('searchForm');
				//doSearch();
			}
			/*
				删除选中的单条计划
			*/
			function deleteYearPlan(id,status){
				if(status&&status=='计划草稿'){
					$.messager.confirm('提示信息','确定要删除这条年度计划吗?',function(r){
						if(r){
							$.ajax({
								url:'/ais/plan/year/delete.action?crudId='+id,
								type:'get',
								success:function(data){
									doSearch();
								}
							});
						}
					})
				}else{
					$.messager.alert('错误',"年度计划已经审批或执行，不能删除！",'error');
				}
			}
			/*
				修改选中的单条计划
			*/
			function updateYearPlan(id,status){
				if(status&&status=='计划草稿'){
					window.location.href="/ais/plan/year/edit.action?crudId="+id;
				}else{
					$.messager.alert('错误',"年度计划已经审批或执行，不能修改！",'error');
				}
			}
			$(function(){
				var d = new Date();
				$('#w_plan_year').combobox('setValue',d.getFullYear());
				// 初始化生成表格
				$('#yearList').datagrid({
					url : "<%=request.getContextPath()%>/operate/manuExt/manuUi.action?querySource=grid&audManuscript.project_id=<%=request.getParameter("project_id")%>",
					method:'post',
					showFooter:false,
					rownumbers:true,
					pagination:true,
					striped:true,
					autoRowHeight:false,
					fit: true,
					fitColumns:false,
					idField:'id',	
					border:false,
					singleSelect:true,
					remoteSort: false,
					toolbar:[{
							id:'newYear',
							text:'新增底稿',
							iconCls:'icon-add',
							handler:function(){
								window.location.href="/ais/plan/year/edit.action";
								/*
								$('#addYearPlan').window({
									title:'新增年度计划',
									href:'/ais/plan/year/edit.action',
									fit:true,
									modal:true,
									minimizable: false,
									maximizable: false,
									shadow: true,
									cache: false,   
									closed: false,
									collapsible: false,
									resizable: false,
									inline: false,
									draggable:false
								});
								*/
							}
						},
						{
							id:'toWord',
							text:'导出Word',
							iconCls:'icon-save',
							handler:function(){
								enterExportWord();
							}
						},
						{
							id:'toExcel',
							text:'导出Excel',
							iconCls:'icon-save',
							handler:function(){
								enterExportPlan('1');
							}
						}
					],
					columns:[[  
		       			{field:'ms_name',title:'底稿名称',width:'100',sortable:true,align:'center'},
		       		/* 	{field:'manuTypeName',title:'底稿类型',width:'200',sortable:true,align:'center'},	 */	
		       			{field:'ms_statusName',title:'底稿名称',width:'100',sortable:true,align:'center'},
		       			{field:'ms_statusName',title:'底稿状态',width:'200',sortable:true,align:'center'},	
		       			{field:'audit_dept_name',title:'被审计单位',width:'100',sortable:true,align:'center'},
		       			{field:'task_name',title:'审计事项',width:'200',sortable:true,align:'center'},	
		       			{field:'ms_author_name',title:'撰写人',width:'100',sortable:true,align:'center'},
		       			{field:'fileCount',title:'附件',width:'200',sortable:true,align:'center'},	
		       			{field:'audit_found',title:'关联疑点',width:'100',sortable:true,align:'center'},
		       			{field:'prom',title:'审计问题数量',width:'200',sortable:true,align:'center'},		
		       			{field:'ms_date',title:'提交日期',width:'100',sortable:true,align:'center'}
					]]   
				}); 
			});
		</script>
	</body>
</html>