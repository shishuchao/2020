<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>取证记录列表</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
	<script type="text/javascript">
		$(function(){
			//查询
			showWin('dlgSearch');
				var projectId = document.getElementsByName('project_id')[0].value;
				// 初始化生成表格
				$('#list_evidenceList').datagrid({
					url : "<%=request.getContextPath()%>/project/evidence/listEvidence.action?querySource=grid&project_id="+projectId,
					method:'post',
					showFooter:false,
					rownumbers:true, 
				 	pagination:true, 
					striped:true,
					autoRowHeight:false,
					fit: true,
					fitColumns:false,
					border:false,
					singleSelect:false,
					remoteSort: false,
					pageSize:20,
					//selectOnCheck: false,
					toolbar: '#tb',
					onBeforeLoad:validationEvidence(),
				
					columns:[[  
                           {field:'status_code',width:'50', checkbox:true, align:'center'},
	                       {field:'status_name',title:'取证记录状态',width:'15%',halign:'center',sortable:true,align:'left'}	,     
                         {field:'evidence_name',
	                     title:'取证记录名称',
	                     width:'20%',
	                     halign:'center', 
	                     align:'left', 
	                     sortable:true
                        },
						{field:'evidence_code',
							title:'取证记录编号',
							sortable:true, 
							halign:'center',
							width:'18.5%',
							align:'center'
						},
						 
						/*	{field:'evidence_source',
							 title:'证据来源',
							 width:150, 
							 halign:'center',
							 align:'left', 
							 sortable:true
						}, */
						{field:'audit_object_name',
							 title:'被审计单位',
							 align:'center',
							 halign:'center', 
							 width:'18%',
							 sortable:true,
							 formatter:function(value,rowData,rowIndex){
									return rowData.audit_object_name;
						}},
						{field:'creator_name',
							 title:'撰写人',
							 halign:'center',
							 align:'center', 
							 width:'14%',
							 sortable:true
						},
						{field:'operate',
							title:'操作',
							halign:'center',
							align:'right',
							 width:'6%',
							sortable:true,
							formatter:function(value,row,rowIndex){
								if('view' != "${view}"){
									var param = [row.formId,row.status_code];
									var btn2 = "修改,openModifyEvidencePage,"+param.join(',');
									return ganerateBtn(btn2);
								}
							
							}
						}
						
					]]   
				}); 
			});
		function validationEvidence(){
			jQuery.ajax({
    			url:'${contextPath}/project/evidence/isMyProject.action',
    			type:'POST',
    			data:{"project_id":'${project_id}',"view":'${view}'},
    			dataType:'json',
    			async:false,
    			success:function(data){
    				if(data.flag=='true'){
    					document.getElementById("addGroupButton").style.display="none";
    					document.getElementById("logoutGroupButton").style.display="none";
    				//	document.getElementById("modifyGroupButton").style.display="none";
    					document.getElementById("deleteGroupButton").style.display="none";
    					document.getElementById("editGroupButton").style.display="none";
    				}
    				if(data.role != 1){
    					document.getElementById("editGroupButton").style.display="none";
    				}
    				 if ( '${param.projectview}' == 'view'){
    					 document.getElementById("search").style.display =  "none";
    				}
    			},
    			error:function(){

    			}
    		});
		}
		function changeButtonState(){};
		</script>
	</head>
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
		<div id="dlgSearch" class="searchWindow">
			<div class="search_head">
				<s:form id="myForm" name="myForm" action="listEvidence" namespace="/project/evidence" method="post">
					<s:hidden name="project_id"/>
					<s:hidden name="roleid" id="roleid"/>
					<s:hidden name="view" value="${view}"/>
					<s:token/>
					<input type="hidden" name="randomdigit" id="randomdigit"/>
					<table class="ListTable" align="center">
						<tr >
							<td align="left" class="EditHead">
								取证记录状态
							</td>
							<td align="left" class="editTd">
								<select class="easyui-combobox" id="status_code" name="evidence.status_code"  editable="false" panelHeight="auto">
								    <option value="">&nbsp;</option>
									<option value="110">草稿</option>
									<option value="120">正在审批</option>
									<option value="130">审批完成</option>
									<option value="140">已经注销</option>
									<!-- <option value="150">已删除</option> -->
								</select>
							</td>
							<td align="left" class="EditHead">
								取证记录名称
							</td>
							<td align="left" class="editTd">
								 
								<s:textfield id="evidence_name" name="evidence.evidence_name" cssClass="noborder" />
								
								<%--
								<input id="evidence_name" name="evidence.evidence_name" type="text" style="width:150px">
								--%>
							</td>
							
						</tr>
					 <tr >
							<td align="left" class="EditHead">
								被审计单位
							</td>
							<td align="left" class="editTd">
								<s:textfield id="evidence_audit_object_name" name="evidence.audit_object_name" cssClass="noborder" />
							</td>
							<td align="left" class="EditHead">
									撰写人
							</td>
							<td align="left" class="editTd">
								<s:textfield id="evidence_creator_name" name="evidence.creator_name" cssClass="noborder" />
							</td>
						</tr> 
					</table>
				</s:form>
			</div>
			<div class="serch_foot">
			     <div class="search_btn">
					<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="resetFun()">重置</a>&nbsp;
					<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
				</div>
			</div>
		</div>
		<div region="center">
			<table id="list_evidenceList"></table>
		</div>
		 	<div id='atTreeWrap' title='取证记录编号' style='overflow:hidden;padding:0px;'>
		 	 <div style="text-align:left;padding:0 0 2px 5px;padding-top:30px;">取证记录编号:&nbsp;&nbsp;
		 	   <span id="contion_evidence"></span>
               	<s:hidden name="contion_evidencename" id="contion_evidenceid"/>
		 	    <s:textfield id="contion_evidencecode"  maxLength="6" cssStyle="width:20%;height:24px;padding-top:5px;" ></s:textfield>&nbsp;&nbsp;
		 	   <a id='sureAtEvidence'  class="easyui-linkbutton"  iconCls="icon-save">确定</a>&nbsp;&nbsp;
		 		<a  id='clearAtEvidence'  class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>&nbsp;&nbsp;
		 	</div> 
		 	</div>
		
		<div id="tb">  	
			<a href="javascript:;" class="easyui-linkbutton" id="editGroupButton"   onclick="openeditEvidencePage()"       data-options="iconCls:'icon-edit',plain:true">调整取证记录编号</a>
			<a href="javascript:;" class="easyui-linkbutton" id="search"            onclick="freshGrid()"              data-options="iconCls:'icon-search',plain:true">查询</a>
			<a href="javascript:;" class="easyui-linkbutton" id="addGroupButton"    onclick="openAddEvidencePage()"    data-options="iconCls:'icon-add',plain:true">新增</a>
