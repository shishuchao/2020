<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%
	response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1 
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0 
	response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
</head>
<body   style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	<div id="logSearch" class="searchWindow">
		<div class="search_head">
		<s:form name="form" id="form">
			<table  id="searchTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr>
					<td class="EditHead" style="width:15%">档案名称</td>
					<td class="editTd" style="width:35%">
						<s:textfield cssClass="noborder"
							name="pigeonholeObject.archives_name" />
					</td>
					<td class="EditHead" style="width:15%">档案年度</td>
					<td class="editTd" style="width:35%">
						<select class="easyui-combobox" name="pigeonholeObject.archives_year"  editable="false">
					       <option value="">&nbsp;</option>
					       <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,9)" id="entry">
				             <option value="<s:property value='key'/>"><s:property value='value'/></option>
					       </s:iterator>
					    </select> 
					</td>
				</tr>
				<tr>
					<td class="EditHead">档案编号</td>
					<td class="editTd">
						<s:textfield  cssClass="noborder"
							name="pigeonholeObject.archives_code" />
					</td>
					<td class="EditHead">审计单位</td>
					<td class="editTd">
						<s:buttonText name="pigeonholeObject.archives_unit_name" cssClass="noborder"
							size="15" 
							hiddenName="pigeonholeObject.archives_unit"
							doubleOnclick="showSysTree(this,
							{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
							   param:{
									'p_item':3
							},
							  title:'请选择审计单位'
							})"
							doubleSrc="/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:hand;border:0" readonly="true"
							display="true" doubleDisabled="false" />

					</td>
				</tr>
				<tr>
					<td class="EditHead">被审计单位</td>
					<td class="editTd" colspan="3">
						<s:buttonText2  cssClass="noborder"
							id="pigeonholeObject.audit_object_name"
							hiddenId="pigeonholeObject.audit_object"
							name="pigeonholeObject.audit_object_name"
							hiddenName="pigeonholeObject.audit_object"
							doubleOnclick="showSysTree(this,
						{ url:'${pageContext.request.contextPath}/mng/audobj/object/getAuditedDeptChildByDeptId.action',
						  param:{
						    'departmentId':'${magOrganization.fid}'
						  },
						  cache:false,
						  checkbox:true,
						  title:'请选择被审计单位'
						})"
							doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:hand;border:0" readonly="true"
							display="${varMap['audit_objectRead']}"
							doubleDisabled="!(varMap['audit_object_buttonWrite']==null?true:varMap['audit_object_buttonWrite'])" />
					</td>
				</tr>
			</table>
		</s:form>
		</div>
		<div class="serch_foot">
	        <div class="search_btn">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="restal()">重置</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="$('#logSearch').window('close')">取消</a>
			</div>
		</div>
	</div>
	<div region="center">
		<table id="archivesPigeonholeList"></table>
	</div>
	<jsp:include flush="true" page="/pages/frReportFlow/ajaxloading.jsp" />
</body>
<script type="text/javascript">
    function doSearch(){
    	 $('#archivesPigeonholeList').datagrid({
			queryParams:form2Json('form')
		});
/*		QUtil.loadGrid({
             // 传入的查询参数； 可选
             param:form2Json('form'),
             // 表格对象
             gridObject:$('#archivesPigeonholeList')[0],
             showMsg:true,
             callbackFn:function(data){
             }
         });*/
		$('#logSearch').window('close');
    }
	//重置查询条件
	function restal(){
		resetForm('form');
		/*doSearch();*/
	}
	$(function(){
		//查询	
		showWin('logSearch');
		frloadOpen();
		// 初始化生成表格
		$('#archivesPigeonholeList').datagrid({
			url : "<%=request.getContextPath()%>/archives/pigeonhole/searchArchivesList4admin.action?querySource=grid",
			method:'post',
			showFooter:false,
			rownumbers:true,
			pagination:true,
			striped:true,
			autoRowHeight:false,
			fit: true,
			pageSize:20,
			idField:'row',	
			fitColumns: true,
			border:false,
			singleSelect:true,
			remoteSort: false,
			queryParams:form2Json('form'),
			toolbar:[{
					id:'searchObj',
					text:'查询',
					iconCls:'icon-search',
					handler:function(){
						searchWindShow('logSearch');
					}
				},'-',helpBtn],
			onLoadSuccess:function(){
				frloadClose();
				doCellTipShow('archivesPigeonholeList');
				initHelpBtn();
			},
			frozenColumns:[[
			       			{field:'archives_status_name',title:'归档状态',width:100,halign:'center',align:'center'},
							{field:'archives_name',title:'档案名称',width:300,sortable:true,halign:'center',align:'left',
								formatter:function(value,rowData,rowIndex) {
									return rowData.archiveLink;
								}
							},
							{field:'archives_code',title:'档案编号',width:100,sortable:true,halign:'center',align:'left'}
			    		]],
			columns:[[  
				{field:'project_name',
						title:'项目名称',
						width:300,
						halign:'center',
						align:'left', 
						sortable:true
				},
				{field:'archives_year',
					title:'档案年度',
					width:100,
					sortable:true, 
					halign:'center',
					align:'center'
				},
				{field:'archives_unit_name',
					 title:'审计单位',
					 width:200,
					 align:'left',
					 halign:'center',
					 sortable:true
				},
				{field:'audit_object_name',
					 title:'被审计单位',
					 width:200,
					 halign:'center',
					 align:'left', 
					 sortable:false
				},
				{field:'adminArchiveLink',
					 title:'档案信息',
					 halign:'center',
					 align:'center',
					 sortable:false
				}
			]]   
		});
		

	});
	/*
 	 *查看归档的详细信息
 	 */
 	function archivesPigeonholeDetail(project_id,formId){
 	    //var url = "${contextPath}/archives/pigeonhole/archivesPigeonholeDetail.action?project_id="
		//		+ project_id + "&&crudId=" + formId + "&&view=admin";
 		//window.location = url;
		var url = "${contextPath}/archives/pigeonhole/archivesPigeonholeDetail.action?project_id="
				+ project_id + "&&crudId=" + formId;
 		aud$openNewTab('档案信息', url, true);
 	}	
 	
 	/*
 	 *查看归档的文件
 	 */
 	function archivesPigeonholeAttachment(archive_name,project_id){
		var url = "${contextPath}/archives/workprogram/pigeonhole/archivesFile.action?type=pigeonhole&project_id=" + project_id
					+ "&archive_name=" + encodeURI(encodeURI(archive_name));
		//window.location.href=url;
		aud$openNewTab('档案文件', url, false);
 	}	
</script>
</html>
