<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>项目台账</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
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
		<div id="dlgSearch" class="searchWindow">
			<div class="search_head">
					<s:form id="searchForm" name="searchForm" action="listAll" namespace="/plan/year" method="post">
						<s:token/>
						<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<%-- 		<tr class="listtablehead">
								<td class="EditHead" >项目编号</td>
										<td class="editTd">
										<s:textfield cssClass="noborder" cssStyle="width:80%;" name="projectStartObject" maxlength="50" />
								</td>
								<td class="EditHead" style="width:15%;">项目名称</td>
								<td class="editTd" style="width:35%;"><s:textfield cssClass="noborder" cssStyle="width:80%;" name="projectStartObject.w_plan_code" maxlength="50" /></td>
							</tr> --%>
			<%-- 				<tr class="listtablehead">
								<td class="EditHead">所属单位</td>
								<td class="editTd">
							        <select id="w_plan_year" class="easyui-combobox" name="projectStartObject.w_plan_year" editable="false">
								       <option value="">&nbsp;</option>
								       <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,5)" id="entry">
							             <option value="<s:property value='key'/>"><s:property value='value'/></option>
								       </s:iterator>
								    </select> 
							    </td>
							    <td class="EditHead" style="width:15%;">项目类别</td>
								<td class="editTd" style="width:35%;"><s:textfield cssClass="noborder" cssStyle="width:80%;" name="projectStartObject.w_plan_name" maxlength="50" /></td>
							</tr> --%>
							<%-- <tr>
								<td class="EditHead">被审计单位</td>
								<td class="editTd">
									<s:buttonText2 cssClass="noborder" cssStyle="width:80%;" id="projectStayrtObject.audit_dept_name" readonly="true" name="projectStartObject.audit_dept_name" hiddenName="projectStartObject.audit_dept" hiddenId="projectStartObject.audit_dept" doubleOnclick="showSysTree(this,
												{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action?p_item=1&orgtype=1',
												  title:'请选择审计单位'
												})" doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png" doubleCssStyle="cursor:pointer;border:0" maxlength="50" />
								</td>
								
								<td class="EditHead">状态</td>
								
								<td class="editTd">
								    <select class="easyui-combobox" name="projectStartObject.status" editable="false">
								       <option value="">&nbsp;</option>
								       <s:iterator value="@ais.plan.constants.PlanState@planStateCodeNameMap" id="entry">
								         <option value="<s:property value="key"/>"><s:property value="value"/></option>
								       </s:iterator>
								    </select>
								</td>
						
							</tr> --%>
	<%-- 						<tr>
							<td class="EditHead">组长</td>
								<td class="editTd">
									 <s:buttonText2 cssClass="noborder" id="w_charge_person_name"
												name="projectStartObject.w_charge_person_name" cssStyle="width:80%;"
												hiddenId="w_charge_person" hiddenName="crudObject.w_charge_person"
												doubleOnclick="showSysTree(this,
												{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action?org=local',
				                                  title:'请选择计划管理员',
				                                  type:'treeAndUser'
												})"
												doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
												doubleCssStyle="cursor:pointer;border:0"
												readonly="true"
												display="${varMap['w_charge_personRead']}"
												doubleDisabled="!(varMap['w_charge_personWrite']==null?true:varMap['w_charge_personWrite'])" /> 
								</td>
								<td class="EditHead">主审</td>
								<td class="editTd">
									 <s:buttonText2 cssClass="noborder" id="w_charge_person_name"
												name="projectStartObject.w_charge_person_name" cssStyle="width:80%;"
												hiddenId="w_charge_person" hiddenName="projectStartObject.w_charge_person"
												doubleOnclick="showSysTree(this,
												{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action?org=local',
				                                  title:'请选择计划管理员',
				                                  type:'treeAndUser'
												})"
												doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
												doubleCssStyle="cursor:pointer;border:0"
												readonly="true"
												display="${varMap['w_charge_personRead']}"
												doubleDisabled="!(varMap['w_charge_personWrite']==null?true:varMap['w_charge_personWrite'])" /> 
								</td>
							</tr> --%>
						</table>
						<s:hidden name="ifFirstQuery" value="no"/>
					</s:form>
			</div>
			<div class="serch_foot">
		        <div class="search_btn">
						<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
						<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>&nbsp;
						<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
				</div>
			</div>	
		</div>
		<div region="center">
			<table id="yearList"></table>
		</div>
		<div id="planName" title="项目信息" style="overflow:hidden;padding:0px">
			<iframe id="showPlanName" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
		</div>
		<script type="text/javascript">
			function freshGrid(){
				$('#dlgSearch').dialog('open');
			}
			/*
			* 查询
			*/
			function doSearch(){
	        	$('#yearList').datagrid({
	    			queryParams:form2Json('searchForm')
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
				resetForm('searchForm');
				doSearch();
			}
			function enterExportPlan(flag){
				var row = $('#yearList').datagrid('getSelected');
				if(row!=null){
					 var yearPlanId = row.formId;
					 window.open("${contextPath}/plan/year/exportPlan.action?year_plan_id="+yearPlanId+"&plan_flag="+flag);
				}else{
					showMessage1("请先选择需要导出的记录！");
				}
			}
			
			function enterExportWord(){
				var row = $('#yearList').datagrid('getSelected');
				if(row!=null){
					 var yearPlanId = row.formId;
					 window.open("${contextPath}/plan/year/exportPlan!exportWord.action?yearPlanId="+yearPlanId);
				}else{
					showMessage1("请先选择需要导出的记录！");
				}
			   
			}
			/*
				删除选中的单条计划
			*/
			function deleteYearPlan(id,status){
				if(status&&status=='计划草稿'){
					top.$.messager.confirm('提示消息','确定要删除这条年度计划吗?',function(r){
						if(r){
							$.ajax({
								url:'/ais/plan/year/delete.action?crudId='+id,
								type:'get',
								success:function(data){
									showMessage1('删除成功!','',5000,'','');
									$('#yearList').datagrid('reload');
								}
							});
						}
					})
				}else{
					showMessage1("年度计划已经审批或执行，不能删除！");
				}
			}
			/*
				修改选中的单条计划
			*/
			function updateYearPlan(id,status){
				if(status&&status=='计划草稿'){
					window.location.href="/ais/plan/year/edit.action?crudId="+id;
				}else{
					showMessage1("年度计划已经审批或执行，不能修改！");
				}
			}
			function planName(id){
				var viewUrl = "${contextPath}/plan/year/view.action?selectedTab=yearDetailListDiv&crudId="+id;
				$('#showPlanName').attr("src",viewUrl);
				$('#planName').window('open');
			}
			 $('#planName').window({
					width:950, 
					height:450,  
					modal:true,
				 	fit:true,
					collapsible:false,
					maximizable:true,
					minimizable:false,
					closed:true    
			    });
			 function operate1(xm_formId,report_closed,pro_auditleader,pro_teamleader){
				 window.location.href = "${contextPath}/ledger/prjledger/projectLedgerNew/edit.action?crudId='"+xm_formId+"'&rework='"+report_closed+"'&report='"+report_closed+"'&editLedger=1&auditleader='"+pro_auditleader+"'&teamleader='"+pro_teamleader+"'";
			 }
			 function operate2(project_id){
				 window.location.href = "${contextPath}/proledger/custom/createLedgerTabs.action?project_id="+project_id+"&isView=true&isEdit=false";
			 }
			$(function(){
				//查询
				showWin('dlgSearch');
				var d = new Date();
				loadSelectH();
				$('#w_plan_year').combobox('setValue',d.getFullYear());
				// 初始化生成表格
				$('#yearList').datagrid({
					url : "<%=request.getContextPath()%>/ledger/prjledger/projectLedgerNew/listTobeStarted.action?querySource=grid&project_id=${project_id}" ,
					method:'post',
					showFooter:false,
					rownumbers:true,
					pagination:true,
					striped:true,
					autoRowHeight:false,
					fit: true,
					pageSize: 20,
					fitColumns:true,
					idField:'formId',
					border:false,
					singleSelect:true,
					remoteSort: false,
					toolbar:[{
							id:'search',
							text:'查询',
							iconCls:'icon-search',
							handler:function(){
								searchWindShow('dlgSearch',750);
							}
						}
					],
					frozenColumns:[[
					       			{field:'project_code',title:'项目编号',sortable:true,halign:'center',align:'center'},
					       			{field:'project_name',title:'项目名称',width:'200',sortable:true,halign:'center',align:'left'}
					    		]],
					columns:[[  
						{field:'pro_type_name',
								title:'项目类别',
								width:200,
								halign:'center',
								align:'left', 
								sortable:true,
							//	formatter:function(value,rowData,rowIndex){
								//	return '<a href=\"javascript:void(0)\" onclick=\"planName(\''+rowData.formId+'\');\">'+value+'</a>';
									/* return '<a href="${contextPath}/plan/year/view.action?selectedTab=yearDetailListDiv&crudId='+rowData.formId+'" target="_blank" >'+value+'</a>'; */
						  //}
						},
						{field:'xm_auditee',
							title:'所属单位',
							sortable:true, 
							halign:'center',
							align:'center'
						},
						{field:'xm_audi_obj',
							 title:'被审计单位',
							 width:200, 
							 halign:'center',
							 align:'left', 
							 sortable:true
						},
						{field:'pro_teamleader',
							 title:'组长',
							 halign:'center',
							 align:'center',
							 sortable:true
						},
						{field:'pro_auditleader',
							 title:'主审',
							 halign:'center',
							 align:'center',
							 sortable:true
						},
						{field:'state',
							 title:'状态', 
							 halign:'center',
							 align:'center',
							 sortable:true
						},
						{field:'operate',
							 title:'操作',
							 halign:'center',
							 align:'center', 
							 sortable:false,
							 formatter:function(value,row,index){
			                     if(row.flog=='true'||row.flog_teamcharge=='true'||row.flog_auditleadert=='true' || row.flog_ast=='true'){
			                    	 return '<a href=\"javascript:void(0)\" onclick=\"operate1(\''+row.xm_formId+'\',\''+row.report_closed+'\',\''+row.pro_auditleader+'\',\''+row.pro_teamleader+'\');\">处理</a>';
			                          //  document.write("<a href='<s:url action="edit" includeParams="none"></s:url>?crudId=${row[1].formId}&rework=${row[0].report_closed}&report=${row[0].report_closed}&editLedger=1&auditleader=${row[0].pro_auditleader}&teamleader=${row[0].pro_teamleader}'>处理</a>");
			                     }else{
			                    	<%--  //document.write("&nbsp;&nbsp;<a href='<%=request.getContextPath()%>/proledger/problem/listEditProblem.action?project_id=${row[1].xm_formId}&edit=false' target='_blank'>问题统计台账</a>"); --%>
			                     }
			              		return '<a href=\"javascript:void(0)\" onclick=\"operate2(\'${project_id}\');\">台账查看</a>';
			                   <%--  document.write("&nbsp;&nbsp;<a href='<%=request.getContextPath()%>/proledger/custom/createLedgerTabs.action?project_id=${row[1].xm_formId}&isView=true&isEdit=false' target='_blank'>台账查看</a>"); --%>
			              
							 }
						}
					]]   
				});
				//单元格tooltip提示
				$('#yearList').datagrid('doCellTip', {
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