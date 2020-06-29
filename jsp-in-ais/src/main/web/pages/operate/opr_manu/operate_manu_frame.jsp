<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>审计底稿列表</title>
		<link href="${contextPath}/resources/css/common.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>   
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/common.js"></script>  
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
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
	<%-- 	<script type='text/javascript' src='/ais/dwr/util.js'></script> --%>
	</head>
	<body  class="easyui-layout" fit='true' border='0'>
		<div id="dlgSearch" class="searchWindow">
			<div class="search_head">	
			<s:form id="searchForm" name="searchForm" action="listAll" namespace="/plan/year" method="post">
				<s:hidden name="manuIds2" id="manuIds2"/>
				<s:hidden name="audManuscript.flushdata" id="flushdata"/>
				<table cellpadding=0 cellspacing=0 border=0 align="center" class="ListTable">
					<tr >
						<td class="EditHead" style="width:15%">底稿名称</td>
						<td class="editTd" style="width:35%">
							<s:textfield cssClass="noborder" name="audManuscript.ms_name" maxlength="50" cssStyle="width:80%"/>
						</td>
						<td class="EditHead" style="width:15%">审计事项</td>
						<td class="editTd" style="width:35%">
						<s:textfield cssClass="noborder" name="audManuscript.task_name" maxlength="50" cssStyle="width:80%"/>
						</td>
					</tr>
					<tr >
						<td class="EditHead">开始日期</td>
						<td class="editTd">
							<%-- <s:textfield cssClass="noborder" name="audManuscript.start_search" cssStyle='width:200px' maxlength="50" cssClass="easyui-datebox noborder"/> --%>
							<input type="text" name="audManuscript.start_search" style="width:80%;" value="${audManuscript.start_search }" editable="false" Class="easyui-datebox noborder" />
						</td>
						<td class="EditHead">结束日期</td>
						<td class="editTd"><%-- <s:textfield cssClass="noborder" name="audManuscript.end_search" cssStyle='width:200px' maxlength="50" cssClass="easyui-datebox noborder"/> --%>
							<input type="text" name="audManuscript.end_search" style="width:80%;" value="${audManuscript.end_search }" editable="false" Class="easyui-datebox noborder" />
						</td>
						
					</tr>
					<tr >
						<td class="EditHead">底稿状态</td>
						<td class="editTd">
							<%-- <s:select list="#{'010':'底稿草稿','020':'正在征求','030':'等待复核','040':'正在复核','050':'复核完毕','060','已经注销'}" listKey="key" listValue="value" name="audManuscript.ms_status" headerKey="" headerValue="" cssStyle='width:200px;'/> --%>
							
							<select id="ms_status" class="easyui-combobox" panelHeight="auto" name="audManuscript.ms_status" style="width:80%;"  editable="false">
						       <option value="">&nbsp;</option>
						       <s:iterator value="auditStatusObjectMap" id="entry">
					             <option value="<s:property value='key'/>"><s:property value='value'/></option>
						       </s:iterator>
						    </select> 
							
						</td>
						<td class="EditHead">被审计单位</td>
						<td class="editTd">
						<%-- <s:select list="auditObjectMap" listValue="value" listKey="key"  name="audManuscript.audit_dept"  cssStyle='width:200px;' headerKey="" headerValue="" value="${crudObject.audit_dept}"/> --%>						
						<select id="audit_dept" class="easyui-combobox" name="audManuscript.audit_dept" style="width:80%;"  editable="false">
						       <option value="">&nbsp;</option>
						       <s:iterator value="auditObjectMap" id="entry">
					             <option value="<s:property value='key'/>"><s:property value='value'/></option>
						       </s:iterator>
						    </select> 
						</td>
					</tr>			
					<tr >
						<td class="EditHead">撰写人</td>
						<td class="editTd">
							<%-- <s:select id ="ms_author" list="%{memberList}" name="audManuscript.ms_author" listValue="userName" listKey="userId" cssStyle='width:200px;' headerKey="" headerValue=""/> --%>						
							<select id="ms_author" class="easyui-combobox" name="audManuscript.ms_author" style="width:80%;"  editable="false">
						       <option value="">&nbsp;</option>
						       <s:iterator value="%{memberList}" id="entry">
					             <option value="<s:property value='userId'/>"><s:property value='userName'/></option>
						       </s:iterator>
						    </select> 
						</td>
						<td class="EditHead">
							底稿编码
						</td>
						<td class="editTd">
							<s:textfield cssClass="noborder" name="audManuscript.ms_code" maxlength="50" cssStyle="width:80%"/>
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
			<table id="manuList"></table>
		</div>
		<div id="templateWindow">
			<table id="templateList"></table>
		</div>
		<div id="dlg" class="easyui-dialog" title="对话框" closed="true" modal="true" style="width:800px;height:500px;overflow:hidden">
			<iframe scrolling="auto" frameborder="0"  src="" style="width:100%;height:100%;"></iframe>
		</div>
		<div id="shareManuSetting" title="共享底稿设置" style='overflow:hidden;padding:0px;'>
			<div id="item1" >
				</br>
				<label><input name="option" type="radio" value="1" />开启全部底稿共享（项目组员可互相查看本项目所有底稿） </label> </br></br>
				<label><input name="option" type="radio" value="2" />开启分组底稿共享（本项目组内的项目组组员可互相查看本组组员的底稿） </label>  </br></br>
				<label><input name="option" type="radio" value="3" checked="checked" />关闭底稿共享（项目组组员只可查看本人底稿，成员之间不可互相查看）<font color="red">默认值</font> </label></br></br>
			</div>
			<div style='text-align:center;' id='shareBtnDiv' style='padding:10px;'>
        		<a  id='saveId'  class="easyui-linkbutton"  iconCls="icon-save">保存</a>&nbsp;&nbsp;&nbsp;&nbsp;
        		<a  id='closeShareSetting' class="easyui-linkbutton"  iconCls="icon-cancel">关闭</a>							        
		    </div>
		</div>	
		<div id="sureManuSetting" title="上传已签字底稿" style='overflow:auto;padding:0px;'>
			<div id="shenjizuFiles" style="float:left;width:70%"></div>
			<div id="shenjizuBtn" style="float:right;width:25%"></div>
		</div>	
		<script type="text/javascript">
		/*
		* 查询
		*/
		function doSearch(){
			if($("#ms_status").combobox('getValue') == "010"){
				if("${param.projectview}" != "view"){
					$("#flushdata").val("2");
				}
			}
        	$('#manuList').datagrid({
    			queryParams:form2Json('searchForm')
    		});
    		$('#dlgSearch').dialog('close');
        }
        /*
		* 取消
		*/
		function doCancel(){
			$('#dlgSearch').dialog('close');
		}
		function enterExportPlan(flag){
			var row = $('#manuList').datagrid('getSelected');
			if(row!=null){
				 var yearPlanId = row.formId;
				 window.open("${contextPath}/plan/year/exportPlan.action?year_plan_id="+yearPlanId+"&plan_flag="+flag);
			}else{
				$.messager.show({title:'提示信息',msg:'请先选择需要导出的记录！'});
			}
		}
		
		function enterExportWord(){
			var row = $('#manuList').datagrid('getSelected');
			if(row!=null){
				 var yearPlanId = row.formId;
				 window.open("${contextPath}/plan/year/exportPlan!exportWord.action?yearPlanId="+yearPlanId);
			}else{
				$.messager.show({title:'提示信息',msg:'请先选择需要导出的记录！'});
			}
		   
		}
		//重置查询条件
		function restal(){
			resetForm('searchForm');
		//	doSearch();
		}
		//liululu  单项底稿
		 function exportDX(){
			 var selectedRows = $('#manuList').datagrid('getChecked');//返回是个数组; 
		        if(selectedRows.length==0){
		            $.messager.show({title:'提示信息',msg:'请选择要导出的底稿!'});
		            return;
		        } 
		/*         for(i=0;i <selectedRows.length;i++){
		        	 var smanuType = selectedRows[i].manuType;
		        	 var manuType ="UNITERM";
		             if(!(smanuType && manuType && smanuType.toLowerCase() == manuType.toLowerCase())){
		                 var ms_code = selectedRows[i].ms_name;
		                 $.messager.show({title:'提示信息',height:'auto',msg:'底稿【'+ms_code+'】不适合单项底稿导出模板!'});
		                 return;
		             }
		        } */
		        var manuIdArray=new Array();
				   for(i=0;i <selectedRows.length;i++){
		                var tempformId = selectedRows[i].formId;
		                manuIdArray.push(tempformId);
				   }	 
		        var selectedValue = manuIdArray.join(",");
		        //判断模板数量
		        jQuery.ajax({
						url:'${contextPath}/operate/manuExt/pandManuTem.action?type=uniterm&project_id='+selectedRows[0].project_id,
						type:'POST',
						dataType:'text',
						async:false,
						success:function(data){
							if(data == 2) {
								// 初始化生成表格
								$('#templateList').datagrid({
									url : "<%=request.getContextPath()%>/operate/manuExt/reportTemplateList.action?type=uniterm&project_id="+selectedRows[0].project_id,
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
												var link = '<a href=\"javascript:void(0);\" onclick=\"expManu(\''+row.templateId+'\',\''+selectedValue+'\',\''+selectedRows[0].project_name+'\',\''+selectedRows[0].project_id+'\',\''+selectedRows[0].manuType+'\');\">导出</a>';
												return link;
											}
										}
									]]
								});

								$('#templateWindow').window({
									title:'选择审计底稿模板',
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
								expManu(data,selectedValue,selectedRows[0].project_name,selectedRows[0].project_id,selectedRows[0].manuType);
							}
						},
						error:function(){
							showMessage1('出错啦！');
						}
			});
		        
		        
		        
				
