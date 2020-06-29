<!DOCTYPE HTML>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
	<head>
		<title>整改总体设置</title>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8"> 
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>   
		<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type='text/javascript' src='${pageContext.request.contextPath}/scripts/turnPage.js'></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>
		<link href="${contextPath}/styles/main/aisCommon.css" rel="stylesheet" type="text/css">
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
	</head>
	<body class="easyui-layout" style="overflow-x:hidden">
				<div  style="width:99%;padding:0px;position:absolute;z-index: 2">
					<table id="toolbar" cellpadding=1 cellspacing=1 border=0 class="ListTable"></table>
				</div>
			<div fit="true" style="z-index: 1;margin-top: 30px;">
				<div class="easyui-panel" style="width:99%;padding:0px;" title="整改总体设置">
				
				<s:form id="myform" action="saveOverallMendLedger" namespace="/proledger/problem">
				<!-- 	<table cellpadding=1 cellspacing=1 border=0 class="ListTable"  > -->
						<table class="ListTable" align="center" style=' overflow: auto;'>
						<tr>
							<td class="EditHead" style="width: 15%;">
								整改责任单位
							</td>
							<td class="editTd" style="width: 35%">
								<s:property value="projectStartObject.audit_object_name"/>
							</td>
							<td class="EditHead" style="width: 15%">
								整改责任部门
							</td>
							<td class="editTd" style="width:35%">
							<s:if test="${view ne 'view' }">
								<s:textfield name="projectStartObject.zeren_dept" cssClass="noborder" cssStyle='width:200px' />
							</s:if>
							<s:else>
								<s:property value="projectStartObject.zeren_dept"/>
							</s:else>
							</td>
						</tr>
						<tr>
						    <td class="EditHead"  >整改责任人</td>
							<td class="editTd" >
							<s:if test="${view ne 'view' }">
								<s:textfield name="projectStartObject.zeren_person" cssClass="noborder" cssStyle='width:200px' />
							</s:if>
							<s:else>
								<s:property value="projectStartObject.zeren_person"/>
							</s:else>							
							</td>
							<td class="EditHead" >联系电话</td>
							<td class="editTd" >
							<s:if test="${view ne 'view' }">							
								<s:textfield name="projectStartObject.telephone" cssClass="noborder" cssStyle='width:200px' />
							</s:if>
							<s:else>
								<s:property value="projectStartObject.telephone"/>
							</s:else>								
							</td>
						</tr>
						<tr>
							<td class="EditHead" style="width: 15%"><font color=red>*</font>监督检查人</td>
							<%-- <td class="editTd" colspan="3">		
								<select class="easyui-combobox" name="projectStartObject.supervisor_name" style="width:260px;"  editable="false">
							       <option value="">&nbsp;</option>
							       <s:iterator value="%{memberList}" id="entry">
						             <option value="<s:property value='userId'/>"><s:property value='userName'/></option>
							       </s:iterator>
							    </select>
							    <s:hidden name="projectStartObject.supervisor_code" />
							</td> --%>
							
							<td class="editTd" colspan="3">
							<s:if test="${view ne 'view' }">
							<select id="supervisor_code" class="easyui-combobox" name="projectStartObject.supervisor_code" editable="false" style="width:200px;" data-options="panelHeight:125">
						       <option value="">&nbsp;</option>
						       <s:iterator value="%{memberList}" id="entry">
							         <s:if test="${projectStartObject.supervisor_code==userId}">
						       			<option selected="selected" value="<s:property value="userId"/>"><s:property value="userName"/>(<s:property value="roleName"/>)</option>
						       		 </s:if>
						       		 <s:else>
								        <option value="<s:property value="userId"/>"><s:property value="userName"/>(<s:property value="roleName"/>)</option>
						       		 </s:else>
						       </s:iterator>
						    </select>
						    </s:if>
						    <s:else>
						    	<s:property value="projectStartObject.supervisor_name"/>
						    </s:else>	
						    <s:hidden name="projectStartObject.supervisor_name"  id="supervisor_name"/>
						</td>
						</tr>
						<tr>
							<%-- <td class="EditHead">
							<s:if test="${interaction==null || interaction==''}">
							<s:if test="${view !='view' || isEdit==false}">
								<a class="easyui-linkbutton" data-options="iconCls:'icon-upload'" onclick="Upload(accelerys);">上传附件</a>
							</s:if>
							</s:if>
							<s:hidden name="projectStartObject.file_id" /></td>
							<td class="editTd" colspan="3">
								<div id="accelerys" align="center">
									<s:property escape="false" value="file_idList" />
								</div>
							</td> --%>
							
							<td class="EditHead">附件
								<s:hidden id="file_id" name="projectStartObject.file_id" />
							</td>
							<td class="editTd" colspan="3">
							<s:if test="${view ne 'view' }">
								<div data-options="fileGuid:'${projectStartObject.file_id}'"  class="easyui-fileUpload"></div>
								</s:if>
								<s:else>
							<div data-options="fileGuid:'${projectStartObject.file_id}',isAdd:false,isEdit:false,isDel:false"  class="easyui-fileUpload"></div>	
								
								</s:else>
							</td>
						</tr>
					</table>
					<s:hidden name="project_id" />
					<s:hidden name="isEdit" />
					</s:form>
					</center>
				</div>
				
				<br/>
				
				<div class="easyui-panel" style="height:370px;width:99%;padding:0px;" title="审计定稿问题">
					<table id="gridList" class="ListTable"  ></table>
					<s:hidden name="project_id" />
					<s:hidden name="isEdit" />
					<s:hidden name="permission" />
				</div>
				<div id="planName" title="问题信息" style="overflow:hidden;padding:0px">
	            	<iframe id="showPlanName" src="" width="100%" title="" height="100%" frameborder="0" ></iframe>
	  			</div>
	  			<s:form id="myform2" action="expMendProblem" namespace="/proledger/problem">
	  				<s:hidden name="project_id" />
					<s:hidden name="isEdit" />
					<s:hidden name="permission" />
	  			</s:form>
	  			
	  		
  			</div>
		<script type="text/javascript">
		
			/*
			 *上传附件
			*/
			function Upload(filelist){
				var guid='${projectStartObject.file_id }';
				var num=Math.random();
				var rnm=Math.round(num*9000000000+1000000000);//随机参数清除模态窗口缓存
				window.showModalDialog('${contextPath}/commons/file/welcome.action?table_name=mng_aud_workplan_detail&table_guid=w_file&guid='+guid+'&&param='+rnm+'&&deletePermission=true',filelist,'dialogWidth:700px;dialogHeight:450px;status:yes');
			}
			/*
			* 删除附件
			*/
			function deleteFile(fileId,guid,isDelete,isEdit,appType,title){
				var boolFlag=window.confirm("确认删除吗?");
				if(boolFlag==true){
					DWREngine.setAsync(false);DWRActionUtil.execute(
						{ namespace:'/commons/file', action:'delFile', executeResult:'false' }, 
						{'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType,'title':title},
						xxx);
					function xxx(data){
					  	document.getElementById(guid).parentElement.innerHTML=data['accessoryList'];
					} 
				}
			}
			function saveForm(){
			    var supervisor_code =$("#supervisor_code").combobox("getValue");
				if(supervisor_code &&supervisor_code != null && supervisor_code != "" ){
					var supervisor_name = $("#supervisor_code").combobox("getText");
					$("#supervisor_name").val(supervisor_name);
				}else{
					top.$.messager.show({
						title:'提示消息',
						msg:'请先选择监督检查人！',
						timeout:5000,
						showType:'slide'
					});
					return false;
				}
				
				
					var formData=$("#myform").serialize();
					$.ajax({
						url : "${contextPath}/proledger/problem/saveOverallMendLedger.action",
						data: formData,
						type: "POST",
						success: function(data){
							$.messager.show({
								title:"消息",
								msg:"保存成功！",
							});
						},
						error:function(data){
							$.messager.show({
								title:"消息",
								msg:"保存失败！",
							});
						}
					});
			}
			//整改信息设定提交
			function submitSetReworkProblem(){
			    var supervisor_code =$("#supervisor_code").combobox("getValue");
				if(supervisor_code &&supervisor_code != null && supervisor_code != "" ){
					var supervisor_name = $("#supervisor_code").combobox("getText");
					$("#supervisor_name").val(supervisor_name);
				}else{
					top.$.messager.show({
						title:'提示消息',
						msg:'请先选择监督检查人！',
						timeout:5000,
						showType:'slide'
					});
					return false;
				}
				var formData=$("#myform").serialize();
				$.ajax({
					url : "${contextPath}/proledger/problem/submitSetReworkProblem.action?supervisor_name="+encodeURIComponent(supervisor_name),
					data: formData,
					type: "POST",
					success: function(tip){
						if(tip=='1'){
							$.messager.show({
								title:"消息",
								msg:"请完成全部问题设定！",
							});
							return false;
						}else if(tip=='-1'){
							$.messager.show({
								title:"消息",
								msg:"请在【被审计单位维护】中完善项目被审计单位反馈账号信息！",
							});
							return false;
						}else{
							$.messager.show({
								title:"消息",
								msg:"提交成功！",
							});
							window.location.href='${contextPath}/proledger/problem/mendLedgerList.action?view=view&project_id=${project_id}&wpd_stagecode=report&isEdit=false&permission=full';
						}
					},
					error:function(data){
						$.messager.show({
							title:"消息",
							msg:"提交失败！",
						});
					}
				});
			}
			
			//选择监督检查人
        	function  getSupervisor(){
           		var code=document.getElementsByName("project_id")[0].value;
           		showPopWin('/ais/pages/system/search/searchdata.jsp?url=<%=request.getContextPath()%>/proledger/problem/selectMember.action&a=a&project_id='+code+'&paraname=projectStartObject.supervisor_name&paraid=projectStartObject.supervisor_code',400,300,'人员选择')
        	} 
			
        	//初始化加载表格
			$(function(){
				// 初始化生成表格
				$('#gridList').datagrid({
					url : "<%=request.getContextPath()%>/proledger/problem/mendLedgerListNew.action?querySource=grid&project_id=${project_id}",
					method:'post',
					showFooter:false,
					rownumbers:true,
					pagination:true,
					striped:true,
					autoRowHeight:false,
					fit: true,
					pageSize:10,
					fitColumns:false,
					idField:'id',	
					border:false,
					singleSelect:true,
					remoteSort: false,
					columns:[[  
						{field:'serial_num',
								title:'问题编号',
								width:'15%',
								align:'center', 
								sortable:true
						},
						{field:'audit_con',
							title:'问题标题',
							width:'15%',
							align:'left', 
							sortable:true
					  },
						{field:'problem_all_name',
							title:'问题类别',
							width:'17.6%',
							sortable:true, 
							halign:'center',
							align:'left'
						},
						{field:'problem_name',
							 title:'问题点',
							 width:'16%',
							 sortable:true, 
							 halign:'center',
							 align:'left'
						},
						{field:'problem_money',
							 title:'问题发生金额（万元）',
							 halign:'center',
							 width:'10%',
							 align:'right',
							 sortable:true
						},
						{field:'problemCount',
							 title:'发生数量（个）',
							 halign:'center',
							 align:'right', 
							 width:'10%',
							 sortable:false
						},
						/* {field:'describe',
							 title:'问题摘要',
							 width:200, 
							 halign:'center',
							 align:'left', 
							 sortable:false
						},
						{field:'audit_advice',
							 title:'处理决定',
							 width:200, 
							 halign:'center',
							 align:'left', 
							 sortable:false
						}, */
						{field:'loginIp',
							 title:'操作',
							 align:'center',
							 sortable:false,
							 width:'12%',
							 formatter:function(value,rowData,rowIndex){
							 	var id = rowData.id;
							 	if(${view != 'view' }){
							 		if(${permission=='full'}){
								 		return "<a href=\"${contextPath}/proledger/problem/editMendLedger.action?id="+id+"&project_id=${project_id}&isEdit=true&permission=full\">编辑</a>"
							 		}else{
							 			/* return "<a href=\"${contextPath}/proledger/problem/editMendLedger.action?id="+id+"&project_id=${project_id}&isEdit=true\">编辑</a>" */
							 			return '<a href=\"javascript:void(0)\" onclick=\"planName(\''+id+'\');\">编辑</a>';
							 		}
							 	}else{
							 		/* return "<a href=\"${contextPath}/proledger/problem/viewMendLedger.action?id="+id+"&project_id=${project_id}&isEdit=false&view=view\">查看</a>" */
							 		return '<a href=\"javascript:void(0)\" onclick=\"viewMendLedger(\''+id+'\');\">查看</a>';
							 	}
							 }
							 
							 
						}
					]]   
				}); 
			});
        	//导出
			function expMendProblemNew(){
				myform2.submit();
			}
        	
        	
        	$(function(){
        		$('#toolbar').datagrid({
        			<s:if test="${authorityFlag=='1'}">
        				<s:if test="${view != 'view'}">
		        			toolbar:[

										{id:'oksubmit',text:'提交',iconCls:'icon-ok',
											handler:function(){
												submitSetReworkProblem();
											}},
											{id:'add',text:'保存',iconCls:'icon-save',
												handler:function(){
													saveForm();
												}},
											{id:'export',text:'导出',iconCls:'icon-export',
												handler:function(){
													expMendProblemNew();
												}}
									]
        				</s:if>
        				<s:else>
	        				toolbar:[
										{id:'export',text:'导出',iconCls:'icon-export',
											handler:function(){
												expMendProblemNew();
											}}
									]
        				</s:else>
        			</s:if>
        		});
        	});
        	function planName(id){
                var viewUrl = "${contextPath}/proledger/problem/editMendLedger.action?id="+id+"&project_id=${project_id}&isEdit=true";
                $('#showPlanName').attr("src",viewUrl);
                $('#planName').window('open');
            }
        	function viewMendLedger(id){
        		var viewUrl = "${contextPath}/proledger/problem/viewMendLedger.action?id="+id+"&project_id=${project_id}&isEdit=false&view=view";
                $('#showPlanName').attr("src",viewUrl);
                $('#planName').window('open');
        	}
        	function closeWin(){
        		$('#planName').window('close');
        	}
        	function saveCloseWin(){
        		$('#planName').window('close');
        		showMessage2("保存成功！");
        	}
        	$('#planName').window({
                width:1000, 
                height:500,  
                modal:true,
                collapsible:false,
                maximizable:true,
                minimizable:false,
                closed:true,
                maximized:true
            });
		</script>
	</body>
</html>
