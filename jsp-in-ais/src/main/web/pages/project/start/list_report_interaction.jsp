<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML >
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>计划执行情况</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>  
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" /> 
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
		
		<script type="text/javascript">
			
			/*
			* DisplayTag添加顶层Header
			*/
			function addTopTableHeader(){
		
				var listTable = document.getElementById('row');
				var tableHead = listTable.firstChild;
				
				var newHeaderTr = tableHead.insertRow(0);
				
				var cellOne = newHeaderTr.insertCell();
				cellOne.innerHTML = '计划信息';
				cellOne.colSpan = 16;
				cellOne.style.textAlign = 'center';
				cellOne.style.fontWeight = 'bold';
				
				/* var cellTwo = newHeaderTr.insertCell();
				cellTwo.colSpan = 2;
				cellTwo.innerHTML='变动信息';
				cellTwo.style.textAlign = 'center';
				cellTwo.style.fontWeight = 'bold';
	
				var cellThree = newHeaderTr.insertCell();
				cellThree.colSpan = 2;
				cellThree.innerHTML='立项信息';
				cellThree.style.textAlign = 'center';
				cellThree.style.fontWeight = 'bold';
	*/
				var cellFour = newHeaderTr.insertCell();
				cellFour.colSpan = 5;
				cellFour.innerHTML='执行信息';
				cellFour.style.textAlign = 'center';
				cellFour.style.fontWeight = 'bold';
				
			}
			//addTopTableHeader();
			/*
			*  打开或关闭查询面板
			*/
			function triggerSearchTable(){
				var isDisplay = document.getElementById('planTable').style.display;
				if(isDisplay==''){
					document.getElementById('planTable').style.display='none';
				}else{
					document.getElementById('planTable').style.display='';
				}
			}		
			
		</script>
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	<div id="dlgSearch" class="easyui-dialog" title="查询条件" modal="true" closed="true" draggable="true"  style="width:700px;height:300px;overflow:hidden">
		<div class="panel layout-panel layout-panel-center" style="width: 686px; left: 6px; top: 30px;">
		<div region="center" title="" class="panel-body panel-body-noheader layout-body" style="width: 684px; height: 234px;">
			<s:form action="projectReportInteraction" namespace="/project/start" id="projectReportInteraction">
				<table id="planTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable" >
					<tr >						
						<td align="left" class="EditHead" style="width:15%">项目编号</td>
						<td align="left" class="editTd" style="width:35%">
							<s:textfield cssClass="noborder" name="pso.project_code" cssStyle="width:80%;" />
						</td>
						<td align="left" class="EditHead" style="width:15%">项目名称:</td>
						<td align="left" class="editTd" style="width:35%">
							<s:textfield cssClass="noborder" name="pso.project_name" cssStyle="width:80%;" />
						</td>
					</tr>
					
					<tr>	
						<td align="left" class="EditHead">计划类别</td>
						<td align="left" class="editTd">
							<select class="easyui-combobox" name="pso.plan_type_name" style="width:80%;" panelHeight="auto">
						   	   	<option value="">&nbsp;</option>
									<s:iterator value="@ais.project.ProjectUtil@getYearTypeList()" id="yeartype">
						       	<option value="<s:property value="key"/>"><s:property value="value"/></option></s:iterator>
							</select>
						</td>
						<td align="left" class="EditHead">项目年度</td>
						<td align="left" class="editTd"  >
							<select class="easyui-combobox" id="pro_year" name="pso.pro_year" style="width:80%;" panelHeight="auto">
						   	    <option value="">&nbsp;</option>
						      	 <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,5)" id="status">
								<s:if test="${status.key==dataday}">
						       		 <option selected="selected" value="<s:property value="key"/>"><s:property value="value"/></option>
						       	</s:if>
						       	<s:else>
						        	 <option value="<s:property value="key"/>"><s:property value="value"/></option>
						         </s:else>
						       </s:iterator>
						    </select>
						</td>
					</tr>
					<tr >
						<td align="left" class="EditHead">审计单位</td>
						<td align="left" class="editTd">
							<s:buttonText2 id="pso.audit_dept_name" cssClass="noborder"
								name="pso.audit_dept_name" cssStyle="width:80%;"
								hiddenName="pso.audit_dept" hiddenId="pso.audit_dept"
								doubleOnclick="showSysTree(this,
									{ url:'${contextPath}/systemnew/orgListByAsyn.action',
									  title:'请选择审计单位',
									  param:{
	                                    'p_item':1,
	                                    'orgtype':1
	                                  }
									})"
								doubleSrc="${contextPath}/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0" readonly="true"
								doubleDisabled="false" maxlength="100" />
						</td>
						<td align="left" class="EditHead">被审计单位</td>
						<td align="left" class="editTd">
							<s:buttonText2 id="pso.audit_object_name" cssClass="noborder"
								name="pso.audit_object_name" cssStyle="width:80%;"
								hiddenName="pso.audit_object" hiddenId="pso.audit_object"
								doubleOnclick="showSysTree(this,
									{ url:'${contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
									  title:'请选择被审计单位',
									  param:{
	                                    'p_item':1,
	                                    'orgtype':1
	                                  }
									})"
								doubleSrc="${contextPath}/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0" readonly="true"
								doubleDisabled="false" maxlength="100" />
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

	<script type="text/javascript">
	        function freshGrid(){
				$('#dlgSearch').dialog('open');
			}
			/*
			* 查询
			*/
			function doSearch(){
	        	$('#resultList').datagrid({
	    			queryParams:form2Json('projectReportInteraction')
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
				resetForm('projectReportInteraction');
				//doSearch();
			}
			
			

		$(function(){
			var d = new Date();
			$('#pro_year').combobox('setValue',d.getFullYear());
			$('#resultList').datagrid({
				url : "<%=request.getContextPath()%>/project/start/projectReportInteraction.action?querySource=grid",
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit:true,
				pageSize: 20,
				fitColumns:false,
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
				       			{field:'is_closed',
				       			title:'状态',
				       			halign:'center',
				       			align:'left',
				       			sortable:true,
				       			formatter:function(value,row,rowIndex){
				       				if (row.pso.is_closed == "closed") {
				       				    return "关闭";
				       				} else {
				       				    return "正在执行";
				       				}
					            }},
				       			{field:'project_code',
				       			title:'项目编号',
				       			width:'280px',
				       			halign:'center',
				       			sortable:true,
				       			align:'left',
				       			formatter:function(value,row,rowIndex){
									return row.pso.project_code;
					            }},
				    		]],
				columns:[[  
					{field:'project_name',
							title:'项目名称',
							width:200,
							align:'left', 
							sortable:true,
							formatter:function(value,row,rowIndex){
								return '<a href="/ais/project/prepare/projectIndex.action?crudId='+row.pso.formId+'&view=view&projectview=view&isView=2&source=view" target="_blank">'+row.pso.project_name+'</a>'
								
					}},
					{field:'plan_type_name',
						 title:'计划类别',
						 halign:'center',
						 align:'left', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
								return row.pso.plan_type_name;
								
					}},
					{field:'pro_year',
						 title:'年度',
						 halign:'center',
						 align:'right', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
								return row.pso.pro_year;
								
					}},
					{field:'month',
						 title:'月度',
						 halign:'center',
						 align:'right', 
						 sortable:true
					},
					{field:'excute_month',
						 title:'执行月度',
						 halign:'center',
						 align:'right', 
						 sortable:true
					},
					{field:'plan_grade_name',
						 title:'计划等级',
						 halign:'center', 
						 align:'left', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
								return row.pso.plan_grade_name;
								
					}},
					{field:'pro_type_child_name',
						 title:'项目类别',
						 width:200, 
						 halign:'center',
						 align:'left', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
								return row.pso.pro_type_child_name;
								
					}},
					{field:'pro_type_child_name',
						 title:'项目子类别',
						 width:200, 
						 halign:'center',
						 align:'left', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
								return row.pso.pro_type_child_name;
								
					}},
					{field:'audit_dept_name',
						 title:'审计单位',
						 width:200, 
						 halign:'center',
						 align:'left', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
								return row.pso.audit_dept_name;
								
					}},
					{field:'audit_object_name',
						 title:'被审计单位',
						 width:200, 
						 halign:'center',
						 align:'left', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
								return row.pso.audit_object_name;
								
					}},
					{field:'audit_start_time',
						 title:'审计期间（起）',
						 halign:'center',
						 align:'right', 
						 sortable:true,
						 formatter:function(value,row,rowIndedx){
							if(row.pso.audit_start_time != null){
								return row.pso.audit_start_time.substring(0,10);
							}
						 }
					},
					{field:'audit_end_time',
						 title:'审计期间（止）',
						 halign:'center',
						 align:'right', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
							if(row.pso.audit_end_time!=null){
								return row.pso.audit_end_time.substring(0,10);
							}
						 }
					},
					{field:'currentStageName',
						 title:'执行阶段',
						 halign:'center',
						 align:'left', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
							 if(row.pso.currentStageName != null){
							 	return row.pso.currentStageName;
							 }
						 }
					}
					,
					{field:'real_start_time',
						 title:'启动日期',
						 halign:'center',
						 align:'right', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
								if(row.pso.real_start_time != null){
									return row.pso.real_start_time.substring(0,10);
								}	
						 }
					},{field:'real_closed_time',
						 title:'关闭日期',
						 halign:'center',
						 align:'right', 
						 sortable:true,
						 formatter:function(value,row,rowIndex){
						 	if(row.pso.real_closed_time != null){
							 	return row.pso.real_closed_time.substring(0,10);
							 }
						 }
					}
				
				]]   
			}); 
		});
			
			</script>
		
		
		
	</body>
</html>