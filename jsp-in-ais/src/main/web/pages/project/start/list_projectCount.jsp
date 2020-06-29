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
			<s:form id="searchForm" action="projectCountReport" namespace="/project" method="post">
				<table id="searchTable" cellpadding=0 border=0 class="ListTable" align="center">
					<tr>
						<td align="left" class="EditHead" style="width:15%">项目编号：</td>
						<td align="left" class="editTd" style="width:35%">
							<s:textfield name="pso.project_code" cssClass="noborder" maxlength="50" cssStyle="width:80%"/>
						</td>
						<td align="left" class="EditHead" style="width:15%">项目名称：</td>
						<td align="left" class="editTd" style="width:35%">
							<s:textfield name="pso.project_name" cssClass="noborder" maxlength="50" cssStyle="width:80%"/>
						</td>
					</tr>
					<tr>
						<td align="left" class="EditHead">项目年度：</td> 
						<td align="left" class="editTd">
							<select id="pro_year" class="easyui-combobox" name="pso.pro_year" editable="false" style="width:80%" panelHeight="auto">
						       <option value="">&nbsp;</option>
						       <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,5)" id="entry">
						         <option value="<s:property value="key"/>"><s:property value="value"/></option>
						       </s:iterator>
						    </select> 
						</td>					
						<td align="left" class="EditHead">项目类别：</td>
						<td align="left" class="editTd">
							<select id="select2" class="easyui-combobox" name="pso.pro_type" style="width:80%" panelHeight="auto">
								<option value="">&nbsp;</option>
								<s:iterator value="basicUtil.PlanProjectTypeMap4Zhongjian.keySet()" id="entry">
						         <option value="<s:property value="code"/>"><s:property value="name"/></option>
						       </s:iterator>
							</select>
							
						</td>
					</tr>
					<tr>
						<td align="left" class="EditHead">审计单位：</td>
						<td align="left" class="editTd">
							<s:buttonText2 id="audit_dept_name"  cssClass="noborder"
								name="pso.audit_dept_name" cssStyle="width:80%"
								hiddenId="audit_dept" hiddenName="pso.audit_dept"
								doubleOnclick="showSysTree(this,
										{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
										   param:{
												'p_item':1,
											     'orgtype':1
										},
										  title:'请选择所属单位'
										})"
								doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
								doubleCssStyle="cursor:hand;border:0" readonly="true" />
						</td>
						<td align="left" class="EditHead">被审计单位：</td>
						<td align="left" class="editTd">
							<s:buttonText2 cssStyle="width:80%;" hiddenId="audit_object" cssClass="noborder"
								id="audit_object_name" name="pso.audit_object_name"
								hiddenName="pso.audit_object"
								doubleOnclick="showSysTree(this,{url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
																  param:{'departmentId':'${organization.fid}'},
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
						<td align="left" class="EditHead" nowrap="nowrap">执行阶段：</td>
						<td align="left" class="editTd">
							<select name="executionstage" class="easyui-combobox" id="executionstage" editable="false" style="width:39%" panelHeight="auto">
								<option value="">&nbsp;</option>
								<option value="0">审计准备</option>
								<option value="1">实施 终结</option>
								<option value="2">审计归档</option>
								<option value="3">整改跟踪</option>
								<option value="4">整改完成</option>
							</select>
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
			function execExport(columns){
				document.getElementById("searchForm").action="projectCountReportExport.action?"+columns;
				document.getElementById("searchForm").target="_blank";
				document.getElementById("searchForm").submit();
				document.getElementById("searchForm").action="projectCountReport.action";
				document.getElementById("searchForm").target="_self";
			}
			
			//重置查询条件
			function resetDoubtList(){
				resetForm('searchForm');
				$("#pro_year").combobox('setValue', ' ');
				//doSearch();
			}
			
			//查询
			function doSearch(){
	        	$('#dataList').datagrid({
	    			queryParams:form2Json('searchForm')
	    		});
	    		$('#proSituation').window('close');
	        }
			$(function(){
				//查询
				showWin('commonPage','公用弹窗页面');
				showWin('proSituation');
				loadSelectH();
                var d = new Date();
                $('#pro_year').combobox('setValue',d.getFullYear());
				// 初始化生成表格
				$('#dataList').datagrid({
					url : "<%=request.getContextPath()%>/project/projectCountReport.action?querySource=grid",
					method:'post',
					showFooter:false,
					rownumbers:true,
					pagination:true,
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
									searchWindShow('proSituation',900);
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
							       	{field:'17',title:'项目状态',halign:'center', align:'center',sortable:true,formatter:function(value,rowData,rowIndex){	
			       						if(rowData[17]=='running'){
				       						return '进行中';
				       					}else{
				       						return '已关闭';
				       					}
	       							}
				       			},
							       	{field:'19',title:'项目编号',width:'300px',halign:'left', sortable:true,align:'left'}
							    ]],
					columns:[[
						{field:'2',
								title:'项目名称',
								width:200,
								halign:'center',
								align:'left',
								sortable:true,
								formatter:function(value,rowData,rowIndex){
									return '<a href=\"javascript:void(0)\" onclick=\"proName(\''+rowData[0]+'\',\''+rowData[13]+'\');\">'+value+'</a>';
								}
							},
						{field:'20',
							 title:'项目类别',
							 width:150,
							 halign:'center',
							 align:'center', 
							 sortable:true
						},	
						{field:'21',
							 title:'项目子类别',
							 width:150,
							 halign:'center',
							 align:'center', 
							 sortable:true
						},						
						{field:'1',
								title:'审计单位',
								width:200,
								halign:'center',
								align:'left', 
								sortable:true
						},
						{field:'4',
							 title:'被审计单位',
							 width:200,
							 halign:'center',
							 align:'left', 
							 sortable:true
						},						
						{field:'3',
							 title:'项目年度',
							 width:80,
							 halign:'center',
							 align:'center', 
							 sortable:true
						},
						{field:'5',
							 title:'项目组长',
							 width:80,
							 halign:'center',
							 align:'left', 
							 sortable:true
						},
						{field:'22',
							 title:'项目组成员数',
							 width:120,
							 halign:'center',
							 align:'center', 
							 sortable:true
						},
						{field:'6',
							 title:'计划开始时间',
							 width:120,
							 halign:'center',
							 align:'center', 
							 sortable:true,
							 formatter:function(value,rowData,rowIndex){
								 if(value!=null){
									return value.substring(0,10);
								 }
							}
						},
						{field:'7',
							 title:'实际开始时间',
							 width:120,
							 halign:'center',
							 align:'center', 
							 sortable:true,
							 formatter:function(value,rowData,rowIndex){
								 if(value!=null){
									return value.substring(0,10);
								 }
							}
						},
						{field:'8',
							 title:'计划结束时间',
							 width:120,
							 halign:'center',
							 align:'center', 
							 sortable:true,
							 formatter:function(value,rowData,rowIndex){
								 if(value!=null){
									return value.substring(0,10);
								 }
							}
						},
						{field:'9',
							 title:'实际结束时间',
							 width:120,
							 halign:'center',
							 align:'center', 
							 sortable:true,
							 formatter:function(value,rowData,rowIndex){
								 if(value!=null){
									return value.substring(0,10);
								 }
							}
						},
						{field:'10',
							 title:'执行阶段',
							 width:80,
							 halign:'center',
							 align:'center', 
							 sortable:true,
							 formatter:function(value,rowData,rowIndex){
								if(rowData[13]==null||rowData[13]=='0'){
									return '审计准备';
								}else if(rowData[13]=='1'&&rowData[14]=='0' || rowData[14]=='1'&&rowData[15]=='0'){
									return '实施 终结';
								}else if(rowData[15]=='1'&&rowData[16]=='0'){
									return '审计归档';
								}else if(rowData[17]=='closed'&&rowData[18]=='0'){
									return '整改跟踪';
								}else if(rowData[17]=='closed'&&rowData[18]=='1'){
									return '整改完成';
								}
							 }
						}
					]]   
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
							