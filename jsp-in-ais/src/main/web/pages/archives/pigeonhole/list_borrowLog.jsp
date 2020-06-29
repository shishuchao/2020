<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<% 
	response.setHeader("Cache-Control","no-cache"); //HTTP 1.1 
	response.setHeader("Pragma","no-cache"); //HTTP 1.0 
	response.setDateHeader ("Expires", 0); //prevents caching at the proxy server 
%>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
	<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
	<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
	<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
	<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
<%--	<STYLE type="text/css">
		.datagrid-row {
		  	height: 30px;
		}
		.datagrid-cell {
			height:10%;
			padding:1px;
		}
	</STYLE>--%>
	<script language="javascript">
		/*
	 	 *查看归档的详细信息
	 	 */
	 	function borrowLog(project_id,formId,project_name){
	 	    var url = "${contextPath}/archives/borrow/borrowLog.action?project_id="+ project_id +"&project_name=" + encodeURI(encodeURI(project_name)) ;
	 		window.location = url;
	 	}	
	</script>
</head>

<body style="margin: 0; padding: 0; overflow: hidden;" class="easyui-layout">
	<div id="borrowLogSearch" class="searchWindow">
		<div class="search_head">
		<s:form action="borrowLogList" namespace="/archives/pigeonhole" name="form" id="form">
			<table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr>
					<td class="EditHead" style="width:15%">档案名称</td>
					<td class="editTd" tyle="width:35%">
						<s:textfield cssStyle="width:80%;" name="pigeonholeObject.archives_name" cssClass="noborder" />
					</td>
					<td class="EditHead" tyle="width:15%">档案年度</td>
					<td class="editTd" tyle="width:35%">
						<select name="pigeonholeObject.archives_year" class="easyui-combobox" editable="false">
							<option value="">&nbsp;</option>
					        <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,9)" id="entry">
				            	<option value="<s:property value='key'/>"><s:property value='value'/></option>
					        </s:iterator>
						</select>
					</td>
				</tr>
				<tr>
					<td class="EditHead">审计单位</td>
					<td class="editTd">
						<s:buttonText cssStyle="width:80%;"
							name="pigeonholeObject.archives_unit_name" 
							cssClass="noborder" hiddenName="pigeonholeObject.archives_unit"
							doubleOnclick="showSysTree(this,
							{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
							   param:{'p_item':3
							   },
							  title:'请选择审计单位'
							})"
							doubleSrc="/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:hand;border:0" readonly="true"
							display="true" doubleDisabled="false" />
					</td>
					<td class="EditHead">被审计单位</td>
					<td class="editTd">
						<s:buttonText2 cssStyle="width:80%;"
							id="pigeonholeObject.audit_object_name"
							hiddenId="pigeonholeObject.audit_object"
							name="pigeonholeObject.audit_object_name" cssClass="noborder"
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
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="$('#borrowLogSearch').window('close')">取消</a>
			</div>
		</div>
	</div>
	<div region="center">
		<table id="archivesPigeonholeList"></table>
	</div>
	<script type="text/javascript"> 
		$(function(){
			showWin('borrowLogSearch');
			$('#archivesPigeonholeList').datagrid({
				url : "<%=request.getContextPath()%>/archives/pigeonhole/borrowLogList.action?querySource=grid",
				method:'post',
				showFooter:false,
				rownumbers:true,
				pagination:true,
				striped:true,
				autoRowHeight:false,
				fit: true,
				pageSize:20,
				fitColumns:true,
				border:false,
				singleSelect:true,
				remoteSort: false,
				toolbar:[{
					id:'searchObj',
					text:'查询',
					iconCls:'icon-search',
					handler:function(){
						searchWindShow('borrowLogSearch');
					}
				},'-',helpBtn],
				onLoadSuccess:function(data){
					initHelpBtn();
					doCellTipShow('archivesPigeonholeList');
				},
				columns:[[ 
					{field:'archives_status_name',title:'归档状态',width:100,halign:'center',align:'left',sortable:true},
			       			{field:'archives_name',title:'档案名称',width:280,sortable:true,halign:'center',align:'left'},
					{field:'project_name',
							title:'项目名称',
							width:280,
							halign:'center',
							align:'left', 
							sortable:true
					},
					{field:'archives_year',
						title:'档案年度',
						sortable:true,
						width:80,
						halign:'center', 
						align:'center'
					},
					{field:'archives_unit_name',
						 title:'审计单位',
						 width:200,
						 halign:'center',
						 align:'left', 
						 sortable:true
					},
					{field:'audit_object_name',
						 title:'被审计单位',
						 width:200,
						 halign:'center',
						 align:'left', 
						 sortable:true
					},
					{field:'option',
						 title:'档案信息',
						 align:'left', 
						 halign:'center',
						 sortable:false,
						 formatter:function(value,row,index){
						 	//return '<a href="${contextPath}/archives/borrow/borrowLog.action?project_id='+row.project_id+'&project_name='+encodeURI(encodeURI(row.project_name))+'">借阅日志</a>';
							 return '<a href="javascript:void(0)" onclick="openBorrowLog(\'' + row.project_id + '\', \'' + row.project_name + '\')">借阅日志</a>';
					 }
					}
				]]   
			});
		

	
		});
		function doSearch(){
        	$('#archivesPigeonholeList').datagrid({
    			queryParams:form2Json('form')
    		});
    		$('#borrowLogSearch').window('close');
        }
        function restal(){
        	document.getElementsByName("pigeonholeObject.audit_object_name")[0].value = '';
			document.getElementsByName("pigeonholeObject.archives_unit_name")[0].value = '';
			resetForm('form');
			/*doSearch();*/
		}

		function openBorrowLog(project_id, project_name) {
			var url = '${contextPath}/archives/borrow/borrowLog.action?project_id=' + project_id + '&project_name=' + encodeURI(encodeURI(project_name));
			aud$openNewTab(project_name+'-借阅日志', url, false);
		}
	</script>
</body>
</html>
