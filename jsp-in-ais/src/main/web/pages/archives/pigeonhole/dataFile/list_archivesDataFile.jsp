<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
		<%--<STYLE type="text/css">
			.datagrid-row {
			  	height: 30px;
			}
			.datagrid-cell {
				height:10%;
				padding:1px;
			}
		</STYLE>--%>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout" fit='true' border='0'>
	<div id="proArchiversSearch" class="searchWindow">
			<div class="search_head">
			<s:form namespace="/archives/pigeonhole" action="listTobeStarted" name="searchForm" id="searchForm">
					<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
						<tr>
							<td class="EditHead" style="width:15%">项目名称</td>
							<td class="editTd" style="width:35%">
								<s:textfield  cssClass="noborder" name="pigeonholeObject.project_name" maxlength="100"/>
							</td>
							<td class="EditHead" style="width:15%">项目类别</td>
							<td class="editTd" style="width:35%">
									<select editable="false" id="pro_type" class="easyui-combobox" name="projectStartObject.pro_type_name" editable="false" panelHeight="auto">
								       <option value="">&nbsp;</option>
								       <s:iterator value="BasicUtil.PlanProjectTypeMap4Zhongjian.keySet()" id="entry">
								         <option value="<s:property value="code"/>"><s:property value="name"/></option>
								       </s:iterator>
								    </select>
							</td>
						</tr>
					</table>
			</s:form>
			</div>
			<div class="serch_foot">
		        <div class="search_btn">
		        	<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>
					<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="myReset()">重置</a>
					<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="$('#proArchiversSearch').window('close')">取消</a>
				</div>
			</div>
	</div>
	<div region="center" id="archiveslist1" border='0'>
		<table id="archiveslist"></table>
	</div>

	<script type="text/javascript">
		$(function(){
			var bodyW = $('body').width();
			//查询
			showWin('proArchiversSearch');
			// 初始化生成表格
			$('#archiveslist').datagrid({
				url : "<%=request.getContextPath()%>/archives/pigeonhole/archivesDataFileList.action?querySource=grid",
				method:'post',
				showFooter:false,
				rownumbers:true, 
			 	pagination:true,
				striped:true,
				autoRowHeight:false,
				fit: true,
				fitColumns: true,
				idField:'id',	
				border:false,
				pageSize: 20,
				singleSelect:true,
				remoteSort: false,
				selectOnCheck:false,
				onLoadSuccess:function(){
					initHelpBtn();
					doCellTipShow('archiveslist');
				},
				onClickCell:function(rowIndex, field, value) {
					if(field == 'project_name') {
						var rows = $('#archiveslist').datagrid('getRows');
						var row = rows[rowIndex];
						if ( row.archives_status == "3"){
							goProjectMenuView(row.project_id,row.formId,row.project_name);
						}else{
							goProjectMenu(row.project_id,row.formId,row.project_name);
						}
					}
				},
				toolbar:[{
							id:'searchObj',
							text:'查询',
							iconCls:'icon-search',
							handler:function(){
								searchWindShow('proArchiversSearch');
							}
						},'-',helpBtn
					],
				frozenColumns:[[
				       			{field:'formId',width:0.01*bodyW+'px', hidden:true, align:'center'},
				       			{field:'archives_status_name',
									title:'状态',
									width:0.1*bodyW+'px',
									halign:'center',
									align:'left', 
									sortable:true,
								},
				       			{field:'project_name',title:'项目名称',width:0.25*bodyW+'px',halign:'center',align:'left',
									formatter:function(value,rowData,rowIndex){
										if ( rowData.archives_status == '3'){
											result = ["<label title='单击查看' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
										}else{
											result = ["<label title='单击编辑' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;	
										}
										return result;
									   }}
				    		]],
				columns:[[  
					{field:'project_code',
							title:'项目编号',
							width:0.1*bodyW+'px',
							halign:'center',
							align:'left', 
							sortable:true,
						},	
					{field:'pro_type_name',
						title:'项目类别',
						width:0.1*bodyW+'px',
						sortable:true,
						halign:'center', 
						align:'left',
						formatter:function(value,rowData,rowIndex){
							if(rowData.pro_type_child_name != null && rowData.pro_type_child_name != '') {
								return rowData.pro_type_child_name;
							} else {
								return value;
							}
						}
					},{field:'audit_dept_name',
						 title:'审计单位',
						 width:0.1*bodyW+'px',
						 halign:'center',
						 align:'left', 
						 sortable:true
					},
					{field:'audit_object_name',
						 title:'被审计单位',
						 width:0.1*bodyW+'px',
						 halign:'center',
						 align:'left', 
						 sortable:true
					},{field:'pro_teamleader_name',
						 title:'组长',
						 width:0.08*bodyW+'px',
						 halign:'center',
						 align:'left', 
						 sortable:true
					},
					{field:'pro_auditleader_name',
						 title:'主审',
						 width:0.08*bodyW+'px',
						 halign:'center',
						 align:'left', 
						 sortable:true
					}
				]]   
			});
			//在调整了窗口大小以后，设置easyui gridview也调整宽度   
			/* $(window).resize(function () {   
			 
			}); */
		});
		
		function goProjectMenu(projectId,formId,project_name){
			var addSjwtUrl  = '${contextPath}/archives/pigeonhole/editDataFile.action?crudId='+formId+'&project_id=' + projectId ;
			//aud$openNewTab(project_name, addSjwtUrl, false);
			window.location.href=addSjwtUrl;
		}
		
		/* 查看 */
		function goProjectMenuView(projectId,formId,project_name){
			var addSjwtUrl  = '${contextPath}/archives/pigeonhole/viewDataFile.action?crudId='+formId+'&project_id=' + projectId ;
			aud$openNewTab(project_name, addSjwtUrl, false);
		}
		
		function doSearch(){
			$("#archiveslist").datagrid({
	    		queryParams:form2Json('searchForm')
	    	});
			$('#proArchiversSearch').window('close')
		}
		
		/*
		*  重置
		*/
		function myReset(){
            $("#searchForm .editTd").find('select,input').attr('value',null);
		}
	</script>	
	</body>
</html>
