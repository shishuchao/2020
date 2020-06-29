<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>年度计划调整</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<%--	<STYLE type="text/css">
		.datagrid-cell {
			height:25px;
		}
		.datagrid-cell-rownumber {
			height:25px;
		}
	</STYLE>--%>
</head>
<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	<div id="dlgSearch" class="searchWindow">
		<div class="search_head">
			<s:form id="searchForm" name="searchForm" action="listAllAdjust!listAllAdjustMain.action" namespace="/plan/year" method="post">
				<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr >
						<td class="EditHead" style="width:15%;">计划状态</td>
						<td class="editTd" style="width:35%;">
						    <select class="easyui-combobox" name="crudObject.status" style="width:80%;"  editable="false">
						       <option value="">请选择</option>
						       <s:iterator value="@ais.plan.constants.PlanState@yearplanStateNameCodeMap" id="entry">
						         <option value="<s:property value="key"/>"><s:property value="value"/></option>
						       </s:iterator>
						    </select>
						</td>
						<td class="EditHead" style="width:15%;">计划编号</td>
						<td class="editTd" style="width:35%;"><s:textfield cssClass="noborder" cssStyle="width:80%;" name="crudObject.w_plan_code" maxlength="50" /></td>
					</tr>
					<tr>
						<td class="EditHead">计划年度</td>
						<td class="editTd">
						    <select id="w_plan_year" class="easyui-combobox" name="crudObject.w_plan_year" style="width:80%;"  editable="false">
						       <option value="">请选择</option>
						       <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,9)" id="entry">
						         <option value="<s:property value="key"/>"><s:property value="value"/></option>
						       </s:iterator>
						    </select>
						</td>
						<td class="EditHead">计划名称</td>
						<td class="editTd"><s:textfield cssClass="noborder" cssStyle="width:80%;" name="crudObject.w_plan_name" maxlength="50" /><s:hidden name="ifFirstQuery" value="no"/></td>
					</tr>
					<%--<tr>
						<td class="EditHead" style="width:15%;">审计单位</td>
						<td class="editTd" colspan="3" style="width:85%;">
							<s:buttonText2 cssClass="noborder" id="crudObject.audit_dept_name" cssStyle="width:32%;"
										readonly="true" name="crudObject.audit_dept_name" hiddenName="crudObject.audit_dept" hiddenId="crudObject.audit_dept" doubleOnclick="showSysTree(this,
										{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action?p_item=1&orgtype=1',
										  title:'请选择审计单位'
										})" doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png" doubleCssStyle="cursor:pointer;border:0" maxlength="50" />
						</td>
					</tr>--%>
				</table>
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
			/* document.getElementById('crudObject.audit_dept_name').value = '${user.fdepname}';
			document.getElementById('crudObject.audit_dept').value = '${user.fdepid}'; */
			/*doSearch();*/
		}
		/*
			调整选中的单条计划
		*/
		function updateYearPlan(crudId){
			window.location.href="/ais/plan/year/edit.action?fromAdjust=yes&crudId="+crudId;

		}

		//查看调整痕迹
		function doViewAdjust(crudId){
			var viewUrl = "${contextPath}/plan/year/listAllAdjust!viewAdjust.action?&crudId="+crudId;
			aud$openNewTab('查看痕迹',viewUrl,false);
		}

		$(function(){
			var bodyW = $('body').width();
			if('${empty crudObject.w_plan_year}'=='true'){
				var d = new Date();
				$('#w_plan_year').combo('setValue',d.getFullYear());
				$('#w_plan_year').combo('setText',d.getFullYear());
			}
			showWin('dlgSearch');
			//showWin('planName','计划基本信息');
			// 初始化生成表格
			$('#yearList').datagrid({
				url : "<%=request.getContextPath()%>/plan/year/listAllAdjust!listAllAdjustMain.action?querySource=grid",
				method:'post',
				showFooter:true,
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
						searchWindShow('dlgSearch');
					}
				},'-',{
					id:'adjust',
					text:'调整',
					iconCls:'icon-edit',
					handler:function(){
						var row = $('#yearList').datagrid('getSelected');
						if(row == null) {
							showMessage1('请选择数据！');
						} else {
							if(row.status_name =='正在执行') {
								updateYearPlan(row.formId);
							} else {
								showMessage1('请选择状态为【正在执行】数据！');
							}
						}
					}
				},'-',{
					id:'viewHis',
					text:'查看痕迹',
					iconCls:'icon-view',
					handler:function(){
						var row = $('#yearList').datagrid('getSelected');
						if(row == null) {
							showMessage1('请选择数据！');
						} else {
							doViewAdjust(row.formId);
						}
					}
				},'-',helpBtn],
				onLoadSuccess:function(){
					initHelpBtn();
				},
				columns:[[
				/*	{field:'formId',title:'选择',checkbox:true},*/
					{field:'status_name',title:'计划状态',halign:'center',sortable:true,align:'left',width:0.06*bodyW+'px'},
					{field:'w_plan_name',
						title:'计划名称',
						width:0.25*bodyW+'px',
						halign:'center',
						align:'left',
						sortable:true,
						formatter:function(value,rowData,rowIndex){
							var result = '<a href="#" onclick="planName(\''+rowData.formId+'\',\''+rowData.w_plan_name+'\')">'+value+'</a>';
							return result;
						}
					},
					{field:'w_plan_code',title:'计划编号',width:0.1*bodyW+'px',sortable:true,halign:'center',align:'left'},
					{field:'w_plan_year',
						title:'计划年度',
						halign:'center',
						align:'center',
						sortable:true,
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
					},
					{field:'w_write_date',
						 title:'操作日期',
						 halign:'center',
						 align:'center',
						 sortable:true,
						hidden:true,
						width:0.1*bodyW+'px',
						 formatter:function(value,row,index){
    						if (!row.editing && value!=null){
    							var v = value.substring(0,10);
								return v;
    						}
    					 }
					}/*,
					{field:'operate',
						 title:'操作',
						 halign:'center',
						 align:'center',
						 sortable:false,
						 formatter:function(value,row,index){
						 	var param = [row.formId];
						 	var btn2 = '${tempNew}' == '1'?"项目填报,projectPlan,"+param.join(','):(row.status_name!='正被审批'?"查看痕迹,doViewAdjust,"+param.join(',')+"-btnrule-调整,updateYearPlan,"+param.join(','):"查看痕迹,doViewAdjust,"+param.join(','));
							return ganerateBtn(btn2);
						 }
					}*/
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
		function planName(id,title){
			var viewUrl = "${contextPath}/plan/year/view.action?fromAdjust=yes&selectedTab=yearDetailListDiv&crudId="+id;
			aud$openNewTab(title,viewUrl,false);
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
        function projectPlan(crudId){
            var url ="${contextPath}//plan/year/statisView.action?tempNew=${tempNew}&fromAdjust=yes&crudId="+crudId;
            aud$openNewTab("项目计划填报",url,false);
        }
	</script>
</body>
</html>