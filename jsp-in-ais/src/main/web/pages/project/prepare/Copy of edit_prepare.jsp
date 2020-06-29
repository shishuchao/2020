<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>准备阶段</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/pages/introcontrol/util/themes/default/easyui.css">
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath()%>/pages/introcontrol/util/easyui-lang-zh_CN.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>
		<script type='text/javascript' src='${contextPath}/scripts/dwr/DWRActionUtil.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/interface/DWRAction.js'></script>
		<script type='text/javascript' src='${contextPath}/dwr/engine.js'></script>
		<script type="text/javascript" src="${contextPath}/scripts/base64_Encode_Decode.js"></script>
		<s:head theme="ajax" />
	</head>
	<script type="text/javascript">
	/**
    	 * 在线审计
    	 */
    	function zxsj(){
    		var host = '<s:property value="@ais.project.ProjectSysParamUtil@getZXSJHostPort()" />';
			var projectCode = document.getElementsByName("projectStartObject.project_code")[0].value;
			var auditStartTime = document.getElementsByName("projectStartObject.audit_start_time")[0].value;
			if(auditStartTime==''){
				alert('审计期间没有定义,无法在线作业!');
				return false;
			}
			var start_1=auditStartTime.split("-")[0];
			var start_2=auditStartTime.split("-")[1];
			var start_3=auditStartTime.split("-")[2];
			
			if(start_2.length==1){
				start_2 = '0' + start_2;
			}
			if(start_3.length==1){
				start_3 = '0' + start_3;
			}
			
			var start=start_1+start_2+start_3;
			
			var auditEndTime = document.getElementsByName("projectStartObject.audit_end_time")[0].value;
			if(auditEndTime==''){
				alert('审计期间没有定义,无法在线作业!');
				return false;
			}
			var end_1=auditEndTime.split("-")[0];
			var end_2=auditEndTime.split("-")[1];
			var end_3=auditEndTime.split("-")[2];
			
			if(end_2.length==1){
				end_2 = '0' + end_2;
			}
			if(end_3.length==1){
				end_3 = '0' + end_3;
			}
			
			var end=end_1+end_2+end_3;
			
			/*var queryString = encode64(encodeURI(""+projectCode+","+start+","+end+",${user.floginname}"));
			//window.open("http://"+host+"/login.jsp?p="+queryString,'','');
			var url ="http://"+host+"/login.jsp?p="+queryString;*/
            var host = '<s:property value="@ais.project.ProjectSysParamUtil@getZXSJHostPort()" />';
            var queryString = encodeURIComponent(RSAEncode("${user.floginname}"));
            var url ="http://"+host+"/vision/Login-YY.jsp?audit="+queryString + "&vision=A6";
			var udswin=window.open(url,'','toolbar=no,location=no,status=yes,resizable=yes');
		    udswin.moveTo(0,0);
		    udswin.resizeTo(window.screen.availWidth,window.screen.availHeight);
			//上面联网窗口打开后会修改一些本机管理的cookie信息,需要重新让管理系统用户自动认证一下才行
			var crudId = document.getElementById('crudId').value;
			window.location.href="/ais/project/actualize/edit.action?crudId="+crudId;
			
    	}
	</script>
	<s:if test="taskInstanceId!=null&&taskInstanceId!=''">
		<body class="easyui-layout" onload="end();">
	</s:if>
	<s:else>
		<body class="easyui-layout">
	</s:else>
	<div region="center" style="overflow:hidden;">
				<div class="easyui-tabs" fit="true" border="false">
					 <s:if test="varMap['modifyMemberRead']==null?true:varMap['modifyMemberRead']">
					<div title="成员信息" style="overflow:hidden;">
						<iframe id="projectMemberFrame" src="${contextPath}/project/getlistMembers.action?crudId=<s:property value="crudObject.project_id" />"
									frameborder="0" scrolling="yes" style="width:100%;height:100%;"></iframe>
					</div>
					</s:if>
					<s:if test="varMap['modifyGroupRead']==null?true:varMap['modifyGroupRead']">
						<div id='projectGroupDiv' title='分组信息' style="overflow:hidden;">
							<iframe id="projectMemberFrame"
									src="${contextPath}/project/listGroups.action?crudId=<s:property value="crudObject.project_id" />"
									frameborder="0" scrolling="yes" style="width:100%;height:100%;"></iframe>
						</div>
					</s:if>
					<s:if test="varMap['modifySSFARead']==null?true:varMap['modifySSFARead']">
						<div id='actualizeScheme_outer' title='实施方案' style="overflow:hidden;">
							<iframe id="actualizeScheme_inner"
								src="${pageContext.request.contextPath}/operate/template/view.action?project_id=<s:property value="crudObject.project_id" />"
								frameborder="0" scrolling="yes" style="width:100%;height:100%;"></iframe>
						</div>
					</s:if>
					 <div id='auditAccessoryDiv' title='被审计单位资料' style="overflow:hidden;">
                        <iframe id="prepareWorkProgram"
                            src="${contextPath}/auditAccessoryList/list.action?cruProId=<s:property value="crudObject.project_id" />&wpd_stagecode=prepare"
                            frameborder="0" scrolling="yes" style="width:100%;height:100%;"></iframe>
                    </div>
                    <s:if test="isReworkEnable&&projectStartObject.pro_type==reworkProjectTypeCode">
						<div id='projectReworkInfoDiv' title='后续审计项目信息' style="overflow:hidden;">
							<display:table id="reworkPro" name="projectStartObject.reworkProjectList" class="its">
									<display:column property="project_code" title="项目编号"
										 headerClass="center"  style="WHITE-SPACE: nowrap"  sortable="true"/>
									<display:column property="project_name" title="项目名称" 
										headerClass="center"  style="WHITE-SPACE: nowrap"  sortable="true"/>
									<display:column property="pro_type_name" title="项目类别" 
										headerClass="center"  style="WHITE-SPACE: nowrap"  sortable="true"/>
									<display:column property="real_start_time" title="启动日期" 
										headerClass="center"  style="WHITE-SPACE: nowrap" sortable="true" />
									<display:column property="real_closed_time" title="关闭日期" 
										headerClass="center"  style="WHITE-SPACE: nowrap" sortable="true" />
									<display:column property="audit_dept_name" title="审计单位" 
										headerClass="center"  style="WHITE-SPACE: nowrap" sortable="true" />
									<display:column property="audit_object_name" title="被审单位" 
										headerClass="center"  style="WHITE-SPACE: nowrap" sortable="true" />
									<display:column property="pro_teamleader_name" title="项目组长" 
										headerClass="center" style="WHITE-SPACE: nowrap"  />
									<display:column title="操作" headerClass="center"
										style="WHITE-SPACE: nowrap" class="center" media="html">
											<a href="<s:url action="view" namespace="/project" includeParams="none"></s:url>?viewPermission=full&crudId=${reworkPro.formId}"
												target="_blank">详细信息</a>
									</display:column>
								</display:table>
						</div>
					</s:if>
					<s:if test="varMap['modifyZJSQRead']==null?true:varMap['modifyZJSQRead']">
						<div id='auditResultPermission' title='审计成果组间授权' style="overflow:hidden;">
							<iframe id="auditResultPermissionFrame"
								src="${contextPath}/project/permission/edit.action?pso.formId=<s:property value="crudObject.project_id" />"
								frameborder="0" scrolling="yes" style="width:100%;height:100%;"></iframe>
						</div>
					</s:if>
					<%-- 督导人员填写督导底稿 
					<s:if test="'${user.floginname}'=='${projectStartObject.superviserId}'">
						<div id='supervisionInfo' title='督导项目专用' style="overflow:hidden;">
							<iframe id="projectInfoFrame"
							src="${contextPath}/project/start/listSupervision.action?project_id=<s:property value="crudObject.project_id"/>"
							frameborder="0" scrolling="yes" style="width:100%;height:100%;"></iframe>
						</div>
					</s:if>
					 --%>
				</div>
			</div>
			<s:if test="${ projectStartObject.prepare_closed ne '1'}">
			<div region="south" split=true style="height: 100px;overflow: auto;">
				<center>
				<s:form id="projectPrepareForm" action="save" namespace="/project/prepare">
				<s:hidden name="projectStartObject.project_code"></s:hidden>
				<div id="proInfoDiv" style="display: none;">
					<jsp:include page="/pages/project/start/edit_start_include.jsp" />
				</div>
				<div align="center">
					<jsp:include flush="true" page="/pages/bpm/list_transition.jsp" />
				</div>
				
				<div align="right" style="width: 97%">
					<s:if test="@ais.project.ProjectSysParamUtil@isZXSJEnabled()">
                        <s:button value="在线分析" cssStyle="margin: auto 5px;" onclick="zxsj();"/>
                    </s:if>
					<input id="saveButton" type="button" value="保存" onclick="this.style.disabled='disabled';return toSave('projectPrepareForm','projectStartTable')"/>
					<jsp:include flush="true" page="/pages/bpm/list_toBeStart.jsp" />
				</div>
				
				<div align="center">
					<jsp:include flush="true" page="/pages/bpm/list_taskinstanceinfo.jsp" />
				</div>
				
			</s:form>
			</center>
			</div>
		</s:if>
		<script type="text/javascript">
		/**
		  * 检查该项目是否是督导项目 
		  * by zhangxingli 
		  */
		function isSupervisionProject(){
			if ('${user.floginname}'!='null'&&'${user.floginname}'=='${projectStartObject.superviserId}')
				return true;
			else
				return false;
		}
		/*
		* 显示或隐藏项目基本信息
		*/
		function triggerProjectInfoDiv(){
				var evt = window.event;
				var eventSrc = evt.target || evt.srcElement;
				var proInfoDiv = document.getElementById('proInfoDiv');
				if(proInfoDiv.style.display=='none'){
					eventSrc.innerText="隐藏项目信息";
					proInfoDiv.style.display='';
				}else{
					eventSrc.innerText="展开项目信息";
					proInfoDiv.style.display='none';
				}
		}
			
			/*
				提交表单
			*/
			function toSubmit(option){

				var tableId = 'projectStartTable';
				var formId = 'projectPrepareForm';
				
				if(!validateDate('audit_start_time','audit_end_time')){
					return false;
				}
				
				if(!fff1()){
					return false;
				}
				
				var flowForm = document.getElementById(formId);
				if(frmCheck(flowForm,tableId)==false){
					return false;
				}else{
					<s:if test="isUseBpm=='true'">
						if(document.getElementsByName('isAutoAssign')[0].value=='false'||document.getElementsByName('formInfo.toActorId')[0]!=undefined){
							var actor_name=document.getElementsByName('formInfo.toActorId')[0].value;
							if(actor_name==null||actor_name==''){
								window.alert('下一步处理人不能为空！');
								return false;
							}
						}
					</s:if>
					if(confirm('确认提交吗?')){
						document.getElementById('submitButton').disabled=true;
						<s:if test="isUseBpm=='true'">
							flowForm.action="<s:url action="submit" includeParams="none"/>";
						</s:if>
						<s:else>
							flowForm.action="<s:url action="directSubmit" includeParams="none"/>";
						</s:else>
						flowForm.submit();
					}else{
						return false;
					}
				}
			}
			/*
				保存表单
			*/
			function toSave(formId,tableId){
				if(!validateDate('audit_start_time','audit_end_time')){
					return false;
				}
				var flowForm = document.getElementById(formId);
				document.getElementById('saveButton').disabled=true;
				if(frmCheck(flowForm,tableId)==false){
					document.getElementById('saveButton').disabled=false;
					return false;
				}else{	
					flowForm.action="${contextPath}/project/prepare/save.action";
					flowForm.submit();
				}
			}

			/*
				校验两个日期大小顺序
			*/
			function validateDate(beginDateId,endDateId){
				var s = document.getElementById(beginDateId).value;
				var e = document.getElementById(endDateId).value
				if(s!='' && e!=''){
					var s_date=new Date(s.replace("-","/"));
					var e_date=new Date(e.replace("-","/"));
					if(s_date.getTime()>e_date.getTime()){
						window.alert("日期区间开始必须小于结束!");
						return false;
					}
				}
	
				return true;
			}
		
			/*
			* 审计文书
			*/
			function Upload_auditAmanuensis(){
				var num=Math.random();
				var rnm=Math.round(num*9000000000+1000000000);
				window.showModalDialog('${contextPath}/commons/file/welcome.action?guid=<s:property value="crudObject.fileAuditAmanuensis"/>&&param='+rnm+'&&deletePermission=<s:property value="%{varMap.deletefileAuditAmanuensisRead}"/>&&isEdit=<s:property value="%{varMap.editfileAuditAmanuensisRead}"/>&&title='+encodeURI(encodeURI("审计文书")),fileAuditAmanuensis,'dialogWidth:700px;dialogHeight:500px;status:yes');
			}
			
			/*
			* 审前调查
			*/
			function Upload_auditBeforeInquire(){
				var num=Math.random();
				var rnm=Math.round(num*9000000000+1000000000);
				window.showModalDialog('${contextPath}/commons/file/welcome.action?guid=<s:property value="crudObject.fileAuditBeforeInquire"/>&&param='+rnm+'&&deletePermission=<s:property value="%{varMap.deletefileAuditBeforeInquireRead}"/>&&isEdit=<s:property value="%{varMap.editfileAuditBeforeInquireRead}"/>&&title='+encodeURI(encodeURI("审前调查")),fileAuditBeforeInquire,'dialogWidth:700px;dialogHeight:500px;status:yes');
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
			
			/*
			* 是否创建了审计方案
			*/
			function fff1(){
				var message="";
				DWREngine.setAsync(false);
				DWREngine.setAsync(false);DWRActionUtil.execute(
				{ namespace:'/operate/task', action:'checkActualizeScheme', executeResult:'false' }, 
				{'pro_form_id':'${crudObject.formId}','pro_id':'${crudObject.project_code}'},xxx);
				function xxx(data){
					message=data['as'];
				};
				if(message!=null&&message!=''){
					alert(message);
					return false;
				}else{
					return true;
				}
			}
		</script>
		
		</body>
</html>