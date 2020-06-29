<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>终结阶段</title>
<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/boot.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/easyui/contextmenu.js"></script>
<script type="text/javascript" src="${contextPath}/resources/js/createOrgTree.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
<script type="text/javascript" src="${contextPath}/resources/js/jquery-fileUpload.js"></script>


</head>

<s:if test="taskInstanceId!=null&&taskInstanceId!=''&&taskInstanceId!=-1">
	<body class="easyui-layout" onload="end();">
</s:if>
<s:else>
	<body class="easyui-layout">
</s:else>
	<div title='审计组初稿' region="north" style="height:30%" data-options="border:true,collapsible:false">
		<table class="easyui-datagrid" data-options="fit:false,fitColumns:true,nowrap:false,striped:true,border:false">
			<thead>
				<tr>
					<th data-options="field:'fileType',width:'8%',halign:'center'">文件类型</th>
					<th data-options="field:'fileName',width:'10%',halign:'center'">文件名称</th>
					<th data-options="field:'createDate',width:'8%',halign:'center',align:'center'">创建日期</th>
					<th data-options="field:'creator',width:'5%',halign:'center',align:'center'">创建人</th>
					<th data-options="field:'updated',width:'10%',halign:'center',align:'center'">最后编辑日期</th>
					<th data-options="field:'updator',width:'8%',halign:'center',align:'center'">最后编辑人</th>
					<th data-options="field:'operate',width:'10%',halign:'center',align:'center'">操作</th>
					<th data-options="field:'chugaoAccessory',width:'25%',halign:'center',align:'left'">附件</td>
					<th data-options="field:'chugaoAccessoryOpr',width:'10%',halign:'center',align:'center'">附件操作</td>
				</tr>
			</thead>
			<tbody>
			<s:if
				test="varMap['viewchugaoRead']==null?true:varMap['viewchugaoRead']">
				<tr>
					<td>审计组初稿</td>
					<td><s:property value="chugao.fileName" /></td>
					<td>
							<s:property value="chugao.fileTime" />
						</td>
					<td>
							<s:property value="chugao.uploader_name" />
						</td>
					<td>
							<s:property value="chugao.fileEditTime" />
						</td>
					<td>
							<s:property value="chugao.remark_name" />
						</td>
					<td>
						
							<s:if test="${param.view ne 'view'  and projectStartObject.report_closed ne '1' and projectStartObject.report_closed ne '2'}">
								<s:if
									test="varMap['createchugaoRead']==null?false:varMap['createchugaoRead'] && flag==1 &&${projectStartObject.report_closed ne '2'}">
									<a href="javascript:;" onclick="showTemplateList()">创建</a>
								</s:if>
								<s:if
									test="varMap['editchugaoRead']==null?true:varMap['editchugaoRead']">
									<s:if test="chugao!=null && flag==1 && ${projectStartObject.report_closed ne '2'} ">
										<a href="javascript:void(0);"
											onclick="window.open('${contextPath}/pages/commons/file/iweb.jsp?fileId=<s:property value="chugao.fileId"/>','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')">编辑</a>
									</s:if>
								</s:if>
							</s:if>
							<s:if test="chugao!=null">
								<a href="javascript:void(0);"
									onclick="window.open('${contextPath}/pages/commons/file/iweb.jsp?fileId=<s:property value="chugao.fileId"/>&r=t','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')">查看</a>
							</s:if>
					</td>
					 <td>
					<div id="chugaoFiles"></div>
						</td>
						<td>
 	        	        <s:if test="${param.view ne 'view' and taskInstanceId ne '-1'}">
 			 		<div id="chugaoBtn"></div>
						 </s:if> 
						</td> 
				</tr>
			</s:if>
			</tbody>
		</table>
	</div>
	<div title='审计组报告' region="center" data-options="border:true">
		<table class="easyui-datagrid" data-options="fit:false,fitColumns:true,nowrap:false,striped:true,border:false">
			<thead>
			<tr>
				<th data-options="field:'fileType',width:'8%',halign:'center'">文件类型</th>
				<th data-options="field:'fileName',width:'10%',halign:'center'">文件名称</th>
				<th data-options="field:'createDate',width:'8%',halign:'center',align:'center'">创建日期</th>
				<th data-options="field:'creator',width:'5%',halign:'center',align:'center'">创建人</th>
				<th data-options="field:'updated',width:'10%',halign:'center',align:'center'">最后编辑日期</th>
				<th data-options="field:'updator',width:'8%',halign:'center',align:'center'">最后编辑人</th>
				<th data-options="field:'operate',width:'10%',halign:'center',align:'center'">操作</th>
				<th data-options="field:'dinggaoAccessory',width:'25%',halign:'center',align:'left'">附件</td>
				<th data-options="field:'dinggaoAccessoryOpr',width:'10%',halign:'center',align:'center'">附件操作</td>
			</tr>
			</thead>
			<tbody>
			<s:if
				test="varMap['viewdinggaoRead']==null?true:varMap['viewdinggaoRead']">
				<tr>
					<td>审计组报告</td>
					<td><s:property value="dinggao.fileName" /></td>
					<td>
							<s:property value="dinggao.fileTime" />
						</td>
					<td>
							<s:property value="dinggao.uploader_name" />
						</td>
					<td>
							<s:property value="dinggao.fileEditTime" />
						</td>
					<td>
							<s:property value="dinggao.remark_name" />
						</td>
					<td>
						
							<s:if test="${param.view ne 'view' and projectStartObject.report_closed ne '1' and projectStartObject.report_closed ne '2'}">
								<s:if
									test="varMap['createdinggaoRead']==null?false:varMap['createdinggaoRead'] && flag==1 && ${projectStartObject.report_closed ne '2'}">
									<a href="javascript:;" onclick="createdinggao()">创建</a>
								</s:if>
								<s:if
									test="varMap['editdinggaoRead']==null?true:varMap['editdinggaoRead']">
									<s:if test="dinggao!=null && flag==1 && ${projectStartObject.report_closed ne '2'}">
										<a href="javascript:void(0);"
											onclick="window.open('${contextPath}/pages/commons/file/iweb.jsp?fileId=<s:property value="dinggao.fileId"/>','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')">编辑</a>
									</s:if>
								</s:if>
							</s:if>
							<s:if test="dinggao!=null">
								<a href="javascript:void(0);"
									onclick="window.open('${contextPath}/pages/commons/file/iweb.jsp?fileId=<s:property value="dinggao.fileId"/>&r=t','','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no')">查看</a>
							</s:if>
						
					 </td>
					 <td>
					     <div id="dinggaoFiles"></div>
					 </td>
						<td>
        	                 <s:if test="${param.view ne 'view' and taskInstanceId ne -1}"> 
				 		        <div id="dinggaoBtn"></div>
					              </s:if>
						</td> 	
				</tr>
			</s:if>
			</tbody>
		</table>
		<%-- <div id="accelerys" align="center">
			<s:property escape="false" value="qitafujian" />
		</div> --%>
	</div>
	
