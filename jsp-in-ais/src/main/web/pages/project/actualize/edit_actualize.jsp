<%@page import="java.net.URLDecoder"%>
<%@page import="ais.framework.util.Base64"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<title>实施阶段</title>
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet" type="text/css" />
		<link href="${contextPath}/resources/csswin/subModal.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${contextPath}/scripts/ais_functions.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/common.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/csswin/subModal.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/check.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/calendar.js"></script>
		<script type="text/javascript" src="${contextPath}/scripts/base64_Encode_Decode.js"></script>
		<s:head theme="ajax" />
        <script language="javascript">
        /**
    	 * 实施作业
    	 */
    	function sszy(){
    		var h = window.screen.availHeight;
    		var w = window.screen.width;
    		var isChecked = false;
			var projectId = document.getElementsByName("crudObject.project_id")[0].value;
			var num=Math.random();
			var rnm=Math.round(num*9000000000+1000000000);
			win = window.open('<%=request.getContextPath()%>/operate/taskExt/index.action?project_id='+projectId+'','cw11','height=768,width=1024,status=no,toolbar=no,menubar=no,location=no,resizable=yes');
			win.moveTo(0,0)   
			win.resizeTo(w,h) 
			if(win && win.open && !win.closed){
              win.focus();
			}
    	}
    	
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
			var url ="http://"+host+"/login.jsp?p="+queryString;*/
            var host = '<s:property value="@ais.project.ProjectSysParamUtil@getZXSJHostPort()" />';
            var password = decode64("${user.dataPass}");
            var queryString = encodeURIComponent(RSAEncode("${user.floginname}"));
            var url ="http://"+host+"/vision/Login-YY.jsp?audit="+queryString + "&vision=A6";
			var udswin=window.open(url,'','height=700px, width=800px, toolbar=no, menubar=no, scrollbars=no,resizable=yes,location=no, status=no');
	        udswin.moveTo(0,0);
	        udswin.resizeTo(window.screen.availWidth,window.screen.availHeight);
			//window.open("http://"+host+"/login.jsp?p="+queryString,'','');
			//上面联网窗口打开后会修改一些本机管理的cookie信息,需要重新让管理系统用户自动认证一下才行
			var crudId = document.getElementById('crudId').value;
			window.location.href="/ais/project/actualize/edit.action?crudId="+crudId;
			
    	}
    	
        </script>
	</head>

	<s:if test="taskInstanceId!=null&&taskInstanceId!=''">
		<body onload="end();">
	</s:if>
	<s:else>
		<body>
	</s:else>
		<center>
			<s:form id="projectActualizeForm" action="save" namespace="/project/actualize">
			     <s:hidden name="crudObject.project_id"></s:hidden>
			     <s:hidden id="crudId" name="crudId" />
                 <s:hidden name="projectStartObject.project_code"></s:hidden>
				<div id="proInfoDiv" style="display: none;">
					<jsp:include page="/pages/project/start/edit_start_include.jsp" />
				</div>
				<s:tabbedPanel id='actualizePanel' theme='ajax' cssStyle="width:97%;margin:0;">
                 <s:div id='auditWorkProgramActualize' label='补充性审计文书' theme='ajax' 
                            labelposition='top' loadingText="正在加载内容......">
                    <c:set var="canEdit" value="false" />
                    <c:forEach items="${projectStartObject.proMembers}" var="proMember">
						<c:if test="${user.floginname==proMember.userId&&(proMember.role=='zuzhang'||proMember.role=='fuzuzhang'||proMember.role=='zhushen')}">
							<c:set var="canEdit" value="true" />
						</c:if>
					</c:forEach>
					<c:choose>
					   <c:when test="${canEdit}">
					   		<iframe id="prepareWorkProgram"
                                src="${contextPath}/workprogram/editWorkProgramProjectDetail.action?projectid=<s:property value="crudObject.project_id" />&wpd_stagecode=actualize"
                                frameborder="0" width="100%" height="300" scrolling="auto"></iframe>
					   </c:when>
					   <c:otherwise>
							<iframe id="prepareWorkProgram"
                                src="${contextPath}/workprogram/viewWorkProgramProjectDetail.action?projectid=<s:property value="crudObject.project_id" />&wpd_stagecode=actualize"
                                frameborder="0" width="100%" height="300" scrolling="auto"></iframe>
					   </c:otherwise>
					</c:choose>
                </s:div>
                <s:div id='projectMemberDiv' label='成员信息' theme='ajax' labelposition='top' loadingText="正在加载内容......">
					<div align="center">
						<iframe id="projectMemberFrame"
							src="${contextPath}/project/members/listMembers.action?projectFormId=<s:property value="crudObject.project_id" />"
							frameborder="0" width="100%" height="440"></iframe>
					</div>
				</s:div>
				<s:div id='auditAccessoryDiv' label='被审计单位资料' theme='ajax' 
                        labelposition='top' loadingText="正在加载内容......">
                        <iframe id="prepareWorkProgram"
                            src="${contextPath}/auditAccessoryList/list.action?cruProId=<s:property value="crudObject.project_id" />&wpd_stagecode=prepare"
                            frameborder="0" width="100%" height="320" scrolling="auto"></iframe>
                </s:div>
                <s:if test="varMap['modifyZJSQRead']==null?true:varMap['modifyZJSQRead']">
						<s:div id='auditResultPermission' label='审计成果组间授权' theme='ajax' 
							labelposition='top' loadingText="正在加载内容......" refreshOnShow="true" >
							<iframe id="auditResultPermissionFrame"
								src="${contextPath}/project/permission/edit.action?pso.formId=<s:property value="crudObject.project_id" />"
								frameborder="0" width="100%" height="320" scrolling="auto"></iframe>
						</s:div>
				</s:if>
                </s:tabbedPanel>
				
				<br />
				
				<div align="center" style="width: 97%">
                    <s:button value="审计实施" cssStyle="margin: auto 5px;" onclick="sszy();"/>
                    <s:if test="@ais.project.ProjectSysParamUtil@isZXSJEnabled()">
                        <s:button value="大数据审计" cssStyle="margin: auto 5px;" onclick="zxsj();"/>
                    </s:if>
                    <%-- 只有整体组的项目组长,副组长和主审才能修改项目基本信息--%>
                    <c:set var="canEdit" value="false" />
					<c:forEach items="${projectStartObject.proMembers}" var="proMember">
						<c:if test="${user.floginname==proMember.userId&&proMember.group.groupType=='zhengti'&&(proMember.role=='zuzhang'||proMember.role=='fuzuzhang'||proMember.role=='zhushen')}">
							<c:set var="canEdit" value="true" />
						</c:if>
					</c:forEach>
					<s:if test="${canEdit}">
						<input type="button" id="saveButton" value="保存项目信息"  onclick="this.style.disabled='disabled';return toSave('projectActualizeForm','projectStartTable');" />
					</s:if>
					<input type="button" value="返回" onclick="this.style.disabled='disabled';window.location.href='${contextPath}/project/actualize/listAll.action'" />
				</div>
				
				<div align="center">
					<jsp:include flush="true" page="/pages/bpm/list_taskinstanceinfo.jsp" />
                    
				</div>
				
			</s:form>
			<s:form id="projectPrepareForm" action="save" namespace="/project/prepare">
			
			</s:form>
		</center>
		
		<script type="text/javascript">
		
			/*
				提交表单
			*/
			function toSubmit(option){

				var tableId = 'projectStartTable';
				var formId = 'projectActualizeForm';
				
				if(!validateDate('audit_start_time','audit_end_time')){
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
					flowForm.action="${contextPath}/project/actualize/save.action";
					flowForm.submit();
				}
			}

			/*
				校验两个日期大小顺序
			*/
			function validateDate(beginDateId,endDateId){
				var s1 = document.getElementById(beginDateId);
				var e1 = document.getElementById(endDateId);
				if(s1 && e1){
					var s = s1.value;
					var e = e1.value;
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
		
		</script>
		
		</body>
</html>