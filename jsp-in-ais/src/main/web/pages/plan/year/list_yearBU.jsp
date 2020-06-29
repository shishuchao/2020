<!DOCTYPE HTML>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>年度计划列表</title>
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
		<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<%--		<STYLE type="text/css">
			.datagrid-row {
			  	height: 30px;
			}
			.datagrid-cell {
				height:10%;
				padding:1px;
			}
		</STYLE>--%>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<div id="dlgSearch" class="searchWindow">
			<div class="search_head">
					<s:form id="searchForm" name="searchForm" action="listAllBU" namespace="/plan/year" method="post">
						<s:token/>
						<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
							<tr >
								<td class="EditHead" >计划状态</td>
								<td class="editTd">
								    <select class="easyui-combobox" name="crudObject.status" editable="false">
								       <option value="">请选择</option>
								       <s:iterator value="@ais.plan.constants.PlanState@yearplanStateNameCodeMap" id="entry">
								         <option value="<s:property value="key"/>"><s:property value="value"/></option>
								       </s:iterator>
								    </select>
								</td>
								<td id="w_charge_number_name" class="EditHead" style="width:15%;">计划编号</td>
								<td class="editTd" style="width:35%;" ><s:textfield cssClass="noborder" cssStyle="width:80%;"  name="crudObject.w_plan_code" maxlength="50" /></td>
							</tr>
							<tr>
								<td class="EditHead">计划年度</td>
								<td class="editTd">
							        <select id="w_plan_year" class="easyui-combobox" name="crudObject.w_plan_year" editable="false">
								       <option value="">请选择</option>
								       <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,9)" id="entry">
							             <option value="<s:property value='key'/>"><s:property value='value'/></option>
								       </s:iterator>
								    </select> 
							    </td>
							    <td id="w_charge_name" class="EditHead" style="width:15%;">计划名称</td>
								<td class="editTd" style="width:35%;"><s:textfield cssClass="noborder" cssStyle="width:80%;" name="crudObject.w_plan_name" maxlength="50" /></td>
							</tr>
<%--							<tr>
								<td class="EditHead">审计单位</td>
								<td class="editTd">
									<s:buttonText2 cssClass="noborder" cssStyle="width:80%;" id="crudObject.audit_dept_name" readonly="true" name="crudObject.audit_dept_name" hiddenName="crudObject.audit_dept" hiddenId="crudObject.audit_dept" doubleOnclick="showSysTree(this,
												{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action?p_item=1&orgtype=1',
												  title:'请选择审计单位'
												})" doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png" doubleCssStyle="cursor:pointer;border:0" maxlength="50" />
								</td>
								<td class="EditHead">计划管理员</td>
								<td class="editTd">
									 <s:buttonText2 cssClass="noborder" id="w_charge_person_name"
												name="crudObject.w_charge_person_name" cssStyle="width:80%;"
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
							</tr>--%>
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
		<div region="center" border='0'>
			<table id="yearList"></table>
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
				// doSearch();
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
			
			function planName(id, w_plan_name){
				var viewUrl = "${contextPath}/plan/year/viewBU.action?selectedTab=yearDetailListDiv&crudId="+id;
				aud$openNewTab( w_plan_name,viewUrl,false);
			}
			
			$(function(){
				var bodyW = $('body').width();
				//查询
				showWin('dlgSearch');
				var d = new Date();
				loadSelectH();
				$('#w_plan_year').combobox('setValue',d.getFullYear());
				// 初始化生成表格
				$('#yearList').datagrid({
					url : "<%=request.getContextPath()%>/plan/year/listAllBU.action?querySource=grid&t="+new Date().getTime() ,
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
					remoteSort: true,
					toolbar:[{
							id:'search',
							text:'查询',
							iconCls:'icon-search',
							handler:function(){
								searchWindShow('dlgSearch',750);
							}
						},'-',helpBtn
					],
					onLoadSuccess:function(){
						initHelpBtn();
					},
					columns:[[
						{field:'status_name',title:'计划状态',sortable:true,halign:'center',align:'left',width:0.06*bodyW+'px'},
						{field:'w_plan_name',
							title:'计划名称',
							width:0.25*bodyW+'px',
							halign:'center',
							align:'left',
							sortable:true,
							formatter:function(value,rowData,rowIndex){
								return '<a href=\"javascript:void(0)\" onclick=\"planName(\''+rowData.formId+'\',\''+rowData.w_plan_name+'\');\">'+value+'</a>';
							}
						},
						{field:'w_plan_code',title:'计划编号',width:0.1*bodyW+'px',sortable:true,halign:'center',align:'left'},
						{field:'w_plan_year',
							title:'计划年度',
							sortable:true, 
							halign:'center',
							align:'center',
							width:0.1*bodyW+'px'
						},
						{field:'audit_dept_name',
							 title:'审计单位',
							 width:0.2*bodyW+'px',
							 halign:'center',
							 align:'left', 
							 sortable:true
						},
						{field:'w_charge_person_name',
							 title:'计划管理员',
							 halign:'center',
							 align:'left',
							 sortable:true,
							width:0.1*bodyW+'px'
						}
					]]   
				});
				//单元格tooltip提示
				$('#yearList').datagrid('doCellTip', {
					onlyShowInterrupt:true,
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