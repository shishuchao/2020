<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>项目列表-项目浏览页</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>  
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>  
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" /> 
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/util/DateUtil.js"></script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	 <div id="dlgSearch" class="searchWindow">
			<div class="search_head">
			<s:form id="myform" name="myform" action="getProjectQualityEvaList.action" namespace="/quality/sampling" method="post">
	         <table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr >
				   <td class="EditHead">
						评价状态
					</td>
					<td class="editTd" >
						<select class="easyui-combobox" data-options="panelHeight:'auto'" name="pQ.status" editable="false">
					       <option value="">请选择</option>
					       <s:iterator value="#@java.util.LinkedHashMap@{'020':'评价中','030':'已评价'}" id="entry">
					         <option value="<s:property value="key"/>"><s:property value="value"/></option>
					       </s:iterator>
					    </select>
					</td>
					<td class="EditHead">
						项目编号
					</td>
					<td class="editTd">
						<s:textfield cssClass="noborder" name="pQ.project_code" maxlength="50"/>
					</td>
				</tr>
				<tr>
				
				    <td class="EditHead" style="width:15%">
						项目名称
					</td>
					<td class="editTd" colspan="3">
						<s:textfield cssClass="noborder" name="pQ.project_name" maxlength="50"/>
					</td>
				</tr>
		
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
			<table id="projectList"></table>
		</div>
		 <div id="viewProjectEvaDlg" title="质量抽检项目评价查看" style="overflow:hidden;padding:0">
			 <iframe id="viewProjectEvaDlgFrame" src="" width="100%" title="" height="100%" frameborder="0"></iframe>
		 </div>
		
		<script type="text/javascript">
	        function freshGrid(){
				$('#dlgSearch').dialog('open');
			}
			/*
			* 查询
			*/
			function doSearch(){
	        	datagrid.datagrid('options').queryParams = form2Json('myform');
				datagrid.datagrid('reload');
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
				resetForm('myform');
				//doSearch();
			}
			var datagrid;
			$(function(){
				var bodyW = $('body').width();
				showWin('dlgSearch');
				$('#viewProjectEvaDlg').window({
					width: 950,
					height: 450,
					modal: true,
					collapsible: false,
					maximizable: true,
					minimizable: false,
					closed: true
				});
			    // 初始化生成表格
				var currentDate = getCurrentDate();
				datagrid = $('#projectList').datagrid({
				    url:"<%=request.getContextPath()%>/quality/sampling/getProjectQualityEvaList.action?querySource=grid",
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
					remoteSort: true,
					singleSelect:true,
					toolbar:[{
							id:'search',
							text:'查询',
							iconCls:'icon-search',
							handler:function(){
								searchWindShow('dlgSearch');
							}
						},'-',helpBtn
					],
					onLoadSuccess:function(){
						initHelpBtn();
					},
					frozenColumns:[[
					       			{field:'status_name',title:'评价状态',halign:'center',align:'center',sortable:true, width:bodyW*0.08+'px'},
					       			{field:'project_code',title:'项目编号',width:bodyW*0.15+'px',sortable:true,halign:'center',align:'left'}
					    		]],
					columns:[[  
						{field:'project_name',
								title:'项目名称',
								width:bodyW*0.25+'px',
								halign:'center',
								align:'left', 
								sortable:true,
								formatter:function(value,rowData,rowIndex){
									if(currentDate >= rowData.eva_start_time && currentDate <= rowData.eva_end_time) {
										if ( rowData.xmType == 'syOff'){
											return '<a href=\"javascript:void(0);\" onclick=\"goProjectMenuView(\''+rowData.project_id+'\',\''+rowData.project_name+'\');\" >'+value+'</a>';
										}else{
											return '<a href=\"javascript:void(0);\" onclick=\"goProjectMenu(\''+rowData.project_id+'\');\" >'+value+'</a>';
										}
									} else if(rowData.status_name != '已评价'){
										var result;
										if(currentDate < rowData.eva_start_time) {
											result = value + "<font color='red'>(作业详情查看未开始)</font>";
										} else {
											result = value + "<font color='red'>(作业详情查看已过期)</font>";
										}
										return result;
									} else {
									    return value;
                                    }

						}},
						{field:'score',
							title:'得分',
							halign:'center',
							width:bodyW*0.08+'px',
							sortable:true, 
							align:'center'
						},
						{field:'eva_userName',
							title:'评价人',
							halign:'center',
							width:bodyW*0.08+'px',
							sortable:true, 
							align:'center'
						},
						{field:'eva_time',
							 title:'评价时间',
							 halign:'center',
							 width:bodyW*0.08+'px',
							 align:'center', 
							 sortable:true
						},

						{field:'caouzo',
							 title:'操作',
							 width:bodyW*0.08+'px',
							 halign:'center',
							 align:'center', 
							 sortable:true,
							 formatter:function(value,rowData,rowIndex){
								 var e = '<a href=\"javascript:void(0);\" onclick=\"editProjectEva(\''+rowData.formId+ '\')\">评价</a>';
								 var v = '<a href=\"javascript:void(0);\" onclick=\"viewProjectEva(\''+rowData.formId+ '\')\">查看</a>';
								 if ( rowData.status == '020'){
									 return e;
								 }else{
									 return v;
								 }
								 
							 }
						}

					]]   
				});
				//单元格tooltip提示
				$('#projectList').datagrid('doCellTip', {
					onlyShowInterrupt : 'true',
					position : 'bottom',
					maxWidth : '200px',
					tipStyler : {
						'backgroundColor' : '#EFF5FF',
						borderColor : '#95B8E7',
						boxShadow : '1px 1px 3px #292929'
					}
				
				});
				
			});
         
			
	
			
		 function goProjectMenu(formId){
				window.open(
						'${contextPath}/project/prepare/projectIndex.action?crudId='
								+ formId + '&source=view&projectview=view&isView=2&view=view', '',
								'height=700px, width=1300px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
		 }
 		 
         function editProjectEva(formId){
        	 window.location.href="${contextPath}/quality/sampling/edit.action?formId="+formId;
         }

         function viewProjectEva(formId){
        	 var url = "${contextPath}/quality/sampling/view.action?formId="+formId;
			 /*$('#viewProjectEvaDlgFrame').attr('src', url);
			 $('#viewProjectEvaDlg').window('open');*/
			 aud$openNewTab("质量抽检项目评价查看", url, true);
         }
			/* 查看 */
 		function goProjectMenuView(projectId,project_name){
 			var addSjwtUrl  = '${contextPath}/archives/pigeonhole/viewDataFile.action?project_id=' + projectId ;
 			aud$openNewTab(project_name, addSjwtUrl, false);
 		}
 		</script>
	</body>
</html>
