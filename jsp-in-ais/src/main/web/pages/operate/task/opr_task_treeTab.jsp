<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://displaytag.sf.net" prefix="display"%>




<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head><meta http-equiv="content-type" content="text/html; charset=UTF-8">

		<title>实施方案详细信息</title>
		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<link href="${contextPath}/styles/main/ais.css" rel="stylesheet"
			type="text/css">
		<s:head theme="ajax" />
	</head>

	<body>
		<s:tabbedPanel id='test' theme='ajax'>
 
			<s:url id="preArchivesInfoDetail" action="archivesPigeonholeDetail"
				namespace="/mng/archives/pigeonhole">
				<s:param name="project_id" value="project_id"></s:param>
				<s:param name="crudId" value="crudId"></s:param>
			</s:url>
			<s:div id='preArchivesInfo' label='总体方案' theme='ajax'
				labelposition='top' loadingText="正在加载内容......" autoStart="false">
				<iframe id="preArchivesInfoFrame"
					src="${contextPath}/operate/task/showContentRootView.action?project_id=<%=request.getParameter("project_id")%>&audTemplateId=<%=request.getParameter("audTemplateId")%>"
					frameborder="0" width="100%" height="1000"></iframe>
			</s:div>


			<s:url id="afterArchivesInfoDetail" action="archivesPigeonholeDetail"
				namespace="/mng/archives/pigeonhole/after">
				<s:param name="project_id" value="project_id"></s:param>
				<s:param name="crudId" value="crudId"></s:param>
			</s:url>
			<s:div id='afterArchivesInfo' label='事项类别' theme='ajax'
				labelposition='top' loadingText="正在加载内容......" autoStart="false">
				<iframe id="afterArchivesInfoFrame"
					src="${contextPath}/operate/task/showContentTypeView.action?type=<%=request.getParameter("type")%>&taskTemplateId=<%=request.getParameter("taskId")%>&project_id=<%=request.getParameter("project_id")%>"
					frameborder="0" width="100%" height="1000"></iframe>
			</s:div>
			<s:url id="copyArchivesInfoDetail" action="archivesPigeonholeDetail"
				namespace="/mng/archives/pigeonhole/copy">
				<s:param name="project_id" value="project_id"></s:param>
				<s:param name="crudId" value="crudId"></s:param>
			</s:url>
			<s:div id='copyArchivesInfo' label='审计事项' theme='ajax'
				labelposition='top' loadingText="正在加载内容......" autoStart="false">
				<iframe id="copyArchivesInfoFrame"
					src="${contextPath}/operate/task/showContentLeafView.action?type=<%=request.getParameter("type")%>&taskTemplateId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>&project_id=<%=request.getParameter("project_id")%>"
					frameborder="0" width="100%" height="1000"></iframe>
			</s:div>
			
			<s:div id='s1' label='审计日记' theme='ajax' 
				labelposition='top' loadingText="正在加载内容......" autoStart="false">
				<iframe id="copyArchivesInfoFrame" name="DA"
					src="${contextPath}/operate/diary/search.action?taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>&project_id=<%=request.getParameter("project_id")%>"
					frameborder="0" width="100%" height="1000"></iframe>
			</s:div>
			
			<s:div id='s2' label='工作底稿' theme='ajax' 
				labelposition='top' loadingText="正在加载内容......" autoStart="false">
				<iframe id="copyArchivesInfoFrame" name="MS"
					src="${contextPath}/operate/manu/search.action?taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>&project_id=<%=request.getParameter("project_id")%>"
					frameborder="0" width="100%" height="1000"></iframe>
			</s:div>
			
			
			<s:div id='s3' label='重大事项' theme='ajax' 
				labelposition='top' loadingText="正在加载内容......" autoStart="false">
				<iframe id="copyArchivesInfoFrame" name="DS"
					src="${contextPath}/operate/doubt/search.action?type=DS&taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>&project_id=<%=request.getParameter("project_id")%>"
					frameborder="0" width="100%" height="1000"></iframe>
			</s:div>
			
			<s:div id='s4' label='审计发现' theme='ajax' 
				labelposition='top' loadingText="正在加载内容......" autoStart="false">
				<iframe id="copyArchivesInfoFrame" name="FX"
					src="${contextPath}/operate/doubt/search.action?type=FX&taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>&project_id=<%=request.getParameter("project_id")%>"
					frameborder="0" width="100%" height="1000"></iframe>
			</s:div>
			
			<s:div id='s5'  label='审计疑点' theme='ajax' 
				labelposition='top' loadingText="正在加载内容......" autoStart="false">
				<iframe id="copyArchivesInfoFrame" name="YD"
					src="${contextPath}/operate/doubt/search.action?type=YD&taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>&project_id=<%=request.getParameter("project_id")%>"
					frameborder="0" width="100%" height="1000"></iframe>
			</s:div>
			
				<s:div id='s6' label='审计备忘' theme='ajax' 
				labelposition='top' loadingText="正在加载内容......" autoStart="false">
				<iframe id="copyArchivesInfoFrame" name="BW"
					src="${contextPath}/operate/doubt/search.action?type=BW&taskId=<%=request.getParameter("taskId")%>&taskPid=<%=request.getParameter("taskPid")%>&project_id=<%=request.getParameter("project_id")%>"
					frameborder="0" width="100%" height="1000"></iframe>
			</s:div>

		</s:tabbedPanel>
	</body>
</html>
