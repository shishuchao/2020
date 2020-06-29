<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML >
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>项目执行情况统计</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<link href="${contextPath}/styles/main/aisCommon.css" rel="stylesheet" type="text/css">
	<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
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
	<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script>
	<link href="${contextPath}/styles/jquery.multiSelect.css" rel="stylesheet" type="text/css">
	<script type='text/javascript' src='${contextPath}/scripts/jquery.multiSelect.js'></script>
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
		<div id="proSituation" class="searchWindow">
			<div class="search_head" id="">
			<s:form id="searchForm" action="multiDemensionProject" namespace="/project" method="post">
				<table id="searchTable" cellpadding=0 border=0 class="ListTable" align="center">
					<tr>
						<td align="left" class="EditHead">查询期间：</td>
						<td align="left" class="editTd">
							<input type="text" class="easyui-datebox noborder" id="pro_starttime" name="wpd.pro_starttime" style="width:39%">
							-
							<input type="text" class="easyui-datebox noborder" id="pro_starttime" name="wpd.pro_endtime" style="width:39%">
						</td>
						<td align="left" class="EditHead">项目来源：</td>
						<td align="left" class="editTd">
							<select multiple="multiple" id="proSource1" editable="false">
								<option value="">&nbsp;</option>
								<s:iterator value='#@java.util.LinkedHashMap@{"inner":"内部项目","outter":"外部项目"}'>
									<option value="${key}">${value}</option>
								</s:iterator>
				  			</select>
				  			<input type="hidden" id="proSource" name="wpd.proSource"/>
						</td>
					</tr>
					<tr>
						<td align="left" class="EditHead">审计单位：</td>
						<td align="left" class="editTd">
							<s:buttonText2 id="audit_dept_name"  cssClass="noborder"
								name="wpd.audit_dept_name" cssStyle="width:70%"
								hiddenId="audit_dept" hiddenName="wpd.audit_dept"
								doubleOnclick="showSysTree(this,
										{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
										   param:{
												'p_item':1,
											     'orgtype':1
										},
										  title:'请选择审计单位',
										   checkbox:true
										})"
								doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
								doubleCssStyle="cursor:hand;border:0" readonly="true" />
						</td>
						<td align="left" class="EditHead">被审计单位：</td>
						<td align="left" class="editTd">
							<s:buttonText2 cssStyle="width:70%;" hiddenId="audit_object" cssClass="noborder"
								id="audit_object_name" name="wpd.audit_object_name"
								hiddenName="wpd.audit_object"
								doubleOnclick="showSysTree(this,{url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
																  param:{'departmentId':'${magOrganization.fid}'},
																  cache:false,
																  checkbox:true,
																  title:'请选择被审计单位'
																})"
								doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
								doubleCssStyle="cursor:hand;border:0" readonly="true"
								title="被审计单位" maxlength="1500" />
						</td>
					</tr>
					<tr>
						<td align="left" class="EditHead">项目年度：</td> 
						<td align="left" class="editTd">
				  			<select id="w_plan_year" class="easyui-combobox" name="wpd.w_plan_year" editable="false" style="width:72%" panelHeight="auto">
						       <option value="">&nbsp;</option>
						       <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,10)" id="entry">
						         <option value="<s:property value="key"/>"><s:property value="value"/></option>
						       </s:iterator>
						    </select> 
						</td>
						<td align="left" class="EditHead">项目类别：</td>
						<td align="left" class="editTd">
							<select multiple="multiple" id="pro_type1" editable="false" class="noborder">
								<option value="">&nbsp;</option>
								<s:iterator value="basicUtil.PlanProjectTypeMap4Zhongjian.keySet()" id="entry">
						        	<option value="<s:property value="code"/>"><s:property value="name"/></option>
						       </s:iterator>
				  			</select>
				  			<input type="hidden" id="pro_type" name="wpd.pro_type"/>
						</td>
							
					</tr>
				</table>
			</s:form>
			</div>
			<div class="serch_foot">
		        <div class="search_btn">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
					<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="resetDoubtList()">重置</a>
					<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="$('#proSituation').window('close')">取消</a>
				</div>
			</div>
		</div>
		<div region="center">
			<table id="dataList"></table>
			<div id="buttonDiv" align="right" style="width: 97%">
				<s:if test="${baseHelper.totalRows>0}">
					<input id="exportButton" type="button" value="导出" onclick="showPopWin('${contextPath}/pages/project/start/countColumnSelector.jsp',500,350)"/>
				</s:if>
			</div>
		</div>
		<div id="proName" title="项目作业信息" style="overflow:hidden;padding:0px">
			<iframe id="showProName" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
		</div>	
		<div id="commonPage"></div>
		<script type="text/javascript">
			function execExport(){
				document.getElementById("searchForm").action="multiDemensionProject.action?querySource=grid&isExport=y";
				document.getElementById("searchForm").submit();
			}
			
			//重置查询条件
			function resetDoubtList(){
				resetForm('searchForm');
				doSearch();
			}
			
			//查询
			function doSearch(){
				showOrHide();
	        	$('#dataList').datagrid({
	    			queryParams:form2Json('searchForm')
	    		});
	    		$('#proSituation').window('close');
	        }
			
			function showOrHide() {
				var proSource = $('#proSource').val();
				if(proSource != '') {
					$('#dataList').datagrid('showColumn','proSource');
				} else {
					$('#dataList').datagrid('hideColumn','proSource');
				}
				
				var audit_dept_name = $('#audit_dept_name').val();
				if(audit_dept_name != ''){
					$('#dataList').datagrid('showColumn','audit_dept_name');
				}else{
					$('#dataList').datagrid('hideColumn','audit_dept_name');
				}
				
				var audit_object_name = $('#audit_object_name').val();
				if(audit_object_name != '') {
					$('#dataList').datagrid('showColumn','audit_object_name');
				} else {
					$('#dataList').datagrid('hideColumn','audit_object_name');
				}
				
				var pro_type = $('#pro_type').val();
				if(pro_type != '') {
					$('#dataList').datagrid('showColumn','pro_type_name');
				} else {
					$('#dataList').datagrid('hideColumn','pro_type_name');
				}
				
				var w_plan_year = $('#w_plan_year').combobox('getValue');
				if(w_plan_year != '') {
					$('#dataList').datagrid('showColumn','w_plan_year');
				} else {
					$('#dataList').datagrid('hideColumn','w_plan_year');
				}
			}
			
			function openNew(typeName, key) {
				var url = '${contextPath}/project/displayDetail.action?key=' + key.replaceAll('#', ',');
				aud$openNewTab(typeName, url ,false);
			}
			
			$(function(){
				var bodyW = $('body').width();
				//查询
				showWin('commonPage','公用弹窗页面');
				showWin('proSituation');
				loadSelectH();
				// 初始化生成表格
				$('#dataList').datagrid({
					url : "<%=request.getContextPath()%>/project/multiDemensionProject.action?querySource=grid",
					method:'post',
					showFooter:false,
					rownumbers:true,
					pagination:false,
					striped:true,
					autoRowHeight:false,
					fit: true,
					pageSize:20,
					fitColumns: false,
					idField:'id',
					border:false,
					singleSelect:true,
					remoteSort: false,
					toolbar:[{
								id:'searchObj',
								text:'查询',
								iconCls:'icon-search',
								handler:function(){
									searchWindShow('proSituation',900,310);
								}
							},
							{
								id:'toWord',
								text:'导出',
								iconCls:'icon-export',
								handler:function(){
									execExport();
								}
							}],
					columns:[[
						{field:'proSource',
								title:'项目来源',
								width:bodyW * 0.1 + 'px',
								halign:'center',
								align:'left',
								sortable:true,
								hidden:true,
								formatter:function(value,rowData,rowIndex){
									if(value == 'inner')
										return '内部项目';
									else
										return '外部项目';
								}
						},
						{field:'audit_dept_name',
								title:'审计单位',
								width:bodyW * 0.1 + 'px',
								halign:'center',
								align:'left', 
								sortable:true,
								hidden:true
						},
						{field:'audit_object_name',
							 title:'被审计单位',
							 width:bodyW * 0.1 + 'px',
							 halign:'center',
							 align:'left', 
							 sortable:true,
							 hidden:true
						},						
						{field:'w_plan_year',
							 title:'项目年度',
							 width:bodyW * 0.1 + 'px',
							 halign:'center',
							 align:'center', 
							 sortable:true,
							 hidden:true,
						},
						{field:'pro_type_name',
							 title:'项目类别',
							 width:bodyW * 0.1 + 'px',
							 halign:'center',
							 align:'center', 
							 sortable:true,
							 hidden:true,
						},
						{field:'planTotal',
							 title:'项目计划总数',
							 width:bodyW * 0.08 + 'px',
							 halign:'center',
							 align:'center', 
							 sortable:true,
							 formatter:function(value,rowData,rowIndex){
								 if(value == null) {
									 return '0';
								 }else{
									 var url = '<a href="javascript:;" onclick="openNew(\'项目计划总数\',\''+rowData.planTotalKey+'\')">'+value+'</a>';
									 return url;
								 }
							 }
						},
						{field:'schedulePlanNum',
							 title:'排程计划数',
							 width:bodyW * 0.08 + 'px',
							 halign:'center',
							 align:'center', 
							 sortable:true,
							 formatter:function(value,rowData,rowIndex){
								 if(value == null) {
									 return '0';
								 }else{
									 var url = '<a href="javascript:;" onclick="openNew(\'排程计划数\',\''+rowData.schedulePlanNumKey+'\')">'+value+'</a>';
									 return url;
								 }
							 }
						},
						{field:'startPlanNum',
							 title:'项目启动数',
							 width:bodyW * 0.08 + 'px',
							 halign:'center',
							 align:'center', 
							 sortable:true,
							 formatter:function(value,rowData,rowIndex){
								 if(value == null) {
									 return '0';
								 }else{
									 var url = '<a href="javascript:;" onclick="openNew(\'项目启动数\',\''+rowData.startPlanNumKey+'\')">'+value+'</a>';
									 return url;
								 }
							 }
						},
						{field:'runningPlanNum',
							 title:'在审项目数',
							 width:bodyW * 0.08 + 'px',
							 halign:'center',
							 align:'center', 
							 sortable:true,
							 formatter:function(value,rowData,rowIndex){
								 if(value == null) {
									 return '0';
								 }else{
									 var url = '<a href="javascript:;" onclick="openNew(\'在审项目数\',\''+rowData.runningPlanNumKey+'\')">'+value+'</a>';
									 return url;
								 }
							 }
						},
						{field:'closedPlanNum',
							 title:'已审项目数',
							 width:bodyW * 0.08 + 'px',
							 halign:'center',
							 align:'center', 
							 sortable:true,
							 formatter:function(value,rowData,rowIndex){
								 if(value == null) {
									 return '0';
								 }else{
									 var url = '<a href="javascript:;" onclick="openNew(\'已审项目数\',\''+rowData.closedPlanNumKey+'\')">'+value+'</a>';
									 return url;
								 }
							 }
						},
						{field:'planNum01',
							 title:'有管理建议书的项目数',
							 width:bodyW * 0.11 + 'px',
							 halign:'center',
							 align:'center', 
							 sortable:true,
							 formatter:function(value,rowData,rowIndex){
								 if(value == null) {
									 return '0';
								 }else{
									 var url = '<a href="javascript:;" onclick="openNew(\'有管理建议书的项目数\',\''+rowData.planNum01Key+'\')">'+value+'</a>';
									 return url;
								 }
							 }
						},
						{field:'planNum02',
							 title:'未提交审计整改方案的项目数',
							 width:bodyW * 0.11 + 'px',
							 halign:'center',
							 align:'center', 
							 sortable:true,
							 formatter:function(value,rowData,rowIndex){
								 if(value == null) {
									 return '0';
								 }else{
									 var url = '<a href="javascript:;" onclick="openNew(\'未提交审计整改方案的项目数\',\''+rowData.planNum02Key+'\')">'+value+'</a>';
									 return url;
								 }
							 }
						},
						{field:'planNum03',
							 title:'质量抽检数量',
							 width:bodyW * 0.11 + 'px',
							 halign:'center',
							 align:'center', 
							 sortable:true,
							 formatter:function(value,rowData,rowIndex){
								 if(value == null) {
									 return '0';
								 }else{
									 var url = '<a href="javascript:;" onclick="openNew(\'质量抽检数量\',\''+rowData.planNum03Key+'\')">'+value+'</a>';
									 return url;
								 }
							 }
						}
					]]   
				}); 
				
				$("#proSource1").multiSelect({ 
					selectAll: false,
					oneOrMoreSelected: '*',
					selectAllText: '全选',
					noneSelected: '',
					listWidth:'200'
				}, function(){   //回调函数
					$('#proSource').attr('name','wpd.proSource').val($("#proSource1").selectedValuesString());
				});
				
				$("#pro_type1").multiSelect({ 
					selectAll: false,
					oneOrMoreSelected: '*',
					selectAllText: '全选',
					noneSelected: '',
					listWidth:'200'
				}, function(){   //回调函数
					$('#pro_type').attr('name','wpd.pro_type').val($("#pro_type1").selectedValuesString());
				});
			});
			function proName(id,stage){
				window.open(
						'${contextPath}/project/prepare/projectIndex.action?crudId='
								+ id + '&stage=' + stage + '&source=view&projectview=view&isView=2&view=view', '',
								'height=700px, width=1300px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
			}
			$('#proName').window({
				width:950,
				height:450,
				modal:true,
				fit:true,
				collapsible:false,
				maximizable:true,
				minimizable:false,
				closed:true
			});
			function toWord(){
				var url = '${contextPath}/pages/project/start/countColumnSelector.jsp';
				showWinIf('commonPage',url,'选择窗口',530,400);
			}	
		</script>
	</body>
</html>
							