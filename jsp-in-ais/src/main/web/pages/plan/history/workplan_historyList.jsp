<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@page import="com.opensymphony.xwork2.ActionContext"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>项目计划列表(项目启动)</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
     	<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="${contextPath}/pages/tlInteractive/tlInteractiveCommon.js"></script>
	</head>
	<body>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<div id="dlgSearch" class="searchWindow">
			<div class="search_head">
			<s:form name="searchForm" id="searchForm" action="listDetailStart" namespace="/plan/detail">
				<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr>
							<td class="EditHead">项目年度</td>
							<td class="editTd">
								<select editable="false" id="plan_year" class="easyui-combobox" style="width:150px;" editable="false" panelHeight="200">
									<option value="">&nbsp;</option>
									<s:iterator value="@ais.project.ProjectUtil@getIncrementSearchYearList(10,0)" id="entry">
										<option value="<s:property value="key"/>"><s:property value="value"/></option>
									</s:iterator>
								</select>
								<input type="hidden" name="crudObject.w_plan_year" id="w_plan_year"/>
							</td>
							<td class="EditHead">
							项目名称
						</td>
						<td class="editTd">
							<s:textfield  cssClass="noborder" name="crudObject.w_plan_name"  maxlength="50" />
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

		<div region="center">
			<table id="resultList"></table>
		</div>
		<div id="importFileZipWin">
		  <iframe id="tmpIframe" name="tmpIframe" style='display:none'></iframe>	
		  <form id="importForm" method="post" target="tmpIframe" enctype="multipart/form-data">
		    <table cellpadding=0 cellspacing=0 border=0 class="ListTable" align="center">
				<input type='hidden' name='fileSuffix' id='fileSuffix' value=''/>
				<tr>
					<td align="left" class="EditHead" style="vertical-align: middle;">选择文件</td>
					<td class="editTd" align="left">
						<s:file name="myfile" id='syZipFile' size="66%" cssStyle="font-size:15px" accept="application/zip"/>
					</td>
				</tr>
			</table>
		  
		  </form>
		
		</div>
	

			<script type="text/javascript">
				/*
				 * 查询
				 */
				function doSearch(){
					$('#resultList').datagrid({
						queryParams:form2Json('searchForm')
					});
                    //单元格tooltip提示
                    $('#resultList').datagrid('doCellTip', {
						onlyShowInterrupt:true,
                        position : 'bottom',
                        maxWidth : '200px',
                        tipStyler : {
                            'backgroundColor' : '#EFF5FF',
                            borderColor : '#95B8E7',
                            boxShadow : '1px 1px 3px #292929'
                        }
                    });
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
					resetForm('searchForm');
				}
			
			var type="${type=='edit'}";
			$(function(){
                $('#plan_year').combobox({
                    onChange:function(newVal,oldVal){
                        $('#w_plan_year').val(newVal);
                    }
                });
		/* 	    if('${crudObject.w_plan_year}' == '') {
                    var now = new Date();
                    $('#plan_year').combobox('setValue', now.getFullYear());
                    $('#plan_year').combo('setText', now.getFullYear());
                    $('#w_plan_year').val(now.getFullYear());
                }else{
                    $('#plan_year').combobox('select', '${crudObject.w_plan_year}');
                } */

			    var bodyW = $('body').width();
				//查询
				showWin('dlgSearch');
				// 初始化生成表格
				$('#resultList').datagrid({
					url : "<%=request.getContextPath()%>/plan/history/historyWorkplanList.action?querySource=grid",
					method:'post',
					showFooter:true,
					rownumbers:true,
					pagination:true,
					striped:true,
					autoRowHeight:true,
					fitColumns:true,
					fit:true,
					border:false,
					cache:false,
					pageSize: 20,
					singleSelect:true,
					remoteSort: true,
					queryParams:{
					  'crudObject.w_plan_year':  $('#w_plan_year').val()
                    },
					toolbar:[{
						id:'search',
						text:'查询',
						iconCls:'icon-search',
						handler:function(){
							searchWindShow('dlgSearch',750);
						}
					},'-',{
						id:'add',
						text:'新增',
						iconCls:'icon-add',
						handler:function(){
							addPlanItem();
						}
					},'-',{
						id:'delete',
						text:'删除',
						iconCls:'icon-delete',
						handler:function(){
							deletePlanItem();
						}
					},/* '-',{
						id:'exportFile',
						text:'导出历史文件模板',
						iconCls:'icon-export',
						handler:function(){
							exportFile();
						}
					},'-',{
						id:'toImport',
						text:'导入历史文档',
						iconCls:'icon-import',
						handler:function(){
							importItem();
						}
					}, */ '-',helpBtn
					
				],
					onLoadSuccess:function(){
						initHelpBtn();
					},
					onClickCell:function(rowIndex, field, value) {
						if(field == 'w_plan_name') {
							var rows = $('#resultList').datagrid('getRows');
							var row = rows[rowIndex];
							var id = "";
							if ( row.proInfo != null ){
								id = row.proInfo.formId;
							}
							planName(row.formId,id,row.w_plan_name);
						}
					},
					columns:[[
                        {field:'formId',width:'50',halign:'center',hidden:true, align:'center'},    
						{field:'plan',title:'项目状态',width:0.08*bodyW+'px',align:'center',halign:'center',sortable:false,
							formatter:function(value,rowData,rowIndex){
								var result ="";
								var id = "";
								var archives_closed = "";
								if ( rowData.proInfo != null ){
									id = rowData.proInfo.formId;
									archives_closed = rowData.proInfo.archives_closed;
								}
								if(id !='' && archives_closed == '1') {
									result = "已提交" ;
								}else if ( id != ''){
									result = "资料补录" ;
								}else  {
									result = "未提交" ;
								}
								return result;
							}
						},
						{field:'w_plan_name',title:'项目名称',width:0.15*bodyW+'px',align:'left',halign:'center',sortable:true,
							formatter:function(value,rowData,rowIndex){
								var result;
								var id = "";
								var archives_closed = "";
								if ( rowData.proInfo != null ){
									id = rowData.proInfo.formId;
									archives_closed = rowData.proInfo.archives_closed;
								}
								if(id !='' && archives_closed == '1') {
									result = ["<label title='单击查看' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
								} else {
									result = ["<label title='单击编辑' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
								}
								return result;
							}
						},

						{field:'w_plan_year',
							title:'项目年度',
							width:0.08*bodyW+'px',
							sortable:true,
							align:'center'
						},
						{field:'audit_dept_name',
							 title:'审计单位',
							 width:0.08*bodyW+'px',
							 align:'left',
							 sortable:true
						},
						{field:'audit_object_name',
							 title:'被审计单位',
							 width:0.08*bodyW+'px',
							 align:'left',
							 sortable:true
						},
						{field:'pro_type_name',
							title:'项目类别',
							width:0.08*bodyW+'px',
							sortable:true,
							align:'left',		
							formatter:function(value,rowData,rowIndex){
								if(rowData.pro_type_child_name != null && rowData.pro_type_child_name != '') {
									return rowData.pro_type_child_name;
								} else {
									return value;
								}
							}
						},
						{field:'audit_start_time',
							title:'审计期间开始',
							width:0.08*bodyW+'px',
							align:'center',
							sortable:true,
							formatter:function(value,rowData,rowIndex){
								if ( value != null ){
									return value.substring(0,10);
								}
							}
							},
						{field:'audit_end_time',
							title:'审计期间结束',
						    width:0.08*bodyW+'px',
							align:'center',
							sortable:true,
							formatter:function(value,rowData,rowIndex){
								if ( value != null ){
									return value.substring(0,10);
								}
							}
						},
						{field:'pro_teamleader_name',
							title:'项目组长',
							width:0.08*bodyW+'px',
							sortable:true,
							align:'center'
						},
						{field:'pro_auditleader_name',
							title:'项目主审',
							width:0.08*bodyW+'px',
							align:'center',
							sortable:true
						},
							
						
					]]
				});
				//单元格tooltip提示
				$('#resultList').datagrid('doCellTip', {
					onlyShowInterrupt:true,
					position : 'bottom',
					maxWidth : '200px',
					tipStyler : {
						'backgroundColor' : '#EFF5FF',
						borderColor : '#95B8E7',
						boxShadow : '1px 1px 3px #292929'
					}
				});

			$("#importFileZipWin").dialog({
				title:'导入历史项目文书',
			    height:300,
			    width:700,
			    closed:true,
			    cache:false,
			    shadow:false,
			    model:true,
			    resizable:true,
			    minimizable:true,
			    maximizable:true,
			    iconCls:'icon-import',
				onOpen:function(){
					clearTemplateFile();
				},
				buttons:[{
					text:'导入文件',
					iconCls:'icon-import',
					handler:function(){
						importFile();
					}
				},{
					text:'清空',
					iconCls:'icon-',
					handler:function(){
						clearTemplateFile();
					}
				},{
					text:'关闭',
					iconCls:'icon-close',
					handler:function(){
						clearTemplateFile();
						$("importFileZipWin").dialog("close");
					}
				}
				]
				
			  });

			});
			
			/**
			导入文件 
			*/
			function importFile(){
				var syZipFile = $('#syZipFile').val();
				if(syZipFile == ''){
					top.$.messager.alert('系统提示',"请先选择要导入的文件",'warning');			
					return;
				}
				if(!aud$checkFile()){
					return;
				}
					top.$.messager.confirm('提示','确定上传文件吗？',function(r){
					      if ( r ){
					    	  importZipFileSubmit()
					      }
					   })
				
			}
			
			function importZipFileSubmit(){
				$("#importForm").form('submit',{
					url:'${contextPath}/interact/interactProxyToWork/mutualToManage.action',
					onSubmit:function(){
						try{
							aud$loadOpen();	
						}catch(e){}
					},
					success:function(data){
						try{
							aud$loadClose();
						}catch(e){}
					}
				});
			}
			
			/**
			*导出模板文件
			*/
			function exportFile(){ 
				var rows = $("#resultList").datagrid("getSelections")
				if ( rows.length < 1){
					showMessage1("请选择一条记录！");
					return false;
				}
				var ids = "";
				for(var i=0;i<rows.length;i++){
					if ( rows[i].proInfo != null ){
						id += rows[i].proInfo.formId+",";
					}else{
						showMessage1(rows[i].w_plan_name+"未提交到项目！");
						return false;
					}
				}
				  var url = "${contextPath}/archives/workprogram/pigeonhole/exportHistoryProject.action?projectIds="+id;
				document.getElementById('searchForm').action = url;
                $('#searchForm').submit();
				
			}
			
			
			// 清空文件选择框
			function clearTemplateFile(){
				$('#fileSuffix').val('');
				var syZipFile = $('#syZipFile')[0];
				syZipFile.outerHTML = syZipFile.outerHTML;
				$('#syZipFile').unbind('change').bind('change', function(){
					 aud$checkFile();
				});
			}
			
			// 上传文件检查
			function aud$checkFile(){
				var filePath = $('#syZipFile').val();
		    	var arr = filePath.split('.');
		    	var suffix = arr[arr.length - 1];
		    	if(suffix && suffix.toLowerCase() != 'zip'){
		    		top.$.messager.alert('系统提示','导入文件后缀名错误，请导入 后缀为zip的文件！','warning');		
		    		return false;
		    	}else{
		    		$('#fileSuffix').val(suffix);
		    		return true;
		    	}
			}
			
			
			
			/*
			*  打开或关闭查询面板
			*/
			function triggerSearchTable(){
				var isDisplay = document.getElementById('planTable').style.display;
				if(isDisplay==''){
					document.getElementById('planTable').style.display='none';
				}else{
					document.getElementById('planTable').style.display='';
				}
			}	
			
			function deletePlanItem(){
				var row = $('#resultList').datagrid('getSelections');
				if (row.length < 1 ){
					showMessage1("请选择一条记录！");
					return false;
				}
				var ids = "";
				for(var i=0;i< row.length;i++){
					if ( row[i].proInfo && row[i].proInfo.formId &&　row[i].proInfo.archives_closed == '1'){
							showMessage1("项目已提交不能删除！");
							return false;
					}else if (row[i].w_writer_person != "${user.floginname}"){
						showMessage1("该项目创建人可删除！");
						return false;
					}else{
						ids += row[i].formId+",";
					}
				}
				$.messager.confirm('确认','确定要删除选中的信息吗？',function(r){
					if(r){
						$.ajax({
							type:'post',
							url:'<%=request.getContextPath()%>/plan/history/deleteHistoryWorkplan.action?ids=' + ids,
							async:false,
							success:function(data){
								if (data == '1'){
									showMessage1("删除成功！");
									$('#resultList').datagrid("reload");
								}else{
									showMessage1("删除失败！");
								}
								
							}
						});
					}
				});
					
			}
		
			/*
				修改选中的单条计划
			*/
			function planName(formId,project_id,project_name){
				var url =  "";
				if (project_id != null && project_id != '' ){
					 url = '<%=request.getContextPath()%>/archives/pigeonhole/editHistoryProject.action?project_id='+project_id;
				}else{
				 url = '<%=request.getContextPath()%>/plan/history/editHistory.action?crudId='+formId+'&history&option=addyuxuan';
				}
				// window.location.href=url;
				//aud$openNewTab(project_name+"-历史项目", url, false);
				window.location.href=url;
			}
			
			function addPlanItem() {
		        var url = '<%=request.getContextPath()%>/plan/history/editHistory.action?prosource=history&option=addyuxuan';
		        //aud$openNewTab('新增项目历史',url,true);
		        window.location.href=url;
			}
					
		</script>

	
	</body>
</html>