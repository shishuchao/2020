<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML >
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<title>审计问题多维统计分析</title>
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
			<s:form id="searchForm" action="multiDemensionProblem" namespace="/project" method="post">
				<table id="searchTable" cellpadding=0 border=0 class="ListTable" align="center">
					<tr>
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
						<td class="EditHead">与本单位经营战略相关度</td>
						<td class="editTd">
							<select multiple="multiple" name="ledgerProblem.tacticRelevancy"  id='tacticRelevancy1' editable="false">
								<option value="">&nbsp;</option>
								<s:iterator value='#@java.util.LinkedHashMap@{"高":"高","中":"中","低":"低"}'>
									<option value="${value}">${key}</option>
								</s:iterator>
							</select>
							<input type="hidden" id="tacticRelevancy" name="ledgerProblem.tacticRelevancy"/>
						</td>
					</tr>
					<tr>
						<td class="EditHead">发生频率</td>
						<td class="editTd">
							<select multiple="multiple" editable="false" id="occurrence1">
								<option value="">&nbsp;</option>
								<s:iterator value='#@java.util.LinkedHashMap@{"高":"高","中":"中","低":"低"}'>
									<option value="${value}">${key}</option>
								</s:iterator>
							</select>
							<input type="hidden" id="occurrence" name="ledgerProblem.occurrence"/>
						</td>
						<td class="EditHead">严重程度</td>
						<td class="editTd">
							<select multiple="multiple" editable="false" id="orderOfSeverity1">
								<option value="">&nbsp;</option>
								<s:iterator value='#@java.util.LinkedHashMap@{"高":"高","中":"中","低":"低"}'>
									<option value="${value}">${key}</option>
								</s:iterator>
							</select>
							<input type="hidden" id="orderOfSeverity" name="ledgerProblem.orderOfSeverity"/>
						</td>
					</tr>
					<tr>
						<td align="left" class="EditHead">查询期间：</td>
						<td align="left" class="editTd">
							<input type="text" class="easyui-datebox noborder" id="pro_starttime" name="wpd.pro_starttime" style="width:39%">
							-
							<input type="text" class="easyui-datebox noborder" id="pro_starttime" name="wpd.pro_endtime" style="width:39%">
						</td>
						<td align="left" class="EditHead">问题点：</td> 
						<td align="left" class="editTd">
				  			<s:buttonText id="problem_name" cssStyle="width:70%" hiddenId="problem_code" cssClass="noborder"
							 name="ledgerProblem.problem_name"
							hiddenName="ledgerProblem.problem_code"
							doubleOnclick="showSysTree(this,{
				    				url:'${contextPath}/plan/detail/problemTreeViewByAsyn.action',
				    				onlyLeafCheck:true,
				    				title:'请选择问题点',
				    				 checkbox:true
								})"
							doubleSrc="/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:hand;border:0" readonly="true" />
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
				  			<select id="pro_year" class="easyui-combobox" name="wpd.w_plan_year" editable="false" style="width:72%" panelHeight="auto">
						       <option value="">&nbsp;</option>
						       <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,5)" id="entry">
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
					<tr>
						<td align="left" class="EditHead">项目名称：</td> 
						<td align="left" class="editTd">
				  			<select id="w_plan_name" class="easyui-combobox" editable="false" style="width:72%" panelHeight="auto">
						       <s:iterator value='#@java.util.LinkedHashMap@{"0":"不显示","1":"显示"}' id="entry">
						         <option value="<s:property value="key"/>"><s:property value="value"/></option>
						       </s:iterator>
						    </select> 
						</td>
						<td align="left" class="EditHead">审计发现类型：</td> 
						<td align="left" class="editTd">
							<select multiple="multiple" id="problem_grade_code1" editable="false">
								<option value="">&nbsp;</option>
								<s:iterator value="basicUtil.problemMethodList" id="entry">
									<option value="<s:property value="code"/>"><s:property value="name"/></option>
								</s:iterator>
				  			</select>
				  			<input type="hidden" id="problem_grade_code" name="ledgerProblem.problem_grade_code"/>
						</td>
					</tr>
					<tr>
						<td align="left" class="EditHead">问题大类：</td> 
						<td align="left" class="editTd">
				  			<s:buttonText id="sort_big_name" cssStyle="width:70%" hiddenId="sort_big_code" cssClass="noborder"
							 name="ledgerProblem.sort_big_name"
							hiddenName="ledgerProblem.sort_big_code"
							doubleOnclick="showSysTree(this,{
				    				url:'${contextPath}/plan/detail/problemTreeViewByAsyn.action',
				    				title:'请选择问题大类',
				    				 checkbox:true
								})"
							doubleSrc="/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:hand;border:0" readonly="true" />
						</td>
						<td align="left" class="EditHead">问题子类：</td> 
						<td align="left" class="editTd">
				  			<s:buttonText id="sort_small_name" cssStyle="width:70%" hiddenId="sort_small_code" cssClass="noborder"
							 name="ledgerProblem.sort_small_name"
							hiddenName="ledgerProblem.sort_small_code"
							doubleOnclick="showSysTree(this,{
				    				url:'${contextPath}/plan/detail/problemTreeViewByAsyn.action',
				    				title:'请选择问题子类',
				    				 checkbox:true
								})"
							doubleSrc="/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:hand;border:0" readonly="true" />
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
					<input id="exportButton" type="button" value="导出" onclick="showPopWin('${contextPath}/pages/project/start/countColumnSelector.jsp',500,400)"/>
				</s:if>
			</div>
		</div>
		<div id="proName" title="项目作业信息" style="overflow:hidden;padding:0px">
			<iframe id="showProName" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
		</div>	
		<div id="commonPage"></div>
		<script type="text/javascript">
			function execExport(){
				document.getElementById("searchForm").action="multiDemensionProblem.action?querySource=grid&isExport=y";
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
				
				var pro_year = $('#pro_year').combobox('getValue');
				if(pro_year != '') {
					$('#dataList').datagrid('showColumn','pro_year');
				} else {
					$('#dataList').datagrid('hideColumn','pro_year');
				}
				
				var w_plan_name = $('#w_plan_name').combobox('getValue');
				if(w_plan_name == '1') {
					$('#dataList').datagrid('showColumn','w_plan_name');
				} else {
					$('#dataList').datagrid('hideColumn','w_plan_name');
				}
				
				var sort_big_name = $('#sort_big_name').val();
				if(sort_big_name != '') {
					$('#dataList').datagrid('showColumn','sort_big_name');
				} else {
					$('#dataList').datagrid('hideColumn','sort_big_name');
				}
				
				var sort_small_name = $('#sort_small_name').val();
				if(sort_small_name != '') {
					$('#dataList').datagrid('showColumn','sort_small_name');
				} else {
					$('#dataList').datagrid('hideColumn','sort_small_name');
				}
				
				var problem_name = $('#problem_name').val();
				if(problem_name != '') {
					$('#dataList').datagrid('showColumn','problem_name');
				} else {
					$('#dataList').datagrid('hideColumn','problem_name');
				}
				
				var problem_grade_code = $('#problem_grade_code').val();
				if(problem_grade_code != '') {
					$('#dataList').datagrid('showColumn','problem_grade_name');
				} else {
					$('#dataList').datagrid('hideColumn','problem_grade_name');
				}
				
				var tacticRelevancy = $('#tacticRelevancy').val();
				if(tacticRelevancy != '') {
					$('#dataList').datagrid('showColumn','tacticRelevancy');
				} else {
					$('#dataList').datagrid('hideColumn','tacticRelevancy');
				}
				
				var occurrence = $('#occurrence').val();
				if(occurrence != '') {
					$('#dataList').datagrid('showColumn','occurrence');
				} else {
					$('#dataList').datagrid('hideColumn','occurrence');
				}
				
				var orderOfSeverity = $('#orderOfSeverity').val();
				if(orderOfSeverity != '') {
					$('#dataList').datagrid('showColumn','orderOfSeverity');
				} else {
					$('#dataList').datagrid('hideColumn','orderOfSeverity');
				}
			}
			
			$(function(){
				var bodyW = $('body').width();
				//查询
				showWin('commonPage','公用弹窗页面');
				showWin('proSituation');
				loadSelectH();
				// 初始化生成表格
				$('#dataList').datagrid({
					url : "<%=request.getContextPath()%>/project/multiDemensionProblem.action?querySource=grid",
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
									searchWindShow('proSituation',900,350);
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
						{field:'pro_year',
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
						{field:'w_plan_name',
							 title:'项目名称',
							 width:bodyW * 0.1 + 'px',
							 halign:'center',
							 align:'center', 
							 sortable:true,
							 hidden:true,
						},
						{field:'sort_big_name',
							 title:'问题大类',
							 width:bodyW * 0.1 + 'px',
							 halign:'center',
							 align:'center', 
							 sortable:true,
							 hidden:true,
						},
						{field:'sort_small_name',
							 title:'问题子类',
							 width:bodyW * 0.1 + 'px',
							 halign:'center',
							 align:'center', 
							 sortable:true,
							 hidden:true,
						},
						{field:'problem_name',
							 title:'问题点',
							 width:bodyW * 0.1 + 'px',
							 halign:'center',
							 align:'center', 
							 sortable:true,
							 hidden:true,
						},
						{field:'problem_grade_name',
							 title:'审计发现类型',
							 width:bodyW * 0.1 + 'px',
							 halign:'center',
							 align:'center', 
							 sortable:true,
							 hidden:true,
						},
						{field:'tacticRelevancy',
							 title:'与本单位经营战略相关度',
							 width:bodyW * 0.1 + 'px',
							 halign:'center',
							 align:'center', 
							 sortable:true,
							 hidden:true,
						},
						{field:'occurrence',
							 title:'发生频率',
							 width:bodyW * 0.1 + 'px',
							 halign:'center',
							 align:'center', 
							 sortable:true,
							 hidden:true,
						},
						{field:'orderOfSeverity',
							 title:'严重程度',
							 width:bodyW * 0.1 + 'px',
							 halign:'center',
							 align:'center', 
							 sortable:true,
							 hidden:true,
						},
						{field:'closedPlanNum',
							 title:'已关闭项目数量',
							 width:bodyW * 0.08 + 'px',
							 halign:'center',
							 align:'center', 
							 sortable:true,
							 formatter:function(value,rowData,rowIndex){
								 if(value == null) {
									 return '0';
								 }else{
									 var url = '<a href="javascript:;" onclick="openNewProject(\'已关闭项目数量\',\''+rowData.closedPlanNumKey+'\')">'+value+'</a>';
									 return url;
								 }
							 }
						},
						{field:'problemNum',
							 title:'问题数量',
							 width:bodyW * 0.08 + 'px',
							 halign:'center',
							 align:'center', 
							 sortable:true,
							 formatter:function(value,rowData,rowIndex){
								 if(value == null) {
									 return '0';
								 }else{
									 var url = '<a href="javascript:;" onclick="openNew(\'问题数量\',\''+rowData.problemNumKey+'\')">'+value+'</a>';
									 return url;
								 }
							 }
						},
						{field:'mendProNum',
							 title:'已整改完的问题数',
							 width:bodyW * 0.08 + 'px',
							 halign:'center',
							 align:'center', 
							 sortable:true,
							 formatter:function(value,rowData,rowIndex){
								 if(value == null) {
									 return '0';
								 }else{
									 var url = '<a href="javascript:;" onclick="openNew(\'已整改完的问题数\',\''+rowData.mendProNumKey+'\')">'+value+'</a>';
									 return url;
								 }
							 }
						},
						{field:'notMendProNum',
							 title:'未整改完的问题数',
							 width:bodyW * 0.08 + 'px',
							 halign:'center',
							 align:'center', 
							 sortable:true,
							 formatter:function(value,rowData,rowIndex){
								 if(value == null) {
									 return '0';
								 }else{
									 var url = '<a href="javascript:;" onclick="openNew(\'未整改完的问题数\',\''+rowData.notMendProNumKey+'\')">'+value+'</a>';
									 return url;
								 }
							 }
						},
						{field:'mendRate',
							 title:'整改完成率',
							 width:bodyW * 0.08 + 'px',
							 halign:'center',
							 align:'center', 
							 sortable:true,
							 formatter:function(value,rowData,rowIndex){
								 if(value == null) {
									 return '0';
								 }else{
									 return value;
								 }
							 }
						},
						{field:'suggestNum',
							 title:'审计建议数量',
							 width:bodyW * 0.11 + 'px',
							 halign:'center',
							 align:'center', 
							 sortable:true,
							 formatter:function(value,rowData,rowIndex){
								 if(value == null) {
									 return '0';
								 }else{
									 var url = '<a href="javascript:;" onclick="openNew(\'审计建议数量\',\''+rowData.suggestNumKey+'\')">'+value+'</a>';
									 return url;
								 }
							 }
						},
						{field:'acceptSugNum',
							 title:'已采纳（有整改）的建议',
							 width:bodyW * 0.11 + 'px',
							 halign:'center',
							 align:'center', 
							 sortable:true,
							 formatter:function(value,rowData,rowIndex){
								 if(value == null) {
									 return '0';
								 }else{
									 var url = '<a href="javascript:;" onclick="openNew(\'已采纳（有整改）的建议\',\''+rowData.acceptSugNumKey+'\')">'+value+'</a>';
									 return url;
								 }
							 }
						},
						{field:'notAcceptSugNum',
							 title:'未采纳（无整改）的建议',
							 width:bodyW * 0.11 + 'px',
							 halign:'center',
							 align:'center', 
							 sortable:true,
							 formatter:function(value,rowData,rowIndex){
								 if(value == null) {
									 return '0';
								 }else{
									 var url = '<a href="javascript:;" onclick="openNew(\'未采纳（无整改）的建议\',\''+rowData.notAcceptSugNumKey+'\')">'+value+'</a>';
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
				
				$("#problem_grade_code1").multiSelect({ 
					selectAll: false,
					oneOrMoreSelected: '*',
					selectAllText: '全选',
					noneSelected: '',
					listWidth:'200'
				}, function(){   //回调函数
					$('#problem_grade_code').attr('name','ledgerProblem.problem_grade_code').val($("#problem_grade_code1").selectedValuesString());
				});
				
				
				$("#tacticRelevancy1").multiSelect({ 
					selectAll: false,
					oneOrMoreSelected: '*',
					selectAllText: '全选',
					noneSelected: '',
					listWidth:'200'
				}, function(){   //回调函数
					$('#tacticRelevancy').attr('name','ledgerProblem.tacticRelevancy').val($("#tacticRelevancy1").selectedValuesString());
				});
				
				$("#occurrence1").multiSelect({ 
					selectAll: false,
					oneOrMoreSelected: '*',
					selectAllText: '全选',
					noneSelected: '',
					listWidth:'200'
				}, function(){   //回调函数
					$('#occurrence').attr('name','ledgerProblem.occurrence').val($("#occurrence1").selectedValuesString());
				});
				
				$("#orderOfSeverity1").multiSelect({ 
					selectAll: false,
					oneOrMoreSelected: '*',
					selectAllText: '全选',
					noneSelected: '',
					listWidth:'200'
				}, function(){   //回调函数
					$('#orderOfSeverity').attr('name','ledgerProblem.orderOfSeverity').val($("#orderOfSeverity1").selectedValuesString());
				});
				//单元格tooltip提示
				$('#dataList').datagrid('doCellTip', {
					position : 'bottom',
					maxWidth : '200px',
					tipStyler : {
						'backgroundColor' : '#EFF5FF',
						borderColor : '#95B8E7',
						boxShadow : '1px 1px 3px #292929'
					}
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
			
			function openNewProject(typeName, key) {
				var url = '${contextPath}/project/displayDetail01.action?key=' + key.replaceAll('#', ',');
				aud$openNewTab(typeName, url ,false);
			}
			
			function openNew(typeName, key) {
				var url = '${contextPath}/project/displayProblems.action?key=' + key.replaceAll('#', ',');
				aud$openNewTab(typeName, url ,false);
			}
		</script>
	</body>
</html>
							