</div>
<div region="south" style="overflow: auto;height:30%" data-options="collapsible:false,border:false">

	<div id="proInfoDiv" style="display: none;">
		<jsp:include page="/pages/project/start/edit_start_include.jsp" />
	</div>
	<s:form id="projectReportForm" action="save"
		namespace="/project/report">
		<s:hidden name="crudObject.formId" />
		<s:hidden name="crudObject.sucai" />
		<s:hidden name="crudObject.caogao" />
		<s:hidden name="crudObject.chugao" />
		<s:hidden name="crudObject.nidinggao" />
		<s:hidden name="crudObject.dinggao" />
		<s:hidden name="crudObject.qitafujian" />
		<s:hidden name="crudObject.shenjizu_accessory" />
		<s:hidden name="processName" />
  	  	<s:hidden name="project_name" />
  	  	<s:hidden name="formNameDetail" />
		<input type="hidden" name="view" value="${param.view }">
			<s:if test="${param.taskview ne 'view' and (taskInstanceId ne -1)}">
				<div align="center">
					<jsp:include flush="true" page="/pages/bpm/list_transition.jsp" />
				</div>
			</s:if>
			<br />
			<s:if test="${param.view ne 'view' }">
				<div align="right" style="width:97%">
					<!--<s:button
							disabled="!(varMap['uploadqitafujianWrite']==null?true:varMap['uploadqitafujianWrite'])"
							display="${varMap['uploadqitafujianRead']}"
							onclick="Upload('crudObject.qitafujian',accelerys)" value="上传其它附件" />-->
					<s:hidden name="crudObject.qitafujian" />
					<!--<s:submit id="saveButton" action="save" value="保存" onclick="this.style.disabled='disabled';return validateBeforSave();" />&nbsp;&nbsp;-->
					<s:if test="${projectStartObject.report_closed ne '2' and projectStartObject.report_closed ne '1'}">
						<jsp:include flush="true" page="/pages/bpm/list_toBeStart.jsp" />
					</s:if>
				</div>
			</s:if>
			<div align="center">
				<jsp:include flush="true"
					page="/pages/bpm/list_taskinstanceinfo.jsp" />
			</div>

	</s:form>