<!-- 			<a href="javascript:;" class="easyui-linkbutton" id="modifyGroupButton" onclick="openModifyEvidencePage()" data-options="iconCls:'icon-edit',plain:true">修改</a>
 -->			<a href="javascript:;" class="easyui-linkbutton" id="deleteGroupButton" onclick="deleteEvidence()"         data-options="iconCls:'icon-delete',plain:true">删除</a>
			<a href="javascript:;" class="easyui-linkbutton" id="viewGroupButton"   onclick="openViewEvidencePage()"   data-options="iconCls:'icon-view',plain:true">查看</a>
			<a href="javascript:;" class="easyui-linkbutton" id="exportGroupButton" onclick="exportEvidence()"         data-options="iconCls:'icon-export',plain:true">导出</a>
			<a href="javascript:;" class="easyui-linkbutton" id="logoutGroupButton" onclick="logoutEvidence()"         data-options="iconCls:'icon-cancel',plain:true">注销</a>
		</div>
		<div id="templateWindow">
			<table id="templateList"></table>
		</div>
		<script type="text/javascript">
		jQuery(document).ready(function(){
			 $('#atTreeWrap').window({   
					width:500,   
					height:150,   
					modal:true,
					collapsible:false,
					maximizable:false,
					minimizable:false,
					closed:true
				}); 
				$('#sureAtEvidence').bind('click',function(){
					  var ids = $('#list_evidenceList').datagrid('getSelections');
						if (ids.length != 1) {
							$.messager.show({title:'提示信息',msg:'请选择一条信息!'});
							return false;
						}	 
					
					  var idV =ids[0].formId;
					
					var contion_evidencecode = $("#contion_evidencecode").val();
					var contion_evidenceid = $("#contion_evidenceid").val();
					if(contion_evidencecode != null && contion_evidencecode != ""  ){
					  var  vatest=/^[0-9]*[1-9][0-9]*$/;
					  var va= vatest.test(contion_evidencecode);
					  if(!va){
						  $.messager.show({title:'提示信息',msg:'输入必须为整数数字!'});
						  return false;
					   }
					  var  contion_evidencecodes=contion_evidenceid+contion_evidencecode;
				
						 $.ajax({
							  url:"${contextPath}/project/evidence/editEvidencePage.action",
							  type:'POST',
							   data: {"project_id":"${project_id}","crudId":idV,"evidence_code":contion_evidencecodes},
							  success: function(data){
									 if(data.saveEvidencecode == 1){
									$("#myForm").submit();
									  $.messager.show({title:'提示信息',msg:'保存编号成功 ！'});
									}else if (data.saveEvidencecode == 0){
								      $.messager.show({title:'提示信息',msg:'取证记录已经编号存在！'});
									}else{
									  $.messager.show({title:'提示信息',msg:'保存失败 ！'});
									}  
							  }
						   });
					}else{
					    $.messager.show({title:'提示信息',msg:'取证记录编号不能为空！'});
					}
				});   
				$('#clearAtEvidence').bind('click',function(){
					$('#atTreeWrap').window('close');
	 			}); 
		});
		
		
		
		$(function(){
			$("#status_code").find("option[value='${evidence.status_code}']").attr("selected",true);		
		});
		function freshGrid(){
			searchWindShow('dlgSearch',750);
		}
		
		  function openeditEvidencePage(){
			  var ids = $('#list_evidenceList').datagrid('getSelections');
				if (ids.length != 1) {
					$.messager.show({title:'提示信息',msg:'请选择一条信息!'});
					return false;
				}	 
			
			  var idV =ids[0].formId;
	        
	        	  $.messager.confirm('提示信息', '确定更改取证记录编号吗？', function(is){
	        	if(is){
	        	  $('#atTreeWrap').window('open');
	        	      $.ajax({
						  url:"${contextPath}/project/evidence/dateEvidencePage.action",
						  type:'POST',
						   data: {"project_id":"${project_id}","crudId":idV},
						  success: function(data){
								if(data.dateEvidecode != null && data.dateEvidecode !=""){
									document.getElementById('contion_evidence').innerHTML=data.dateEvidecode;	
									$("#contion_evidenceid").val(data.dateEvidecode);
									$("#contion_evidencecode").val(data.dateEvideshu);
									$('#atTreeWrap').window('open');
								}
								else{
									$.messager.show({title:'提示信息',msg:'原编码错误 ！'});
								}
						  }
					   }); 
	                };
	   
	        	  });
		   }
		
		
		/*
		* 查询
		*/
		function doSearch(){
			if($('#status_code').combobox('getValue') == "110"){
				if('${param.projectview}' !='view'){
					$("#roleid").val("1");
				}
				
			}
        	$("#list_evidenceList").datagrid({
				queryParams:form2Json("myForm")
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
		function resetFun(){
			resetForm('myForm');
			doSearch();
		}
		/**
			添加
		*/
		function openAddEvidencePage(){
			window.location.href = '${contextPath}/project/evidence/edit.action?project_id=${project_id}';		
		}
		
		/**
			查看记录
		*/
		function openViewEvidencePage(){
				var ids = $('#list_evidenceList').datagrid('getSelections');
				if (ids.length != 1) {
					$.messager.show({title:'提示信息',msg:'请选择一条信息!'});
					return false;
				}	
				var selectedValue = ids[0].formId;
				window.location.href = '${contextPath}/project/evidence/view.action?winview=benpage&view=${view}&project_id=${project_id}&projectview=${param.projectview}&crudId='+selectedValue;
				
		}		
		
		/**
			已审批完成的记录，先注销，再组长和主审删除
		*/
		function logoutEvidence(){
				var ids = $('#list_evidenceList').datagrid('getSelections');
				if (ids.length != 1) {
					$.messager.show({title:'提示信息',msg:'请选择一条信息!'});
					return false;
				}	
				var selectedValue = ids[0].formId;
				$.messager.confirm('提示信息', '确定要注销取证记录信息吗?', function(isLogout){
					if(isLogout){
						$.ajax({
							   type: "POST",
							   url: "${contextPath}/project/evidence/logoutOpr.action",
							   data: {"project_id":"${project_id}","crudId":selectedValue},
							   success: function(reV){
									if(reV=='suc'){
										$.messager.show({title:'提示信息',msg:'注销成功!'});	
										doSearch();
									}else if(reV=='other'){
										$.messager.show({title:'提示信息',msg:'只能注销自己的创建的已审批完成的取证记录!'});								
									}else if(reV=='statusfail'){
										$.messager.show({title:'提示信息',msg:'已审批完成的取证记录才能注销!'});								
									}else{
										$.messager.alert('提示信息','操作失败!','erro');
									}
							   }
						});
					}
				});					
		}	
		
		/**
			修改记录
		*/
		function openModifyEvidencePage(selectedValue,status_code){
				/* var ids = $('#list_evidenceList').datagrid('getSelections');
				if (ids.length != 1) {
					$.messager.show({title:'提示信息',msg:'请选择一条信息!'});
					return false;
				}
				var selectedValue = ids[0].formId; */
			if(status_code != null){
				if("130" == status_code){
					$.messager.show({title:'提示信息',msg:'取证记录已被审批完成！'});
					return false;
				}
				if("140" == status_code){
					$.messager.show({title:'提示信息',msg:'取证记录已被注销！'});
					return false;
				}
			}
				$.ajax({
					   type: "POST",
					   url: "${contextPath}/project/evidence/modifyValidate.action",
					   data: {"project_id":"${project_id}","crudId":selectedValue},
					   success: function(reV){
							if(reV=='suc'){
								window.location.href = '${contextPath}/project/evidence/edit.action?project_id=${project_id}&crudId='+selectedValue;
							}else if(reV=='nouser'){
								$.messager.show({title:'提示信息',msg:'只能修改自己撰写的取证记录!'});
							}else if(reV=='nostatus'){
								$.messager.show({title:'提示信息',msg:'只有草稿状态和本人正在审批的取证记录才能编辑!'});							
							}else if(reV=='fal'){
								$.messager.show({title:'提示信息',msg:'取证记录正在被审批!'});
							}else{
								$.messager.alert('提示信息','操作异常!','erro');
							}
					   }
				});					
			
		}
		
		/**
			删除记录
		*/
		function deleteEvidence(){
			var rows = $('#list_evidenceList').datagrid('getChecked');
			var crudIds = '';
			for(var i=0;i<rows.length;i++){
				crudIds += rows[i].formId + ',';
			}
			if (rows.length == 0) {
				$.messager.show({title:'提示信息',msg:'请选择一条信息!'});
				return false;
			}
			$.messager.confirm('提示信息', '确定要删除取证记录信息吗?', function(isDel){
				if(isDel){
					$.ajax({
						   type: "POST",
						   url: "${contextPath}/project/evidence/delOpr.action",
						   data: {"project_id":"${project_id}","crudId":crudIds},
						   success: function(reV){
								if(reV=='suc'){
									$.messager.show({title:'提示信息',msg:'删除成功!'});	
									doSearch();
								}else if(reV=='nouser'){
									$.messager.show({title:'提示信息',msg:'只能删除自己撰写的取证记录!'});
								}else if(reV=='fail140'){
									$.messager.show({title:'提示信息',msg:'已注销的取证记录，只有组长和主审才能删除!'});
								}else{
									$.messager.show({title:'提示信息',msg:'只有草稿和已注销状态的取证记录才能删除!'});
								}
						   }
					});
				}							
			}); 							
		}
		/* liululu */
		/**导出
		*/
		function exportEvidence(){
				var ids = $('#list_evidenceList').datagrid('getSelections');//返回的是个数组
			        if(ids.length == 0){
			            $.messager.show({title:'提示信息',msg:'请选择要导出的底稿!'});
			            return false;
			        } 
			       /*  for(i=0;i <ids.length;i++){
			        	 var sevidenceType = ids[i].evidenceType;
			        	 alert(sevidenceType);
			        	 var evidenceType ="evidence";
			             if(!(sevidenceType && evidenceType && sevidenceType.toLowerCase() == evidenceType.toLowerCase())){
			                 var ms_code = ids[i].evidence_name;
			                 $.messager.show({title:'提示信息',height:'auto',msg:'记录【'+ms_code+'】不适合取证记录导出模板!'});
			                 return;
			             }
			        } */
			        var evidenceIdArray=new Array();
					   for(i=0;i <ids.length;i++){
			                var tempformId = ids[i].formId;
			                evidenceIdArray.push(tempformId);
					   }	 
			        var selectedValue = evidenceIdArray.join(",");
			        //判断记录数量
			         jQuery.ajax({
						url:'${contextPath}/operate/manuExt/pandManuTem.action?type=evidence&project_id='+ids[0].project_id,
						type:'POST',
						dataType:'text',
						async:false,
						success:function(data){
							if(data == 2) {
									// 初始化生成表格
									$('#templateList').datagrid({
									url : "<%=request.getContextPath()%>/operate/manuExt/reportTemplateList.action?type=evidence&project_id="+ids[0].project_id,
									method:'post',
									showFooter:false,
									rownumbers:true,
									striped:true,
									autoRowHeight:false,
									fit: true,
									fitColumns:true,
									idField:'id',
									border:false,
									singleSelect:true,
									remoteSort: false,
									columns:[[
										{field:'name',
											title:'模板名称',
											width:200,
											halign:'center',
											align:'left',
											sortable:true
										},
										{field:'operate',
											title:'操作',
											width:100,
											align:'center',
											formatter:function(value,row,index){
												var link = '<a href=\"javascript:void(0);\" onclick=\"expEvidence(\''+row.templateId+'\',\''+selectedValue+'\',\''+ids[0].project_name+'\',\''+ids[0].project_id+'\');\">导出</a>';
												return link;
											}
										}
									]]
								});
			
								$('#templateWindow').window({
									title:'选择取证记录模板',
									width:600,
									height:400,
									modal:true,
									collapsible:false,
									maximizable:true,
									minimizable:false
								});
							}else if(data == 0){
								showMessage1('请维护对应的模板！');
							}else{
								expEvidence(data,selectedValue,ids[0].project_name,ids[0].project_id);
						}
					},
						error:function(){
							showMessage1('出错啦！');
						}
			});
		}
		/*
		 * 创建quzheng
		 */
		function expEvidence(templateId,crudId,project_name,project_id){
			var h = window.screen.availHeight;
			var w = window.screen.width;
			window.showModalDialog("/ais/project/evidence/expEvidence.action?templateId="+templateId+"&crudId="+crudId+"&project_name="+encodeURI(project_name)+"&project_id="+project_id,window,'dialogWidth:'+w+'px;dialogHeight:'+h+'px;status:no;resizable:yes;minimize:yes;maximize:yes;');
			 $("#templateWindow").window({"onOpen":function(){
				 $("#templateWindow").window('close');
			 }}); 
			 location.reload();
		}
		/*
			改变底部按钮状态
		*/
		function changeGroupButtonState(status_code){
			var deleteButton = document.getElementById('deleteGroupButton');
		//	var modifyGroupButton = document.getElementById('modifyGroupButton');
			var logoutGroupButton = document.getElementById('logoutGroupButton');
			
			//只有草稿状态才能修改和删除
			if(status_code=='110'){
				//草稿状态
				deleteButton.disabled=false;
			//	modifyGroupButton.disabled=false;
				logoutGroupButton.disabled=true;
			}else if(status_code=='120'){
				//140已注销
				deleteButton.disabled=true;
				logoutGroupButton.disabled=true;		
			}else if(status_code=='130'){
				//130审批完成
				deleteButton.disabled=true;
			//	modifyGroupButton.disabled = true;	
				logoutGroupButton.disabled=false;		
			}else if(status_code=='140'){
				//140已注销
				deleteButton.disabled=false;
			//	modifyGroupButton.disabled = true;	
				logoutGroupButton.disabled=true;		
			}else{
				deleteButton.disabled=true;
			//	modifyGroupButton.disabled = true;	
				logoutGroupButton.disabled=true;			
			}
		}
		</script>
	</body>
</html>