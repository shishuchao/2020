<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
<head>
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
<%--	<STYLE type="text/css">
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
	<div id="archivesSearch" class="searchWindow">
		<div class="search_head">
		<s:form action="searchArchivesList" namespace="/archives/pigeonhole" name="form" id="form">
			<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable" id="searchTable" >
				<tr>
					<td class="EditHead" style="width:15%">档案名称</td>
					<td class="editTd" style="width:35%">
						<s:textfield cssClass="noborder" name="pigeonholeObject.archives_name"  />
					</td>
					<td class="EditHead" style="width:15%">档案年度</td>
					<td class="editTd" style="width:35%">
						<select class="easyui-combobox" name="pigeonholeObject.archives_year" editable="false">
							<option value="">&nbsp;</option>
							<s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,9)" id="entry">
								<option value="<s:property value='key'/>"><s:property value='value'/></option>
							</s:iterator>
						</select>
					</td>
				</tr>
				<tr>
					<td class="EditHead">审计单位</td>
					<td class="editTd" >
					<s:buttonText cssClass="noborder" id="archives_unit_name" name="pigeonholeObject.archives_unit_name" 
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
					<td class="EditHead">被审计单位</td>
					<td class="editTd" >
						<s:buttonText2 cssClass="noborder" id="audit_object_name" hiddenId="pigeonholeObject.audit_object"
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
							doubleCssStyle="cursor:hand;border:0"
							readonly="true"
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
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="$('#archivesSearch').window('close')">取消</a>
			</div>
		</div>
	</div>
	<div region="center">
		<table id="archivesPigeonholeList"></table>
	</div>
	<script type="text/javascript">
        function doSearch(){
        	$('#archivesPigeonholeList').datagrid({
    			queryParams:form2Json('form')
    		});
    		$('#archivesSearch').window('close');
        }
		//重置查询条件
		function restal(){
			resetForm('form');
			$('#form input').each(function(){
				$(this).val('');
			});;
			// doSearch();
		}
		$(function(){
			//查询
			var bodyW = $('body').width();
			showWin('archivesSearch');
			// 初始化生成表格
			$('#archivesPigeonholeList').datagrid({
				url : "<%=request.getContextPath()%>/archives/pigeonhole/searchArchivesList.action?querySource=grid",
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
							searchWindShow('archivesSearch');
						}
					},'-',helpBtn],
				onLoadSuccess:function(){
					initHelpBtn();
					doCellTipShow('archivesPigeonholeList');
				},
				columns:[[
					{field:'archives_status_name',title:'归档状态',width:0.06*bodyW+'px',halign:'center',align:'center'},
	       			{field:'archives_name',title:'档案名称',width:0.2*bodyW+'px',sortable:true,halign:'center',align:'left',
						formatter:function(value,rowData,rowIndex){
	       					return rowData.archiveLink;
						}
					},
					{field:'project_name',
						title:'项目名称',
						width:0.2*bodyW+'px',
						halign:'center',
						align:'left',
						sortable:true
					},
					{field:'archives_year',
						title:'档案年度',
						sortable:true,
						width:0.06*bodyW+'px',
						halign:'center',
						align:'center'
					},
					{field:'archives_unit_name',
						title:'审计单位',
						width:0.2*bodyW+'px',
						halign:'center',
						align:'left',
						sortable:true
					},
					{field:'audit_object_name',
						title:'被审计单位',
						width:0.2*bodyW+'px',
						halign:'center',
						align:'left',
						sortable:true
					}/*,
					{field:'archiveLink',
						 title:'档案信息',
						 halign:'center',
						 align:'left', 
						 sortable:false
					}*/
				]]   
			});
			
		});
		function archivesPigeonholeDetail(project_id,formId){
	 	    var url = "${contextPath}/archives/pigeonhole/archivesPigeonholeDetail.action?project_id=" 
	 	    		+ project_id + "&&crudId=" + formId +"&&view=com";
	 		window.location = url;
	 	}	
		</script>
	</body>
</html>
