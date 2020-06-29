<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>计划执行情况</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />  
	<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script> 
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>

	<script type="text/javascript">
		function execExport(columns){
			document.getElementById("planReport").action="planReportExport.action?"+columns;
			document.getElementById("planReport").target="_self";
			document.getElementById("planReport").submit();
			document.getElementById("planReport").action="planReport.action";
			document.getElementById("planReport").target="_self";
		}
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
		
		function toWord(){
			//var ids = $('#list_booksList').datagrid('getSelections');
			var url = '${contextPath}/pages/plan/detail/columnSelector.jsp';
			showWinIf('commonPage',url,'选择窗口',530,400);
			//showPopWin('${contextPath}/pages/plan/detail/columnSelector.jsp',500,350);
		}
		function viewPlan(url){
			showWinIf('commonPage',url,'项目计划信息');
		}
	</script>
</head>
<body class="easyui-layout">
		<div id="dlgSearch" class="searchWindow">
			<div class="search_head">
			<s:form action="planReport" namespace="/plan/detail" id="planReport">
				<table id="planTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr>
						<td align="left" class="EditHead" style="width:15%">计划状态</td>
						<td align="left" class="editTd" style="width:35%">
							<select class="easyui-combobox" name="plan.status" panelHeight='auto'>
								<option value="">&nbsp;</option>
								<s:iterator id="key" value="planStateCodeNameMap.keySet()" >
								    <option value="<s:property value='#key'/>"><s:property value='planStateCodeNameMap.get(#key)'/></option>
								</s:iterator>
							</select>
						</td>
						<td align="left" class="EditHead" style="width:15%">计划编号</td>
						<td align="left" class="editTd" style="width:35%">
							<s:textfield name="plan.w_plan_code" cssStyle="width:80%;" maxlength="50"
								cssClass="noborder" />
						</td>
					</tr>
					<tr>
						<td align="left" class="EditHead">计划年度</td>
						<td align="left" class="editTd">
							<select class="easyui-combobox" id="w_plan_year" name="plan.w_plan_year" style="width:80%;">
								<option value="">&nbsp;</option>
								<s:iterator id="key" value="searchYearListMap.keySet()" >
								    <option value="<s:property value='#key'/>"><s:property value='searchYearListMap.get(#key)'/></option>
								</s:iterator>
								<s:iterator id="key" value="searchYearListMap.keySet()">
									<s:if test="${status.key==dataday}">
										<option selected="selected"
											value="<s:property value='#key'/>"><s:property value='searchYearListMap.get(#key)'/>
										</option>
									</s:if>
									<s:else>
										<option value="<s:property value='#key'/>">
											<s:property value='searchYearListMap.get(#key)'/>
										</option>
									</s:else>
								</s:iterator>
							</select>
						</td>
						<td align="left" class="EditHead">计划月度</td>
						<td align="left" class="editTd">
							<!--<s:select cssStyle="width:160px;"  cssClass="easyui-combobox"
						list="{'1','2','3','4','5','6','7','8','9','10','11','12'}"
						name="plan.w_plan_month" theme="ufaud_simple"
						templateDir="/strutsTemplate" emptyOption="true" /> -->
							<select class="easyui-combobox" name="plan.w_plan_month">
								<option value="">&nbsp;</option>
								<s:iterator id="key" value="monthListMap.keySet()" >
								    <option value="<s:property value='#key'/>"><s:property value='monthListMap.get(#key)'/></option>
								</s:iterator>
							</select>
						</td>
					</tr>
					<tr>
						<td align="left" class="EditHead">开始执行月度</td>
						<td align="left" class="editTd">
							<select class="easyui-combobox" name="plan.w_plan_excute_month"
								style="width:80%;">
								<option value="">&nbsp;</option>
								<s:iterator id="key" value="monthListMap.keySet()" >
								    <option value="<s:property value='#key'/>"><s:property value='monthListMap.get(#key)'/></option>
								</s:iterator>
							</select>
						</td>
						<td align="left" class="EditHead">计划类别</td>
						<td align="left" class="editTd">
							<select class="easyui-combobox" name="plan.w_plan_type_name" panelHeight='auto' >
								<option value="">&nbsp;</option>
								<s:iterator id="key" value="yearTypeListMap.keySet()" >
								    <option value="<s:property value='#key'/>"><s:property value='yearTypeListMap.get(#key)'/></option>
								</s:iterator>
							</select>
						</td>
					</tr>
					<tr>
						<td align="left" class="EditHead">审计单位</td>
						<td align="left" class="editTd">
							<s:buttonText2 id="plan.audit_dept_name" cssClass="noborder"
								name="plan.audit_dept_name" cssStyle="width:80%;"
								hiddenName="plan.audit_dept" hiddenId="plan.audit_dept"
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
						<td align="left" class="EditHead">项目组长</td>
						<td align="left" class="editTd">
							<s:buttonText2 id="plan.pro_teamleader_name"
								cssClass="noborder" name="plan.pro_teamleader_name"
								cssStyle="width:80%;" hiddenId="plan.pro_teamleader"
								hiddenName="plan.pro_teamleader"
								doubleOnclick="showSysTree(this,
							{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
                                 title:'请选择负责人',
                                 type:'treeAndEmployee'
                                 
							})"
								doubleSrc="${contextPath}/resources/images/s_search.gif"
								doubleCssStyle="cursor:hand;border:0" readonly="true"
								doubleDisabled="false" maxlength="100" />
						</td>
					</tr>
					<tr>
						<td align="left" class="EditHead" style="width:15%">计划名称</td>
						<td align="left" class="editTd" colspan="3" style="width:85%">
							<s:textfield name="plan.w_plan_name" cssClass="noborder" maxlength="255" />
						</td>
					</tr>
				</table>
			</s:form>
		</div>
		<div class="serch_foot">
		    <div class="search_btn">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search'"
					onclick="doSearch()">查询</a>&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'"
					onclick="restal()">重置</a>&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'"
					onclick="doCancel()">取消</a>
			</div>
		</div>
	</div>
	<div region="center">
		<table id="resultList"></table>
	</div>
	<div id="commonPage"></div>
	<script type="text/javascript">
        function freshGrid(){
			searchWindShow('dlgSearch',750);
		}
		/*
		* 查询
		*/
		function doSearch(){
        	$('#resultList').datagrid({
    			queryParams:form2Json('planReport')
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
			document.getElementsByName("plan.audit_dept_name")[0].value = '';
			document.getElementsByName("plan.pro_teamleader_name")[0].value = '';
			resetForm('planReport');
            $("#w_plan_year").combobox('setValue', ' ');
			// doSearch();
		}
		$(function(){
			showWin('commonPage','公用弹窗页面');
			showWin('dlgSearch');
			var d = new Date();
			$('#w_plan_year').combobox('setValue',d.getFullYear());
			$('#resultList').datagrid({
			url : "<%=request.getContextPath()%>/plan/detail/planReport.action?querySource=grid",
			method: 'post',
			showFooter: false,
			rownumbers: true,
			pagination: true,
			striped: true,
			autoRowHeight: false,
			fit: true,
			pageSize: 20,
			fitColumns: false,
			border: false,
			singleSelect: true,
			remoteSort: false,
			toolbar:[{
					id:'search',
					text:'查询',
					iconCls:'icon-search',
					handler:function(){
						freshGrid();
					}
				},
				{
					id:'toWord',
					text:'导出',
					iconCls:'icon-export',
					handler:function(){
						toWord();
						
					}
				}],
			frozenColumns:[[
			       			{field:'status_name',title:'计划状态',halign:'center', align:'center',sortable:true},
			       			{field:'w_plan_code',title:'计划编号',width:'300px',halign:'left', sortable:true,align:'left'}
			    		]],
			columns:[[  
				{field:'w_plan_name',
						title:'计划名称',
						width:200,
						halign:'center',
						align:'left', 
						sortable:true,
						formatter:function(value,row,rowIndex){
							var url = "${contextPath}/plan/detail/view.action?crudId="+row.formId;
							return "<a href=\"javascript:void(0)\" onclick=\"viewPlan('"+url+"')\">"+row.w_plan_name+"</a>";
				}},
				{field:'w_plan_type_name',
					 title:'计划类别',
					 width:100,
					 halign:'center',
					 align:'center', 
					 sortable:true
				},
				{field:'w_plan_year',
					 title:'计划年度',
					 width:100,
					 halign:'center',
					 align:'center', 
					 sortable:true
				},
				{field:'w_plan_month',
					 title:'计划月度',
					 width:100,
					 align:'center', 
					 halign:'center',
					 sortable:true
				},
				{field:'w_plan_excute_begin',
					 title:'开始执行月度',
					 width:100,
					 align:'center', 
					 halign:'center',
					 sortable:true,
					 formatter:function(value,row,rowIndex) {
						 if(value!=null){
								var date = row.w_plan_excute_begin;
								var time = new Date(date);
								return m = time.getMonth()+1;
						 	}
						 }
				},
				{field:'plan_grade_name',
					 title:'计划等级',
					 width:80,
					 halign:'center',
					 align:'center', 
					 sortable:true
				},
				{field:'pro_type_name',
					 title:'项目类别',
					 width:150, 
					 halign:'center',
					 align:'left', 
					 sortable:true
				},
				{field:'pro_type_child_name',
					 title:'项目子类别',
					 width:150, 
					 halign:'center',
					 align:'left', 
					 sortable:true
				},
				{field:'audit_dept_name',
					 title:'审计单位',
					 width:200,
					 align:'left', 
					 halign:'center',
					 sortable:true
				},
				{field:'audit_object_name',
					 title:'被审计单位',
					 width:200,
					 align:'left', 
					 halign:'center',
					 sortable:true
				},
				{field:'pro_teamcharge_name',
					 title:'负责人',
					 width:100,
					 align:'left', 
					 halign:'center',
					 sortable:true
				},
				{field:'audit_start_time',
					 title:'被审计期间（起）',
					 width:120,
					 align:'center', 
					 halign:'center',
					 sortable:true,
					 formatter:function(value,row,rowIndedx){
						if(value!=null){
							return value.substring(0,10);
						}
					 }
				},
				{field:'audit_end_time',
					 title:'被审计期间（止）',
					 width:120,
					 align:'center', 
					 halign:'center',
					 sortable:true,
					 formatter:function(value,row,rowIndex){
						if(value!=null){
							return value.substring(0,10);
						}
					 }
				},
				{field:'pro_teamleader_name',
					 title:'项目组长',
					 width:100,
					 halign:'center',
					 align:'left', 
					 sortable:true
				},
				{field:'pro_auditleader_name',
					 title:'项目主审',
					 width:100,
					 halign:'center',
					 align:'left', 
					 sortable:true
				},
				{field:'proInfo',
					 title:'执行阶段',
					 width:100,
					 align:'center', 
					 halign:'center',
					 sortable:true,
					 formatter:function(value,row,rowIndex){
						 if(value != null){
							var agename=value.currentStageName;
						 	return agename;
						 	
						 }
					 }
				},
				{field:'pro_starttime',
					 title:'启动日期',
					 width:100,
					 halign:'center',
					 align:'center', 
					 sortable:true,
					 formatter:function(value,row,rowIndex){
							if(value!=null){
								return value.substring(0,10);
							}	
					 }
				},
				{field:'pro_endtime',
					 title:'关闭日期',
					 width:100,
					 halign:'center',
					 align:'center', 
					 sortable:true,
					 formatter:function(value,row,rowIndex){
					 	if(value != null){
						 	return value.substring(0,10);
						 }
					 }
				}
			
			]]   
		}); 
	});
			
	</script>



	</body>
</html>