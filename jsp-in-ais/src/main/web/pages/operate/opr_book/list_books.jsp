<%@ page contentType="text/html;charset=UTF-8" language="java" import="ais.sysparam.util.SysParamUtil"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>查询书列表</title>
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
		function validationAudBook(){
			jQuery.ajax({
    			url:'${contextPath}/operate/audBook/isMyProject.action',
    			type:'POST',
    			data:{"project_id":'${project_id}',"view":'${view}'},
    			dataType:'json',
    			async:false,
    			success:function(data){
    				if(data.flag=='true'){
    					 document.getElementById("add").style.display =  "none";
    					 document.getElementById("del").style.display =  "none";
    					 document.getElementById("cancel").style.display =  "none";
    					// document.getElementById("edit").style.display =  "none";
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
		</script>
	</head>
	<%-- <body style="overflow:hidden;" class="easyui-layout">
	  <div id="dlgSearch" class="easyui-dialog" title="查询条件" modal="true" closed="true" draggable="true"  style="width:600px;height:300px;overflow:hidden">
		<div region="center" title=""  style="width: 584px; height: 234px;">
		<s:form id="myForm" action="getlistBooks" method="post" namespace="/operate/audBook" >
			<s:hidden name="project_id"/>
			<input type="hidden" name="view" value="${view}"/> --%>
	<!-- 修改这段代码输入框后的小×可以使用 -->		
	<body style="margin: 0;padding: 0;overflow:hidden;" class="easyui-layout">
	  <div id="dlgSearch" class="searchWindow" title="查询条件">
		<div class="search_head">
			<s:form id="myForm" action="getlistBooks" method="post" namespace="/operate/audBook" >
				<s:hidden name="project_id"/>
				<s:hidden name="roleid" id="roleid"/>
				<input type="hidden" name="view" value="${view}"/> 
				<%-- <s:hidden name="view" value="${view}"/> --%>
				<s:token/>
				<table class="ListTable" align="center">
					<tr>
						<td align="left" class="EditHead">
							查询书状态
						</td>
						<td align="left" class="editTd">
							<%-- <s:select cssClass="easyui-combobox"  editable="false" panelHeight="auto"
								list="#@java.util.LinkedHashMap@{'010':'草稿','020':'正在审批','030':'审批完成','040':'注销','050':'已删除'}"
								name="audBook.book_status" theme="ufaud_simple" id="book_status"
								templateDir="/strutsTemplate" emptyOption="true" /> --%>
								<select class="easyui-combobox" id="book_status" name="audBook.book_status"  editable="false" panelHeight="auto">
						    	<option value="">&nbsp;</option>
								<option value="010">草稿</option>
								<option value="020">正在审批</option>
								<option value="030">审批完成</option>
								<option value="040">已经注销</option>
							</select>
						</td>
						<td align="left" class="EditHead">
							查询书名称
						</td>
						<td align="left" class="editTd" >
							<%--
								<input name="audBook.book_name" title="查询书名称" id="book_name" class="easyui-textbox" style="width:150px"> 
							 --%>
							<s:textfield name="audBook.book_name" title="查询书名称" id="book_name" cssClass="noborder"/>
						
						</td>
					</tr>
			 		<tr>
						<td align="left" class="EditHead">
							被审计单位
						</td>
						<td align="left" class="editTd">
							<s:textfield id="audit_object_name" name="audBook.audit_object_name" cssClass="noborder" />
							<%--
								<input id="audit_object_name" name="audBook.audit_object_name" class="easyui-textbox" style="width:150px"> 
							--%>
						</td>
						<td align="left" class="EditHead">
							撰写人
						</td>
						<td align="left" class="editTd">
							<s:textfield id="fname" name="audBook.fname" cssClass="noborder" />
							<%-- 
								<input id="fname" name="audBook.fname" class="easyui-textbox" style="width:150px"> 
							--%>
						</td>
					</tr> 
				</table>
			</s:form>
		</div>
		<!-- <div region="south" border="false" style="text-align: right; padding-right: 20px; width: 566px; height: 26px;" title="" class="panel-body panel-body-noheader panel-body-noborder layout-body">
			<div style="display: inline;" align="right"> -->
		<div class="serch_foot">
			<div class="search_btn">
				<a class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="doSearch()">查询</a>&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-reload'" onclick="resetBook()">重置</a>&nbsp;
				<a class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="doCancel()">取消</a>
			</div>
		</div>
	</div>
		<div region="center">
			<table id="list_booksList"></table>
		</div>
    	<div id='atTreeWrap' title='审计查询书编号' style='overflow:hidden;padding:0px;'>
		 	 <div style="text-align:left;padding:0 0 2px 5px;padding-top:30px;">审计查询书编号:&nbsp;&nbsp;
		 	    <span id="contion_book"></span>
               	<s:hidden name="contion_bookname" id="contion_bookid"/>
		 	    <s:textfield id="contion_Bookcode"  maxLength="6" cssStyle="width:20%;height:24px;padding-top:5px;" ></s:textfield>&nbsp;&nbsp;
		 	    <a id='sureAtBook'  class="easyui-linkbutton"  iconCls="icon-save">确定</a>&nbsp;&nbsp;
		 		<a  id='clearAtBook'  class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>&nbsp;&nbsp;
		 	  </div> 
		 	</div> 
		<div id="tb">
			<a href="javascript:void(0);" class="easyui-linkbutton" id="editGroupButton" onclick="openeditBookPage()" data-options="iconCls:'icon-edit',plain:true">调整查询书编号</a>
			<a href="javascript:void(0);" class="easyui-linkbutton" id="search" onclick="freshGrid()" data-options="iconCls:'icon-search',plain:true">查询</a>
			<a href="javascript:void(0);" class="easyui-linkbutton"  id="add" onclick="addBook()" data-options="iconCls:'icon-add',plain:true">新增</a>
<!-- 			<a href="javascript:void(0);" class="easyui-linkbutton" id="edit"  onclick="editBook()" data-options="iconCls:'icon-edit',plain:true">修改</a>
 -->			<a href="javascript:void(0);" class="easyui-linkbutton"  id="del" onclick="delBook()" data-options="iconCls:'icon-delete',plain:true">删除</a>
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="viewBook()" data-options="iconCls:'icon-view',plain:true">查看</a>
			<a href="javascript:void(0);" class="easyui-linkbutton"  onclick="exportBook()" data-options="iconCls:'icon-export',plain:true">导出</a>
			<a href="javascript:void(0);" class="easyui-linkbutton" id="cancel"  onclick="logoutBook()" data-options="iconCls:'icon-cancel',plain:true">注销</a>
		</div>
		<div id="templateWindow">
			<table id="templateList"></table>
		</div>
		<script type="text/javascript">
			//查询，使窗体排版正确
			showWin('dlgSearch');
			
			$(function(){
				var projectId = document.getElementsByName('project_id')[0].value;
				// 初始化生成表格
				$('#list_booksList').datagrid({
					url : "<%=request.getContextPath()%>/operate/audBook/getlistBooks.action?querySource=grid&project_id="+projectId,
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
					onBeforeLoad:validationAudBook(),
					/* frozenColumns:[[
									
					    		]], */
					columns:[[  
                        {field:'book_status',width:'50', checkbox:true, align:'center'},
	                    {field:'book_statusName',title:'查询书状态',width:'15.5%',sortable:true,halign:'center',align:'left',sortable:true},
						{field:'book_name',
							title:'查询书名称',
							sortable:true,
							halign:'center',
							width:'20%',
							align:'left'
						},
						{field:'book_code',
							 title:'查询书编码',
							 halign:'center', 
							 align:'center', 
							 width:'15%',
							 sortable:true
						},
						{field:'audit_object_name',
							title:'被审计单位',
							sortable:true,
							halign:'center',
							width:'20%',
							align:'center'
						},
						{field:'fname',
							 title:'撰写人',
							 halign:'center', 
							 align:'center', 
							 width:'14.9%',
							 sortable:true
						},
						{field:'operate',
							title:'操作',
							 width:'7%',
							halign:'center',
							align:'right',
							sortable:true,
							formatter:function(value,row,rowIndex){
								if('view' != "${view}"){
									var param = [row.formId,row.book_status];
									var btn2 = "修改,editBook,"+param.join(',');
									return ganerateBtn(btn2);
								}
							
							}
						}
					/* 	{field:'query_item',
							 title:'查询事项',
							 width:'400',
							 halign:'center', 
							 align:'left',
							 sortable:true
						},
						{field:'query_requirements',
							 title:'查询要求',
							 width:'400',
							 halign:'center', 
							 align:'left',
							 sortable:true
						} */
						
					]]   
				}); 
			});
			
			
			
		    function openeditBookPage(){
				   
					var ids = $('#list_booksList').datagrid('getSelections');
					if (ids.length  != 1 ) {
						$.messager.show({title:'提示信息',msg:'请选择一条信息！'});
						return false;
					}
				  var idV = ids[0].formId;
					$.messager.confirm('提示信息', '确定要更改查询书编号吗?', function(is){
						if(is){
		        	    $.ajax({
							  url:"${contextPath}/operate/audBook/dateBookPage.action",
							  type:'POST',
							   data: {"project_id":"${project_id}","crudId":idV},
							  success: function(data){
									if(data.dateBookcode != null && data.dateBookcode !=""){
										document.getElementById('contion_book').innerHTML=data.dateBookcode;	
										$("#contion_bookid").val(data.dateBookcode);
										$("#contion_Bookcode").val(data.dateBookshu);
										$('#atTreeWrap').window('open');
									}else{
										$.messager.show({title:'提示信息',msg:'原编码错误 ！'});
									}
							  }
						   }); 
						
		           } ;
					 }); 
			   } 
			   
		    function freshGrid(){
				//$('#dlgSearch').dialog('open');
				searchWindShow('dlgSearch',750);
			}
			/*
			* 查询
			*/
			function doSearch(){
				 
				if($('#book_status').combobox('getValue') == "010"){
					if('${param.projectview}' != "view"){
						$("#roleid").val("1");
					}
					
				}
	        	$("#list_booksList").datagrid({
					queryParams:form2Json("myForm")
				});
				$('#dlgSearch').dialog('close');
	        	//$('#resultList').datagrid('reload');
	        }
			
			var myformUrl = "${contextPath}/operate/audBook/getlistBooks.action"
			/*
			* 重置
			*/
			function resetBook(){
				resetForm('myForm');
				doSearch();
			}
			/*
			* 取消
			*/
			function doCancel(){
				$('#dlgSearch').dialog('close');
			}
			/*
			* 添加
			*/
			function addBook(){
				window.location.href = '${contextPath}/operate/audBook/edit.action?project_id=${project_id}';
			}
			/*
			* 删除
			*/
			function delBook(formId){
				var rows = $('#list_booksList').datagrid('getChecked');
				if (rows.length == 0) {
					$.messager.show({title:'提示信息',msg:'请选择一条信息！'});
					return false;
				}
				var crudIds = '';
				for(var i=0;i<rows.length;i++){
					crudIds += rows[i].formId + ',';
				}
				
				$.messager.confirm('提示信息', '确定要删除查询书信息吗?', function(isDel){
					if(isDel){
						$.ajax({
						   type: "POST",
						   url: "${contextPath}/operate/audBook/delAudBook.action",
						   data: {"project_id":"${project_id}","crudId":crudIds},
						   success: function(reV){
								if(reV=='suc'){
									$.messager.show({title:'提示信息',msg:'删除成功!'});	
									doSearch();
								}else if(reV=='nouser'){
									$.messager.show({title:'提示信息',msg:'只能删除自己撰写的查询书!'});	
								}else if(reV=='fail140'){
									$.messager.show({title:'提示信息',msg:'已注销的查询书，只有组长和主审才能删除!'});					
								}else{
									$.messager.show({title:'提示信息',msg:'只有草稿和已注销状态的查询书才能删除!'});
								}
						   }
						});	
					}
				}); 

				
			}
			
			/*
			* 修改
			*/
			function editBook(selectedValue,book_status){
				/*var ids = $('#list_booksList').datagrid('getSelections');
				 if (ids.length  != 1 ) {
					$.messager.show({title:'提示信息',msg:'请选择一条信息！'});
					return false;
				} 
				var selectedValue = ids[0].formId;*/
				if(selectedValue == null || selectedValue.length < 1){
					$.messager.show({title:'提示信息',msg:'请选择一条信息！'});
					return false;
				}
				
				if(book_status != null){
					if("030" == book_status){
						$.messager.show({title:'提示信息',msg:'查询书已被审批完成！'});
						return false;
					}
					if("040" == book_status){
						$.messager.show({title:'提示信息',msg:'查询书已被注销！'});
						return false;
					}
				}
				var taskInstanceId=getTaskInstanceId(selectedValue);
				$.ajax({
					   type: "POST",
					   url: "${contextPath}/operate/audBook/modifyValidate.action",
					   data: {"project_id":"${project_id}","crudId":selectedValue},
					   success: function(reV){
							if(reV=='suc'){
								window.location.href = '${contextPath}/operate/audBook/edit.action?crudId='+selectedValue+"&project_id=${project_id}&taskInstanceId="+taskInstanceId;
							}else if(reV=='nouser'){
								$.messager.show({title:'提示信息',msg:'只能修改自己撰写的查询书!'});	
							}else if(reV=='nostatus'){
								$.messager.show({title:'提示信息',msg:'只有草稿状态或者本人正在审批的查询书才能编辑!'});							
							}else if(reV=='fal'){
								$.messager.show({title:'提示信息',msg:'查询书正在被审批!'});	
							}else{
								$.messager.alert('提示信息','操作异常!','erro');
							}
					   }
				});	
			}
			/*
			*获取taskInstanceId
            **/
            function getTaskInstanceId(crudId){
				var taskInstanceId='';
            	jQuery.ajax({
        			url:'${contextPath}/operate/audBook/getTaskInstance.action',
        			type:'POST',
        			data:{"crudId":crudId},
        			dataType:'json',
        			async:false,
        			success:function(data){
        				taskInstanceId=data.taskInstanceId;
        			},
        			error:function(){
        			}
        		});
            	return taskInstanceId;
			}
            
            /*
			* 注销
			*/
			function logoutBook(){
				var ids = $('#list_booksList').datagrid('getSelections');
				if (ids.length != 1 ) {
					$.messager.show({title:'提示信息',msg:'请选择一条信息！'});
					return false;
				}
				var selectedValue = ids[0].formId;
				$.messager.confirm('提示信息', '确定要注销查询书信息吗?', function(isLogout){
					if(isLogout){
						$.ajax({
							   type: "POST",
							   url: "${contextPath}/operate/audBook/logoutBook.action",
							   data: {"project_id":"${project_id}","crudId":selectedValue},
							   success: function(reV){
									if(reV=='suc'){
									//	$.messager.alert('提示信息','注销成功!','info',function(){
										//	$("#myForm").submit();
									//	});	
										$.messager.show({title:'提示信息',msg:'注销成功!'});	
										doSearch();
									}else if(reV=='other'){
										$.messager.show({title:'提示信息',msg:'只能注销自己的创建的已审批完成的查询书!'});							
									}else if(reV=='statusfail'){
										$.messager.show({title:'提示信息',msg:'已审批完成的查询书才能注销!'});							
									}else{
										$.messager.alert('提示信息','操作失败!','erro');	
									}
							   }
						});	
					}
				});
            }
			
			/*
			* 查看
			*/
			function viewBook(formId){
				var ids = $('#list_booksList').datagrid('getSelections');
				if (ids.length != 1 ) {
					$.messager.show({title:'提示信息',msg:'请选择一条信息！'});
					return false;
				}
				var selectedValue = ids[0].formId;
				window.location.href = '${contextPath}/operate/audBook/view.action?winview=benpage&view=${view}&projectview=${param.projectview}&project_id=${project_id}&crudId='+selectedValue;
			}
			/*
			* 导出成员
			*/
			function exportBook(){
				var ids = $('#list_booksList').datagrid('getSelections');//返回的是个数组
		        if(ids.length == 0){
		            $.messager.show({title:'提示信息',msg:'请选择要导出的底稿!'});
		            return false;
		        } 
		        var bookIdArray=new Array();
				   for(i=0;i <ids.length;i++){
		                var tempformId = ids[i].formId;
		                bookIdArray.push(tempformId);
				   }	 
		        var selectedValue = bookIdArray.join(",");
		        
		      //判断记录数量
		         jQuery.ajax({
					url:'${contextPath}/operate/manuExt/pandManuTem.action?type=book&project_id='+ids[0].project_id,
					type:'POST',
					dataType:'text',
					async:false,
					success:function(data){
						if(data == 2) {
							// 初始化生成表格
							$('#templateList').datagrid({
								url : "<%=request.getContextPath()%>/operate/manuExt/reportTemplateList.action?type=book&project_id="+ids[0].project_id,
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
											var link = '<a href=\"javascript:void(0);\" onclick=\"expBook(\''+row.templateId+'\',\''+selectedValue+'\',\''+ids[0].project_name+'\',\''+ids[0].project_id+'\');\">导出</a>';
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
							expBook(data,selectedValue,ids[0].project_name,ids[0].project_id);
						}
					},
						error:function(){
							showMessage1('出错啦！');
						}
			});
		}
			
			/*
			 * 创建chaxun
			 */
			function expBook(templateId,crudId,project_name,project_id){
				var h = window.screen.availHeight;
				var w = window.screen.width;
				window.showModalDialog("/ais/operate/audBook/expBook.action?templateId="+templateId+"&crudId="+crudId+"&project_name="+encodeURI(project_name)+"&project_id="+project_id,window,'dialogWidth:'+w+'px;dialogHeight:'+h+'px;status:no;resizable:yes;minimize:yes;maximize:yes;');
				 $("#templateWindow").window({"onOpen":function(){
					 $("#templateWindow").window('close');
				 }}); 
				 location.reload();
			}
			/*
			 *改变底部按钮状态
			*/
		function changeButtonState(book_status){
			var deleteButton = document.getElementById('del');
		//	var modifyButton = document.getElementById('edit');
			var logoutButton = document.getElementById('logout');
			//只有草稿状态才能修改和删除
			if(book_status=='010'){
				//草稿状态
				deleteButton.disabled = false;
			//	modifyButton.disabled = false;
				logoutButton.disabled=true;
			}else if(book_status=='020'){
				//040已注销
				deleteButton.disabled=true;
				logoutButton.disabled=true;		
			}else if(book_status=='030'){
				//030审批完成
				deleteButton.disabled=true;
				//modifyButton.disabled = true;	
				logoutButton.disabled=false;		
			}else if(book_status=='040'){
				//040已注销
				deleteButton.disabled=false;
			//	modifyButton.disabled = true;	
				logoutButton.disabled=true;		
			}else{
				deleteButton.disabled=true;
				//modifyButton.disabled = true;	
				logoutButton.disabled=true;			
			}
			
		}
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
		 	$('#sureAtBook').bind('click',function(){
			
				
				var ids = $('#list_booksList').datagrid('getSelections');
				if (ids.length  != 1 ) {
					$.messager.show({title:'提示信息',msg:'请选择一条信息！'});
					return false;
				}
			
				var idV = ids[0].formId;
				var contion_bookcode = $("#contion_Bookcode").val();
				var contion_bookid = $("#contion_bookid").val();
				if(contion_bookcode != null && contion_bookcode != ""  ){
					  var  vatest=/^[0-9]*[1-9][0-9]*$/;
					  var va= vatest.test(contion_bookcode);
					  if(!va){
							$.messager.show({title:'提示信息',msg:'输入必须为整数数字！'});
						  return false;
					   }
					 var  contion_bookcodes=contion_bookid+contion_bookcode;
					 $.ajax({
						  url:"${contextPath}/operate/audBook/editBookPage.action",
						  type:'POST',
						   data: {"project_id":"${project_id}","crudId":idV,"book_code":contion_bookcodes},
						  success: function(data){
								 if(data.saveBookcode == 1){
									document.getElementById("roleid").value='';
								    $("#myForm").submit();
									$.messager.show({title:'提示信息',msg:'保存编号成功 ！'});

								}else if (data.saveBookcode == 0){
									$.messager.show({title:'提示信息',msg:'审计查询书已经编号存在！'});
								}else{
									$.messager.show({title:'提示信息',msg:'保存失败 ！'});
								}  
								
						  }
					   });
					
					
					
				}else{
					$.messager.show({title:'提示信息',msg:'审计查询书编号不能为空 ！'});
				}
			});    
			$('#clearAtBook').bind('click',function(){
				$('#atTreeWrap').window('close');
				}); 
	});	
		</script>
	</body>
</html>