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
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	 <div id="dlgSearch" class="searchWindow">
			<div class="search_head">
			<s:form id="myform" name="myform" action="projectQualityEvaResultList.action" namespace="/quality/sampling" method="post">
	         <table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<tr >
					<td class="EditHead" style="width:20%">
						项目编号
					</td>
					<td class="editTd" style="width:33%">
						<s:textfield cssClass="noborder" name="pQ.project_code" cssStyle="width:80%" maxlength="50"/>
					</td>
					
				    <td class="EditHead" style="width:15%">
						项目名称
					</td>
					<td class="editTd" style="width:32%">
						<s:textfield cssClass="noborder" name="pQ.project_name" cssStyle="width:80%" maxlength="50"/>
					</td>
				</tr>
				<tr>
						<td class="EditHead" style="width:15%">
							审计单位
						</td>
						<td class="editTd" style="width:32%">
						  <s:buttonText2 name="pQ.audit_dept_name" cssClass="noborder"
							hiddenName="pQ.audit_dept" cssStyle="width:80%"
							doubleOnclick="showSysTree(this,
								{ url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
								  title:'请选择审计单位',
                                  param:{
                                    'p_item':3
                                  }
								})"
							doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
							doubleCssStyle="cursor:pointer;border:0" readonly="true" />
						</td>

						<td class="EditHead" style="width:15%">
							项目年度
						</td>
						<td class="editTd" style="width:32%">
						 <select class="easyui-combobox" name="pQ.pro_year" id="pro_year" style="width:80%"  editable="false">
					       <option value="">请选择</option>
					       <s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,9)" id="entry">
					         <option value="<s:property value="key"/>"><s:property value="value"/></option>
					       </s:iterator>
					    </select>
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
				var d = new Date();
				$('#pro_year').combobox('setValue',d.getFullYear());
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
				datagrid = $('#projectList').datagrid({
				    url:"<%=request.getContextPath()%>/quality/sampling/projectQualityEvaResultList.action?querySource=grid",
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
					       			{field:'project_code',title:'项目编号',width:bodyW*0.15+'px',sortable:true,halign:'center',align:'center'}
					    		]],
					columns:[[  
						{field:'project_name',
								title:'项目名称',
								width:bodyW*0.2+'px',
								halign:'center',
								align:'left', 
								sortable:true,
								formatter:function(value,rowData,rowIndex){
									if ( rowData.xmType == 'syOff'){
										return '<a href=\"javascript:void(0);\" onclick=\"goProjectMenuView(\''+rowData.project_id+'\',\''+rowData.project_name+'\');\" >'+value+'</a>';
									 }else if ( rowData.xmType == 'history' ){
										return '<a href=\"javascript:void(0);\" onclick=\"goProjectMenuHistoryView(\''+rowData.project_id+'\',\''+rowData.project_name+'\');\" >'+value+'</a>';
									 }else{
										return '<a href=\"javascript:void(0);\" onclick=\"goProjectMenu(\''+rowData.project_id+'\');\" >'+value+'</a>';
									} 
						}},
						{field:'pro_year',
							title:'项目年度',
							halign:'center',
							width:0.1*bodyW+'px',
							sortable:true, 
							align:'center'
						},
						{field:'score',
							title:'得分',
							halign:'center',
							width:bodyW*0.1+'px',
							sortable:true, 
							align:'center'
						},
						{field:'eva_userName',
							title:'评价人',
							halign:'center',
							width:bodyW*0.1+'px',
							sortable:true, 
							align:'center'
						},
						{field:'eva_time',
							 title:'评价时间',
							 halign:'center',
							 width:bodyW*0.1+'px',
							 align:'center', 
							 sortable:true
						},

						{field:'caouzo',
							 title:'操作',
							 width:bodyW*0.1+'px',
							 halign:'center',
							 align:'center', 
							 sortable:true,
							 formatter:function(value,rowData,rowIndex){
								 var v = '<a href=\"javascript:void(0);\" onclick=\"viewProjectEva(\''+rowData.formId+ '\')\">查看</a>';
								 return v; 
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
 		 

         function viewProjectEva(formId){
			 var url = "${contextPath}/quality/sampling/view.action?backPage=1&formId="+formId;
			 $('#viewProjectEvaDlgFrame').attr('src', url);
			 $('#viewProjectEvaDlg').window('open');
         }
 		/* 查看 */
  		function goProjectMenuView(projectId,project_name){
  			var addSjwtUrl  = '${contextPath}/archives/pigeonhole/viewDataFile.action?project_id=' + projectId ;
  			aud$openNewTab(project_name, addSjwtUrl, false);
  		}
 		
 		/* 历史项目查看 */
 		function goProjectMenuHistoryView(projectId,project_name){
 			var addSjwtUrl  = '${contextPath}/archives/pigeonhole/editHistoryProject.action?noBack=1&project_id=' + projectId ;
  			aud$openNewTab(project_name, addSjwtUrl, false);
 		}
 		</script>
	</body>
</html>