</div>
<div id="templateWindow">
	<table id="templateList"></table>
</div>
<script type="text/javascript">
$(function(){
	
	if($('#chugaoFiles').length > 0){
		$('#chugaoFiles').fileUpload({
			fileGuid:'${crudObject.chugao_accessory}',
			echoType:2,
			<s:if test="${param.view != 'view' and taskInstanceId != -1}">
			isDel:true,
			isEdit:true,
			 </s:if>
			<s:else>
			isDel:false,
			isEdit:false,
			</s:else> 
			uploadFace:1,
			triggerId:'chugaoBtn'
		});
	}
	if($('#dinggaoFiles').length > 0){
		$('#dinggaoFiles').fileUpload({
			fileGuid:'${crudObject.dinggao_accessory}',
			echoType:2,
			<s:if test="${param.view != 'view' and taskInstanceId != -1}">
			isDel:true,
			isEdit:true,
			 </s:if>
			<s:else>
			isDel:false,
			isEdit:false,
			</s:else>
			uploadFace:1,
			triggerId:'dinggaoBtn'
		});
	}
});

		/**
		  * 检查该项目是否是督导项目 
		  * by zhangxingli  2012.10.21
		  */
		function isSupervisionProject(){
			if ('${user.floginname}'!='null' && '${user.floginname}'=='${projectStartObject.superviserId}')
				return true;
			else
				return false;
		}
		/*
		 * 流程启动前提示和检验
		 */
		function beforStartProcess(){

			var isCreatechugao = "${varMap['createchugaoRead']}";
			var chugaoId = "${chugao.fileId}";
			if(isCreatechugao == 'true'&& (chugaoId == null ||chugaoId == "")){
				top.$.messager.show({
					title:'提示消息',
					msg:"审计组初稿必须创建！",
					timeout: 5000,
					showType:'slide'
				});
				return false;
			}
			var isCreatedinggao = "${varMap['createdinggaoRead']}";
			var dinggaoId = "${dinggao.fileId}";
			if(isCreatedinggao == 'true'&& (dinggaoId == null ||dinggaoId == "")){
				top.$.messager.show({
					title:'提示消息',
					msg:"审计组报告必须创建!",
					timeout: 5000,
					showType:'slide'
				});
				return false;
			}
			//中铁  分配事项必须做底稿，没有做就不能提交
			if(!validateWriteDigao()){
				return false;
			}
			if(!taskToSubmit()){//审计方案提交检查
				return false;
			}
			return true;
		}
		function doStart(){
			document.getElementById('projectReportForm').action = "start.action";
			document.getElementById('projectReportForm').submit();
		}
		/**
		 *	报告阶段最后一步提交前的台账相关校验
		 */
		function AccoutFlowFinished(){
			var result = 'YES';
			var messages = '';
			DWREngine.setAsync(false);
			DWREngine.setAsync(false);DWRActionUtil.execute(
					{ namespace:'/ledger/prjledger/projectLedgerNew', action:'accoutFlowFinished', executeResult:'false' },
					{'projectStartFormId':'${crudObject.project_id}'},
					xxx);
			function xxx(data){
				result = data['accoutFlowFinished'];
				messages = data['messages'];
			}
			return true;
			/**
			 if(result=='YES'){
						return true;
					}else{
						alert("项目中还存在没有设置\"是否整改\"的问题台账,不能启动流程！");
						return false;
					}
			 */
		}

		/*
		 * 创建审计报告素材
		 */
		function createsucai(){
			if(confirm('确定要创建吗？如果您之前已经创建过，之前创建的内容将全部丢失!')){
				window.location.href="/ais/project/report/createsucai.action?crudId=${crudObject.formId}&taskInstanceId=${taskInstanceId}";
			}
		}
		/*
		 * 创建审计报告草稿
		 */
		function createcaogao(){
			if(confirm('确定要创建吗？如果您之前已经创建过，之前创建的内容将全部丢失!')){
				window.location.href="/ais/project/report/createcaogao.action?crudId=${crudObject.formId}&taskInstanceId=${taskInstanceId}";
			}
		}
		/*
		 * 创建审计报告初稿
		 */
		function createchugao(templateId){
			//审计问题一览，如果入报告没处理，对那些问题进行提示，需要进行处理，否则不能创建初稿
			var flag = true;
			$.ajax({
				type:'get',
				url:'${contextPath}/project/report/checkLedgerProblemsNoOPr.action',
				data:{project_id:'${crudObject.project_id}'},
				dataType:'json',
				async:false,
				cache:false,
				success:function(data){
					if(data.type=='yes'){
						top.$.messager.show({
							title:'提示信息',
							msg:data.Mes,
							width:500,
							height:'auto',
							showType:'slide',
							timeout:5000
						});
						flag = false;
					}
				}
			}); 
			if(flag){
				top.$.messager.confirm('确认对话框','确定要使用此模板创建报告吗？之前创建的报告内容将全部丢失!',function(r){
					if(r){
						var h = window.screen.availHeight;
						var w = window.screen.width;
						window.showModalDialog("/ais/project/report/createchugao.action?templateId="+templateId+"&crudId=${crudObject.formId}&taskInstanceId=${taskInstanceId}",window,'dialogWidth:'+w+'px;dialogHeight:'+h+'px;status:no;resizable:yes;minimize:yes;maximize:yes;');
					}
				});
			}else{
				return false;
			}
		}
		//检查入报告问题
		function checProblemInReport(){
			$.ajax({
				type: "POST",
				url: "<%=request.getContextPath()%>/project/report/checProblemInReport.action",
				data : {

					"project_id":"${crudObject.project_id}","wpd_stagecode":"prepare"
				},
				success: function(data){
					if(data['success']!=false){
						alert(data['success']);
						/* return false; */
					}/* else{
					 return true;
					 }
					 */
				}
			});
		}

		/*
		 * 创建审计报告拟定稿
		 */
		function createnidinggao(){
			if(confirm('确定要创建吗？如果您之前已经创建过，之前创建的内容将全部丢失!')){
				window.location.href="/ais/project/report/createnidinggao.action?crudId=${crudObject.formId}&taskInstanceId=${taskInstanceId}";
			}
		}
		/*
		 * 创建审计报告定稿
		 */
		function createdinggao(){
			top.$.messager.confirm('确认对话框','确定要创建吗？如果您之前已经创建过，之前创建的内容将全部丢失!',function(r){
				if(r){
					var h = window.screen.availHeight;
					var w = window.screen.width;
					window.showModalDialog("/ais/project/report/createdinggao.action?crudId=${crudObject.formId}&taskInstanceId=${taskInstanceId}",window,'dialogWidth:'+w+'px;dialogHeight:'+h+'px;status:no;resizable:yes;minimize:yes;maximize:yes;');
				}
			});
		}
		/*
		 *   删除其它审计报告附件
		 */
		function deleteFile(fileId,guid,isDelete,isEdit,appType,title){
			var boolFlag=window.confirm("确认删除吗?");
			if(boolFlag==true){
				DWREngine.setAsync(false);DWRActionUtil.execute(
					{ namespace:'/commons/file', action:'delFile', executeResult:'false' }, 
					{'fileId':fileId, 'deletePermission':isDelete, 'isEdit':isEdit, 'guid':guid, 'appType':appType,'title':title},
					xxx);
				function xxx(data){
				  	window.location.reload();
				}
			}
		}
		/*
		 上传其它审计报告附件
		 */
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
		/*
		 * 保存前校验
		 */
		function validateBeforSave(){
			if(!validateDate('audit_start_time','audit_end_time')){
				return false;
			}
			if(frmCheck(document.forms[0],'projectStartTable')==false){
				return false;
			}
			/*if(!taskToSubmit()){//审计方案提交检查
			 return false;
			 }*/
			return true;
		}
		/*
		 * 提交或启动报告阶段流程时教研，必做事项是否增加了底稿
		 * by zhangxingli 2013-11-12
		 */
		function validateWriteDigao(){
			var flag="YES";
			DWREngine.setAsync(false);
			DWREngine.setAsync(false);DWRActionUtil.execute(
					{ namespace:'/operate/manuExt', action:'validateWriteDigaoTheTasks', executeResult:'false' },
					{'project_id':'${crudObject.project_id}'},
					xxx);
			function xxx(data){
				var dataArr=new Array();
				var dataStr=data['isWrite'];
				if(data['isWrite']=='0'||data['isWrite']=='1'){
					flag="YES";
				}else {//已经分工的审计事项有未填写的底稿
					top.$.messager.show({
						title:'提示消息',
						msg:'<div>以下已分工的审计事项未编写底稿，不能启动或提交流程:</div>'+dataStr,
						width:500,
						height:'auto',
						timeout: 5000,
						showType:'slide'
					});//提示：分配到的审计事项未编写底稿，不能启动或提交流程！
					flag="NO";
				}
			}
			if(flag=="YES") {
				return true;
			}else{
				return false;
			}
		}
		/*
		 * 提交流程表单
		 */
		function toSubmit(){
			/*if(!validateBeforSave()){
			 return false;
			 }*/
			//by  zhangxingli 2013-11-12
			/* if(!validateWriteDigao()){
			 return false;
			 } */
			///add by yangbo 校验整改信息是否已处理完毕。
			 <s:if test="varMap['isCheckZGXXWrite']==null?false:varMap['isCheckZGXXWrite']">
			if(!AccoutFlowFinished()){
				return false;
			}
			</s:if> 

			<s:if test="varMap['createdinggaoRequired']&&(dinggao == null) ">
			var temp = $("#projectReportForm_formInfo_toNodeId").find("option:selected").text();
			if(temp.indexOf('<s:property value="@ais.bpm.util.BpmConstants@RETURN_STEP"/>')!=-1){
			}else{
				top.$.messager.show({
					title:'提示消息',
					msg:"审计组报告报告必须创建!",
					timeout: 5000,
					showType:'slide'
				});
				return false;
			}
			</s:if>
			<s:if test="isUseBpm=='true'">
			if(document.getElementsByName('isAutoAssign')[0].value=='false'||document.getElementsByName('formInfo.toActorId')[0]!=undefined){
				var actor_name=document.getElementsByName('formInfo.toActorId')[0].value;
				
					
				
				
				if(actor_name==null||actor_name==''){
					top.$.messager.show({
						title:'提示消息',
						msg:"下一步处理人不能为空!",
						timeout: 5000,
						showType:'slide'
					});
					return false;
				}
			}
			/* <s:if test="taskInstanceId!=null&&taskInstanceId!=''">
			 if(!taskToSubmit()){//审计方案提交检查
			 return false;
			 }
			</s:if> */
			</s:if>
			/* <s:else>
			 if(!taskToSubmit()){//审计方案提交检查
			 return false;
			 }
			</s:else> */
			top.$.messager.confirm('确认对话框',"您确认提交吗?",function(r){
				if(r){
					document.getElementById('submitButton').disabled=true;
					var startForm = document.getElementById('projectReportForm');
					<s:if test="isUseBpm=='true'">
					startForm.action="<s:url action="submit" includeParams="none"/>";
					</s:if>
					<s:else>
					startForm.action="<s:url action="directSubmit" includeParams="none"/>";
					</s:else>
					startForm.submit();
				}else{
					return false;
				}
			});
		}

		/*
		 校验两个日期大小顺序
		 */
		function validateDate(beginDateId,endDateId){
			var s1 = document.getElementById(beginDateId);
			var e1 = document.getElementById(endDateId);
			if(s1 && e1){
				var s = s1.value;
				var e = e1.value
				if(s!='' && e!=''){
					var s_date=new Date(s.replace("-","/"));
					var e_date=new Date(e.replace("-","/"));
					if(s_date.getTime()>e_date.getTime()){
						window.alert("日期区间开始必须小于结束!");
						return false;
					}
				}
			}
			return true;
		}

		/*
		 * 审计方案提交检查
		 */
		function taskToSubmit(){
			var message="";
			var pic_digaoshenheStr;
			DWREngine.setAsync(false);
			DWREngine.setAsync(false);DWRActionUtil.execute(
					{ namespace:'/operate/doubt', action:'dwrGetValue', executeResult:'false' },
					{'project_id':'${crudObject.project_id}'},xxx);
			function xxx(data){
				pic_digaoshenheStr=data['pic_digaoshenheStr'];//有审核中不能提交

			}
			if(pic_digaoshenheStr!=null&&pic_digaoshenheStr!=''){
				top.$.messager.show({
					title:'提示消息',
					msg:pic_digaoshenheStr,
					timeout: 5000,
					showType:'slide'
				});
				return false;
			}
			return true;
		}
	//审计报告模板列表
	function showTemplateList(){
		// 初始化生成表格
		$('#templateList').datagrid({
			url : "<%=request.getContextPath()%>/unitary/nc/autoreport/reportTemplateList.action?template.projectTypeCode=${projectStartObject.pro_type},${projectStartObject.pro_type_child}&crudId=${crudObject.formId}&fromType=report",
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
						var link = '<a href=\"javascript:void(0);\" onclick=\"createchugao(\''+row.templateId+'\');\">创建报告</a>';
						return link;
					}
				}
			]]
		});

		$('#templateWindow').window({
			title:'选择报告模板',
			width:600,
			height:400,
			modal:true,
			collapsible:false,
			maximizable:true,
			minimizable:false
		});
	}
</script>
</body>
</html>