/* 		        var str = "";
		        for(i=0;i <selectedRows.length;i++){
		        	 var smanuType = selectedRows[i].manuType;
		        	 var manuType ="UNITERM";
		             if(!(smanuType && manuType && smanuType.toLowerCase() == manuType.toLowerCase())){
		                 var ms_code = selectedRows[i].ms_name;
		                 $.messager.show({title:'提示信息',height:'auto',msg:'底稿【'+ms_code+'】不适合单项底稿导出模板!'});
		                 return;
		             }
		             str += selectedRows[i].formId + ",";
		        }
		       		 document.getElementsByName('manuIds2')[0].value=str;
			      	 var ttt = document.getElementsByName('manuIds2')[0].value;
		           	 $('#manuTemplateFrame').attr('src','${contextPath}/commons/oaprint/manuTemplateList.action?dwrModuleid=1040&manuType=UNITERM&manuIds2='+ttt);
			         $('#manuTemplate_div').window('open'); */
		 }
		 /*
			 * 创建审计底稿初稿
			 */
			function expManu(templateId,crudId,project_name,project_id,type){
				var h = window.screen.availHeight;
				var w = window.screen.width;
				type = "UNITERM";
				window.showModalDialog("/ais/operate/manuExt/expManu.action?templateId="+templateId+"&form_id="+crudId+"&project_name="+encodeURI(project_name)+"&project_id="+project_id+"&type="+type,window,'dialogWidth:'+w+'px;dialogHeight:'+h+'px;status:no;resizable:yes;minimize:yes;maximize:yes;');
				 $("#templateWindow").window({"onOpen":function(){
					 $("#templateWindow").window('close');
				 }}); 
				 location.reload();
		 	 }
		 //导出word底稿
		 function exportZH(){
			 var selectedRows = $('#manuList').datagrid('getChecked');//返回是个数组; 
		        if(selectedRows.length==0){
		            $.messager.show({title:'提示信息',msg:'请选择要导出的底稿!'});
		            return;
		        } 
		   	   var manuType ="UNITERM";
		      /*   for(i=0;i <selectedRows.length;i++){
		        	 var smanuType = selectedRows[i].manuType;
		        
		             if(!(smanuType && manuType && smanuType.toLowerCase() == manuType.toLowerCase())){
		                 var ms_code = selectedRows[i].ms_name;
		                 $.messager.show({title:'提示信息',height:'auto',msg:'底稿【'+ms_code+'】不适合综合底稿导出模板!'});
		                 return;
		             }
		        } */
		        var manuIdArray=new Array();
				   for(i=0;i <selectedRows.length;i++){
		                var tempformId = selectedRows[i].formId;
		                manuIdArray.push(tempformId);
				   }	 
		        var selectedValue = manuIdArray.join(",");
		        //判断模板数量
		        jQuery.ajax({
						url:'${contextPath}/operate/manuExt/pandManuTem.action?type=uniterm&project_id='+selectedRows[0].project_id,
						type:'POST',
						dataType:'text',
						async:false,
						success:function(data){
							if(data == 2) {
								// 初始化生成表格
								$('#templateList').datagrid({
									url : "<%=request.getContextPath()%>/operate/manuExt/reportTemplateList.action?type=uniterm&project_id="+selectedRows[0].project_id,
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
												var link = '<a href=\"javascript:void(0);\" onclick=\"expManu(\''+row.templateId+'\',\''+selectedValue+'\',\''+selectedRows[0].project_name+'\',\''+selectedRows[0].project_id+'\',\''+selectedRows[0].manuType+'\');\">导出</a>';
												return link;
											}
										}
									]]
								});

								$('#templateWindow').window({
									title:'选择审计底稿模板',
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
								expManu(data,selectedValue,selectedRows[0].project_name,selectedRows[0].project_id,selectedRows[0].manuType);
							}
						},
						error:function(){
							showMessage1('出错啦！');
						}
			});
				
		        /* var str = "";
		        for(i=0;i <selectedRows.length;i++){
		        	 var smanuType = selectedRows[i].manuType;
		        	 var manuType ="COMPREHENSIVE";
		             if(!(smanuType && manuType && smanuType.toLowerCase() == manuType.toLowerCase())){
		                 var ms_code = selectedRows[i].ms_name;
		                 $.messager.show({title:'提示信息',height:'auto',msg:'底稿【'+ms_code+'】不适合综合底稿导出模板!'});
		                 return;
		             }
		             str += selectedRows[i].formId + ",";
		        }
		       		 document.getElementsByName('manuIds2')[0].value=str;
			      	 var ttt = document.getElementsByName('manuIds2')[0].value;
		           	 $('#manuTemplateFrame').attr('src','${contextPath}/commons/oaprint/manuTemplateList.action?dwrModuleid=1040&manuType=COMPREHENSIVE&manuIds2='+ttt);
			         $('#manuTemplate_div').window('open'); */
		 }
		
		function manuView(){
			var rows = $('#manuList').datagrid('getChecked');//返回是个数组
			if(rows!=null && rows.length>0){
				if(rows.length==1){
					var row = rows[0];
					var myurl = "${contextPath}/operate/manu/view.action?crudId="+row.formId+"&project_id=<%=request.getParameter("project_id")%>&interaction=${interaction}";
					parent.addTab("tabs","审计底稿查看","manuViewTab",myurl,false);
					//window.open("${contextPath}/operate/manu/view.action?crudId="+row.formId+"&project_id=<%=request.getParameter("project_id")%>&interaction=${interaction}","","height=700px, width=700px, toolbar=no, menubar=no, scrollbars=yes,resizable=yes,location=no, status=no");
				}else{
					$.messager.show({title:'提示信息',msg:'请选择一条记录!'});
				}
			}else{
				$.messager.show({title:'提示信息',msg:'请选择一条记录!'});
			}
		}
		
		function editDigaoFrameUrl(id,taskInstanceId){
			window.location.href="/ais/operate/manu/edit.action?back=false&crudId="+id+"&taskInstanceId="+taskInstanceId+"&project_id=<%=request.getParameter("project_id")%>&taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>";
		}			
		
		function editDigaoFrame(id){
			window.location.href="/ais/operate/manu/edit.action?crudId="+id+"&project_id=<%=request.getParameter("project_id")%>&taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>";
		}			
		
	    function isGoOn(){
	    	var flag=false;
	    	jQuery.ajax({
				url:'${contextPath}/operate/manuExt/isGoOn.action',
				type:'POST',
				data:{"project_id":'${project_id}'},
				dataType:'json',
				async:false,
				success:function(data){
					if(data == 2) {
						showMessage1('实施方案正在调整，暂不允许登记底稿!');
						flag= true;
					}else{
						flag= false;
					}
				},
				error:function(){
					showMessage1('实施方案调整验证出错啦！');
				}
			});
	    	return flag;
	    }		
	    
	    function batchSubmitObj(){
	    	if(isGoOn()){
    			  return false;
    		  }	
	    	 var selectedRows = $('#manuList').datagrid('getChecked');//返回是个数组; 
		        if(selectedRows.length==0){
		            $.messager.show({title:'提示信息',msg:'请选择要提交的底稿!'});
		            return;
		       }                     
		      var str = "";
		      //if(selectedRows.length==1){
		      //  manuModify(selectedRows[0].formId,selectedRows[0].ms_author,selectedRows[0].ms_status);
		      //}else{
		    	//  var  manuType = selectedRows[0].manuType;
		          for(var i=0;i <selectedRows.length;i++){
					var project_id = selectedRows[i].project_id;
					var manuId = selectedRows[i].formId;
					var groupId = selectedRows[i].groupId;
					var authLevel = '';
					var statusNew = '';

					//获取最新底稿状态
					DWREngine.setAsync(false);
					DWRActionUtil.execute(
					{ namespace:'/operate/manu', action:'getManuDelAuth', executeResult:'false' }, 
					{'groupId':groupId,'project_id':project_id,'manuId':manuId},xxx);
				    function xxx(data){
				    	authLevel =data['url'];
				    	statusNew =data['checkCode'];
				    }
				    if(statusNew!=selectedRows[i].ms_status){
				    	showMessage1('所选取的底稿 ['+selectedRows[i].ms_name+'] 状态发生变化，请刷新数据后重试!');
				    	return false;
				    }
		        	  
		        	  if('${user.floginname}'==selectedRows[i].ms_author){
		               }else{
							$.messager.show({title:'提示信息',height:'auto',msg:'所选取的底稿 ['+selectedRows[i].ms_name+'] 没有权限修改,不能批量提交审批流程!'});
		                	return false;
		               }
		               if(selectedRows[i].ms_status=='010'){
		               }else{
							$.messager.show({title:'提示信息',height:'auto',msg:'所选取的底稿 ['+selectedRows[i].ms_name+'] 不是底稿草稿状态,不能批量提交审批流程!'});
		                return false;
		               }
		         /*       if(manuType != selectedRows[i].manuType){
		            	   $.messager.show({title:'提示信息',msg:'请选择要提交底稿相同类型!'});
				            return;
		               } */
		            //   if(selectedRows[i].manuType=='UNITERM'){
		               		var manu_id = selectedRows[i].formId;
		                   	var flag = false;
							jQuery.ajax({
								   type: "POST",
								   url: "${contextPath}/proledger/problem/save!checkIfhasProblem.action",
								   async : false,
								   data: {"project_id":'<%=request.getParameter("project_id")%>',"manuscript_id":manu_id},
								   success: function(problemId){
										if(problemId=='' || null==problemId){
											flag = true;
										}
								   }
							});			   
							/* if(flag){
								$.messager.show({title:'提示信息',height:'auto',msg:'所选取的底稿 ['+selectedRows[i].ms_name+'] 没有填写问题定性,不能批量提交审批流程!'});
				                return false;			
							}      */  	
		            //   }
		               str += selectedRows[i].formId + ","; 
		          }                                   
		      document.getElementsByName('manuIds2')[0].value=str;
		       var ttt = document.getElementsByName('manuIds2')[0].value;
		        
		      var title = "底稿批量提交";
				var myurl = '${contextPath}/operate/manu/batch.action?taskId=<%=request.getParameter("taskId")%>&isArray=false&is2=true&manuIds2='+ttt;
				$("#myFrame").attr("src",myurl);
				$('#tempBatchDiv').window('open'); 
		      //}
	    }
		
		function manuAdd(){
		  if(isGoOn()){
			  return false;
		  }				
			window.location.href='/ais/operate/manu/edit.action?project_id=<%=request.getParameter("project_id")%>&taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>';			  
		}
		//是否选中一条记录
		function isSingle(rows){
			if(rows!=null && rows.length>0){
				if(rows.length==1){
					return true;
     			}else{
					showMessage1('请选择一条记录!');
					return false;	     			
     			}				
			}else{
				showMessage1('请选择一条记录!');
				return false;
			}	
		}			
		
     function del(){
     		var rows = $('#manuList').datagrid('getChecked');//返回是个数组
	      	if(isSingle(rows)){
	      		var row = rows[0];
	        var ms_author=row.ms_author;
	        var ms_status=row.ms_status;
	            //删除
	          
	      var groupId = row.groupId;
		  var project_id = row.project_id;   
	      if('010'==ms_status){
	          if('${user.floginname}'!=ms_author){
				showMessage1('没有权限删除！');
				return false;
			  }
           }else if('060'==ms_status){
               //请组长和副组长和主审删除
             DWREngine.setAsync(false);
        			DWREngine.setAsync(false);DWRActionUtil.execute(
        		{ namespace:'/operate/manu', action:'getManuDelAuth', executeResult:'false' }, 
        		{'groupId':groupId,'project_id':project_id},xxx);
        	     function xxx(data){
        	     url =data['url'];
                 //alert(url);
                 
        		} 
        		
        		if(url=="0"){
					showMessage1('底稿所属小组的组长，主审有权限删除该底稿！');
               		return false;
         		}
            
           }else{
         	  if('050'==ms_status){
				showMessage1('底稿已经复核完毕，不能删除！');
             	return false;
            }else  {
				showMessage1('底稿已经进入审批流程，不能删除！');
             	return false;
            }
             
           }
	       var id=row.formId;
	       $.messager.confirm('确认对话框', '确认删除吗？', function(r){
	    		if (r){
	    			jQuery.ajax({
	    				url:'${contextPath}/operate/manuExt/manuDel.action',
	    				type:'POST',
	    				data:{"audManuscript.formId":id},
	    				dataType:'text',
	    				async:false,
	    				success:function(data){
	    					if(data == "suc") {
	    						showMessage2('删除成功！');
	    						window.location.reload();
	    					}else{
								showMessage2('删除失败！');
	    					}
	    				},
	    				error:function(){
							showMessage2('删除底稿出错了！');
	    				}
	    			});
	    		}
	    	});


	    		
	      }
        
      }				
     function go2(doubt_id){
    	 var myurl = "${contextPath}/operate/doubt/view.action?type=YD&doubt_id="+doubt_id;
	        parent.addTab("tabs","审计疑点查看","doubtViewTab",myurl,false);
   	}
			
     function piliangDel(){
		 //实施方案调整时允许注销和删除底稿
//    	 if(isGoOn()){
// 			  return false;
// 		  }
        var selectedRows = $('#manuList').datagrid('getChecked');//返回是个数组
        var str = "";
        var myManu=new Array()
 		//一条数据，走单独删除
 		if(selectedRows.length < 1){
 			showMessage1('请选择一条记录!');
 			return false;
 		}			
        /* if(selectedRows && selectedRows.length==1){
           	del();
        }else{ */
           for(i=0;i <selectedRows.length;i++){
              
                var ms_author = selectedRows[i].ms_author;
		        var ms_status = selectedRows[i].ms_status;
			  	var project_id = selectedRows[i].project_id;
				var manuId = selectedRows[i].formId;
				var groupId = selectedRows[i].groupId;
				var authLevel = '';
				var statusNew = '';

				DWREngine.setAsync(false);
				DWRActionUtil.execute(
				{ namespace:'/operate/manu', action:'getManuDelAuth', executeResult:'false' }, 
				{'groupId':groupId,'project_id':project_id,'manuId':manuId},xxx);
			    function xxx(data){
			    	authLevel =data['url'];
			    	statusNew =data['checkCode'];
			    }
			    if(statusNew!=ms_status){
			    	showMessage1('所选取的底稿 ['+selectedRows[i].ms_name+'] 状态发生变化，请刷新数据后重试！');
			    	return false;
			    }

			    if(ms_status=='010'){
					if('${user.floginname}'!=ms_author){
						showMessage1('所选取的底稿 ['+selectedRows[i].ms_name+'] 没有权限删除,不能批量删除!');
						return false;
					}
			    }else if(ms_status=='060'){//请组长和副组长和主审删除
					if(authLevel=="0"){
						showMessage1('底稿所属小组的组长、主审,项目领导和维护人有权限删除该底稿!');
						return false;
					}
			    }else{
			    	showMessage1('所选取的底稿 ['+selectedRows[i].ms_name+'] 不是底稿草稿或者已经注销状态,不能批量删除!');
					return false;
			    }
               
               /* if(selectedRows[i].ms_status=='010'){
                   if('${user.floginname}'==selectedRows[i].ms_author){
               		}else{
						showMessage1('所选取的底稿 ['+selectedRows[i].ms_name+'] 没有权限删除,不能批量删除!');
                  		return false;
               		}
               }else if(selectedRows[i].ms_status=='060'){//请组长和副组长和主审删除
               
                    var groupId = selectedRows[i].groupId;
                   
				    DWREngine.setAsync(false);
					DWREngine.setAsync(false);DWRActionUtil.execute(
					{ namespace:'/operate/manu', action:'getManuDelAuth', executeResult:'false' }, 
					{'groupId':groupId,'project_id':project_id},xxx);
					 function xxx(data){
					 url =data['url'];
					 } 
					if(url=="0"){
						showMessage1('底稿所属小组的组长、副组长、主审有权限删除该底稿!');
						return false;
					}else{
					}
				 }else{
					showMessage1('所选取的底稿 ['+selectedRows[i].ms_name+'] 不是底稿草稿或者已经注销状态,不能批量删除!');
                	return false;
               } */
                
           }
           
           $.messager.confirm('确认对话框', "确认删除这 "+selectedRows.length+" 条数据吗？", function(r){
        	   if (r){
        		   for(i=0;i <selectedRows.length;i++){
                	   str += selectedRows[i].formId + ","; 
                           }
   			   jQuery.ajax({
   					url:'${contextPath}/operate/manuExt/manuDel.action',
   					type:'POST',
   					data:{"audManuscript.formId":str},
   					dataType:'text',
   					async:false,
   					success:function(data){
   						if(data == "suc") {
   							showMessage2("删除成功！");
   							window.location.reload();
   						}else{
   							showMessage1("删除失败！");
   						}
   					},
   					error:function(){
   						showMessage1("删除底稿出错了！");
   					}
           });	
   			   }
           });
     	  //}
    	}	
			
			function manuModify(ms_id,ms_author,ms_status){
				if(ms_id!=null && ms_id != ''){
						
			  	 if(isGoOn()){
					  return false;
				  }
		        var url="0";
		         if('${user.floginname}'!=ms_author){
					showMessage1('没有权限修改或者提交!');
					return false;
			    }
			      if('010'==ms_status || '050'==ms_status){
			    	  if('050'==ms_status) {
			    		  $.messager.confirm("确认对话框","确认修改已复核完毕的底稿吗？",function(r){
			   	    	   if(r){
			   	    		   jQuery.ajax({
			   	   				url:'${contextPath}/operate/manuExt/updateFormInfoState.action',
			   	   				type:'POST',
			   	   				data:{'formId':ms_id},
			   	   				async:false,
			   	   				success:function(data){
			   	   					if(data == "1") {
			   	   					 	editDigaoFrame(ms_id);
			   	   					}else{
			   	   	                    showMessage1("更新底稿状态失败！");
			   	   					}
			   	   				},
			   	   				error:function(){
			   	                    showMessage1("系统异常！");
			   	   				}
			   	   			});		
			   	    	  }
			   	       });
			    	  } else {
			    		  editDigaoFrame(ms_id);
			    	  }
			      }else if('060'==ms_status){
			         showMessage1('底稿已经注销,不能修改或者提交!');
			         return false;
			      }else{
			    	  DWREngine.setAsync(false);
			   		  DWREngine.setAsync(false);DWRActionUtil.execute(
			   		  {namespace:'/operate/manu', action:'getFormUrl', executeResult:'false' }, 
			   		  {'crudId':ms_id},xxx);
			   	      		function xxx(data){
			   	     		url =data['url'];
			   		  } 
		    		if(url=="0"){
		    			showMessage1('底稿已经进入审批流程,不能修改或者提交!');
		          		return false;
		    		}else{
		    			editDigaoFrameUrl(ms_id,url);
		    		}
			    	  
			    	 /*  if('050'==ms_status){
			    		  showMessage1('底稿已经复核完毕,不能修改或者提交!');
			        	  return false;
			       	  } else  {
				   		DWREngine.setAsync(false);
				   			DWREngine.setAsync(false);DWRActionUtil.execute(
				   		{ namespace:'/operate/manu', action:'getFormUrl', executeResult:'false' }, 
				   		{'crudId':ms_id},xxx);
				   	     function xxx(data){
				   	     url =data['url'];
				            //alert(url);
				            
				   		} 
			    		if(url=="0"){
			    			showMessage1('底稿已经进入审批流程,不能修改或者提交!');
			          		return false;
			    		}else{
			    			editDigaoFrameUrl(ms_id,url);
			    		}
			       	 } */
			    }
						
				}else{
					showMessage1('操作失败！');
				}
			}		
			
        function manuIn(){
//        	if(isGoOn()){
//    			  return false;
//    		  }
			var rows = $('#manuList').datagrid('getChecked');
			if(rows.length == 1){
				var ms_author = rows[0].ms_author;
				var ms_status = rows[0].ms_status;
				var groupId = rows[0].groupId;
				var project_id = rows[0].project_id;
				var id = rows[0].formId;
			    // 恢复的权限//该底稿的所在小组dezuzhang
			    if('060'==ms_status){
                    DWREngine.setAsync(false);
             		DWREngine.setAsync(false);DWRActionUtil.execute(
             		{ namespace:'/operate/manu', action:'getManuDelAuth', executeResult:'false' }, 
             		{'groupId':groupId,'project_id':project_id,'manuId':id},xxx);
             	     function xxx(data){
             	     url =data['url'];
             		} 
             		if(url=="0"){
             			showMessage1('底稿所属小组的组长、主审有权限恢复该底稿!');
		                return false;
             		}
                 }else{
           		  	showMessage1('只能恢复已经注销的底稿!');
                  	return false;
                 }
				
		    	jQuery.ajax({
					url:'${contextPath}/operate/manuExt/manuUpdate.action',
					type:'POST',
					data:{'audManuscript.formId':id,'audManuscript.ms_status':'050'},
					dataType:'text',
					async:false,
					success:function(data){
						if(data == "suc") {
							showMessage2('恢复成功！');
							doSearch();
						}else{
							showMessage1('恢复失败！');
						}
					},
					error:function(){
						showMessage1('系统异常！');
					}
				});	     
	      	}else{
				$.messager.show({
					title:'提示消息',
					msg:'请选择一条数据进行操作!',
					timeout:5000,
					showType:'slide'
				});
				return false;
			}
      }
     
        function shareManu(){
        	var project_id = '<%=request.getParameter("project_id")%>';
    		$.ajax({
			   type: "POST",
			   url: "/ais/operate/manuExt/getShareMenu.action",
			   data: {"project_id":project_id},
			   success: function(data){
				   if(data.flag == '1'){
					   $("input[name='option']").get(0).checked=true;
				   }else if(data.flag == '2'){
					   $("input[name='option']").get(1).checked=true;
				   }else{
					   $("input[name='option']").get(2).checked=true;
				   }
			   }
         	});	
         	$('#shareManuSetting').window('open'); 
       }
        
        function sureManu(){
  		  var rows = $('#manuList').datagrid('getChecked');
  		  if(rows.length == 1){
  			var ms_status = rows[0].ms_status;
  			var sure_guid = rows[0].sure_guid;
      		if('050'!=ms_status){
      			showMessage1("只能上传复核完毕的底稿!！");
                return false;
            } 
      		if(sure_guid == '' || sure_guid == 'null' || sure_guid == null) {
      			$.ajax({
      				url:'${contextPath}/operate/manu/assignSureGuid.action',
      				data:{'id' : rows[0].formId},
      				async:false,
      				type:'post',
      				success:function(data) {
      					sure_guid = data;
      				}
      			});
      		}
       		$.ajax({
       			url:'${contextPath}/operate/manu/checkSureUploadManu.action',
       			data:{"project_id":"${project_id}","id": rows[0].formId},
       			type:'post',
       			async:false,
       			success:function(data){
       				if (data.roleSure == "2"){
       		       		$('#sureManuSetting').window('open'); 
       		  			var id = rows[0].formId;
       		  			if($('#shenjizuFiles').length > 0){
       						$('#shenjizuFiles').fileUpload({
       							fileGuid:sure_guid,
       							echoType:2,
       							uploadFace:1,
       							triggerId:'shenjizuBtn',
       							onFileSubmitSuccess:function(data,options){
       								jQuery.ajax({
       					   				url:'${contextPath}/operate/manu/sureUploadManu.action',
       					   				type:'POST',
       					   				data:{'id':id},
       					   				dataType:'text',
       					   				async:false,
       					   				success:function(data){
       					   					if(data == "suc") {
       					   						window.location.reload();
       					   					}else{
       					   	                    showMessage1("上传失败！");
       					   					}
       					   				},
       					   				error:function(){
       					                    showMessage1("系统异常！");
       					   				}
       					   			});
       							}
       						});
       					}
       				}else{
       					showMessage1("没有上传权限！");
       				}
       			}
       		})
       		
       		

        }else{
		  $.messager.show({
			  title:'提示消息',
			  msg:'请选择一条数据进行操作!',
			  timeout:5000,
			  showType:'slide'
		  });
		  return false;
  		}
       }	
        
      function manuOut(){
		  //实施方案调整时允许注销和删除底稿
//    	  if(isGoOn()){
//  			  return false;
//  		  }
		  var rows = $('#manuList').datagrid('getChecked');
		  if(rows.length == 1){
			var ms_author = rows[0].ms_author;
			var ms_status = rows[0].ms_status;
			if('${user.floginname}'==ms_author){
	        }else{
	          showMessage1("没有权限注销！");
	          return false;
	        }
     		if('050'==ms_status){
              //alert("123");
            }else{
              showMessage1("只能注销复核完毕的底稿!！");
              return false;
            }
			var id = rows[0].formId;
	       $.messager.confirm("确认对话框","确认注销吗？",function(r){
	    	   if(r){
	    		   jQuery.ajax({
	   				url:'${contextPath}/operate/manuExt/manuUpdate.action',
	   				type:'POST',
	   				data:{'audManuscript.formId':id,'audManuscript.ms_status':'060'},
	   				dataType:'text',
	   				async:false,
	   				success:function(data){
	   					if(data == "suc") {
	   	                    showMessage2("注销成功！");
	   						doSearch();
	   					}else{
	   	                    showMessage1("注销失败！");
	   					}
	   				},
	   				error:function(){
	                    showMessage1("系统异常！");
	   				}
	   			});		
	    	  }
	       });
      	}else{
			  $.messager.show({
				  title:'提示消息',
				  msg:'请选择一条数据进行操作!',
				  timeout:5000,
				  showType:'slide'
			  });
			  return false;
		}
      }			
	 
    //上传附件
      function Upload(id,delete_flag,edit_flag){
      	var num=Math.random();
      	var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
      	var rv = window.showModalDialog('${contextPath}/commons/file/welcome.action?guid='+id+'&&param='+rnm+'&&deletePermission='+delete_flag+'&&isEdit='+edit_flag,'refresh','dialogWidth:700px;dialogHeight:450px;status:yes');
      	if(!rv){
      		window.location.reload();
      	}else{
      		window.location.reload();
      	}
      }

      function deleteFile(fileId,guid,isDelete,isEdit,appType,title){
      	top.$.messager.confirm('提示信息','确认删除吗?',function(isDel){
      		if(isDel){
      			DWREngine.setAsync(false);DWRActionUtil.execute(
      			{ namespace:'/commons/file', action:'delFile', executeResult:'false' }, 
      			{'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType,'title':title},
      			xxx);
      			function xxx(data){
      			  	window.location.reload();
      			}
      		}
      	});
      } 
      
     function piliangSubmit(){
 
       var selectedRows = $('#manuList').datagrid('getChecked');//返回是个数组; 
        if(selectedRows.length==0){
          	showMessage1('请选择要提交的底稿!');
            return;
       }                     
      var str = "";
      if(selectedRows.length==1){
        manuModify(selectedRows[0]);
      }else{
          for(i=0;i <selectedRows.length;i++){
               if('${user.floginname}'==selectedRows[i].ms_author){
                
               }else{
					showMessage1('所选取的底稿 ['+selectedRows[i].ms_name+'] 没有权限修改,不能批量提交审批流程,请单独提交!');
                	return false;
               }
               if(selectedRows[i].ms_status=='010'){
               }else{
					showMessage1('所选取的底稿 ['+selectedRows[i].ms_name+'] 不是底稿草稿状态,不能批量提交审批流程,请单独提交!');
                return false;
               }
             //  if(selectedRows[i].manuType=='UNITERM'){
               		var manu_id = selectedRows[i].formId;
                   	var flag = false;
					jQuery.ajax({
						   type: "POST",
						   url: "${contextPath}/proledger/problem/save!checkIfhasProblem.action",
						   async : false,
						   data: {"project_id":'<%=request.getParameter("project_id")%>',"manuscript_id":manu_id},
						   success: function(problemId){
								if(problemId=='' || null==problemId){
									flag = true;
								}
						   }
					});			   
					/* if(flag){
						showMessage1('所选取的底稿 ['+selectedRows[i].ms_name+'] 没有填写问题定性,不能批量提交审批流程!');
		                return false;			
					}   */     	
               }
               str += selectedRows[i].formId + ","; 
         // }                                   
      document.getElementsByName('manuIds2')[0].value=str;
       var ttt = document.getElementsByName('manuIds2')[0].value;
        
      var title = "底稿批量提交";
      
		var myurl = '${contextPath}/operate/manu/batch.action?taskId=<%=request.getParameter("taskId")%>&isArray=false&is2=true&manuIds2='+ttt;
		$("#myFrame").attr("src",myurl);
		$('#tempBatchDiv').window('open');      
      
      }
     
	 //var num=Math.random();
	 //var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
   
    }			
    
    function expManuscript(manuType, manuTypeName){
        // manuType底稿类型  UNITERM-单项底稿，COMPREHENSIVE-综合底稿，不同的类型对应的导出模板不一样
       var selectedRows = $('#manuList').datagrid('getChecked');//返回是个数组; 
        if(selectedRows.length==0){
        	showMessage1('请选择要导出的底稿!');
            return;
        } 
        var idArr = [];
        manuType = "UNITERM";
        for(i=0;i <selectedRows.length;i++){
            var data = selectedRows[i];
       //     var smanuType = manuType;
            //alert(manuType+' '+smanuType);
           /*  if(!(smanuType && manuType && smanuType.toLowerCase() == manuType.toLowerCase())){
                var ms_code = ms_code;
                //alert("底稿【'+ms_code+'】不适合【'+manuTypeName+'】导出模板");
                //$.messager.alert('提示信息','底稿【'+ms_code+'】不适合【'+manuTypeName+'】导出模板!','info');
               	showMessage1('底稿【'+ms_code+'】不适合【'+manuTypeName+'】导出模板!');
                return;
            } */
            idArr.push(formId);
        }
        if(idArr.length > 0){
            //必须通过隐藏域传递参数，否则太长被IE截取
            document.getElementsByName('manuIds2')[0].value = idArr.join(",");
            //底稿模板方式导出
            var manuFormType="1040";
            var _url = "${contextPath}/commons/oaprint/manuTemplateList.action?dwrModuleid="+manuFormType+"&manuType="+manuType;
            window.open(_url);
        }else{
            showMessage1('获得底稿ID出错!');
        }
    }    
    //查看疑点  
    function viewManu(id){
       	var myurl = "${contextPath}/operate/manu/view.action?view=${param.view}&projectview=${param.projectview}&pageview=pageview&crudId="+id+"&project_id=<%=request.getParameter("project_id")%>&interaction=${interaction}";    
    	aud$openNewTab("审计底稿查看",myurl,true);
       //	parent.addTab("tabs","审计底稿查看","manuViewTab",myurl,false);
    }
    
	    /**
		查看底稿   用于归档文件管理
	*/
	function openView(){
			var ids = $('#manuList').datagrid('getSelections');
			if (ids.length != 1) {
				$.messager.show({title:'提示信息',msg:'请选择一条信息!'});
				return false;
			}	
			var selectedValue = ids[0].formId;
		//	window.location.href = '${contextPath}/operate/manu/view.action?view=${param.view}&projectview=${param.projectview}&pageview=pageview&crudId='+selectedValue+'&project_id=${project_id}&interaction=${interaction}'; 
		     var t = '${contextPath}/operate/manu/view.action?view=${param.view}&projectview=${param.projectview}&pageview=pageview&crudId='+selectedValue+'&project_id=${project_id}&interaction=${interaction}';
		    $('#manuFrame').attr('src',t);
	        $('#manuViewDiv').window('open');
	       

	}	
	 function exportmanu(){
		$('#exportDX').window('open');  
	 }   

   	function sendMail(){
       var selectedRows = $('#manuList').datagrid('getChecked');//返回是个数组; 
   	    if(selectedRows.length==0){
   	        showMessage1('请选择要发送的底稿!');
   	        return;
   	    }                     
   	    var str = "";
   	    for(i=0;i <selectedRows.length;i++){
   	           str += selectedRows[i].formId + ","; 
   	    }
   	    DWREngine.setAsync(false);
   	    DWREngine.setAsync(false);
   	    DWRActionUtil.execute(
   	   			{ namespace:'/operate/doubt', action:'generateEmailAttachments', executeResult:'false' }, 
   	   			{'manuIds':str},xxx);
   	   		     function xxx(data){
   	   		     	result =data['manuAttachmentIds'];
   	   		     	if(result!=null&&result!=''){
   	   		     		//window.open('<%=request.getContextPath()%>/msg/sendMail.action?innerMsg.attachmentsId='+result,500,350,'发送邮件');		
	   	   		     	var myurl = '<%=request.getContextPath()%>/msg/sendMail.action?innerMsg.attachmentsId='+result;
						$("#mailFrame").attr("src",myurl);
						$('#tempMailDiv').window('open');  
   	   		     	}
   	   			}
   	}	
   		
   		function closeMailUi(){
			$('#tempMailDiv').window('close');   		
   		}
   		function close_win(){
   			$('#manuTemplate_div').window('close');  
   		}
   		function close_bat(){
   			$('#tempBatchDiv').window('close');  
   		
   		}
   		function reload_bat(){
   			location.reload();
   		}
   		
   
   		function importMsg(obj){
   			if(obj!= null && obj !="" &&  obj == '1'){
   			  top.$.messager.show({
   	    		  title:'提示信息',
   	    		  msg:"保存成功",
   	    		  timeout:5000,
   	    		  showType:'slide',
   	    		  height:'auto',	
   	    	  }) 
   			}
   	
   		}

		//复制底稿-显示自动过滤出同类型审计项目列表
		function aud$copyManus(){
			try{
				var url = "${contextPath}/project/showCopyProjectList.action?projectId=${project_id}";
				new aud$createTopDialog({
					title:'我的项目',
					url  :url
				}).open();
			}catch(e){
				alert(e.message);
			}
		}
			
			$(function(){
			
				importMsg("${importMsg}");
				showWin('dlgSearch');
				
				// 初始化生成表格
				$('#manuList').datagrid({
					url : "<%=request.getContextPath()%>/operate/manuExt/mainUi!manuListJsonGrid.action?querySource=grid&taskId=<%=request.getParameter("taskId")%>&permission=<%=request.getParameter("permission")%>&isView=<%=request.getParameter("isView")%>&project_id=<%=request.getParameter("project_id")%>&projectview=<%=request.getParameter("projectview")%>&interaction=${interaction}&t="+new Date().getTime(),
					method:'post',
					showFooter:true,
					rownumbers:true,
					pagination:false,
					striped:true,
					autoRowHeight:false,
					fit:true,
					idField:'formId',
					fitColumns: false,	
					border:false,
					singleSelect:false,
					remoteSort: false,
					onLoadSuccess:function(){
						if ('view' != "${view}"){
							$(this).prev().find('div.datagrid-body').prop('scrollLeft',99999);
						}
						initHelpBtn();
					},
					toolbar:[{
							id:'search',
							text:'查询',
							iconCls:'icon-search',
							handler:function(){
								searchWindShow('dlgSearch');
							}
						},'-',{
							id:'newObj',
							text:'新增',
							iconCls:'icon-add',
							handler:function(){
								manuAdd();
							}
						},'-',{
							id:'editObj',
							text:'调整',
							iconCls:'icon-edit',
							handler:function(){
								var formIds = new Array();
								var rows = $('#manuList').datagrid('getChecked');
								if(rows.length == 1){
									var ms_author = rows[0].ms_author;
									var ms_status = rows[0].ms_status;
									var groupId = rows[0].groupId;
									var project_id = rows[0].project_id;
									var manuId = rows[0].formId;
									var authLevel = '';
									var statusNew = '';

									DWREngine.setAsync(false);
									DWRActionUtil.execute(
									{ namespace:'/operate/manu', action:'getManuDelAuth', executeResult:'false' }, 
									{'groupId':groupId,'project_id':project_id,'manuId':manuId},xxx);
								    function xxx(data){
								    	authLevel =data['url'];
								    	statusNew =data['checkCode'];
								    }

								    if(statusNew!=ms_status){
								    	showMessage1('底稿状态发生变化，请刷新数据后重试！');
								    	return false;
								    }

								    if('050'==ms_status){
										if('${user.floginname}'!=ms_author){
											showMessage1('只能调整本人的底稿！');
											return false;
										}
								    }else{
								    	showMessage1('只能调整复核完毕的底稿!');
										return false;
									}

									$.messager.confirm("确认对话框","确认修改已复核完毕的底稿吗？",function(r){
										if(r){
											jQuery.ajax({
												url:'${contextPath}/operate/manuExt/updateFormInfoState.action',
												type:'POST',
												data:{'formId':manuId},
												async:false,
												success:function(data){
													if(data == "1") {
														editDigaoFrame(manuId);
													}else{
														showMessage1("更新底稿状态失败！");
													}
												},
												error:function(){
													showMessage1("系统异常！");
												}
											});
										}
									});
								}else{
									showMessage1("请选择一条数据进行操作!");
								}
								
								/* for(i in rows) {
									if(rows[i].ms_status == '050' && '${user.floginname}'== rows[i].ms_author) {
										formIds.push(rows[i].formId);
									}
								}
								if(formIds.length == 1) {
									$.messager.confirm("确认对话框","确认修改已复核完毕的底稿吗？",function(r){
										if(r){
											jQuery.ajax({
												url:'${contextPath}/operate/manuExt/updateFormInfoState.action',
												type:'POST',
												data:{'formId':formIds[0]},
												async:false,
												success:function(data){
													if(data == "1") {
														editDigaoFrame(formIds[0]);
													}else{
														showMessage1("更新底稿状态失败！");
													}
												},
												error:function(){
													showMessage1("系统异常！");
												}
											});
										}
									});
								} else {
									showMessage1("请选择本人底稿状态为‘复核完毕’的1条数据进行调整！")
								} */
							}
						},'-',{
							id:'delObj',
							text:'删除',
							iconCls:'icon-delete',
							handler:function(){
								piliangDel();
							}
						},'-',{
							id:'batchSubmitObj',
							text:'批量提交',
							iconCls:'icon-ok',
							handler:function(){
								batchSubmitObj();
							}
						},'-',{
							id:'outManuOwner',
							text:'注销',
							iconCls:'icon-cancel',
							handler:function(){
								manuOut();
							}
						},'-',{
							id:'inManuOwner',
							text:'恢复',
							iconCls:'icon-recover',
							handler:function(){
								manuIn();
							}
						},'-',{
							id:'exportmanu',
							text:'导出/导入底稿',
							iconCls:'icon-recover',
							handler:function(){
								exportmanu();
							}
						},'-',
						/* {
							id:'exportDX',
							text:'导出单项底稿',
							iconCls:'icon-export',
							handler:function(){
								exportDX();
							}
						},	 */	
						{
							id:'exportZH',
							text:'导出WORD底稿',
							iconCls:'icon-export',
							handler:function(){
								exportZH();
							}
						}/* ,		
						//去掉邮件发送
						{
							id:'emailOpr',
							text:'邮件发送',
							iconCls:'icon-email',
							handler:function(){
								sendMail();
							}
						} */	
						<s:if test="${sure == '1'}">
						,{
							id:'share',
							text:'共享底稿设置',
							iconCls:'icon-publish',
							handler:function(){
								shareManu();
							}
						}
						</s:if>
						,{
							id:'sure',
							text:'上传已签字底稿',
							iconCls:'icon-upload',
							handler:function(){
								sureManu();
							}
						}
						,'-',{
							id:'copyManus',
							text:'复制其他项目底稿',
							iconCls:'icon-view',
							handler:function(){
								aud$copyManus();
							}
						},'-',helpBtn
					],
					onClickCell:function(rowIndex, field, value) {
						if(field == 'ms_name') {
							var rows = $('#manuList').datagrid('getRows');
							var row = rows[rowIndex];
							if(!isGoOn() && '${user.floginname}'== row.ms_author && row.ms_status=='010' && 'view' != "${param.projectview}") {
								var project_id = row.project_id;
								var manuId = row.formId;
								var groupId = row.groupId;
								var authLevel = '';
								var statusNew = '';

								//获取最新底稿状态
								DWREngine.setAsync(false);
								DWRActionUtil.execute(
								{ namespace:'/operate/manu', action:'getManuDelAuth', executeResult:'false' }, 
								{'groupId':groupId,'project_id':project_id,'manuId':manuId},xxx);
							    function xxx(data){
							    	authLevel =data['url'];
							    	statusNew =data['checkCode'];
							    }
							    if(statusNew!=row.ms_status){
							    	showMessage1('底稿状态发生变化，请刷新数据后重试！');
							    	return false;
							    }
								
								editDigaoFrame(row.formId);
							} else {
								viewManu(row.formId);
							}
						}
					},
					frozenColumns:[[
					       			{field:'formId',title:"复选框", halign:'center',checkbox:true, align:'center'},
		       						{field:'ms_name',title:'底稿名称',halign:'center',width:300,sortable:true,align:'left',
					       				formatter:function(value,row,rowIndex){
											var result;
											if('${user.floginname}'== row.ms_author && row.ms_status=='010' && 'view' != "${param.projectview}") {
												result = ["<label title='单击编辑' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
											} else {
												result = ["<label title='单击查看' style='cursor:pointer;color:blue;'>",value,"</label>"].join('') ;
											}
											return result;
										}	
		       						},
		       						{field:'ms_statusName',title:'底稿状态',halign:'center',width:80,sortable:true,align:'center'}
		       						,{field:'curDealPerson',title:'当前处理人',halign:'center',width:100,sortable:true,align:'center'}
					    		]],
					columns:[[  
		       		/* 	{field:'manuTypeName',title:'底稿类型',halign:'center',width:70,sortable:true,align:'center'},		 */
		       		
		       			{field:'task_name',title:'审计事项',halign:'center',width:270,sortable:true,align:'left'},	
		       			{field:'ms_author_name',title:'撰写人',halign:'center',width:70,sortable:true,align:'center'},
		       			{field:'prom',title:'问题',halign:'center',width:50,sortable:true,align:'center'},	
		       			{field:'fileCount',title:'附件',halign:'center',width:50,sortable:true,align:'center'},	
		       			{field:'audit_found',title:'关联疑点',halign:'center',width:100,sortable:true,align:'center',
		       				formatter:function(value,row,rowIndex){
		       						var audit_found = row.audit_found;
		       						if(null!=audit_found){
		       						var manuId = audit_found.split(',');
									return "<a href=\"javascript:void(0)\" onclick=\"go2('"+manuId[0]+"')\">"+manuId[1]+"</a>"
		       						}else{
		       							return "";
		       						}
							}},
		       			{field:'ms_date_view',title:'创建日期',halign:'center',width:100,sortable:true,align:'center'},
		       			{field:'subms_date',title:'最后修改日期',halign:'center',width:100,sortable:true,align:'center'},
		       			{field:'isSureUpload',title:'是否上传签字底稿',halign:'center',width:130,sortable:true,align:'center',
		       				formatter:function(value,row,rowIndex){
		       					if(value == '1'){
		       						return "已上传";
		       					}else{
		       						return "未上传";
		       					}
		       				},
	       				}/*,
		       			{field:'operate',
							title:'操作',
							halign:'center',
							align:'right',
							sortable:true,
							width:80,
							formatter:function(value,row,rowIndex){
								if('view' != "${param.projectview}") {
									if("${archives_closed}" != '1') {
										var param = [row.formId,row.ms_author,row.ms_status,row.groupId,row.project_id];
										var btn2 = "修改,manuModify,"+param.join(',');
										return ganerateBtn(btn2);
									}
								}
							}
						}*/
					]]   
				});
				//单元格tooltip提示
				$('#manuList').datagrid('doCellTip', {
					onlyShowInterrupt:true,
					position : 'bottom',
					maxWidth : '200px',
					tipStyler : {
						'backgroundColor' : '#EFF5FF',
						borderColor : '#95B8E7',
						boxShadow : '1px 1px 3px #292929'
					}
				});
				if(${isView=='true'|| view=='view'}){
					$('#manuList').datagrid({
						toolbar:[{
							id:'search',
							text:'查询',
							iconCls:'icon-search',
							handler:function(){
								searchWindShow('dlgSearch');
							}
						 } ,'-',
					
			 		   {
							id:'exportZH',
							text:'导出WORD底稿',
							iconCls:'icon-export',
							handler:function(){
								exportZH();
							}
						},'-',helpBtn
							 
						
						]
					});					
				}
				if(${param.projectview=='view'}){
					$('#manuList').datagrid({
						toolbar:[{
							id:'search',
							text:'查询',
							iconCls:'icon-search',
							handler:function(){
								searchWindShow('dlgSearch');
							}
						 },
						 {
							id:'view',
							text:'查看',
							iconCls:'icon-view',
							handler:function(){
								openView();
							}
						},/* {
							id:'exportDX',
							text:'导出单项底稿',
							iconCls:'icon-export',
							handler:function(){
								exportDX();
							}
						},		 */

						{
							id:'exportZH',
							text:'导出WORD底稿',
							iconCls:'icon-export',
							handler:function(){
								exportZH();
							}
						
						} 
						]
					});					
				}

			//初始化增加窗口
		    $('#tempBatchDiv').window({
				width:'85%', 
				height:'85%',  
				modal:true,
				collapsible:false,
				maximizable:false,
				minimizable:false,
				closed:true    
		    });   
		    
			//初始化增加窗口
		    $('#tempMailDiv').window({
				width:600, 
				height:450,  
				modal:true,
				collapsible:false,
				maximizable:false,
				minimizable:false,
				closed:true    
		    });   			    			
				
		    $('#manuTemplate_div').window({   
				//width:600,   
				//height:350,  
				fit:true,
				modal:true,
				border:0,
				collapsible:false,
				maximizable:true,
				minimizable:false,
				closed:true
			});
		    $('#exportDX').window({   
		    	width:750, 
				height:450,
				modal:true,
				border:0,
				collapsible:false,
				maximizable:true,
				minimizable:false,
				closed:true
			});
		    $('#manuViewDiv').window({   
		    	width:1000, 
				height:470,
				modal:true,
				border:0,
				collapsible:false,
				maximizable:true,
				minimizable:false,
				closed:true
			});
		    $('#shareManuSetting').window({ 
		    	title:"共享底稿设置",
		    	width:600, 
				height:230,
				modal:true,
				border:0,
				collapsible:false,
				maximizable:true,
				minimizable:false,
				closed:true
			});
		    
		    $('#sureManuSetting').window({ 
		    	title:"上传已签字底稿",
		    	width:600, 
				height:230,
				modal:true,
				border:0,
				collapsible:false,
				maximizable:true,
				minimizable:false,
				closed:true
			});
			    // 导入/导出 excel审计事项
			    $('#importmanu').bind('click',function(){
			    	 if(isGoOn()){
		    			  return false; 
		    		  }	
			 		// $('#operate1').val("imoprtManu");
			 		
			    	 var path = $('#manu_file').val();
			         var arr = path.split('.');
			         var suffix = arr[arr.length - 1];
			    	if( suffix.indexOf("xls") != -1 || suffix.indexOf("xlsx") != -1){
			    	    
			     			var excelType = suffix.toLowerCase() == 'xls' ? '2003' : (suffix.toLowerCase() == 'xlsx' ? '2007' : '2003');
				    		$('#excelType').val(excelType);
				    
				    		$('#importmanu').css('display','false');
				    		document.getElementById("layer").style.display = "";
							document.getElementById("errorInfo1").style.display = "none";
							document.getElementById("errorInfo2").style.display = "none";
				    		export_form.action="${contextPath}/operate/manu/importExcelManu.action";
					    	export_form.submit();
				    		  /*$('#manufile').val(path);	 
				    		  $.ajax({
				    		  url:"${contextPath}/operate/manu/importExcelManu.action",
				    	      type:'post',
				    	      data:$('#export_form').serialize(),
				    	      async:false,
				    	      success:function(data){
				    	    	if(  data.manu != null &&   data.manu != ""){
				    	     	   	  top.$.messager.show({
					    	    		  title:'提示信息',
					    	    		  msg:data.manu,
					    	    		  timeout:5000,
					    	    		  showType:'slide',
					    	    		  height:'auto',	
					    	    	  }) 
					    	    	 window.location.reload();
				    	    	}
				    	 
				    	      }	  
				    	   }); */
			   	   }else{
			   		showMessage1('导入文件后缀名错误，请导入 xls或者xlsx 的Excel文件！');
			    	}  
			    });
			  
	  	//保存事件
		$('#saveId').bind('click',function(){
			var checkVal =$("input[type='radio']:checked").val();
			$.ajax({
				type: "POST",
				dataType:'json',
				url : "/ais/proledger/problem/shareManuSetting.action",
				data:{
					'project_id':'<%=request.getParameter("project_id")%>',
					'checkVal':checkVal
				},
				success: function(data){
					if(data.type == 'ok'){
						$('#shareManuSetting').window('close');
						showMessage2("保存成功！");	
						$('#manuList').datagrid('reload');
					}else{
						showMessage2("保存失败！");	
					}		
				},
				error:function(data){
					showMessage2("请求失败！");	
				}
			});	
		});
		
		//关闭按钮
		$('#closeShareSetting').bind('click',function(){
			$('#shareManuSetting').window('close');
		});
	  	
		$('#exportDXExcel').bind('click',function(){
	
			
		//	document.getElementById("exportDXExcel").style.display = "none";

	/*  		$.ajax({
				   url:"${contextPath}/operate/manuExt/exporManuWorkExcel.action",
					data:{"project_id":'${project_id}','operate1':'imoprtManu','beanName':'LedgerTemplateNew','treeId':'id','treeText':'code','treeParentId':'fid'},
					type: "get",
					async:true,
					success:function(data){
						//document.getElementById("exportDXExcel").style.display = "block";
					}
				});  */
	
	     	//document.location.href="${contextPath}/operate/manuExt/exporManuWorkExcel.action?project_id=${project_id}&beanName=LedgerTemplateNew&treeId=id&treeText=code&treeParentId=fid";
			window.location.href = "${contextPath}/templatedownload?file=audManuscript.xls&&type=audManuscript&&project_id=${project_id}&beanName=LedgerTemplateNew&treeId=id&treeText=code&treeParentId=fid";

              });
		$('#closeImportmanu').bind('click',function(){
		     	document.location.href="<%=request.getContextPath()%>/operate/manuExt/mainUi!manuListJsonGrid.action?taskId=<%=request.getParameter("taskId")%>&permission=<%=request.getParameter("permission")%>&isView=<%=request.getParameter("isView")%>&project_id=<%=request.getParameter("project_id")%>&projectview=<%=request.getParameter("projectview")%>&interaction=${interaction}&t="+new Date().getTime();
	           });
		
		
<%-- 		$('#exportDXCheckExcel').bind('click',function(){
				   var selectedRows = $('#manuList').datagrid('getChecked');//返回是个数组; 
			      if(selectedRows.length==0){
			          $.messager.show({title:'提示信息',msg:'请选择要导出的底稿!'});
			          return;
			      } 
			      var manuIdArray=new Array();
					   for(i=0;i <selectedRows.length;i++){
			              var tempformId = selectedRows[i].formId;
			              manuIdArray.push(tempformId);
			             
			              var groupId = selectedRows[i].groupId;
						    DWREngine.setAsync(false);
							DWREngine.setAsync(false);DWRActionUtil.execute(
							{ namespace:'/operate/manu', action:'getManuDelAuth', executeResult:'false' }, 
							{'groupId':groupId,'project_id':project_id},xxx);
							 function xxx(data){
							 url =data['url'];
							 } 
							 if(url=="0"){
									showMessage1('底稿所属小组的组长，副组长，主审有权限删除该底稿！');
				               		return false;
				         		}
			              
					   }	 
			      var selectedValue = manuIdArray.join(",");  
			  
			     
			      
			      
				 	$.ajax({
					   url:"${contextPath}/operate/manuExt/exporManuWorkExcel.action",
						data:{"project_id":'${project_id}'},
						type: "post",
						async:false,
						success:function(data){
						}
					});  
					document.getElementById('export_form').action = "<%=request.getContextPath()%>/operate/manuExt/exporManuWorkExcel.action?project_id=${project_id}" ;
					$('#export_form').submit();
		              }); --%>
		
		              
		          	<s:if test="${operate1 == 'imoprtManu'}">
		  
				 	  $('#exportDX').window('open');
					</s:if>         
			});
		</script>
	      <div id="tempBatchDiv" title="底稿批量提交" style='overflow:hidden;'>
				<iframe id="myFrame" name="myFrame" title="批量提交" src="" width="100%" height="99%" frameborder="0" scrolling="no"></iframe>				
	      </div>			
	       <div id="manuTemplate_div" title="底稿模板选择" style='overflow:hidden;'> 	  		
				<iframe id="manuTemplateFrame" name="manuTemplateFrame" title="模板选择" src="" width="100%" height="100%" frameborder="0" ></iframe>				
	      </div>
	      <div id="tempMailDiv" title="邮件发送" style='overflow:hidden;padding:0px;'> 	  		
				<iframe id="mailFrame" name="mailFrame" title="邮件发送" src="" width="100%" height="99%" frameborder="0"></iframe>				
	      </div>
	        <div id="manuViewDiv" title=" " style='overflow:hidden;padding:0px;'> 	  		
				<iframe id="manuFrame" name="manuFrame" title=" " src="" width="100%" height="99%" frameborder="0"></iframe>				
	      </div>
	      <div id="exportDX" style="padding: 0px;overflow:hidden" title="导入底稿" >
		 <!--    <a id='exportDXCheckExcel' class="easyui-linkbutton" iconCls="icon-export"> 导出选择草稿底稿</a>&nbsp; -->
	
		    <button id='exportDXExcel' class="easyui-linkbutton" iconCls="icon-export">导出本人草稿底稿</button>&nbsp; 
		    <button id='importmanu' class="easyui-linkbutton" iconCls="icon-import">导入审计底稿</button>&nbsp; 
		    <button id='closeImportmanu' class="easyui-linkbutton" iconCls="icon-cancel">关闭</button>&nbsp;
		 	<form id='export_form' name='export_form' action='/ais/operate/manu/importExcelManu.action' method="POST"
				enctype="multipart/form-data">
				<input type='hidden' id='excelType' name='excelType' />
				<input type='hidden' id="manufile" name='manufile'/>
                

				<input type='hidden' name='operate1' value="imoprtManu"/>
				<input type='hidden' name='beanName' value="LedgerTemplateNew"/>
				<input type='hidden' name='treeId' value="id"/>
				<input type='hidden' name='treeText' value="code"/>
				<input type='hidden' name='treeParentId' value="fid"/>
				<input type='hidden' id="project_id" name='project_id' value="${project_id}"/>
				<table class="ListTable" align="center">
					<tr>
						<td class="EditHead">
							导入的Excel文件(支持MS Office Excel 2003)
						</td>
						<!--实际后台也支持2007 -->
						<td class="editTd">
							<s:file name="manu_file" id='manu_file' />
						</td>
					</tr>
				</table>
			</form>
				<div id="layer" style="display: none" align="center">
						<img src="${contextPath}/images/uploading.gif">
						<br>
						正在读取，请稍候......
					</div>
					<div align="left" id="errorInfo1">
						<s:if test="%{#tipList.size != 0}">
							<s:iterator value="%{#tipList}">
								<font color="#FF0000">&nbsp;&nbsp;&nbsp;●<s:property value="%{position}"/>：<s:property value="%{errorInfo}"/></font><br>
							</s:iterator>
						</s:if>
					</div>
					<div align="left" id="errorInfo2">
					<s:if test="%{#tipMessage != null}">
							<font color="#FF0000">&nbsp;&nbsp;&nbsp;●<s:property value="%{#tipMessage.errorInfo}"/></font>
						</s:if> 
					</div>
		</div>	      
	</body>
</html>