
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
			<s:form id="myform" name="myform" action="getProjectQualityList.action" namespace="/quality/sampling" method="post">
				<table id="searchTable" cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr >
						<td class="EditHead">
							评价状态
						</td>
						<td class="editTd" >
							<select class="easyui-combobox" data-options="panelHeight:'auto'" name="pQ.status" style="width:80%"  editable="false">
								<option value="">请选择</option>
								<s:iterator value="#@java.util.LinkedHashMap@{'010':'待分配','020':'评价中','030':'已评价'}" id="entry">
									<option value="<s:property value="key"/>"><s:property value="value"/></option>
								</s:iterator>
							</select>
						</td>
						<td class="EditHead" style="width:20%">
							项目编号
						</td>
						<td class="editTd" style="width:33%">
							<s:textfield cssClass="noborder" name="pQ.project_code" cssStyle="width:80%" maxlength="50"/>
						</td>
					</tr>
					<tr>

						<td class="EditHead" style="width:15%">
							项目名称
						</td>
						<td class="editTd" style="width:32%">
							<s:textfield cssClass="noborder" name="pQ.project_name" cssStyle="width:80%" maxlength="50"/>
						</td>

						<td class="EditHead" style="width:15%">
							分配的评价人
						</td>
						<td class="editTd" style="width:32%">
							<s:textfield cssClass="noborder" name="pQ.allot_userName" cssStyle="width:80%" maxlength="50"/>
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
		
		<div id="evaWindow" style="overflow: hidden;" title="人员分配">
			<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
				<s:hidden name="formId" id="evaFormId"/>
				<tr>
					<td class="EditHead" style="width:30%"><font color="red">*</font> 评价人员分配</td>
					<td class="editTd">
						<s:buttonText2 id="allot_userName" hiddenId="allot_userCode" cssClass="noborder"
									   name="allot_userName"
									   hiddenName="allot_userCode"
									   doubleOnclick="showSysTree(
										this,
										{
											url:'${pageContext.request.contextPath}/systemnew/orgListByAsyn.action',
											param:{
												'p_item':1,
												'orgtype':1
											},
											title:'请选择评价人员',
											type:'treeAndEmployee'
										})"
									   doubleSrc="${pageContext.request.contextPath}/easyui/1.4/themes/icons/search.png"
									   doubleCssStyle="cursor:pointer;border:0"
									   readonly="true"
									   maxlength="1000" title="评价人员"/>

					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:30%"><font color="red">*</font> 评价开始时间</td>
					<td class="editTd">
						<input type="text" class="easyui-datebox" editable="false" name="eva_start_time" id="eva_start_time" style="width: 150px">
					</td>
				</tr>
				<tr>
					<td class="EditHead" style="width:30%"><font color="red">*</font> 评价结束时间</td>
					<td class="editTd">
						<input type="text" id="eva_end_time" name="eva_end_time" class="easyui-datebox" editable="false" style="width: 150px"/>
					</td>
				</tr>
			</table>
			<div style="margin-top:30px;text-align: center;">
				<a id='sureAt' class="easyui-linkbutton" iconCls="icon-save" onclick="saveAllotPerson()">保存</a>&nbsp;&nbsp;
				<a id='clearAt' class="easyui-linkbutton" iconCls="icon-cancel" onclick="closeEva()">取消</a>&nbsp;&nbsp;
			</div>
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
			    // 初始化生成表格
				datagrid = $('#projectList').datagrid({
				    url:"<%=request.getContextPath()%>/quality/sampling/getProjectQualityList.action?querySource=grid",
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
					remoteSort: false,
					singleSelect:true,
					toolbar:[{
							id:'search',
							text:'查询',
							iconCls:'icon-search',
							handler:function(){
								searchWindShow('dlgSearch');
							}
						},
						{
							id:'editProject',
							text:'分配',
							iconCls:'icon-edit',
							handler:function(){
								editProject();
							}
						},'-',helpBtn
					],
					onLoadSuccess:function(){
						initHelpBtn();
					},
					frozenColumns:[[
									/* {field:'formId',width:50, checkbox:true,halign:'center', align:'center'}, */
					       			{field:'status_name',title:'评价状态',halign:'center',align:'center',sortable:true, width:0.08*bodyW+'px'},
					       			{field:'project_code',title:'项目编号',width:0.15*bodyW+'px',sortable:true,halign:'center',align:'center'}
					    		]],
					columns:[[  
						{field:'project_name',
								title:'项目名称',
								width:0.2*bodyW+'px',
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
						{field:'allot_userName',
							title:'分配的评价人',
							halign:'center',
							width:0.1*bodyW+'px',
							sortable:true, 
							align:'center'
						},
						{field:'eva_start_time',
							 title:'评价开始时间',
							 halign:'center',
							 width:0.1*bodyW+'px',
							 align:'center', 
							 sortable:true
						},
						{field:'eva_end_time',
							 title:'评价结束时间',
							 width:0.1*bodyW+'px',
							 halign:'center',
							 align:'center', 
							 sortable:true
						}

					]]   
				});
				//单元格tooltip提示
				$('#projectList').datagrid('doCellTip', {
					onlyShowInterrupt : true,
					position : 'bottom',
					maxWidth : '200px',
					tipStyler : {
						'backgroundColor' : '#EFF5FF',
						borderColor : '#95B8E7',
						boxShadow : '1px 1px 3px #292929'
					}
				
				});
				

				
			});
         
			
			jQuery(document).ready(function(){
				$('#evaWindow').window({   
					width:500,   
					height:250,   
					modal:true,
					collapsible:false,
					maximizable:false,
					minimizable:false,
					closed:true 
				}); 
			})	
			
		 function goProjectMenu(formId){
				window.open(
						'${contextPath}/project/prepare/projectIndex.action?crudId='
								+ formId + '&source=view&projectview=view&isView=2&view=view', '',
								'height=700px, width=1300px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
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
 		
		 function editProject(){
			 var rows = $("#projectList").datagrid("getSelections");
			 if ( rows.length != 1 ){
				 showMessage1("请选择一条记录！");
				 return false;
			 }

			 $("#allot_userName").val(rows[0].allot_userName);
			 $("#allot_userCode").val(rows[0].allot_userCode);
			 $("#eva_start_time").datebox("setValue", rows[0].eva_start_time);
			 $("#eva_end_time").datebox("setValue", rows[0].eva_end_time);

			 if ( rows[0].status == "010"){
				 $("#evaFormId").val(rows[0].formId);  
				 $("#evaWindow").window("open");
			 }else if (rows[0].status == "020"){
				 top.$.messager.confirm("提示","确定修改评价人吗？",function(r){
						if(r){
							 $("#evaFormId").val(rows[0].formId);  
							 $("#evaWindow").window("open");
						}
				 });	
			 } else{
				 showMessage1("请选择待分配状态！");
				 return false;
			 }
			
			 
		 } 
		
		  // 保存人员 
		 function saveAllotPerson(){
			 var evaFormId = $("#evaFormId").val();
			 var allot_userCode = $("#allot_userCode").val();
			 var allot_userName = $("#allot_userName").val();
			 if (allot_userName == null || allot_userName == "" ){
				 top.$.messager.show({title:'提示消息',msg:'评价人员分配不能为空！'});
				 return false;
			 }
			 var eva_start_time = $("#eva_start_time").datebox('getValue');
			 if (eva_start_time == null || eva_start_time == "" ){
				 top.$.messager.show({title:'提示消息',msg:'评价开始时间不能为空！'});
				 return false;
			 }
			 var eva_end_time = $("#eva_end_time").datebox('getValue');
			 if (eva_end_time == null || eva_end_time == "" ){
				 top.$.messager.show({title:'提示消息',msg:'评价结束时间不能为空！'});
				 return false;
			 }
			 if (new Date(eva_start_time).getTime() > new Date(eva_end_time).getTime()) {
				 top.$.messager.show({title:'提示消息',msg:'评价开始时间不能大于评价结束时间！'});
				 return false;
			 }

			 $.ajax({
				 url:'${contextPath}/quality/sampling/saveAllotPerson.action',
				 type:'post',
				 data:{"formId":evaFormId,"allot_userCode":allot_userCode,"allot_userName":allot_userName,"eva_start_time":eva_start_time,"eva_end_time":eva_end_time},
				 success:function(data){
					 if ( data == "1"){
						 top.$.messager.show({title:'提示消息',msg:'保存成功！'});
						 closeEva();
						 $("#projectList").datagrid('reload');
						 // $("#evaWindow").window("close");
					 }else{
						 top.$.messager.show({title:'提示消息',msg:'保存失败！'});
					 }
				 }
			 })

		 }
		 
		  /*  关闭 */
		 function closeEva(){
			 $("#evaWindow").window("close");
		 }
 		</script>
	</body>
</html>
